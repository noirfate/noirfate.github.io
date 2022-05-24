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

## 威胁分析

### 容器逃逸

#### 漏洞案例

##### [CVE-2017-1002101](https://noirfate.github.io/2022/04/18/k8s-env#cve-2017-1002101)
容器A和容器B都挂载相同的`hostPath`，容器A先启动并在`hostPath`下创建指向`/`的符号链接`rootLink`，设置容器B的`hostPath`的`subPath`为`rootLink`，当启动容器B后，`kubelet`会把宿主机`/`挂载到容器B中<br>

##### [CVE-2018-1002100](https://noirfate.github.io/2022/04/18/k8s-env#cve-2018-1002100)
`kubctl cp`从容器拷贝到宿主机时，调用容器中的`tar`命令对文件进行打包，然后在宿主机解压，解压时没有对文件路径进行校验，攻击者可构造恶意`tar`导致路径穿越覆盖宿主机上的任意文件

##### [CVE-2021-25741](https://noirfate.github.io/2022/04/18/k8s-env#cve-2021-25741)
CVE-2017-1002101的修复策略不完善，如下图所示，在校验完成后会调用`mount`，而`mount`会跟随符号链接，这会产生TOCTOU漏洞。通过`renameat2(AT_FDCWD, source, AT_FDCWD, dest, RENAME_EXCHANGE)`系统调用在校验后`mount`前修改路径为符号链接

######
![](/assets/img/cve-2017-1002101-fix.jpeg)
*Fig. CVE-2017-1002101 Fix*
{:.image-caption}
######
![](/assets/img/cve-2021-25741-toctou.png)
*Fig. CVE-2021-25741 TOCTOU*
{:.image-caption}

#### 挖掘思路
> 此类问题集中在`kubelet`组件中

- 处理路径时是否follow符号链接
- 处理路径时是否存在路径穿越问题
- 检查路径时是否存在`TOCTOU`的问题

### 拒绝服务

#### 漏洞案例

#### 挖掘思路

- 触发代码中的`panic`函数
- 触发死循环
- 触发channel堵塞
- 触发死锁

### 信息泄露

#### 漏洞案例

#### 挖掘思路

### 权限提升

#### 漏洞案例

##### [CVE-2018-1002105](https://noirfate.github.io/2022/04/18/k8s-env#cve-2018-1002105)
当用户具备名字空间A中的`pods/exec`权限时，可构造错误的`pods/exec`请求给`kube-apiserver`，它会把请求转发给`kubelet`，但由于没有判断返回值，导致`kube-apiserver`和`kubelet`的连接依旧存在。攻击者通过复用该连接，可在该`kubelet`掌管的所有`pod`中执行任意命令
![](/assets/img/k8s_sec11.png)

#### 挖掘思路

- kube-apiserver的proxy代理通道是否存在滥用的可能

## 组件分析

### kubectl
Kubernetes命令行工具，使得你可以对Kubernetes集群运行命令，如使用kubectl来部署应用、监测和管理集群资源以及查看日志等等

#### 代码
> RootPath: pkg/kubectl

#### 漏洞

- [CVE-2018-1002100](#cve-2018-1002100)

### kubelet
kubelet 是在每个 Node 节点上运行的主要 “节点代理”，接受通过各种机制（主要是通过 apiserver）提供的一组 PodSpec，并确保这些 PodSpec 中描述的容器处于运行状态且运行状况良好
![](/assets/img/k8s_sec6.jpg)
![](/assets/img/k8s_sec7.png)

#### 命令行/配置
> 修改`/etc/systemd/system/kubelet.service.d/10-kubeadm.conf`变更启动参数，执行`systemctl daemon-reload`加载新配置，重启`systemctl restart kubelet`

- `--enable-debugging-handlers`，默认是`true`，关闭它则不能通过`kubelet`进入容器执行命令或查看日志了，相关代码见`pkg/kubelet/server.go:InstallDebuggingHandlers`
- `--anonymous-auth`，默认是`true`，允许匿名访问
- `--authorization-mode`，没有设置`--config`时默认是`AlwaysAllow`，设置了则为`Webhook`，`Webhook`使用`apiserver`的`SubjectAccessReview`进行鉴权
- `--bootstrap-kubeconfig`，`kubelet`使用`bootstrap-token`向`apiserver`申请证书，生成配置，[官方文档](https://kubernetes.io/zh/docs/reference/command-line-tools-reference/kubelet-tls-bootstrapping/)、[参考1](https://suraj.io/post/add-new-k8s-node-bootstrap-token/)、[参考2](https://suraj.io/post/2021/02/k8s-bootstrap-token/)

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

- [CVE-2017-1002101](#cve-2017-1002101)
- [CVE-2021-25741](#cve-2021-25741)

### kube-apiserver
Kubernetes API 服务器验证并配置 API 对象的数据， 这些对象包括 pods、services、replicationcontrollers 等。 API 服务器为 REST 操作提供服务，并为集群的共享状态提供前端， 所有其他组件都通过该前端进行交互

#### 命令行/配置

- `--allow-privileged`，默认是`false`，设为`true`时允许创建特权容器
- `--anonymous-auth`，默认是`true`，允许匿名请求，用户名为`system:anonymous`，用户组为`system:unauthenticated`
- `--enable-bootstrap-token-auth`，启用以允许将`kube-system`名字空间中类型为`bootstrap.kubernetes.io/token`的`Secret`用于TLS引导身份验证
- `--token-auth-file`，设置认证令牌，该令牌长期有效，在不重启的情况下无法修改，文件格式为`csv`，内容为`token,user,uid,"group1,group2,group3"`

#### 代码
> RootPath: staging/src/k8s.io/apiserver

#### 漏洞

- [CVE-2018-1002105](#cve-2018-1002105)
