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

## 概览
![](/assets/img/k8s_sec1.jpg)

## 威胁分析

### 伪造欺骗

### 篡改

### 抵赖

### 拒绝服务

- 触发代码中的`panic`函数
- 触发死循环
- 触发channel堵塞
- 触发死锁

### 信息泄露

### 权限提升

## 组件

### kubectl
kubernetes命令行管理工具

#### 命令行/配置
- 资源缩写
resource                    |  abbreviation
----------------------------|--------------
componentstatuses           |  cs
configmaps                  |  cm
endpoints                   |  ep
events                      |  ev
limitranges                 |  limits
namespaces                  |  ns
nodes                       |  no
persistentvolumeclaims      |  pvc
persistentvolumes           |  pv
pods                        |  po
replicationcontrollers      |  rc
resourcequotas              |  quota
serviceaccounts             |  sa
services                    |  svc
customresourcedefinitions   |  crd,crds
controllerrevisions         |  apps
daemonsets                  |  ds
deployments                 |  deploy
replicasets                 |  rs
statefulsets                |  sts
horizontalpodautoscalers    |  hpa
cronjobs                    |  cj
certificatesigningrequests  |  csr
events                      |  ev
ingresses                   |  ing
networkpolicies             |  netpol
poddisruptionbudgets        |  pdb
podsecuritypolicies         |  psp
priorityclasses             |  pc
storageclasses              |  sc

#### 插件
> https://krew.sigs.k8s.io/plugins/

- [rakkess](https://github.com/corneliusweig/rakkess): RBAC权限枚举工具
- [kubectl-who-can](https://github.com/aquasecurity/kubectl-who-can): 列出哪些用户可以操作特定资源
- [kube-prompt](https://github.com/c-bata/kube-prompt): kubectl交互式工具

#### 代码

#### 漏洞

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
- SyncLoop
	- configCh
	![](/assets/img/k8s_sec8.png)
	- plegCh
	获取`PLEG`消息，如果消息不是`ContainerRemoved`则调用`handler.HandlePodSyncs`，回收`Pod`中停止的容器。比如用`docker stop`停止一个容器，`plegCh`就会返回`ContainerDied`消息，`kubelet`会重启这个容器


#### 漏洞

