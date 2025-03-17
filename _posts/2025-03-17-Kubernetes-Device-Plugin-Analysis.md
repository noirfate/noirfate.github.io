---
title: Kubernetes Device Plugin Analysis
layout: post
categories: k8s
tags: k8s
date: 2025-03-17 18:00
excerpt: Kubernetes Device Plugin Analysis
---

# Kubelet Device Plugin
## 架构
Kubernetes提供了Device Plugin框架，用于支持容器访问节点上的特殊硬件设备（如 GPU、FPGA、NIC、TPU 等），设备插件的主要作用是：

- 在节点上发现和管理设备资源。
- 向Kubernetes API Server注册这些设备资源。
- 在Pod请求设备资源时，负责向kubelet提供设备的具体信息（如设备节点路径、环境变量等），以便容器启动时挂载使用。

简单来说，Device Plugin是一个grpc服务，包含客户端和服务端，客户端连接kubelet注册自己的服务端供其调用

| 服务名称 | gRPC 服务端 | gRPC 客户端 | Unix socket 路径 | 接口功能 |
| ---- | ---- | ---- | ---- | ---- |
| Device Plugin Registration Service (注册服务) | kubelet | Device Plugin | `/var/lib/kubelet/device-plugins/kubelet.sock` | Device Plugin 启动后，向 kubelet 注册自己存在 |
| Device Plugin Service (设备插件服务) | Device Plugin | kubelet | `/var/lib/kubelet/device-plugins/<resource>.sock` | kubelet 获取设备状态、分配设备给 Pod |

![](/assets/img/dp1.png)

### 注册服务
Device Plugin启动后，连接kubelet的`unix socket`，注册资源名称（资源名称不允许重复），宣告自己的存在，源码定义在[api.proto](https://github.com/kubernetes/kubelet/blob/master/pkg/apis/deviceplugin/v1beta1/api.proto)
```proto
// Registration is the service advertised by the Kubelet
// Only when Kubelet answers with a success code to a Register Request
// may Device Plugins start their service
// Registration may fail when device plugin version is not supported by
// Kubelet or the registered resourceName is already taken by another
// active device plugin. Device plugin is expected to terminate upon registration failure
service Registration {
	rpc Register(RegisterRequest) returns (Empty) {}
}

message DevicePluginOptions {
	// Indicates if PreStartContainer call is required before each container start
	bool pre_start_required = 1;
	// Indicates if GetPreferredAllocation is implemented and available for calling
	bool get_preferred_allocation_available = 2;
}

message RegisterRequest {
	// Version of the API the Device Plugin was built against
	string version = 1;
	// Name of the unix socket the device plugin is listening on
	// PATH = path.Join(DevicePluginPath, endpoint)
	string endpoint = 2;
	// Schedulable resource name. As of now it's expected to be a DNS Label
	string resource_name = 3;
	// Options to be communicated with Device Manager
	DevicePluginOptions options = 4;
}
```

### 设备插件服务
在向kubelet注册了自己的服务端点之后，启动grpc服务，实现框架要求的接口，源码定义在[api.proto](https://github.com/kubernetes/kubelet/blob/master/pkg/apis/deviceplugin/v1beta1/api.proto)
```proto
// DevicePlugin is the service advertised by Device Plugins
service DevicePlugin {
	// GetDevicePluginOptions returns options to be communicated with Device
	// Manager
	rpc GetDevicePluginOptions(Empty) returns (DevicePluginOptions) {}

	// ListAndWatch returns a stream of List of Devices
	// Whenever a Device state change or a Device disappears, ListAndWatch
	// returns the new list
	rpc ListAndWatch(Empty) returns (stream ListAndWatchResponse) {}

	// GetPreferredAllocation returns a preferred set of devices to allocate
	// from a list of available ones. The resulting preferred allocation is not
	// guaranteed to be the allocation ultimately performed by the
	// devicemanager. It is only designed to help the devicemanager make a more
	// informed allocation decision when possible.
	rpc GetPreferredAllocation(PreferredAllocationRequest) returns (PreferredAllocationResponse) {}

	// Allocate is called during container creation so that the Device
	// Plugin can run device specific operations and instruct Kubelet
	// of the steps to make the Device available in the container
	rpc Allocate(AllocateRequest) returns (AllocateResponse) {}

	// PreStartContainer is called, if indicated by Device Plugin during registeration phase,
	// before each container start. Device plugin can run device specific operations
	// such as resetting the device before making devices available to the container
	rpc PreStartContainer(PreStartContainerRequest) returns (PreStartContainerResponse) {}
}

// AllocateResponse includes the artifacts that needs to be injected into
// a container for accessing 'deviceIDs' that were mentioned as part of
// 'AllocateRequest'.
// Failure Handling:
// if Kubelet sends an allocation request for dev1 and dev2.
// Allocation on dev1 succeeds but allocation on dev2 fails.
// The Device plugin should send a ListAndWatch update and fail the
// Allocation request
message AllocateResponse {
	repeated ContainerAllocateResponse container_responses = 1;
}

message ContainerAllocateResponse {
  	// List of environment variable to be set in the container to access one of more devices.
	map<string, string> envs = 1;
	// Mounts for the container.
	repeated Mount mounts = 2;
	// Devices for the container.
	repeated DeviceSpec devices = 3;
	// Container annotations to pass to the container runtime
	map<string, string> annotations = 4;
	// CDI devices for the container.
	repeated CDIDevice cdi_devices = 5 [(gogoproto.customname) = "CDIDevices"];
}

// - Allocate is expected to be called during pod creation since allocation
//   failures for any container would result in pod startup failure.
// - Allocate allows kubelet to exposes additional artifacts in a pod's
//   environment as directed by the plugin.
// - Allocate allows Device Plugin to run device specific operations on
//   the Devices requested
message AllocateRequest {
	repeated ContainerAllocateRequest container_requests = 1;
}

message ContainerAllocateRequest {
	repeated string devices_ids = 1 [(gogoproto.customname) = "DevicesIDs"];
}
```
Device Plugin必须实现`ListAndWatch`（设备发现）和 `Allocate`（设备分配）这两个重要接口

### Device Plugin参与创建pod流程
```
Device Plugin启动
     │
     │(Register资源名与设备ID列表)
     ▼
Kubelet Device Manager <───(维护设备资源池，记录设备列表)
     │
     │(报告资源容量给K8s调度器)
     ▼
Kubernetes Scheduler <───(只关心资源总量，不关心具体设备ID)
     │
     │(Pod调度: resources.limits["nvidia.com/gpu"]=1)
     ▼
Kubelet Device Manager
     │
     │(本地选择具体设备ID分配给Pod，标记为Allocated)
     ▼
调用 Device Plugin Allocate 接口（明确具体设备ID）
     │
     ▼
Device Plugin Allocate 接口返回挂载信息(设备节点、环境变量)
     │
     ▼
容器运行时（CRI）启动容器，挂载设备到容器内
```

## 设备插件分析

### 总览
#### 风险一：输入验证不充分
Device Plugin的实现一般接收来自kubelet的Pod spec请求数据（如设备 ID、数量、annotations），如果其未对输入内容严格校验，攻击者可能诱导Device Plugin执行敏感操作，如挂载宿主机关键目录，导致容器逃逸
#### 风险二：设备目录挂载权限过高
Device Plugin在实现Allocate接口时，可能返回过高权限的设备节点或挂载路径（如宿主机GPU、磁盘设备），特别是当以读写权限挂载宿主机目录时，可能导致容器逃逸
#### 风险三：日志信息泄露
Device Plugin在实现中可能将敏感信息写入日志中，通常Device Plugin的secret凭证权限较高，如果泄露给容器，则可能导致逃逸
#### 风险四：不安全的环境变量
Device Plugin可通过Allocate接口返回环境变量给容器，如果环境变量中包含宿主敏感信息（如认证凭据），可能导致信息泄露，甚至容器逃逸
#### 风险五：不安全的Annotations
Device Plugin可通过allocate接口返回annotations，攻击者可能通过annotations影响其他Kubernetes组件的行为
#### 风险六：三方库依赖漏洞
Device Plugin引用的三方库可能存在漏洞
#### 风险七：不安全的标签
Device Plugin可能会监控Pod或Node的Label变化，并进行相应的处理，如果攻击者能够修改Label，则可能影响Device Plugin的处理逻辑
#### 风险八：不安全的ConfigMap
Device Plugin可能会将配置信息保存在ConfigMap中再挂载到pod里，如果攻击者能够修改ConfigMap，则可能影响Device Plugin的处理逻辑
#### 风险九：高权限容器
Device Plugin可能会以特权或CAP_SYS_ADMIN等权限运行，或者容器中挂载了高权限的凭据，那么当其有外部暴露面时，攻击者可通过网络或管道等通信方式攻入高权限容器，从而实现提权或逃逸

### 分析框架
```yaml
### 插件名称
> 代码仓地址

#### 部署
##### 插件组件1
- Kind
- Image
- Container
	- 容器1
	**主要功能：** xxx
	**创建条件：** xxx
	**挂载卷：** xxx
- SecurityContext
- Seccomp
##### Role
##### ConfigMap
#### 代码分析
##### 插件组件1
- 入口
- 主要功能函数
#### 风险分析
##### 插件组件1
- ✔️ 风险一：输入验证不充分
- ✔️ 风险二：设备目录挂载权限过高
- ✔️ 风险三：日志信息泄露
- ✔️ 风险四：不安全的环境变量
- ✔️ 风险五：不安全的Annotations
- ✔️ 风险六：三方库依赖漏洞
- ✔️ 风险七：不安全的标签
- ✔️ 风险八：不安全的ConfigMap
- ✔️ 风险九：高权限容器
```

### Nvidia Device Plugin
> 代码仓：https://github.com/NVIDIA/k8s-device-plugin

#### 部署
##### Nvidia Device Plugin（必选）
在每个具有NVIDIA GPU的节点上运行，负责发现和管理GPU资源，主要包括：向Kubernetes报告可用的GPU资源、处理GPU资源分配请求、支持MIG(Multi-Instance GPU)配置、支持CDI(Container Device Interface)

- Kind
DaemonSet
- Image
nvcr.io/nvidia/k8s-device-plugin
- Container
    - initContainer<br>
    **主要功能：** 执行`config-manager`，使用参数`ONESHOT`，即检查一次就退出，它会获取标签`nvidia.com/device-plugin.config`的值，即配置文件名，如果`CONFIG_FILE_SRCDIR`中包含该文件，则将其链接到`CONFIG_FILE_DST`。其中`CONFIG_FILE_SRCDIR`为`/available-configs`，它是将ConfigMap挂载到容器中，`CONFIG_FILE_DST`为`/config/config.yaml`<br>
    **创建条件：** 只有当使用`helm`安装时设置了`configmap`，才会创建`initContainer`，默认不设置<br>
    **挂载卷：** 将configmap中配置的内容挂载到`/available-configs`
    - nvidia-device-plugin-sidecar<br>
    **主要功能：** 执行`config-manager`，监控节点标签`nvidia.com/device-plugin.config`的值，动态修改配置文件，并向进程名为`nvidia-device-plugin`的进程发送信号，通知其加载新的配置文件<br>
    **创建条件：** 只有当使用`helm`安装时设置了`configmap`，才会创建`nvidia-device-plugin-sidecar`，默认不设置<br>
    **挂载卷：** 将configmap中配置的内容挂载到`/available-configs`
    - nvidia-device-plugin-ctr<br>
    **主要功能：** 执行`nvidia-device-plugin`，向kubelet注册自身，根据资源类型（nvml、tegra）创建plugin，处理kubelet请求，修改pod spec，为pod添加gpu支持<br>
    **创建条件：** 无<br>
    **挂载卷：** 默认挂载宿主机路径`/var/lib/kubelet/device-plugins`、`/run/nvidia/mps`、`/run/nvidia/mps/shm`和`/var/run/cdi`，可选挂载`nvidiaDriverRoot`和`configmap`
- SecurityContext
    - 默认值
    ```yaml
    allowPrivilegeEscalation: false
    capabilities:
        drop: ["ALL"]
    ```
    - 安装时明确设置`securityContext`
    使用用户设置的值
    - 未设置`securityContext`，但开启了`compatWithCPUManager`
    ```yaml
    privileged: true
    ```
    - `migStrategy`非空或`deviceListStrategy`包含`volume-mounts`时
    ```yaml
    capabilities:
        add:
            - SYS_ADMIN
    ```

##### GPU Feature Discovery (可选)
发现GPU特性并将其作为节点标签添加到Kubernetes节点，为用户在创建Pod时提供精细化调度选择，需要在安装时手动启用
- Kind
DaemonSet
- Image
nvcr.io/nvidia/k8s-device-plugin
- Container
   - initContainer<br>
    **主要功能：** 执行`config-manager`，使用参数`ONESHOT`，即检查一次就退出，它会获取标签`nvidia.com/device-plugin.config`的值，即配置文件名，如果`CONFIG_FILE_SRCDIR`中包含该文件，则将其链接到`CONFIG_FILE_DST`。其中`CONFIG_FILE_SRCDIR`为`/available-configs`，它是将ConfigMap挂载到容器中，`CONFIG_FILE_DST`为`/config/config.yaml`<br>
    **创建条件：** 只有当使用`helm`安装时设置了`configmap`，才会创建`initContainer`，默认不设置<br>
    **挂载卷：** 将configmap中配置的内容挂载到`/available-configs`
    - gpu-feature-discovery-sidecar<br>
    **主要功能：** 执行`config-manager`，监控节点标签`nvidia.com/device-plugin.config`的值，动态修改配置文件，并向进程名为`gpu-feature-discovery`的进程发送信号，通知其加载新的配置文件<br>
    **创建条件：** 只有当使用`helm`安装时设置了`configmap`，才会创建`gpu-feature-discovery-sidecar`，默认不设置<br>
    **挂载卷：** 将configmap中配置的内容挂载到`/available-configs`
    - gpu-feature-discovery-ctr<br>
    **主要功能：** 执行`gpu-feature-discovery`，调用nvml或tegra库获取GPU信息，通过文件`/etc/kubernetes/node-feature-discovery/features.d/gfd`或`Node Feature API`向[nfd (node-feature-discovery)](https://github.com/kubernetes-sigs/node-feature-discovery)报告需要添加的标签，之后由`nfd`为节点添加标签<br>
    **创建条件：** 使用`helm`安装时需要设置`gfd.enabled = true`<br>
    **挂载卷：** 默认挂载宿主机路径`/etc/kubernetes/node-feature-discovery/features.d`、`/sys`和`/ + nvidiaDriverRoot`，可选挂载`configmap`
- SecurityContext
    - 默认
    ```yaml
    privileged: true
    ```

##### MPS Control（可选）
MPS (Multi-Process Service) Control Daemon是NVIDIA提供的一个服务，用于在多个容器之间共享单个GPU，只会部署在具备`nvidia.com/mps.capable: "true"`标签的节点上
- Kind
DaemonSet
- Image
nvcr.io/nvidia/k8s-device-plugin
- Container
    - initContainer
        - mps-control-daemon-mounts<br>
        **主要功能：** 执行`mps-control-daemon mount-shm`，创建共享内存区，挂载`tmpfs`到`/mps/shm`<br>
        **创建套件：** 无<br>
        **挂载卷：** 挂载宿主机路径`/run/nvidia/mps`
        - mps-control-daemon-init
         **主要功能：** 执行`config-manager`，监控节点标签`nvidia.com/device-plugin.config`的值，动态修改配置文件，并向进程名为`/usr/bin/mps-control-daemon`的进程发送信号，通知其加载新的配置文件<br>
         **创建条件：** 只有当使用`helm`安装时设置了`configmap`，才会创建`initContainer`，默认不设置<br>
         **挂载卷：** 将configmap中配置的内容挂载到`/available-configs`
    - mps-control-daemon-ctr
    **主要功能：** 执行`mps-control-daemon`，它的主要作用就是启动cuda mps服务`nvidia-cuda-mps-control -d`<br>
    **创建条件：** 无<br>
    **挂载卷：** 挂载宿主机路径`/run/nvidia/mps`和`/run/nvidia/mps/shm`
- SecurityContext
    - 全局默认
    ```yaml
    shareProcessNamespace: true
    hostPID: true
    ```
    - 初始化容器
    ```yaml
    privileged: true
    ```
##### Role
- 默认值
空
- 仅配置了`configmap`，未配置`gfd (gpu-feature-discovery)`和`nfd (node-feature-discovery)`中的`enableNodeFeatureApi`

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
    ...
rules:
  - apiGroups: [""]
    resources: ["nodes"]
    verbs: ["get", "list", "watch"]
```

- 配置了`gfd`和`nfd.enableNodeFeatureApi`

```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
    ...
rules:
  - apiGroups: [""]
    resources: ["nodes"]
    verbs: ["get", "list", "watch"]
  - apiGroups: ["nfd.k8s-sigs.io"]
    resources: ["nodefeatures"]
    verbs: ["get", "list", "watch", "create", "update"]
```

##### ConfigMap
- 默认值
空

#### 代码分析
##### Nvidia Device Plugin
- 入口`cmd/nvidia-device-plugin/main.go`
```go
func startPlugins(c *cli.Context, o *options) ([]plugin.Interface, bool, error) {
    ...

    // 在指定的搜索路径中搜索并加载libnvidia-ml.so.1，搜索路径为（/usr/lib64、/usr/lib/x86_64-linux-gnu、/usr/lib/aarch64-linux-gnu、/lib64、/lib/x86_64-linux-gnu、/lib/aarch64-linux-gnu），会解析符号链接
	driverRoot := root(*config.Flags.Plugin.ContainerDriverRoot)
	nvmllib := nvml.New(
		nvml.WithLibraryPath(driverRoot.tryResolveLibrary("libnvidia-ml.so.1")),
	)
    ...

	// 根据资源类型（nvml、tegra）创建插件
	klog.Info("Retrieving plugins.")
	plugins, err := GetPlugins(infolib, nvmllib, devicelib, config)
	if err != nil {
		return nil, false, fmt.Errorf("error getting plugins: %v", err)
	}

	started := 0
	for _, p := range plugins {
		if len(p.Devices()) == 0 {
			continue
		}

		// 启动插件
		if err := p.Start(o.kubeletSocket); err != nil {
			klog.Errorf("Failed to start plugin: %v", err)
			return plugins, true, nil
		}
		started++
	}

    ...
}
```
- 启动plugin`internal/plugin/server.go`
```go
func (plugin *nvidiaDevicePlugin) Start(kubeletSocket string) error {
	plugin.initialize()

    // 如果启用了mps，就等待mps服务起来
	if err := plugin.mps.waitForDaemon(); err != nil {
		return fmt.Errorf("error waiting for MPS daemon: %w", err)
	}

    // 创建plugin unix socket，启动plugin服务
	err := plugin.Serve()
	if err != nil {
		klog.Errorf("Could not start device plugin for '%s': %s", plugin.rm.Resource(), err)
		plugin.cleanup()
		return err
	}
	klog.Infof("Starting to serve '%s' on %s", plugin.rm.Resource(), plugin.socket)

    // 向kubelet注册
	err = plugin.Register(kubeletSocket)
	if err != nil {
		klog.Errorf("Could not register device plugin: %s", err)
		return errors.Join(err, plugin.Stop())
	}
	klog.Infof("Registered device plugin for '%s' with Kubelet", plugin.rm.Resource())

    ...
}
```
- 向kubelet汇报设备状态`internal/plugin/server.go`
```go
func (plugin *nvidiaDevicePlugin) ListAndWatch(e *pluginapi.Empty, s pluginapi.DevicePlugin_ListAndWatchServer) error {
	if err := s.Send(&pluginapi.ListAndWatchResponse{Devices: plugin.apiDevices()}); err != nil {
		return err
	}

	for {
		select {
		case <-plugin.stop:
			return nil
		case d := <-plugin.health:
			// FIXME: there is no way to recover from the Unhealthy state.
			d.Health = pluginapi.Unhealthy
			klog.Infof("'%s' device marked unhealthy: %s", plugin.rm.Resource(), d.ID)
			if err := s.Send(&pluginapi.ListAndWatchResponse{Devices: plugin.apiDevices()}); err != nil {
				return nil
			}
		}
	}
}
```
- 给pod分配GPU`internal/plugin/server.go`
```go
func (plugin *nvidiaDevicePlugin) Allocate(ctx context.Context, reqs *pluginapi.AllocateRequest) (*pluginapi.AllocateResponse, error) {
	responses := pluginapi.AllocateResponse{}
    // 遍历容器创建请求
	for _, req := range reqs.ContainerRequests {
        // 校验输入，检查传入的DevicesIDs是否存在
		if err := plugin.rm.ValidateRequest(req.DevicesIDs); err != nil {
			return nil, fmt.Errorf("invalid allocation request for %q: %w", plugin.rm.Resource(), err)
		}
        // 生成回复
		response, err := plugin.getAllocateResponse(req.DevicesIDs)
		if err != nil {
			return nil, fmt.Errorf("failed to get allocate response: %v", err)
		}
		responses.ContainerResponses = append(responses.ContainerResponses, response)
	}

	return &responses, nil
}
//
func (plugin *nvidiaDevicePlugin) getAllocateResponse(requestIds []string) (*pluginapi.ContainerAllocateResponse, error) {
	deviceIDs := plugin.deviceIDsFromAnnotatedDeviceIDs(requestIds)

	// 创建response
	response := &pluginapi.ContainerAllocateResponse{
		Envs: make(map[string]string),
	}

    // 如果启用了CDI，则添加response.CDIDevices
	if plugin.deviceListStrategies.AnyCDIEnabled() {
		responseID := uuid.New().String()
		if err := plugin.updateResponseForCDI(response, responseID, deviceIDs...); err != nil {
			return nil, fmt.Errorf("failed to get allocate response for CDI: %v", err)
		}
	}

    // 如果启用了MPS，则添加环境变量CUDA_MPS_PIPE_DIRECTORY，把mps的pipe和shm目录挂载到容器中
	if plugin.mps.enabled {
		plugin.updateResponseForMPS(response)
	}

    // 如果所有设备都启用了CDI，则直接返回
	if plugin.deviceListStrategies.AllCDIEnabled() {
		return response, nil
	}

    // 添加环境变量
	if plugin.deviceListStrategies.Includes(spec.DeviceListStrategyEnvVar) {
		plugin.updateResponseForDeviceListEnvVar(response, deviceIDs...)
		plugin.updateResponseForImexChannelsEnvVar(response)
	}

    // 挂载对应的gpu设备
	if plugin.deviceListStrategies.Includes(spec.DeviceListStrategyVolumeMounts) {
		plugin.updateResponseForDeviceMounts(response, deviceIDs...)
	}

    // 设置DeviceSpecs，默认是False，如果在安装时设置了compatWithCPUManager，则启用
    // 以读写权限挂载/dev/nvidiactl、/dev/nvidia-uvm、/dev/nvidia-uvm-tools、/dev/nvidia-modeset
	if *plugin.config.Flags.Plugin.PassDeviceSpecs {
		response.Devices = append(response.Devices, plugin.apiDeviceSpecs(*plugin.config.Flags.NvidiaDevRoot, requestIds)...)
	}

	if *plugin.config.Flags.GDSEnabled {
		response.Envs["NVIDIA_GDS"] = "enabled"
	}
	if *plugin.config.Flags.MOFEDEnabled {
		response.Envs["NVIDIA_MOFED"] = "enabled"
	}
	return response, nil
}
```

##### GPU Feature Discovery
- 入口`cmd/gpu-feature-discovery`
```go
func (d *gfd) run(sigs chan os.Signal) (bool, error) {
	defer func() {
		if d.config.Flags.UseNodeFeatureAPI != nil && *d.config.Flags.UseNodeFeatureAPI {
			return
		}
		if d.config.Flags.GFD.Oneshot != nil && *d.config.Flags.GFD.Oneshot {
			return
		}
		if d.config.Flags.GFD.OutputFile != nil && *d.config.Flags.GFD.OutputFile == "" {
			return
		}
		err := removeOutputFile(*d.config.Flags.GFD.OutputFile)
		if err != nil {
			klog.Warningf("Error removing output file: %v", err)
		}
	}()

    // 创建时间戳标签nvidia.com/gfd.timestamp
	timestampLabeler := lm.NewTimestampLabeler(d.config)
rerun:
    // 根据配置创建标签：
    // 1. 机器类型：nvidia.com/gpu.machine
    // 2. cuda版本：[nvidia.com/cuda.driver.major、nvidia.com/cuda.driver.minor、nvidia.com/cuda.driver.rev、nvidia.com/cuda.runtime.major、nvidia.com/cuda.runtime.minor](旧)，[nvidia.com/cuda.driver-version.major、nvidia.com/cuda.driver-version.minor、nvidia.com/cuda.driver-version.revision、nvidia.com/cuda.driver-version.full、nvidia.com/cuda.runtime-version.major、nvidia.com/cuda.runtime-version.minor、nvidia.com/cuda.runtime-version.full](新)
    // 3. MIG标签：nvidia.com/mig.capable
    // 4. MPS标签：nvidia.com/mps.capable
    // 5. GPU标签：nvidia.com/gpu
    // 6. Imex标签：nvidia.com/gpu.clique
	loopLabelers, err := lm.NewLabelers(d.manager, d.vgpu, d.config)
	if err != nil {
		return false, err
	}

	labelers := lm.Merge(
		timestampLabeler,
		loopLabelers,
	)

	labels, err := labelers.Labels()
	if err != nil {
		return false, fmt.Errorf("error generating labels: %v", err)
	}

	if len(labels) <= 1 {
		klog.Warning("No labels generated from any source")
	}

    // 输出lables给nfd
	klog.Info("Creating Labels")
	if err := d.labelOutputer.Output(labels); err != nil {
		return false, err
	}

	if *d.config.Flags.GFD.Oneshot {
		return false, nil
	}

	klog.Info("Sleeping for ", *d.config.Flags.GFD.SleepInterval)
	rerunTimeout := time.After(time.Duration(*d.config.Flags.GFD.SleepInterval))

	for {
		select {
		case <-rerunTimeout:
			goto rerun

		// Watch for any signals from the OS. On SIGHUP trigger a reload of the config.
		// On all other signals, exit the loop and exit the program.
		case s := <-sigs:
			switch s {
			case syscall.SIGHUP:
				klog.Info("Received SIGHUP, restarting.")
				return true, nil
			default:
				klog.Infof("Received signal %v, shutting down.", s)
				return false, nil
			}
		}
	}
}
```

##### MPS Control
- 入口`cmd/mps-control-daemon/main.go`
```go
func startDaemons(c *cli.Context, cfg *Config) ([]*mps.Daemon, bool, error) {
    ...
    // 为启用共享的GPU设备创建mps服务
    mpsDaemons, err := mps.NewDaemons(infolib, nvmllib, devicelib,
		mps.WithConfig(config),
	)
    ...
    // 启动mps服务
	for _, mpsDaemon := range mpsDaemons {
		if err := mpsDaemon.Start(); err != nil {
			klog.Errorf("Failed to start MPS daemon: %v", err)
			return mpsDaemons, true, nil
		}
	}
}
```
- 服务启动`cmd/mps-control-daemon/mps/daemon.go`
```go
func (d *Daemon) Start() error {
    // 执行nvidia-smi命令设置GPU模式为单进程独占，由mps server独占GPU资源，其他使用GPU的容器都通过mps来共享GPU资源
	if err := d.setComputeMode(computeModeExclusiveProcess); err != nil {
		return fmt.Errorf("error setting compute mode %v: %w", computeModeExclusiveProcess, err)
	}

	klog.InfoS("Staring MPS daemon", "resource", d.rm.Resource())

    // 设置mps server的通信管道，在容器中的路径是/mps/pipes/，容器的/mps对应于宿主机路径是/run/nvidia/mps
	pipeDir := d.PipeDir()
	if err := os.MkdirAll(pipeDir, 0755); err != nil {
		return fmt.Errorf("error creating directory %v: %w", pipeDir, err)
	}

    // 在启用selinux的情况下，为pipe目录添加selinux标签system_u:object_r:container_file_t:s0
	if err := setSELinuxContext(pipeDir, unprivilegedContainerSELinuxLabel); err != nil {
		return fmt.Errorf("error setting SELinux context: %w", err)
	}

    // 创建日志目录，在容器中的路径是/mps/logs
	logDir := d.LogDir()
	if err := os.MkdirAll(logDir, 0755); err != nil {
		return fmt.Errorf("error creating directory %v: %w", logDir, err)
	}

    // 执行nvidia-cuda-mps-control -d
	mpsDaemon := exec.Command(mpsControlBin, "-d")
	mpsDaemon.Env = append(mpsDaemon.Env, d.EnvVars().toSlice()...)
	if err := mpsDaemon.Run(); err != nil {
		return err
	}

    // 通过之前建立的pipe管道与mps服务通信
	for index, limit := range d.perDevicePinnedDeviceMemoryLimits() {
		_, err := d.EchoPipeToControl(fmt.Sprintf("set_default_device_pinned_mem_limit %s %s", index, limit))
		if err != nil {
			return fmt.Errorf("error setting pinned memory limit for device %v: %w", index, err)
		}
	}
	if threadPercentage := d.activeThreadPercentage(); threadPercentage != "" {
		_, err := d.EchoPipeToControl(fmt.Sprintf("set_default_active_thread_percentage %s", threadPercentage))
		if err != nil {
			return fmt.Errorf("error setting active thread percentage: %w", err)
		}
	}

	statusFile, err := os.Create(d.startedFile())
	if err != nil {
		return err
	}
	defer statusFile.Close()

    // 执行tail命令跟踪日志输出
	d.logTailer = newTailer(filepath.Join(logDir, "control.log"))
	klog.InfoS("Starting log tailer", "resource", d.rm.Resource())
	if err := d.logTailer.Start(); err != nil {
		klog.ErrorS(err, "Could not start tail command on control.log; ignoring logs")
	}

	return nil
}
```

##### Config Manager
- 入口`cmd/config-manager/main.go`
```go
func start(c *cli.Context, f *Flags) error {
	kubeconfig, err := clientcmd.BuildConfigFromFlags("", f.Kubeconfig)
	if err != nil {
		return fmt.Errorf("error building kubernetes clientcmd config: %s", err)
	}

    // 创建kubernetes client api
	clientset, err := kubernetes.NewForConfig(kubeconfig)
	if err != nil {
		return fmt.Errorf("error building kubernetes clientset from config: %s", err)
	}

	config := NewSyncableConfig(f)

    // 监控节点标签变化
	stop := continuouslySyncConfigChanges(clientset, config, f)
	defer close(stop)

    // 定期检查，更新配置文件
	for {
		klog.Infof("Waiting for change to '%s' label", f.NodeLabel)
		config := config.Get()
		klog.Infof("Label change detected: %s=%s", f.NodeLabel, config)
		err := updateConfig(config, f)
		if f.Oneshot || err != nil {
			return err
		}
	}
}
```
- 更新配置`cmd/config-manager/main.go`
```go
func updateConfig(config string, f *Flags) error {
	config, err := updateConfigName(config, f)
	if err != nil {
		return err
	}

	if config == "" {
		klog.Infof("Updating to empty config")
	} else {
		klog.Infof("Updating to config: %s", config)
	}

    // 更新配置文件符号链接，将新的配置文件链接到目标配置文件
	updated, err := updateSymlink(config, f)
	if err != nil {
		return err
	}
	if !updated {
		klog.Infof("Already configured. Skipping update...")
		return nil
	}

	if config == "" {
		klog.Infof("Successfully updated to empty config")
	} else {
		klog.Infof("Successfully updated to config: %s", config)
	}

    // 向对应服务进程发送SIGHUP信号，重启服务
	if f.SendSignal {
		klog.Infof("Sending signal '%s' to '%s'", syscall.Signal(f.Signal), f.ProcessToSignal)
		err := signalProcess(f)
		if err != nil {
			return err
		}
		klog.Infof("Successfully sent signal")
	}

	return nil
}
//
func updateSymlink(config string, f *Flags) (bool, error) {
	src := "/dev/null"
	if config != "" {
		src = filepath.Join(f.ConfigFileSrcdir, config)
	}

    // ConfigFileDst为符号链接，链接到当前最新的配置文件
	exists, err := fileExists(f.ConfigFileDst)
	if err != nil {
		return false, fmt.Errorf("error checking if file '%s' exists: %v", f.ConfigFileDst, err)
	}

	if exists {
        // 获取源文件路径
		srcRealpath, err := filepath.EvalSymlinks(src)
		if err != nil {
			return false, fmt.Errorf("error evaluating realpath of '%v': %v", src, err)
		}
        // 获取目标文件路径
		dstRealpath, err := filepath.EvalSymlinks(f.ConfigFileDst)
		if err != nil {
			return false, fmt.Errorf("error evaluating realpath of '%v': %v", f.ConfigFileDst, err)
		}

        // 判断是否为相同文件
		if srcRealpath == dstRealpath {
			return false, nil
		}

        // 删除ConfigFileDst
		err = os.Remove(f.ConfigFileDst)
		if err != nil {
			return false, fmt.Errorf("error removing existing config: %v", err)
		}
	}

    // 创建符号链接 src -> ConfigFileDst
	err = os.Symlink(src, f.ConfigFileDst)
	if err != nil {
		return false, fmt.Errorf("error creating symlink: %v", err)
	}

	return true, nil
}
```

#### 风险分析
##### Nvidia Device Plugin
- ✔️ 风险一：输入验证不充分
- ✔️ 风险二：设备目录挂载权限过高
- ✔️ 风险三：日志信息泄露
- ✔️ 风险四：不安全的环境变量
- ✔️ 风险五：不安全的Annotations
- ✔️ 风险六：三方库依赖漏洞
- ✔️ 风险七：不安全的标签
- ✔️ 风险八：不安全的ConfigMap
- ✔️ 风险九：高权限容器
##### GPU Feature Discovery
- ✔️ 风险一：输入验证不充分
- ✔️ 风险二：设备目录挂载权限过高
- ✔️ 风险三：日志信息泄露
- ✔️ 风险四：不安全的环境变量
- ✔️ 风险五：不安全的Annotations
- ✔️ 风险六：三方库依赖漏洞
- ✔️ 风险七：不安全的标签
- ✔️ 风险八：不安全的ConfigMap
- ✔️ 风险九：高权限容器
##### MPS Control
- ✔️ 风险一：输入验证不充分
- ✔️ 风险二：设备目录挂载权限过高
- ✔️ 风险三：日志信息泄露
- ✔️ 风险四：不安全的环境变量
- ✔️ 风险五：不安全的Annotations
- ✔️ 风险六：三方库依赖漏洞
- ✔️ 风险七：不安全的标签
- ✔️ 风险八：不安全的ConfigMap
- ❓ 风险九：高权限容器
    - `mps-control-daemon`使用了`hostpid`，可以访问宿主机的进程空间，且当启用`mps`功能时，在用户容器中挂载了`nvidia-cuda-mps-control`的本地socket路径，若该进程存在漏洞，则可能进入`mps`的容器中
##### Config Manager
- ✔️ 风险一：输入验证不充分
- ✔️ 风险二：设备目录挂载权限过高
- ✔️ 风险三：日志信息泄露
- ✔️ 风险四：不安全的环境变量
- ✔️ 风险五：不安全的Annotations
- ✔️ 风险六：三方库依赖漏洞
- ✔️ 风险七：不安全的标签
- ✔️ 风险八：不安全的ConfigMap
- ✔️ 风险九：高权限容器

### Ascend Device Plugin
> 代码仓：https://gitee.com/ascend/ascend-device-plugin/tree/branch_v6.0.0-RC3/

#### 部署
##### ascend device plugin
- Kind
DaemonSet
- Image
无
- Container
	- 310/310P和910
	**主要功能：** 支持huawei-Ascend310、huawei-Ascend310P、huawei-Ascend910显卡的`device plugin`，执行`device-plugin -useAscendDocker=true -logFile=/var/log/mindx-dl/devicePlugin/devicePlugin.log -logLevel=0`<br>
	**创建条件：** 无<br>
	**挂载卷：** 910会挂载宿主机路径`/var/lib/kubelet/device-plugins`、`/var/lib/kubelet/pod-resources`、`/usr/local/Ascend/driver`、`/var/log/mindx-dl/devicePlugin`、`/var/log/lingqu`，310/310P不会挂载`/var/log/lingqu`
	- 310/310P volcano
	**主要功能：** 支持huawei-Ascend310、huawei-Ascend310P显卡和`volcano`调度器的`device plugin`，执行`device-plugin -useAscendDocker=true -volcanoType=true -logFile=/var/log/mindx-dl/devicePlugin/devicePlugin.log -logLevel=0`<br>
	**创建条件：** 无<br>
	**挂载卷：** 会挂载宿主机路径`/var/lib/kubelet/device-plugins`、`/var/lib/kubelet/pod-resources`、`/usr/local/Ascend/driver`(ro)、`/var/log/mindx-dl/devicePlugin`
	- 910 vnpu volcano
	**主要功能：** 支持huawei-Ascend910虚拟npu和`volcano`调度器的`device plugin`，执行`device-plugin -useAscendDocker=true -volcanoType=true -presetVirtualDevice=true -logFile=/var/log/mindx-dl/devicePlugin/devicePlugin.log -logLevel=0`<br>
	**创建条件：** 无<br>
	**挂载卷：** 会挂载宿主机路径`/var/lib/kubelet/device-plugins`、`/var/lib/kubelet/pod-resources`、`/usr/local/Ascend/driver`、`/var/log/mindx-dl/devicePlugin`、`/user/restore/reset`、`/run/vnpu_cfg_lock`、`/tmp`、`/etc/vnpu.cfg`、`/var/log/lingqu`
	- 310P-1usoc
	**主要功能：** 支持huawei-Ascend310P显卡的`SOC`部署方式，执行`run_for_310P_1usoc.sh`，最终会执行`/usr/local/bin/device-plugin -useAscendDocker=false -volcanoType=true -presetVirtualDevice=true -logFile=/var/log/mindx-dl/devicePlugin/devicePlugin.log -logLevel=0`<br>
	**创建条件：** 无<br>
	**挂载卷：** 会挂载宿主机路径`/var/lib/kubelet/device-plugins`、`/usr/local/Ascend/driver`(ro)、`/var/log/mindx-dl/devicePlugin`、`/var/lib/kubelet/pod-resources`、`/tmp`、`/var/dmp_daemon`(ro)、`/var/slogd`(ro)、`/usr/lib64/libyaml-0.so.2`(ro)、`/etc/hdcBasic.cfg`(ro)、`/etc/slog.conf`(ro)
- SecurityContext
```yaml
securityContext:
    privileged: true
    readOnlyRootFilesystem: true
```
- SecComp
```yaml
seccomp.security.alpha.kubernetes.io/pod: runtime/default
```
##### Role

```yaml
kind: ClusterRole
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: pods-node-ascend-device-plugin-role-910
rules:
  - apiGroups: [""]
    resources: ["pods"]
    verbs: ["get", "list", "update", "watch", "patch"]
  - apiGroups: [""]
    resources: ["nodes"]
    verbs: ["get", "patch"]
  - apiGroups: [""]
    resources: ["nodes/status"]
    verbs: ["get", "patch", "update"]
  - apiGroups: [""]
    resources: ["configmaps"]
    verbs: ["get", "create", "update", "list", "watch"]
  - apiGroups: [ "" ]
    resources: [ "events" ]
    verbs: [ "create" ]
```

##### ConfigMap
无

#### 代码分析
##### ascend device plugin
- 入口`main.go`
```go
func main() {
	...
	// 初始化昇腾设备管理模块
	hdm, err := InitFunction()
	if err != nil {
		return
	}
	// 检查是否使用Ascend Docker
	setUseAscendDocker()
	// 设备状况监控服务，更新设备信息到k8s
	go hdm.ListenDevice(ctx)
	// 退出信号处理
	hdm.SignCatch(cancel)
}
```
- 初始化设备管理`main.go`
```go
func InitFunction() (*server.HwDevManager, error) {
	// 代码在npu-exporter中，最终调用dcmi(Davinci Card Management Interface)获取设备信息
	devM, err := devmanager.AutoInit("")
	if err != nil {
		hwlog.RunLog.Errorf("init devmanager failed, err: %v", err)
		return nil, err
	}
	// 初始化plugin server
	hdm := server.NewHwDevManager(devM)
	if hdm == nil {
		hwlog.RunLog.Error("init device manager failed")
		return nil, fmt.Errorf("init device manager failed")
	}
	hwlog.RunLog.Info("init device manager success")
	common.ParamOption.EnableSwitchFault = true
	if common.ParamOption.RealCardType == common.Ascend910A3 && common.ParamOption.EnableSwitchFault {
		// 初始化灵衢交换机设备
		switchDevMgr := deviceswitch.NewSwitchDevManager()
		if err := switchDevMgr.InitSwitchDev(); err != nil {
			hwlog.RunLog.Warnf("failed to init switch switch device manager, will not deal with switch fault, "+
				"err: %s", err.Error())
			common.ParamOption.EnableSwitchFault = false
			// will not return err, to ensure dp keep running while switch is not reachable
			return hdm, nil
		}
		hdm.SwitchDevManager = switchDevMgr
	}
	return hdm, nil
}
```
- ListAndWatch`pkg/server/plugin.go`
```go
func (ps *PluginServer) ListAndWatch(empty *v1beta1.Empty, stream v1beta1.DevicePlugin_ListAndWatchServer) error {
	send := func(stream v1beta1.DevicePlugin_ListAndWatchServer) {
		for i := 0; i < common.RetryUpdateCount; i++ {
			if err := sendToKubelet(stream, ps.responseToKubelet()); err != nil {
				hwlog.RunLog.Errorf("send to kubelet failed, error is %v", err)
				continue
			}
			lastStatus.Store(true)
			return
		}
		lastStatus.Store(false)
		hwlog.RunLog.Errorf("the number of retries (%d) retries send failed.", common.RetryUpdateCount)
	}
	ps.isRunning.Store(true)
	send(stream)
	for {
		select {
		case <-ps.stop:
			ps.isRunning.Store(false)
			return nil
		// 从reciChan接收设备更新信号，向kubelet发送更新后的设备信息 (在ListenDevice中会定时调用updateAllInfo获取设备信息，然后调用notifyToK8s，如果设备信息发送变化，则向reciChan管道中发送信号)
		case _, ok := <-ps.reciChan:
			if ok {
				send(stream)
			}
		}
	}
}
```
- Allocate`pkg/server/plugin.go`
```go
func (ps *PluginServer) Allocate(ctx context.Context, requests *v1beta1.AllocateRequest) (*v1beta1.AllocateResponse,
	error) {
	// 检查传入的device id是否合法
	if err := ps.checkAllocateRequest(requests); err != nil {
		hwlog.RunLog.Error(err)
		return nil, err
	}
	resps := new(v1beta1.AllocateResponse)
	for _, rqt := range requests.ContainerRequests {
		var err error
		allocateDevices := rqt.DevicesIDs
		if !common.ParamOption.PresetVDevice {
			hwlog.RunLog.Infof("request num: %d", len(rqt.DevicesIDs))
		} else {
			hwlog.RunLog.Infof("request: %#v", rqt.DevicesIDs)
		}
		if common.ParamOption.UseVolcanoType {
			allocateDevices, err = ps.useVolcano(rqt.DevicesIDs)
			if err != nil {
				hwlog.RunLog.Error(err)
				return nil, err
			}
		}
		_, ascendVisibleDevices, err := common.GetDeviceListID(allocateDevices, ps.ascendRuntimeOptions)
		if err != nil {
			hwlog.RunLog.Error(err)
			return nil, err
		}

		resp := new(v1beta1.ContainerAllocateResponse)
		if !common.ParamOption.UseAscendDocker {
			// 如果没有使用Ascend Docker，则通过DeviceSpec设置设备挂载路径
			hwlog.RunLog.Info("device-plugin will use origin mount way")
			mountDefaultDevice(resp, ps.defaultDevs)
			mountDevice(resp, ascendVisibleDevices, ps.ascendRuntimeOptions)
		} else {
			// 设置环境变量
			common.SetAscendRuntimeEnv(ascendVisibleDevices, ps.ascendRuntimeOptions, resp)
			hwlog.RunLog.Info("device-plugin will use ascend-docker to mount")
		}
		ps.SetSlowNodeNoticeEnv(resp)
		resps.ContainerResponses = append(resps.ContainerResponses, resp)
	}
	return resps, nil
}
```
#### 风险分析
##### ascend device plugin
- ✔️ 风险一：输入验证不充分
- ✔️ 风险二：设备目录挂载权限过高
- ✔️ 风险三：日志信息泄露
- ✔️ 风险四：不安全的环境变量
- ✔️ 风险五：不安全的Annotations
- ✔️ 风险六：三方库依赖漏洞
- ✔️ 风险七：不安全的标签
- ✔️ 风险八：不安全的ConfigMap
- ✔️ 风险九：高权限容器