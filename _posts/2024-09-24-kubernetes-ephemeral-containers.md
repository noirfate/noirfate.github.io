---
title: Kubernetes Ephemeral Containers
layout: post
categories: k8s
tags: k8s
date: 2024-09-24 18:00
excerpt: Kubernetes Ephemeral Containers
---

{:.table-of-content}
* TOC
{:toc}

# Kubernetes临时容器

## 缘起
许多Kubernetes使用者不在Linux发行版的基础上构筑镜像，而是选择构建一个最小化镜像，以降低运维负担和减少攻击面。这会使得运行的容器中缺少一些发行版自带的命令和工具，导致调试起来十分麻烦。为了满足调试需求，Kubernetes增加了一个新特性——临时容器（Ephemeral Containers），它的目标是：
- 允许访问单个容器的命名空间和文件系统
- 在运行时而不是在创建pod或镜像时获取容器镜像
- 遵循准入控制器和审计日志
- 可通过API调用
- 通过CRI支持任意运行时
- 不需要节点的管理权限
- 对正在运行的容器镜像没有副作用
- 定义一个可供准入控制器检查的v1.Container结构

## 历史

| Feature | Default | Stage | From | To |
| ---- | ---- | ---- | ---- | ---- |
| EphemeralContainers | false | Alpha | 1.16 | 1.22 |
| EphemeralContainers | true | Beta | 1.23 | 1.24 |
| EphemeralContainers | true | GA | 1.25 | 1.26 |

### Feature Gate（特性门控）
Feature Gate（特性门控）是Kubernetes中用于控制实验性或可选功能的机制。通过Feature Gate，集群管理员可以启用或禁用特定的Kubernetes功能，这些功能通常处于Alpha或Beta阶段
#### Alpha阶段
- 默认状态：禁用
- 特点：
    - 功能处于早期测试阶段，可能不稳定
    - API和功能可能在未来版本中发生重大更改
    - 不建议在生产环境中使用
- Feature Gate：使用特性门控启用
#### Beta阶段
- 默认状态：启用
- 特点：
    - 功能已经过测试，较为稳定
    - API可能在未来版本中发生小的更改
    - 可以在非关键业务的生产环境中使用，但需注意兼容性
- Feature Gate：仍受特性门控控制，但默认启用
#### GA（正式发布）阶段：
- 默认状态：启用，且不能禁用
- 特点：
    - 功能稳定且向后兼容
    - 可以安全地在生产环境中使用
- Feature Gate：不再需要特性门控（个别除外）
#### 注意事项
当一个`feature`从`alpha`进入`beta`时，会从之前的默认禁止变为默认启用，可能会对集群的安全配置产生影响，临时容器即是一例。自从变为默认启用后，就被发现了两个相关权限校验遗漏的漏洞

### 里程碑
#### 1.16
- 临时容器发布alpha版本
- 临时容器没有实现共享目标容器命名空间的能力，需要`Pod`在创建时设置`shareProcessNamespace: true`
- 临时容器创建可使用`kubectl replace --raw /api/v1/namespaces/{namespace}/pods/{podname}/ephemeralcontainers -f ephemeral-container.json`，[参考](https://www.shogan.co.uk/kubernetes/enabling-and-using-ephemeral-containers-on-kubernetes-1-16/)
```json
{
    "apiVersion": "v1",
    "kind": "EphemeralContainers",
    "metadata": {
        "name": "{podname}"
    },
    "ephemeralContainers": [{
        "command": [
            "bash"
        ],
        "image": "ubuntu",
        "imagePullPolicy": "IfNotPresent",
        "name": "debug",
        "stdin": true,
        "tty": true,
        "terminationMessagePolicy": "File"
    }]
}
```
- 临时容器创建后，使用`kubectl attach -it {podname} -c debug`进入`shell`
- 临时容器无法配置port和resource

#### 1.18
- `kubectl`增加创建临时容器的命令`kubectl alpha debug`
- `kubelet`和`docker`支持在创建容器时指定目标容器的`PID`命名空间，以支持临时容器的`--target`的功能

#### 1.19
`kubectl alpha debug`新增两种调试模式，可以在不支持临时容器的集群上创建调试容器
- 创建`node`调试容器，在指定`node`上创建`pod`，会使用宿主机的命名空间，并把宿主机根目录挂载到`/host`目录下，如：`kubectl alpha debug node/{nodename} -it --image=ubuntu --image-pull-policy=IfNotPresent -- /bin/bash`
- 使用`--copy-to={container}`复制指定容器的配置创建调试容器，可以修改其中的部分配置，如`image`、`command`等等

#### 1.20
- `kubectl alpha debug`升级为`beta`版，命令变为`kubectl debug`
- 临时容器仍为alpha版，默认不启用

#### 1.22
- 临时容器API做了修改，不兼容1.21及以下版本的`kubectl`
- 临时容器支持设置自己独立的`securityContext`，可以和`Pod`的不同

#### 1.23
- 临时容器升级为`beta`版，默认开启

#### 1.25
- 临时容器升级为`GA`版

## 功能
### 临时容器结构
临时容器的结构和普通容器一样，但是有些字段被禁止了，参见`allowedEphemeralContainerFields`和`validateEphemeralContainers`，位于代码`pkg/apis/core/validation/validation.go`中，禁止的字段包括`Ports`、`Resources`、`LivenessProbe`、`ReadinessProbe`、`StartupProbe`、`Lifecycle`，实际可以使用的字段如下：

| Name | Type | Description | Notes |
| ------------ | ------------- | ------------- | ------------- |
| **args** | **list[str]** | 启动参数 | [optional] |
| **command** | **list[str]** | 启动命令 | [optional] |
| **env** | **list[V1EnvVar]** | 环境变量 | [optional] |
| **env_from** | **list[V1EnvFromSource]** | 环境变量 | [optional] |
| **image** | **str** | 容器镜像 | [optional] |
| **image_pull_policy** | **str** | 镜像拉取策略 | [optional] |
| **name** | **str** | 临时容器名称 | | |
| **security_context** | **V1SecurityContext** | 安全上下文，独立于`Pod`的安全上下文 | [optional] |
| **stdin** | **bool** | 是否打开标准输入 | [optional] |
| **stdin_once** | **bool** | 标准输入仅在连接时打开，断开后即关闭 | [optional] |
| **target_container_name** | **str** | 指定目标容器名称以使用与其相同的进程命名空间 | [optional] |
| **termination_message_path** | **str** | 容器结束消息写入的文件名称 | [optional] |
| **termination_message_policy** | **str** | 容器结束消息处理方式 | [optional] |
| **tty** | **bool** | 是否启用`tty` | [optional] |
| **volume_devices** | **list[V1VolumeDevice]** | 容器使用的卷设备 | [optional] |
| **volume_mounts** | **list[V1VolumeMount]** | 容器使用的`pod`挂载卷，不支持`subpath` | [optional] |
| **working_dir** | **str** | 容器工作目录 | [optional] |

### kubectl debug
可以使用`kubectl debug`方便的创建临时容器，但是它并没有完全支持上述临时容器的所有字段，目前只支持：
- Name
- Env
- Image
- ImagePullPolicy
- Stdin
- TTY
- TargetContainerName


## 原生风险
内置准入控制插件没有处理含有临时容器的情况，如忽略了所有`subresource`的检查、忽略了对`pods`的更新操作检查等等

### CVE-2023-2727：Bypassing policies imposed by the ImagePolicyWebhook
#### 描述
用户可以通过创建临时容器的方式绕过`ImagePolicyWebhook`准入插件的权限校验使用禁止访问的镜像
#### 漏洞点
从下面的补丁中可以看出，原先在校验时没有考虑`subresource`，在没有临时容器时确实不需要考虑，在启用临时容器后，`pods`会多出一个名为`ephemeralcontainers`的`subresource`，在其中可以设置镜像
```patch
diff --git a/plugin/pkg/admission/imagepolicy/admission.go b/plugin/pkg/admission/imagepolicy/admission.go
index 6fd7f0dfad753..f1f88fef3b005 100644
--- a/plugin/pkg/admission/imagepolicy/admission.go
+++ b/plugin/pkg/admission/imagepolicy/admission.go
@@ -46,6 +46,7 @@ import (
 
 // PluginName indicates name of admission plugin.
 const PluginName = "ImagePolicyWebhook"
+const ephemeralcontainers = "ephemeralcontainers"
 
 // AuditKeyPrefix is used as the prefix for all audit keys handled by this
 // pluggin. Some well known suffixes are listed below.
@@ -132,8 +133,9 @@ func (a *Plugin) webhookError(pod *api.Pod, attributes admission.Attributes, err
 
 // Validate makes an admission decision based on the request attributes
 func (a *Plugin) Validate(ctx context.Context, attributes admission.Attributes, o admission.ObjectInterfaces) (err error) {
-	// Ignore all calls to subresources or resources other than pods.
-	if attributes.GetSubresource() != "" || attributes.GetResource().GroupResource() != api.Resource("pods") {
+	// Ignore all calls to subresources other than ephemeralcontainers or calls to resources other than pods.
+	subresource := attributes.GetSubresource()
+	if (subresource != "" && subresource != ephemeralcontainers) || attributes.GetResource().GroupResource() != api.Resource("pods") {
 		return nil
 	}
 
@@ -144,13 +146,21 @@ func (a *Plugin) Validate(ctx context.Context, attributes admission.Attributes,
 
 	// Build list of ImageReviewContainerSpec
 	var imageReviewContainerSpecs []v1alpha1.ImageReviewContainerSpec
-	containers := make([]api.Container, 0, len(pod.Spec.Containers)+len(pod.Spec.InitContainers))
-	containers = append(containers, pod.Spec.Containers...)
-	containers = append(containers, pod.Spec.InitContainers...)
-	for _, c := range containers {
-		imageReviewContainerSpecs = append(imageReviewContainerSpecs, v1alpha1.ImageReviewContainerSpec{
-			Image: c.Image,
-		})
+	if subresource == "" {
+		containers := make([]api.Container, 0, len(pod.Spec.Containers)+len(pod.Spec.InitContainers))
+		containers = append(containers, pod.Spec.Containers...)
+		containers = append(containers, pod.Spec.InitContainers...)
+		for _, c := range containers {
+			imageReviewContainerSpecs = append(imageReviewContainerSpecs, v1alpha1.ImageReviewContainerSpec{
+				Image: c.Image,
+			})
+		}
+	} else if subresource == ephemeralcontainers {
+		for _, c := range pod.Spec.EphemeralContainers {
+			imageReviewContainerSpecs = append(imageReviewContainerSpecs, v1alpha1.ImageReviewContainerSpec{
+				Image: c.Image,
+			})
+		}
 	}
 	imageReview := v1alpha1.ImageReview{
 		Spec: v1alpha1.ImageReviewSpec{
```
### CVE-2023-2728：bypassing mountable secrets policy imposed by the ServiceAccount admission plugin
#### 描述
用户可以通过创建临时容器的方式绕过`ServiceAccount`准入插件的权限校验挂载禁止访问的`Secrets`
#### 漏洞点
首先是增加对`update`操作的校验，因为创建临时容器属于对当前`pod`的`update`操作
```patch
 func NewServiceAccount() *Plugin {
 	return &Plugin{
-		Handler: admission.NewHandler(admission.Create),
+		Handler: admission.NewHandler(admission.Create, admission.Update),
 		// TODO: enable this once we've swept secret usage to account for adding secret references to service accounts
 		LimitSecretReferences: false,
 		// Auto mount service account API token secrets
```

`admission`总共支持四种操作：
- create
创建新资源
- update
更新已有资源
- delete
删除已有资源
- connect
与特定资源进行连接，如`kubectl exec`、`kubectl attach`、`kubectl port-forward`等等

其次是修改忽略规则，对于`subresource`为`ephemeralcontainers`的更新请求也需要校验
```patch
 func shouldIgnore(a admission.Attributes) bool {
-	if a.GetResource().GroupResource() != api.Resource("pods") {
-		return true
-	}
-	if a.GetSubresource() != "" {
+	if a.GetResource().GroupResource() != api.Resource("pods") || (a.GetSubresource() != "" && a.GetSubresource() != "ephemeralcontainers") {
 		return true
 	}
```

最后是增加对`ephemeralcontainers`中引用`secrets`的校验，但这里还遗漏了对`envFrom`的校验，这就导致了下面的漏洞`CVE-2024-3177`
```patch
+func (s *Plugin) limitEphemeralContainerSecretReferences(pod *api.Pod, a admission.Attributes) error {
+	// Require ephemeral container pods to have service accounts
+	if len(pod.Spec.ServiceAccountName) == 0 {
+		return admission.NewForbidden(a, fmt.Errorf("no service account specified for pod %s/%s", a.GetNamespace(), pod.Name))
+	}
+	// Ensure the referenced service account exists
+	serviceAccount, err := s.getServiceAccount(a.GetNamespace(), pod.Spec.ServiceAccountName)
+	if err != nil {
+		return admission.NewForbidden(a, fmt.Errorf("error looking up service account %s/%s: %w", a.GetNamespace(), pod.Spec.ServiceAccountName, err))
+	}
+	if !s.enforceMountableSecrets(serviceAccount) {
+		return nil
+	}
+	// Ensure all secrets the ephemeral containers reference are allowed by the service account
+	mountableSecrets := sets.NewString()
+	for _, s := range serviceAccount.Secrets {
+		mountableSecrets.Insert(s.Name)
+	}
+	for _, container := range pod.Spec.EphemeralContainers {
+		for _, env := range container.Env {
+			if env.ValueFrom != nil && env.ValueFrom.SecretKeyRef != nil {
+				if !mountableSecrets.Has(env.ValueFrom.SecretKeyRef.Name) {
+					return fmt.Errorf("ephemeral container %s with envVar %s referencing secret.secretName=\"%s\" is not allowed because service account %s does not reference that secret", container.Name, env.Name, env.ValueFrom.SecretKeyRef.Name, serviceAccount.Name)
+				}
+			}
+		}
+	}
+	return nil
+}
```

### CVE-2024-3177: Bypassing mountable secrets policy imposed by the ServiceAccount admission plugin
#### 描述
`ServiceAccount`准入插件在进行校验时，没有校验利用`envFrom`方式挂载的`secrets`，导致可以通过`envFrom`绕过其对`secrets`的权限检查
#### 漏洞点
遗漏了对`envFrom`的校验
```patch
diff --git a/plugin/pkg/admission/serviceaccount/admission.go b/plugin/pkg/admission/serviceaccount/admission.go
index c844a051c24b3..3f4338128e53c 100644
--- a/plugin/pkg/admission/serviceaccount/admission.go
+++ b/plugin/pkg/admission/serviceaccount/admission.go
@@ -337,6 +337,13 @@ func (s *Plugin) limitSecretReferences(serviceAccount *corev1.ServiceAccount, po
 				}
 			}
 		}
+		for _, envFrom := range container.EnvFrom {
+			if envFrom.SecretRef != nil {
+				if !mountableSecrets.Has(envFrom.SecretRef.Name) {
+					return fmt.Errorf("init container %s with envFrom referencing secret.secretName=\"%s\" is not allowed because service account %s does not reference that secret", container.Name, envFrom.SecretRef.Name, serviceAccount.Name)
+				}
+			}
+		}
 	}
 
 	for _, container := range pod.Spec.Containers {
@@ -347,6 +354,13 @@ func (s *Plugin) limitSecretReferences(serviceAccount *corev1.ServiceAccount, po
 				}
 			}
 		}
+		for _, envFrom := range container.EnvFrom {
+			if envFrom.SecretRef != nil {
+				if !mountableSecrets.Has(envFrom.SecretRef.Name) {
+					return fmt.Errorf("container %s with envFrom referencing secret.secretName=\"%s\" is not allowed because service account %s does not reference that secret", container.Name, envFrom.SecretRef.Name, serviceAccount.Name)
+				}
+			}
+		}
 	}
 
 	// limit pull secret references as well
@@ -388,6 +402,13 @@ func (s *Plugin) limitEphemeralContainerSecretReferences(pod *api.Pod, a admissi
 				}
 			}
 		}
+		for _, envFrom := range container.EnvFrom {
+			if envFrom.SecretRef != nil {
+				if !mountableSecrets.Has(envFrom.SecretRef.Name) {
+					return fmt.Errorf("ephemeral container %s with envFrom referencing secret.secretName=\"%s\" is not allowed because service account %s does not reference that secret", container.Name, envFrom.SecretRef.Name, serviceAccount.Name)
+				}
+			}
+		}
 	}
 	return nil
 }
```

## 配置风险
集群管理员在管理权限时忽略了临时容器
### 限制高权限账户
在某些情况下，需要授予用户创建和管理pod资源的权限，但是又不想让他通过pod逃逸到宿主机，此时往往会采取禁用特权容器、禁用`hostPath`、禁止`root`启动容器等方法来进行限制，但仍可通过创建临时容器来绕过这些限制，这是由于临时容器的`SecurityContext`不受`Pod`的`SecurityContext`的限制，可以创建特权容器
- 创建低权限`Pod`
```yaml
apiVersion: v1
kind: Pod
metadata:
  name: test
  namespace: default
spec:
  containers:
  - name: test
    image: ubuntu
    command: ["/bin/sh", "-c", "sleep 50000"]
    imagePullPolicy: IfNotPresent
    securityContext:
      runAsUser: 65534
      seccompProfile:
        type: RuntimeDefault
      allowPrivilegeEscalation: false
      capabilities:
        drop:
          - ALL
```
- 使用`kubectl debug`创建特权临时容器
```
kubectl debug test -it --image=ubuntu --image-pull-policy=IfNotPresent --target=test --profile=sysadmin -- /bin/bash
```

## 防御
使用`kyverno`禁止创建临时容器
```yaml
apiVersion: kyverno.io/v1
kind: ClusterPolicy
metadata:
  name: block-ephemeral-containers
  annotations:
    policies.kyverno.io/title: Block Ephemeral Containers
    policies.kyverno.io/category: Other
    policies.kyverno.io/severity: medium
    kyverno.io/kyverno-version: 1.6.0
    policies.kyverno.io/minversion: 1.6.0
    kyverno.io/kubernetes-version: "1.23"
    policies.kyverno.io/subject: Pod
    policies.kyverno.io/description: >-
      Ephemeral containers, enabled by default in Kubernetes 1.23, allow users to use the
      `kubectl debug` functionality and attach a temporary container to an existing Pod.
      This may potentially be used to gain access to unauthorized information executing inside
      one or more containers in that Pod. This policy blocks the use of ephemeral containers.      
spec:
  validationFailureAction: audit
  background: true
  rules:
  - name: block-ephemeral-containers
    match:
      any:
      - resources:
          kinds:
            - Pod
    validate:
      message: "Ephemeral (debug) containers are not permitted."
      pattern:
        spec:
          X(ephemeralContainers): "null"
```
