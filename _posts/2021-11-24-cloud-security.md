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
- [champtar](https://blog.champtar.fr/)
- [Cloud Service Provider security mistakes](https://github.com/SummitRoute/csp_security_mistakes)
- [Azure RedTeam](https://github.com/rootsecdev/Azure-Red-Team#stealing-tokens-from-az-powershell)

## 开源情报

- [hacking8](https://i.hacking8.com/)

## k8s知识

- 架构
![](/assets/img/cs2.png)
![](/assets/img/cs3.png)
- [Kubernetes指南](https://feisky.gitbooks.io/kubernetes)
- [kubernetes中文指南](https://jimmysong.io/kubernetes-handbook)
- [kubernetes RBAC介绍](https://www.cncf.io/wp-content/uploads/2020/08/2020_04_Introduction-to-Kubernetes-RBAC.pdf)
- [kubernetes历史漏洞 - git issue](https://github.com/kubernetes/kubernetes/issues?q=label%3Aarea%2Fsecurity+is%3Aclosed)
- [kubernetes历史漏洞 - git changelog](https://github.com/kubernetes/kubernetes/tree/master/CHANGELOG)
- [kubernetes历史漏洞 - hackerone](https://hackerone.com/kubernetes/hacktivity?type=team)
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
- [云原生安全书的相关源码](https://github.com/Metarget/cloud-native-security-book)

## 云原生攻击

- [通过伪造节点的证书签名请求获取证书访问集群（有csr权限）](https://www.4armed.com/blog/hacking-kubelet-on-gke/) [另一篇](https://rhinosecuritylabs.com/cloud-security/kubelet-tls-bootstrap-privilege-escalation/) [参考](https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/)
![](/assets/img/cs1.png)
- [红蓝对抗中的云原生漏洞挖掘及利用实录](https://mp.weixin.qq.com/s/Aq8RrH34PTkmF8lKzdY38g)
- [A Compendium of Container Escapes](https://capsule8.com/assets/ug/us-19-Edwards-Compendium-Of-Container-Escapes.pdf)
- [Royal Flush: Privilege Escalation Vulnerability in Azure Functions（debugfs利用）](https://www.intezer.com/blog/cloud-security/royal-flush-privilege-escalation-vulnerability-in-azure-functions/)
- [win silo容器逃逸](https://unit42.paloaltonetworks.com/what-i-learned-from-reverse-engineering-windows-containers/) [其他1](https://unit42.paloaltonetworks.com/windows-server-containers-vulnerabilities/) [其他2](https://unit42.paloaltonetworks.com/siloscape/)
- [利用Linux内核漏洞实现Docker逃逸](https://paper.seebug.org/1602/)
- [Container Escape in 2021](https://conference.hitb.org/hitbsecconf2021sin/materials/D2T2%20-%20Ccntainer%20Escape%20in%202021%20-%20Li%20Qiang.pdf)
- [kata逃逸](https://wohin.me/kata-containerstao-yi-yan-jiu/) [POC](https://github.com/Metarget/cloud-native-security-book/tree/main/code/0304-%E8%BF%90%E8%A1%8C%E6%97%B6%E6%94%BB%E5%87%BB/02-%E5%AE%89%E5%85%A8%E5%AE%B9%E5%99%A8%E9%80%83%E9%80%B8)
- [AWS跨账号读写桶](https://www.wiz.io/blog/black-hat-2021-aws-cross-account-vulnerabilities-how-isolated-is-your-cloud-environment) [PPT](https://i.blackhat.com/USA21/Wednesday-Handouts/us-21-Breaking-The-Isolation-Cross-Account-AWS-Vulnerabilities.pdf)
- [ChaosDB Explained: Azure's Cosmos DB Vulnerability](https://www.wiz.io/blog/chaosdb-explained-azures-cosmos-db-vulnerability-walkthrough)
- [Kubernetes Pod Escape Using Log Mounts](https://blog.aquasec.com/kubernetes-security-pod-escape-log-mounts) [POC](https://github.com/danielsagi/kube-pod-escape)
- [gcp dhcp takeover code exec](https://github.com/irsl/gcp-dhcp-takeover-code-exec)
- [jwt token伪造](https://medium.com/@sajan.dhakate/exploiting-json-web-token-jwt-73d172b5bc02)
- AWS IAM提权
	- [privilege escalation in aws](https://labs.bishopfox.com/tech-blog/privilege-escalation-in-aws)
	- [aws iam privilege escalation playground](https://labs.bishopfox.com/tech-blog/iam-vulnerable-an-aws-iam-privilege-escalation-playground)
	- [iam-vulnerable](https://github.com/BishopFox/iam-vulnerable)
	- [Pmapper](https://github.com/nccgroup/PMapper)
	- [aws privilege escalation methods mitigation](https://rhinosecuritylabs.com/aws/aws-privilege-escalation-methods-mitigation/)
	- [cloudsplaining](https://github.com/salesforce/cloudsplaining/ )
	- [aws-assessment-tools](https://labs.bishopfox.com/tech-blog/iam-vulnerable-assessing-the-aws-assessment-tools)
- [azure 容器逃逸](https://unit42.paloaltonetworks.com/azure-container-instances/)
- [在容器中偷取主机runc](https://github.com/twistlock/whoc)
- [azure omi agent rce](https://www.wiz.io/blog/secret-agent-exposes-azure-customers-to-unauthorized-code-execution)
- [azure利用service principal提权](https://posts.specterops.io/azure-privilege-escalation-via-service-principal-abuse-210ae2be2a5 )
- [digitalocean k8s逃逸](https://www.4armed.com/blog/hacking-digitalocean-kubernetes/)
- [普罗未授权访问](https://jfrog.com/blog/dont-let-prometheus-steal-your-fire/)
- [A review of Azure Sphere vulnerabilities](https://blog.talosintelligence.com/2021/11/a-review-of-azure-sphere.html)
- [Azure privilege escalation via azure api permissions abuse](https://posts.specterops.io/azure-privilege-escalation-via-azure-api-permissions-abuse-74aee1006f48)
- [部署后门api-server pod](https://www.cdxy.me/?p=839)
- [GCP AppSheet SSRF](https://nechudav.blogspot.com/2021/12/ssrf-vulnerability-in-appsheet-google.html)
- [GCP metadata MITM escape](https://blog.champtar.fr/Metadata_MITM_root_EKS_GKE/)
- [Amazon WorkSpaces Eltima SDK win提权漏洞](https://www.sentinelone.com/labs/usb-over-ethernet-multiple-privilege-escalation-vulnerabilities-in-aws-and-other-major-cloud-services/)
- [AWS SageMaker Jupyter Notebook Instance Takeover](https://blog.lightspin.io/aws-sagemaker-notebook-takeover-vulnerability)
- [Azure app service source code leak](https://www.wiz.io/blog/azure-app-service-source-code-leak)
- [Cloud security breaches and vulnerabilities 2021 in review](https://blog.christophetd.fr/cloud-security-breaches-and-vulnerabilities-2021-in-review/)
- [VMWare Workspace One Access SSRF](https://blog.assetnote.io/2022/01/17/workspace-one-access-ssrf/)
- [AWS exploit lambda trigger via S3 filename](https://sysdig.com/blog/exploit-mitigate-aws-lambdas-mitre/)
- [利用ebpf逃逸](https://drivertom.blogspot.com/2022/01/ebpfdocker.html) [文章](https://security.tencent.com/index.php/blog/msg/206)
- [AWS CloudFormation XXE](https://orca.security/resources/blog/aws-cloudformation-vulnerability/)
- [利用内核模块进行逃逸](https://github.com/xcellerator/linux_kernel_hacking/tree/master/3_RootkitTechniques/3.8_privileged_container_escaping)

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
- [pacu - AWS后渗透工具](https://rhinosecuritylabs.com/aws/pacu-open-source-aws-exploitation-framework/)
- [gcphound - GCP渗透工具](https://desi-jarvis.medium.com/gcphound-a-swiss-army-knife-offensive-toolkit-for-google-cloud-platform-gcp-fb9e18b959b4)
- [cloudgoat - aws靶场](https://github.com/RhinoSecurityLabs/cloudgoat)
- 云资源关系可视化
	- [awspx](https://github.com/FSecureLABS/awspx)
	- [Stormspotter](https://github.com/Azure/Stormspotter)

## CVE

- [CVE-2015-2925: 利用kernel bind mount漏洞逃逸](https://github.com/kagami/docker_cve-2015-2925)
- [CVE-2017-1002101: k8s subpath mount符号链接逃逸](http://blog.nsfocus.net/cve-2017-1002101/) [POC](https://github.com/bgeesaman/subpath-exploit)
- [CVE-2018-15664: docker cp symlink-race attack](http://mayoterry.com/index.php/archives/69.html) [POC](https://github.com/Metarget/cloud-native-security-book/tree/main/code/0302-%E5%BC%80%E5%8F%91%E4%BE%A7%E6%94%BB%E5%87%BB/02-CVE-2018-15664/symlink_race)
- [CVE-2018-1002100 CVE-2019-1002101: kubectl cp路径穿越](https://unit42.paloaltonetworks.com/disclosing-directory-traversal-vulnerability-kubernetes-copy-cve-2019-1002101/) [CVE-2018-1002100](https://hansmi.ch/articles/2018-04-openshift-s2i-security)
- [CVE-2018-1002105: k8s apiserver <=> kubelet连接保持提权漏洞](https://paper.seebug.org/757/#1)
- [CVE-2019-5736: docker runc覆盖逃逸](https://unit42.paloaltonetworks.com/breaking-docker-via-runc-explaining-cve-2019-5736/) [POC](https://github.com/BBRathnayaka/POC-CVE-2019-5736)
- [CVE-2019-9512: HTTP/2 DOS](https://github.com/Metarget/cloud-native-security-book/tree/main/code/0404-K8s%E6%8B%92%E7%BB%9D%E6%9C%8D%E5%8A%A1%E6%94%BB%E5%87%BB)
- [CVE-2019-9946: k8s 利用hostport进行中间人攻击](http://blog.champtar.fr/CVE-2019-9946/)
- [CVE-2019-13139: docker build exec](https://staaldraad.github.io/post/2019-07-16-cve-2019-13139-docker-build/)
- [cve-2019-11247: 通过访问namespace api endpoint，越权增删改查全局CRD资源](https://www.stackrox.io/blog/how-to-remediate-kubernetes-security-vulnerability-cve-2019-11247/)
- [CVE-2019-11250: Bearer tokens are revealed in logs](https://github.com/kubernetes/kubernetes/issues/81114)
- [CVE-2019-11253: Kubernetes API Server YAML Parsing Remote DOS](https://gist.github.com/bgeesaman/0e0349e94cd22c48bf14d8a9b7d6b8f2)
- [CVE-2019-14271: docker cp libnss_files.so escape](https://unit42.paloaltonetworks.com/docker-patched-the-most-severe-copy-vulnerability-to-date-with-cve-2019-14271/) [POC](https://github.com/Metarget/cloud-native-security-book/tree/main/code/0302-%E5%BC%80%E5%8F%91%E4%BE%A7%E6%94%BB%E5%87%BB/03-CVE-2019-14271)
- [CVE-2019-16884: AppArmor bypass via malicious image](https://github.com/opencontainers/runc/issues/2128)
- [CVE-2019–18801: envoy heap overflow](https://blog.envoyproxy.io/exploiting-an-envoy-heap-vulnerability-96173d41792)
- [CVE-2020-8554: k8s service流量劫持](https://unit42.paloaltonetworks.com/cve-2020-8554/) [POC](https://hackerone.com/reports/764986)
- [CVE-2020-8555: k8s controler SSRF](https://medium.com/@BreizhZeroDayHunters/when-its-not-only-about-a-kubernetes-cve-8f6b448eafa8) [其他](https://hackerone.com/reports/776017)
- [CVE-2020-8557: Node disk DOS by writing to container /etc/hosts](https://github.com/kubernetes/kubernetes/issues/93032) [其他](https://hackerone.com/reports/867699)
- [CVE-2020-8558: route_localnet漏洞](https://github.com/tabbysable/POC-2020-8558)
- [CVE-2020-8561: k8s apiserver SSRF](https://hackerone.com/reports/941178) [公告](https://groups.google.com/g/kubernetes-security-announce/c/RV2IhwcrQsY)
- [CVE-2020-14343: k8s test-infra yaml.load exec](https://hackerone.com/reports/1051192)
- [CVE-2020-15157: container image SSRF](https://darkbit.io/blog/cve-2020-15157-containerdrip)
- [CVE-2020-15257: containerd-shim abstract namespace unix socket](https://research.nccgroup.com/2020/12/10/abstract-shimmer-cve-2020-15257-host-networking-is-root-equivalent-again/) [POC1](https://github.com/nccgroup/abstractshimmer) [POC2](https://www.cdxy.me/?p=837)
- [CVE-2021-3121: Out Of Bounds in protobuf unmarshalling](https://hackerone.com/reports/1073363)
- [CVE-2021-3847: overlayfs文件安全属性拷贝问题](https://www.openwall.com/lists/oss-security/2021/10/14/3)
- [CVE-2021-25738: k8s java client parse yaml exec](https://j0vsec.com/post/cve-2021-25738/) [POC](https://github.com/jordyv/poc-snakeyaml)
- [CVE-2021-25741: k8s subpath mount符号链接条件竞争逃逸](https://sysdig.com/blog/cve-2021-25741-kubelet-falco/)
- [CVE-2021-25742: k8s ingress-nginx read local file](https://hackerone.com/reports/1249583)
- [CVE-2021-27075: Azure虚机上的普通用户可以访问VM extenstion中的敏感信息](https://www.intezer.com/blog/cloud-security/cve-2021-27075-microsoft-azure-vulnerability-allows-privilege-escalation-and-leak-of-data/)
- [CVE-2021-28112: AWS workspace client 命令注入RCE](https://rhinosecuritylabs.com/aws/cve-2021-38112-aws-workspaces-rce/)
- [CVE-2021-30465: docker runc mount TOCTOU](https://www.kingkk.com/2021/06/runc%E5%AE%B9%E5%99%A8%E9%80%83%E9%80%B8%E6%BC%8F%E6%B4%9E%E5%88%86%E6%9E%90%EF%BC%88CVE-2021-30465%EF%BC%89/) [其他](https://hackmd.io/@mauilion/By2CV2MtO)
- [CVE-2021-41091: 利用/var/lib/docker下可setuid执行程序提权](https://nvd.nist.gov/vuln/detail/CVE-2021-41091) [公告](https://github.com/moby/moby/security/advisories/GHSA-3fwx-pjgw-3558)
- [CVE-2021-43784: runc netlink message int16 overflow](https://bugs.chromium.org/p/project-zero/issues/detail?id=2241)

# QEMU/HyperV

## 知识

- [QEMU 源码分析](https://airbus-seclab.github.io/qemu_blog/)
- [QEMU 博客](https://airbus-seclab.github.io/qemu_blog/)
- [HyperV攻击面](https://i.blackhat.com/USA21/Wednesday-Handouts/us-21-Mobius-Band-Explore-Hyper-V-Attack-Interface-Through-Vulnerabilities-Internals.pdf)

## 漏洞

- [QEMU Heap Overflow in SDHCI Component](https://starlabs.sg/advisories/21-3409/)
- [QEMU Misuse Error Handling逃逸](https://github.com/hustdebug/scavenger)
- [QEMU Virglrenderer逃逸](https://i.blackhat.com/asia-20/Thursday/asia-20-Shao-3D-Red-Pill-A-Guest-To-Host-Escape-On-QEMUKVM-Virtio-Device-wp.pdf)
- [QEMU vGPU逃逸](https://i.blackhat.com/USA21/Wednesday-Handouts/us-21-Another-Road-Leads-To-The-Host-From-A-Message-To-VM-Escape-On-Nvidia-VGPU.pdf)

# KERNEL

## 知识

- [kvm安全](https://github.com/rafaeldtinoco/howtos)

## 博客

- [project zero](https://googleprojectzero.blogspot.com/)
- [Aleph Research](https://alephsecurity.com/)
- [Alexander Popov](https://a13xp0p0v.github.io/)
- [pwn2own 2021 ubuntu lpe](https://flatt.tech/assets/reports/210401_pwn2own/whitepaper.pdf)

## CVE

- [CVE-2016-5195: Dirty Cow](https://github.com/dirtycow/dirtycow.github.io/wiki/PoCs)
- [CVE-2020-8835: 利用ebpf verification漏洞提权](https://www.zerodayinitiative.com/blog/2020/4/8/cve-2020-8835-linux-kernel-privilege-escalation-via-improper-ebpf-program-verification)
- [CVE-2020-12351/CVE-2020-12352: BleedingTooth: Linux Bluetooth Zero-Click Remote Code Execution](https://github.com/google/security-research/tree/master/pocs/linux/bleedingtooth)
- [CVE-2021-3178: nfs leak](https://bugzilla.redhat.com/show_bug.cgi?id=1918179)
- [CVE-2021-3493: overlayfs file capability eop](https://ssd-disclosure.com/ssd-advisory-overlayfs-pe/)
- [CVE-2021-20226: a reference counting bug which leads to local privilege escalation in io_uring](https://flattsecurity.medium.com/cve-2021-20226-a-reference-counting-bug-which-leads-to-local-privilege-escalation-in-io-uring-e946bd69177a)
- [CVE-2021-22543: KVM VM_IO|VM_PFNMAP vma mishandling](https://github.com/google/security-research/security/advisories/GHSA-7wq5-phmq-m584)
- [CVE-2021-22555: Heap Out-Of-Bounds Write in xt_compat_target_from_user](https://github.com/google/security-research/tree/master/pocs/linux/cve-2021-22555)
- [CVE-2021-29657: AMD KVM Guest Escape](https://googleprojectzero.blogspot.com/2021/06/an-epyc-escape-case-study-of-kvm.html)
- [CVE-2021-33909: fs/seq_file提权](https://www.qualys.com/2021/07/20/cve-2021-33909/sequoia-local-privilege-escalation-linux.txt) [POC](https://github.com/Liang2580/CVE-2021-33909)
- [CVE-2021-42008: 6pack driver提权](https://syst3mfailure.io/sixpack-slab-out-of-bounds)
- [CVE-2021-43267: tipc eop](https://haxx.in/posts/pwning-tipc/)
- [CVE-2022-0185: fsconfig heap overflow](https://github.com/Crusaders-of-Rust/CVE-2022-0185) [文章](https://www.willsroot.io/2022/01/cve-2022-0185.html)

# APP

- [利用sudo程序在logrotate.d目录下产生coredump，从而提权](https://www.openwall.com/lists/oss-security/2021/10/20/2)
- [ubuntu apport提权](https://flattsecurity.medium.com/cve-2020-15702-race-condition-vulnerability-in-handling-of-pid-by-apport-4047f2e00a67) [其他](https://alephsecurity.com/2021/02/16/apport-lpe/)
- [CVE-2021-21220: chrome v8 pwn2own 2021](https://www.zerodayinitiative.com/blog/2021/12/6/two-birds-with-one-stone-an-introduction-to-v8-and-jit-exploitation) [Part2](https://www.zerodayinitiative.com/blog/2021/12/8/understanding-the-root-cause-of-cve-2021-21220-a-chrome-bug-from-pwn2own-2021)

# DEVELOP

- GCC 11 内存检测
	- [part1](https://developers.redhat.com/blog/2021/04/30/detecting-memory-management-bugs-with-gcc-11-part-1-understanding-dynamic-allocation/)
	- [part2](https://developers.redhat.com/blog/2021/05/05/detecting-memory-management-bugs-with-gcc-11-part-2-deallocation-functions/)
	- [static analysis](https://developers.redhat.com/blog/2021/01/28/static-analysis-updates-in-gcc-11/)
- JAVA沙箱
	- [沙箱逃逸](https://tersesystems.com/blog/2015/12/29/sandbox-experiment/) [其他](https://c0d3p1ut0s.github.io/%E6%94%BB%E5%87%BBJava%E6%B2%99%E7%AE%B1/)
	- [黑名单扩展](http://pro-grade.sourceforge.net/)

# ATTACK

- [ATTCK](https://attack.mitre.org/versions/v9/)
- [Microsoft Enterprise Cloud Red Teaming](https://download.microsoft.com/download/C/1/9/C1990DBA-502F-4C2A-848D-392B93D9B9C3/Microsoft_Enterprise_Cloud_Red_Teaming.pdf)
- [Fireeye Redteam Operations](https://www.fireeye.com/content/dam/fireeye-www/services/pdfs/pf/ms/ds-red-team-operations.pdf)