---
title: Cloud Security
layout: post
categories: redteaming
tags: cloud security
date: 2021-11-24 18:00
excerpt: Cloud Security
---

{:.table-of-content}
* TOC
{:toc}

# 云原生

## 云安全博客

- [intezer](https://www.intezer.com/blog/cloud-security/)
- [rhinosecuritylabs](https://rhinosecuritylabs.com/blog/)
- [wiz](https://www.wiz.io/blog)

## 开源情报

- [hacking8](https://i.hacking8.com/)

## k8s知识

- [Kubernetes指南](https://feisky.gitbooks.io/kubernetes)
- [kubernetes中文指南](https://jimmysong.io/kubernetes-handbook)
- [kubernetes RBAC介绍](https://www.cncf.io/wp-content/uploads/2020/08/2020_04_Introduction-to-Kubernetes-RBAC.pdf)
- [历史漏洞 - git issue](https://github.com/kubernetes/kubernetes/issues?q=label%3Aarea%2Fsecurity+is%3Aclosed)
- [历史漏洞 - git changelog](https://github.com/kubernetes/kubernetes/tree/master/CHANGELOG)
- [历史漏洞 - hackerone](https://hackerone.com/kubernetes/hacktivity?type=team)
- user namespace逃逸问题
	- k8s默认没有用docker的seccomp规则,在启动的容器中可以通过unshare -mr bash获得全部的cap,再通过mount cgroup逃逸
	- 可用 seccomp.security.alpha.kubernetes.io/pod: runtime/default 配置禁用unshare [参考](https://snyk.io/blog/kernel-privilege-escalation/)
	- 可通过禁用user namespace来防止逃逸`echo 0 > /proc/sys/user/max_user_namespaces` [参考](https://www.stigviewer.com/stig/red_hat_enterprise_linux_8/2020-11-25/finding/V-230548)
	- [user namespace man](https://man7.org/linux/man-pages/man7/user_namespaces.7.html)
- [cloudformation injection](https://rhinosecuritylabs.com/aws/cloud-malware-cloudformation-injection/)
	- 服务从S3桶下载执行模板或代码
	- 攻击者为具有S3桶读写权限的IAM子用户
	- 攻击者创建函数，当其他用户上传模板和代码时触发
	- 在触发函数中修改其他用户上传的文件，只有修改的操作早于服务从S3桶下载，即可完成注入攻击
- k8s pod安全策略
	- [security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
	- [pod安全配置介绍](https://medium.com/kubernetes-tutorials/defining-privileges-and-access-control-settings-for-pods-and-containers-in-kubernetes-2cef08fc62b7) [其他](https://fuckcloudnative.io/posts/security-best-practices-for-kubernetes-pods/)
- [linux capability](https://fuckcloudnative.io/posts/linux-capabilities-why-they-exist-and-how-they-work/) [文章1](https://fuckcloudnative.io/posts/linux-capabilities-in-practice-1/) [文章2](https://fuckcloudnative.io/posts/linux-capabilities-in-practice-2/) [利用](https://book.hacktricks.xyz/linux-unix/privilege-escalation/linux-capabilities)
- [docker的init进程](https://shareinto.github.io/2019/01/30/docker-init(1)/)
- [k8s审计工具介绍](https://fuckcloudnative.io/posts/tools-and-methods-for-auditing-kubernetes-rbac-policies/)
- [利用user namespace增强安全性](https://kinvolk.io/blog/2020/12/improving-kubernetes-and-container-security-with-user-namespaces/)


## 云原生攻击

- [通过伪造节点的证书签名请求获取证书访问集群（有csr权限）](https://www.4armed.com/blog/hacking-kubelet-on-gke/) [另一篇](https://rhinosecuritylabs.com/cloud-security/kubelet-tls-bootstrap-privilege-escalation/) [参考](https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/)
![](/assets/img/cs1.png)
- [红蓝对抗中的云原生漏洞挖掘及利用实录](https://mp.weixin.qq.com/s/Aq8RrH34PTkmF8lKzdY38g)
- [A Compendium of Container Escapes](https://capsule8.com/assets/ug/us-19-Edwards-Compendium-Of-Container-Escapes.pdf)
- [Royal Flush: Privilege Escalation Vulnerability in Azure Functions（debugfs利用）](https://www.intezer.com/blog/cloud-security/royal-flush-privilege-escalation-vulnerability-in-azure-functions/)
- [win silo容器逃逸](https://unit42.paloaltonetworks.com/what-i-learned-from-reverse-engineering-windows-containers/) [其他1](https://unit42.paloaltonetworks.com/windows-server-containers-vulnerabilities/) [其他2](https://unit42.paloaltonetworks.com/siloscape/)
- [利用Linux内核漏洞实现Docker逃逸](https://paper.seebug.org/1602/)
- [Container Escape in 2021](https://conference.hitb.org/hitbsecconf2021sin/materials/D2T2%20-%20Ccntainer%20Escape%20in%202021%20-%20Li%20Qiang.pdf)
- [kata逃逸](https://wohin.me/kata-containerstao-yi-yan-jiu/)
- [AWS跨账号读写桶](https://www.wiz.io/blog/black-hat-2021-aws-cross-account-vulnerabilities-how-isolated-is-your-cloud-environment) [PPT](https://i.blackhat.com/USA21/Wednesday-Handouts/us-21-Breaking-The-Isolation-Cross-Account-AWS-Vulnerabilities.pdf)
- [ChaosDB Explained: Azure's Cosmos DB Vulnerability](https://www.wiz.io/blog/chaosdb-explained-azures-cosmos-db-vulnerability-walkthrough)

## 云原生工具

- [镜像扫描](https://github.com/aquasecurity/trivy)
- [k8s集群扫描](https://github.com/aquasecurity/starboard)
- [tracee - 入侵检测](https://github.com/aquasecurity/tracee)
- [CDK - 容器逃逸](https://github.com/cdk-team/CDK)
- [ctrsploit - 容器逃逸](https://github.com/ctrsploit/ctrsploit)
- [kubesploit - k8s渗透远控](https://github.com/cyberark/kubesploit)
- [metarget - 云原生靶场](https://github.com/brant-ruan/metarget) [介绍](https://mp.weixin.qq.com/s/EULJgDrCvuq3DwUpGUskfQ)
- [kubernetes-goat - k8s靶场](https://github.com/madhuakula/kubernetes-goat)
- [kubeletctl](https://github.com/cyberark/kubeletctl)
- [解密k8s etcd存储](https://github.com/jpbetz/auger)
- [whaler - 从docker镜像推导出dockerfile](https://github.com/P3GLEG/Whaler)
- [dive - docker镜像分析工具](https://github.com/wagoodman/dive) [docker镜像分析](https://theartofmachinery.com/2021/03/18/reverse_engineering_a_docker_image.html)
- [krew - kubectl插件管理工具](https://github.com/kubernetes-sigs/krew/)
- [rakkess - kubectl权限检查工具](https://github.com/corneliusweig/rakkess)

## CVE

- [CVE-2017-1002101: k8s subpath mount符号链接逃逸](http://blog.nsfocus.net/cve-2017-1002101/) [POC](https://github.com/bgeesaman/subpath-exploit)
- [CVE-2018-1002100 CVE-2019-1002101: kubectl cp路径穿越](https://unit42.paloaltonetworks.com/disclosing-directory-traversal-vulnerability-kubernetes-copy-cve-2019-1002101/) [CVE-2018-1002100](https://hansmi.ch/articles/2018-04-openshift-s2i-security)
- [CVE-2018-1002105: k8s apiserver <=> kubelet连接保持提权漏洞](https://paper.seebug.org/757/#1)
- [CVE-2019-11250: Bearer tokens are revealed in logs](https://github.com/kubernetes/kubernetes/issues/81114)
- [CVE-2019-11253: Kubernetes API Server YAML Parsing Remote DOS](https://gist.github.com/bgeesaman/0e0349e94cd22c48bf14d8a9b7d6b8f2)
- [CVE-2020-8555: k8s controler SSRF](https://medium.com/@BreizhZeroDayHunters/when-its-not-only-about-a-kubernetes-cve-8f6b448eafa8)
- [CVE-2020-8561: k8s apiserver SSRF](https://hackerone.com/reports/941178) [公告](https://groups.google.com/g/kubernetes-security-announce/c/RV2IhwcrQsY)
- [CVE-2020-15157: container image SSRF](https://darkbit.io/blog/cve-2020-15157-containerdrip)
- [CVE-2021-3847: overlayfs文件安全属性拷贝问题](https://www.openwall.com/lists/oss-security/2021/10/14/3)
- [CVE-2021-25741: k8s subpath mount符号链接条件竞争逃逸](https://sysdig.com/blog/cve-2021-25741-kubelet-falco/)
- [CVE-2021-27075: Azure虚机上的普通用户可以访问VM extenstion中的敏感信息](https://www.intezer.com/blog/cloud-security/cve-2021-27075-microsoft-azure-vulnerability-allows-privilege-escalation-and-leak-of-data/)
- [CVE-2021-28112: AWS workspace client 命令注入RCE](https://rhinosecuritylabs.com/aws/cve-2021-38112-aws-workspaces-rce/)
- [CVE-2021-41091: 利用/var/lib/docker下可setuid执行程序提权](https://nvd.nist.gov/vuln/detail/CVE-2021-41091) [公告](https://github.com/moby/moby/security/advisories/GHSA-3fwx-pjgw-3558)

