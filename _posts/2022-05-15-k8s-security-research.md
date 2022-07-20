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
> [安全公告](https://groups.google.com/g/kubernetes-security-announce)

## 概览
![](/assets/img/k8s_sec1.jpg)

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
- Flow
while cluster manager service use user provided kubeconfig to manage user's k8s cluster, a malicious user can use kubectl authentication helpers to execute arbitrary command when kubeconfig is loaded
	- exec helper<br>
	```yaml
  user:
    exec:
      args: [...]
      command: ...
      env: {...}
	```
	- gcp helper<br>
	```yaml
  user:
    auth-provider:
      config:
        cmd-args: ...
        cmd-path: ...
      name: gcp
	```

#### kube-apiserver unauthenticated access
- Prerequisites
	- `--insecure-port` is not set to 0
- Flow
attacker access kube-apiserver insecure port, such as 8080

#### kube-apiserver anonymous access
- Prerequisites
	- `--anonymous-auth` not set or set to true
- Flow
attacker can access kube-apiserver without credentials

## 组件安全

### kubectl
Kubernetes命令行工具，使得你可以对Kubernetes集群运行命令，如使用kubectl来部署应用、监测和管理集群资源以及查看日志等等

#### 代码
> RootPath: pkg/kubectl

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
![](/assets/img/k8s_sec6.jpg)
![](/assets/img/k8s_sec7.png)

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

#### 代码
> RootPath: pkg/kubelet

##### Server
kubelet监听在10250端口，开放了一些API，可通过HTTPS访问。主要代码在`server/server.go`中，`NewServer`函数负责创建服务，主要包含三个部分：
- InstallAuthFilter：认证授权，大部分为自动生成的代码
- InstallDefaultHandlers：默认API，`/healthz、/pods、/stats/[summary, {podName}/{containerName}, {namespace}/{podName}/{uid}/{containerName}]、metrics`
- InstallDebuggingHandlers：调试API，默认开启，`/run、/exec、/attach、/portForward、/logs(读取/var/log目录下的文件)、/containerLogs、/runningpods、/debug/pprof/[profile, symbol, cmdline, trace]`

##### Manager

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

#### 代码
> RootPath: staging/src/k8s.io/apiserver

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

#### 代码

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

#### 代码

#### 漏洞

#### 挖掘思路

### kube-proxy
`kube-proxy`是一个网络代理服务，运行在每一个K8S节点上，负责维护`pod`间通信、`node`间通信以及和外部的通信等等的网络规则

#### 命令行/配置

#### 代码

#### 漏洞

- [CVE-2020-8558: route_localnet漏洞](https://github.com/tabbysable/POC-2020-8558)

#### 挖掘思路
该组件已知漏洞较少，主要为网络配置上的安全问题，大体思路如下：

- 不安全的网络配置

## 插件安全

### ingress-nginx

#### 命令行/配置

#### 代码
> https://github.com/kubernetes/ingress-nginx

#### 漏洞

- [CVE-2021-25742 snippet command execution](https://github.com/noirfate/k8s_debug/tree/main/CVE-2021-25742)
- [CVE-2021-25745,CVE-2021-25746,CVE-2021-25748](https://blog.lightspin.io/kubernetes-nginx-ingress-controller-vulnerabilities)

#### 挖掘思路
已知漏洞都是通过对ingress的配置影响nginx配置，导致代码执行、敏感信息泄露等漏洞

## 供应链安全

### SBOM to Vulns
> https://security.googleblog.com/2022/06/sbom-in-action-finding-vulnerabilities.html
