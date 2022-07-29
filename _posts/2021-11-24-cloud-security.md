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
- [orca](https://orca.security/resources/blog/)
- [netspi](https://www.netspi.com/blog/technical/cloud-penetration-testing/)
- [集锦](https://github.com/pen4uin/awesome-cloud-native-security)
- [从0开始k8s攻防](https://github.com/neargle/my-re0-k8s-security)

## 开源情报

- [hacking8](https://i.hacking8.com/)
- [osv - 开源软件漏洞库](https://osv.dev/)
- [漏洞信息搜索](https://sca.analysiscenter.veracode.com/vulnerability-database/search)
- [漏洞利用搜索](https://sploitus.com/)
- [云服务商漏洞搜索引擎](https://www.cloudvulndb.org/results?q=)
- [2022 top25漏洞类型](https://cwe.mitre.org/top25/archive/2022/2022_cwe_top25.html)

## 云原生知识

- k8s架构
![](/assets/img/cs2.png)
![](/assets/img/cs3.png)
- [Kubernetes指南](https://feisky.gitbooks.io/kubernetes)
- [kubernetes中文指南](https://jimmysong.io/kubernetes-handbook)
- [kubernetes图书](https://lib.jimmysong.io/)
- [kubernetes RBAC介绍](https://www.cncf.io/wp-content/uploads/2020/08/2020_04_Introduction-to-Kubernetes-RBAC.pdf) [AuthN](http://arthurchiao.art/blog/cracking-k8s-authn/) [AuthZ](http://arthurchiao.art/blog/cracking-k8s-authz-rbac/)
- [kubernetes历史漏洞 - git issue](https://github.com/kubernetes/kubernetes/issues?q=label%3Aarea%2Fsecurity+is%3Aclosed)
- [kubernetes历史漏洞 - git changelog](https://github.com/kubernetes/kubernetes/tree/master/CHANGELOG)
- [kubernetes历史漏洞 - hackerone](https://hackerone.com/kubernetes/hacktivity?type=team)
- k8s pod安全策略
	- [security context](https://kubernetes.io/docs/tasks/configure-pod-container/security-context/)
	- [pod安全配置介绍](https://medium.com/kubernetes-tutorials/defining-privileges-and-access-control-settings-for-pods-and-containers-in-kubernetes-2cef08fc62b7) [其他](https://fuckcloudnative.io/posts/security-best-practices-for-kubernetes-pods/)
- [linux capability](https://fuckcloudnative.io/posts/linux-capabilities-why-they-exist-and-how-they-work/) [文章1](https://fuckcloudnative.io/posts/linux-capabilities-in-practice-1/) [文章2](https://fuckcloudnative.io/posts/linux-capabilities-in-practice-2/) [利用](https://book.hacktricks.xyz/linux-unix/privilege-escalation/linux-capabilities)
- [docker的init进程](https://shareinto.github.io/2019/01/30/docker-init(1)/)
- [k8s审计工具介绍](https://fuckcloudnative.io/posts/tools-and-methods-for-auditing-kubernetes-rbac-policies/)
- [利用user namespace增强安全性](https://kinvolk.io/blog/2020/12/improving-kubernetes-and-container-security-with-user-namespaces/)
- [云原生安全书的相关源码](https://github.com/Metarget/cloud-native-security-book)
- [云原生术语](https://glossary.cncf.io/abstraction/)
- [通过k8s软件物料清单查询漏洞](https://security.googleblog.com/2022/06/sbom-in-action-finding-vulnerabilities.html)
- [kubeconfig执行命令及读取文件安全隐患](https://banzaicloud.com/blog/kubeconfig-security/)
- [golang安全审计](https://www.elttam.com/blog/golang-codereview/)
- [k8s安全最佳实践](https://sysdig.com/learn-cloud-native/kubernetes-security/kubernetes-security-101/)
- [arthurchiao](http://arthurchiao.art/)
- [moelove](https://moelove.info/)
- [datadoghq - 云平台安全配置规则](https://docs.datadoghq.com/security_platform/default_rules/)
- [kubelet认证流程](https://www.jianshu.com/p/bb973ab1029b)
- [bridgecrew - 云平台安全配置规则](https://docs.bridgecrew.io/docs)
- [kubernetes wiki](https://wiki.shileizcc.com/confluence/display/KUB/Kubernetes)

## 云原生攻击

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
- [Azure 容器逃逸](https://unit42.paloaltonetworks.com/azure-container-instances/)
- [在容器中偷取主机runc](https://github.com/twistlock/whoc)
- [Azure omi agent rce](https://www.wiz.io/blog/secret-agent-exposes-azure-customers-to-unauthorized-code-execution)
- [Azure利用service principal提权](https://posts.specterops.io/azure-privilege-escalation-via-service-principal-abuse-210ae2be2a5 )
- [Azure虚机上的普通用户可以访问VM extenstion中的敏感信息](https://www.intezer.com/blog/cloud-security/cve-2021-27075-microsoft-azure-vulnerability-allows-privilege-escalation-and-leak-of-data/)
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
- [利用ebpf逃逸](https://drivertom.blogspot.com/2022/01/ebpfdocker.html) [代码](https://github.com/TomAPU/bpfcronescape/) [文章](https://security.tencent.com/index.php/blog/msg/206)
- [AWS CloudFormation XXE](https://orca.security/resources/blog/aws-cloudformation-vulnerability/)
- [利用内核模块进行逃逸](https://github.com/xcellerator/linux_kernel_hacking/tree/master/3_RootkitTechniques/3.8_privileged_container_escaping)
- [Hunting for bugs in VMware: View Planner and vRealize Business for Cloud](https://swarm.ptsecurity.com/hunting-for-bugs-in-vmware-view-planner-and-vrealize-business-for-cloud/)
- [JWT token攻击手法](https://redhuntlabs.com/wp-content/uploads/2022/02/A-Practical-Guide-to-Attacking-JWT-JSON-Web-Tokens.pdf)
- [AWS S3桶利用方法](https://mp.weixin.qq.com/s/2TVG58L_thQoGb2e9jpKMA)
- [Azure Automation Service窃取其他租户凭证](https://orca.security/resources/blog/autowarp-microsoft-azure-automation-service-vulnerability/)
- [Apiary SSRF to get Oracle Cloud Metadata](https://orca.security/resources/blog/oracle-server-side-request-forgery-ssrf-attack-metadata/)
- [GKE Autopilot Vulnerabilities](https://unit42.paloaltonetworks.com/gke-autopilot-vulnerabilities/)
- [Azure hybrid workers part1 runas提权](https://www.netspi.com/blog/technical/cloud-penetration-testing/abusing-azure-hybrid-workers-for-privilege-escalation/)
- [Azure hybrid workers part2 跨租户信息窃取](https://www.netspi.com/blog/technical/cloud-penetration-testing/abusing-azure-hybrid-workers-part-2/)
- [使用CDN绕过原站防护](https://blog.ryanjarv.sh/2022/03/16/bypassing-wafs-with-alternate-domain-routing.html)
- [azure攻击手法](https://cloudbrothers.info/en/azure-dominance-paths/)
- [针对azure的npm包供应链攻击](https://jfrog.com/blog/large-scale-npm-attack-targets-azure-developers-with-malicious-packages/)
- [如何寻找Azure上的越权攻击](https://docs.google.com/presentation/d/1vVpNezQ1uVS3_PQ_beYH-cQR6qrvGcMP8MWV7LA-nKU/mobilepresent?slide=id.p)
- [EverNote SSRF leak GCP metadata](https://blog.neolex.dev/13/)
- [AWS RDS PostgreSQL log_fdw插件任意文件读](https://blog.lightspin.io/aws-rds-critical-security-vulnerability)
- [AWS VPN Client TOCTOU任意文件写](https://rhinosecuritylabs.com/aws/cve-2022-25165-aws-vpn-client/)
- [AWS log4shell热补容器逃逸](https://unit42.paloaltonetworks.com/aws-log4shell-hot-patch-vulnerabilities/)
- [Azure PostgreSQL服务跨租户数据窃取](https://www.wiz.io/blog/wiz-research-discovers-extrareplica-cross-account-database-vulnerability-in-azure-postgresql/)
- [Exploitation of an SSRF vulnerability against EC2 IMDSv2](https://www.yassineaboukir.com//blog/exploitation-of-an-SSRF-vulnerability-against-EC2-IMDSv2/)
- [在有创建pod权限时，即使没有查看secrets的权限，也可以在pod中挂载任意secret](https://suraj.io/post/2021/05/access-k8s-secrets/)
- [GCP IAM提权利用脚本](https://github.com/RhinoSecurityLabs/GCP-IAM-Privilege-Escalation)
- [GCP IAP认证绕过，攻击者使用被害者的Oauth Client ID和任意Secret创建IAP，当被害者访问攻击者的URL时在中间一次redirect时会泄露被害者的token](https://www.seblu.de/2021/12/iap-bypass.html)
- [GCP Dataflow虚机上JMX服务RCE](https://mbrancato.github.io/2021/12/28/rce-dataflow.html)
- [GCP ASM Istio多集群部署时，control plane会使用istio-system中的secret，其中保存了集群的kubeconfig，通过修改kubeconfig增加exec即可在control plane执行任意代码](https://lf.lc/vrp/203177829/)
- [GCP Cloud Shell命令注入](https://docs.google.com/document/d/1-TTCS6fS6kvFUkoJmX4Udr-czQ79lSUVXiWsiAED_bs/edit#)
- [Azure synapse sudo提权](https://medium.com/tenable-techblog/microsoft-azure-synapse-pwnalytics-87c99c036291)
- [AWS Cognito错误配置，允许创建新用户，从而获取AWS凭证](https://notsosecure.com/hacking-aws-cognito-misconfigurations)
- [Azure 利用docker remote api逃逸dynamics container sandbox](https://hencohen10.medium.com/microsoft-dynamics-container-sandbox-rce-via-unauthenticated-docker-remote-api-20-000-bounty-7f726340a93b)
- [Azure Fabric服务利用其数据收集agent的读写文件TOCTOU漏洞写入主机任意文件导致容器逃逸](https://unit42.paloaltonetworks.com/fabricscape-cve-2022-30137/)
- [AWS workspace client 命令注入RCE CVE-2021-28112](https://rhinosecuritylabs.com/aws/cve-2021-38112-aws-workspaces-rce/)
- [AWS EKS服务k8s集群IAM认证越权](https://blog.lightspin.io/exploiting-eks-authentication-vulnerability-in-aws-iam-authenticator)
- [利用Google客户端的APIKey访问隐藏API](https://www.ezequiel.tech/p/75k-google-services-mix-up.html)
- [Azure site recovery tool dll hijacking](https://medium.com/tenable-techblog/microsoft-azure-site-recovery-dll-hijacking-cd8cc34ef80c)
- [GCP mysql数据库导出注入代码实现RCE](https://www.ezequiel.tech/2020/08/dropping-shell-in.html)

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
- [cloudgoat - aws靶场](https://github.com/RhinoSecurityLabs/cloudgoat) [使用样例](https://dhiyaneshgeek.github.io/cloud/security/2022/06/15/aws-misconfigurations/)
- 云资源关系可视化
	- [awspx](https://github.com/FSecureLABS/awspx)
	- [Stormspotter](https://github.com/Azure/Stormspotter)
- [kubectl-trace - 在k8s集群中执行bpf](https://github.com/iovisor/kubectl-trace)
- [kube-prompt - kubectl交互式工具](https://github.com/c-bata/kube-prompt)
- [TerraformGoat - 利用terraform构建公有云靶场环境](https://github.com/HXSecurity/TerraformGoat)
- [k9s - k8s终端UI工具](https://github.com/derailed/k9s/)
- [kuboard-spray - k8s图形化安装](https://github.com/eip-work/kuboard-spray)
- [kubeeye - k8s审计工具](https://github.com/kubesphere/kubeeye)

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
- [CVE-2019-1002101: kubectl cp没有处理好符号链接导致任意文件写](https://unit42.paloaltonetworks.com/disclosing-directory-traversal-vulnerability-kubernetes-copy-cve-2019-1002101/) [POC](https://github.com/brompwnie/CVE-2019-1002101-Helpers)
- [CVE-2020-8554: k8s service流量劫持](https://unit42.paloaltonetworks.com/cve-2020-8554/) [POC](https://hackerone.com/reports/764986)
- [CVE-2020-8555: k8s controller SSRF](https://medium.com/@BreizhZeroDayHunters/when-its-not-only-about-a-kubernetes-cve-8f6b448eafa8) [其他](https://hackerone.com/reports/776017)
- [CVE-2020-8557: Node disk DOS by writing to container /etc/hosts](https://github.com/kubernetes/kubernetes/issues/93032) [其他](https://hackerone.com/reports/867699)
- [CVE-2020-8558: route_localnet漏洞](https://github.com/tabbysable/POC-2020-8558)
- [CVE-2020-8559: 恶意kubelet返回302给apiserver，控制node的攻击者可在任意pod中执行代码](https://github.com/tdwyer/CVE-2020-8559) [分析](http://blog.nsfocus.net/cve-2020-8559/)
- [CVE-2020-8561: k8s apiserver SSRF](https://hackerone.com/reports/941178) [公告](https://groups.google.com/g/kubernetes-security-announce/c/RV2IhwcrQsY)
- [CVE-2020-10749: 利用ipv6路由广播实施k8s中间人攻击](https://github.com/knqyf263/CVE-2020-10749)
- [CVE-2020-14343: k8s test-infra yaml.load exec](https://hackerone.com/reports/1051192)
- [CVE-2020-15157: container image SSRF](https://darkbit.io/blog/cve-2020-15157-containerdrip)
- [CVE-2020-15257: containerd-shim abstract namespace unix socket](https://research.nccgroup.com/2020/12/10/abstract-shimmer-cve-2020-15257-host-networking-is-root-equivalent-again/) [POC1](https://github.com/nccgroup/abstractshimmer) [POC2](https://www.cdxy.me/?p=837)
- [CVE-2021-3121: Out Of Bounds in protobuf unmarshalling](https://hackerone.com/reports/1073363)
- [CVE-2021-3847: overlayfs文件安全属性拷贝问题](https://www.openwall.com/lists/oss-security/2021/10/14/3)
- [CVE-2021-21284: docker使用--userns-remap时，容器中的root用户如果能够修改`/var/lib/docker/<remapping>`则可以提权](https://github.com/moby/moby/security/advisories/GHSA-7452-xqpj-6rpc)
- [CVE-2021-25738: k8s java client parse yaml exec](https://j0vsec.com/post/cve-2021-25738/) [POC](https://github.com/jordyv/poc-snakeyaml)
- [CVE-2021-25741: k8s subpath mount符号链接条件竞争逃逸](https://github.com/Betep0k/CVE-2021-25741) [文章1](https://sysdig.com/blog/cve-2021-25741-kubelet-falco/) [文章2](https://security.googleblog.com/2021/12/exploring-container-security-storage.html)
- [CVE-2021-25742: k8s ingress-nginx read local file](https://hackerone.com/reports/1249583) [文章](https://blog.lightspin.io/kubernetes-nginx-ingress-controller-vulnerabilities)
- [CVE-2021-30465: docker runc mount TOCTOU](https://www.kingkk.com/2021/06/runc%E5%AE%B9%E5%99%A8%E9%80%83%E9%80%B8%E6%BC%8F%E6%B4%9E%E5%88%86%E6%9E%90%EF%BC%88CVE-2021-30465%EF%BC%89/) [其他](https://hackmd.io/@mauilion/By2CV2MtO)
- [CVE-2021-41091: 利用/var/lib/docker下setuid程序提权](https://nvd.nist.gov/vuln/detail/CVE-2021-41091) [公告](https://github.com/moby/moby/security/advisories/GHSA-3fwx-pjgw-3558) [利用](https://www.cyberark.com/resources/threat-research-blog/how-docker-made-me-more-capable-and-the-host-less-secure)
- [CVE-2021-43784: runc netlink message int16 overflow](https://bugs.chromium.org/p/project-zero/issues/detail?id=2241)
- [CVE-2022-0492: 利用unshare+cgroup逃逸](https://unit42.paloaltonetworks.com/cve-2022-0492-cgroups/) [分析](http://terenceli.github.io/%E6%8A%80%E6%9C%AF/2022/03/06/cve-2022-0492)
- [CVE-2022-21701: istio gateway提权不完全分析之模板覆盖](http://noahblog.360.cn/abuse-gateway-api-attack-kubernetes/) [yaml多行注释](https://yaml-multiline.info/)
- [CVE-2022-23648: containerd cri plugin容器镜像路径穿越漏洞](https://bugs.chromium.org/p/project-zero/issues/detail?id=2244)

# QEMU/HyperV

## 知识

- [QEMU 源码分析](https://airbus-seclab.github.io/qemu_blog/)
- [QEMU 博客](https://airbus-seclab.github.io/qemu_blog/)
- [HyperV攻击面](https://i.blackhat.com/USA21/Wednesday-Handouts/us-21-Mobius-Band-Explore-Hyper-V-Attack-Interface-Through-Vulnerabilities-Internals.pdf)
- [QEMU issues](https://gitlab.com/qemu-project/qemu/-/issues)

## 漏洞

- [QEMU Heap Overflow in SDHCI Component](https://starlabs.sg/advisories/21-3409/)
- [QEMU Misuse Error Handling逃逸](https://github.com/hustdebug/scavenger)
- [QEMU Virglrenderer逃逸](https://i.blackhat.com/asia-20/Thursday/asia-20-Shao-3D-Red-Pill-A-Guest-To-Host-Escape-On-QEMUKVM-Virtio-Device-wp.pdf)
- [QEMU vGPU逃逸](https://i.blackhat.com/USA21/Wednesday-Handouts/us-21-Another-Road-Leads-To-The-Host-From-A-Message-To-VM-Escape-On-Nvidia-VGPU.pdf)
- [QEMU QMP migrate任意命令执行](https://cxsecurity.com/issue/WLB-2022020039)
- [Matryoshka Trap: Recursive MMIO Flaws](https://qiuhao.org/Matryoshka_Trap.pdf) [poc](https://github.com/QiuhaoLi/CVE-2021-3929-3947) [blackhat](https://i.blackhat.com/Asia-22/Thursday-Materials/AS-22-Qiuhao-Recursive-MMIO-final.pdf)

# KERNEL

## 知识

- [kvm安全](https://github.com/rafaeldtinoco/howtos)

## 博客

- [project zero](https://googleprojectzero.blogspot.com/)
- [Aleph Research](https://alephsecurity.com/)
- [Alexander Popov](https://a13xp0p0v.github.io/)
- [pwn2own 2021 ubuntu lpe](https://flatt.tech/assets/reports/210401_pwn2own/whitepaper.pdf)
- [modprobe内核利用方法](https://sam4k.com/like-techniques-modprobe_path/)

## CVE

- [CVE-2016-5195: Dirty Cow](https://github.com/dirtycow/dirtycow.github.io/wiki/PoCs)
- [CVE-2017-0781： blueborne - 蓝牙漏洞](https://github.com/ArmisSecurity/blueborne)
- [CVE-2017-5123： linux waitid系统调用提权漏洞](https://github.com/nongiach/CVE)
- [CVE-2019-13272 - ptrace_link漏洞本地提权](https://github.com/jas502n/CVE-2019-13272)
- [CVE-2017-13281： bluedroid - 蓝牙漏洞](https://github.com/JiounDai/Bluedroid)
- [CVE-2020-8835: 利用ebpf verification漏洞提权](https://github.com/noirfate/bpf-lpe) [文章](https://www.zerodayinitiative.com/blog/2020/4/8/cve-2020-8835-linux-kernel-privilege-escalation-via-improper-ebpf-program-verification)
- [CVE-2020-12351/CVE-2020-12352: BleedingTooth: Linux Bluetooth Zero-Click Remote Code Execution](https://github.com/google/security-research/tree/master/pocs/linux/bleedingtooth)
- [CVE-2021-3178: nfs leak](https://bugzilla.redhat.com/show_bug.cgi?id=1918179)
- [CVE-2021-3490： ebpf内核提权](https://github.com/chompie1337/Linux_LPE_eBPF_CVE-2021-3490) [文章](https://www.graplsecurity.com/post/kernel-pwning-with-ebpf-a-love-story)
- [CVE-2021-20226: a reference counting bug which leads to local privilege escalation in io_uring](https://flattsecurity.medium.com/cve-2021-20226-a-reference-counting-bug-which-leads-to-local-privilege-escalation-in-io-uring-e946bd69177a)
- [CVE-2021-22543: KVM VM_IO,VM_PFNMAP vma mishandling](https://github.com/google/security-research/security/advisories/GHSA-7wq5-phmq-m584)
- [CVE-2021-22555: Heap Out-Of-Bounds Write in xt_compat_target_from_user](https://github.com/google/security-research/tree/master/pocs/linux/cve-2021-22555)
- [CVE-2021-23134: NFC UAF](https://ruia-ruia.github.io/NFC-UAF/)
- [CVE-2021-26708: vsock本地提权](https://github.com/hardenedvault/vault_range_poc) [文章](https://a13xp0p0v.github.io/2021/02/09/CVE-2021-26708.html)
- [CVE-2021-29657: AMD KVM Guest Escape](https://googleprojectzero.blogspot.com/2021/06/an-epyc-escape-case-study-of-kvm.html)
- [CVE-2021-33909: fs/seq_file提权](https://www.qualys.com/2021/07/20/cve-2021-33909/sequoia-local-privilege-escalation-linux.txt) [POC](https://github.com/Liang2580/CVE-2021-33909)
- [CVE-2021-34886: ebpf类型混淆漏洞](https://github.com/HexRabbit/CVE-writeup/tree/master/CVE-2021-34886)
- [CVE-2021-41073: io_uring类型混淆漏洞提权](https://github.com/chompie1337/Linux_LPE_io_uring_CVE-2021-41073)
- [CVE-2021-42008: 6pack driver提权](https://syst3mfailure.io/sixpack-slab-out-of-bounds)
- [CVE-2021-43267: tipc eop](https://haxx.in/posts/pwning-tipc/)
- [CVE-2022-0185: fsconfig heap overflow](https://github.com/Crusaders-of-Rust/CVE-2022-0185) [文章](https://www.willsroot.io/2022/01/cve-2022-0185.html)
- [CVE-2022-0847: 利用管道越权写文件](https://github.com/Arinerron/CVE-2022-0847-DirtyPipe-Exploit) [覆盖容器镜像文件](https://blog.aquasec.com/cve-2022-0847-dirty-pipe-linux-vulnerability) [覆盖runc](https://github.com/DataDog/dirtypipe-container-breakout-poc)
- [CVE-2022-0995: watch_queue OOB本地提权](https://github.com/Bonfee/CVE-2022-0995)
- [CVE-2022-25636：netfilter netdev OOB漏洞提权](https://github.com/Bonfee/CVE-2022-25636)
- [CVE-2022-27666：ipsec esp6 OOB漏洞提权](https://github.com/plummm/CVE-2022-27666) [文章](https://etenal.me/archives/1825)
- [CVE-2022-23222 - ebpf verify本地提权漏洞](https://github.com/tr3ee/CVE-2022-23222)
- [CVE-2022-34918 - netfilter类型混淆提权漏洞](https://github.com/trhacknon/CVE-2022-34918-LPE-PoC)

# APP

- [利用sudo程序在logrotate.d目录下产生coredump，从而提权](https://www.openwall.com/lists/oss-security/2021/10/20/2)
- [ubuntu apport提权](https://flattsecurity.medium.com/cve-2020-15702-race-condition-vulnerability-in-handling-of-pid-by-apport-4047f2e00a67) [其他](https://alephsecurity.com/2021/02/16/apport-lpe/)
- [CVE-2021-21220: chrome v8 pwn2own 2021](https://www.zerodayinitiative.com/blog/2021/12/6/two-birds-with-one-stone-an-introduction-to-v8-and-jit-exploitation) [Part2](https://www.zerodayinitiative.com/blog/2021/12/8/understanding-the-root-cause-of-cve-2021-21220-a-chrome-bug-from-pwn2own-2021)
- [JDBC RCE](http://tttang.com/archive/1462/)

# DEVELOP

- GCC 11 内存检测
	- [part1](https://developers.redhat.com/blog/2021/04/30/detecting-memory-management-bugs-with-gcc-11-part-1-understanding-dynamic-allocation/)
	- [part2](https://developers.redhat.com/blog/2021/05/05/detecting-memory-management-bugs-with-gcc-11-part-2-deallocation-functions/)
	- [static analysis](https://developers.redhat.com/blog/2021/01/28/static-analysis-updates-in-gcc-11/)
- JAVA沙箱
	- [沙箱逃逸](https://tersesystems.com/blog/2015/12/29/sandbox-experiment/) [其他1](https://c0d3p1ut0s.github.io/%E6%94%BB%E5%87%BBJava%E6%B2%99%E7%AE%B1/) [其他2](https://www.mi1k7ea.com/2020/05/03/%E6%B5%85%E6%9E%90Java%E6%B2%99%E7%AE%B1%E9%80%83%E9%80%B8/)
	- [黑名单扩展](http://pro-grade.sourceforge.net/)
	- [权限风险说明]( https://docs.oracle.com/javase/8/docs/technotes/guides/security/permissions.html)
	- [java cgroup](https://github.com/haosdent/jcgroup)
	- 黑名单示例
	```
	{
    (java.io.FilePermission "<<ALL FILES>>" "read,write,delete,execute")
    (java.net.SocketPermission "*:1-" "connect,accept,listen,resolve")
    (java.net.URLPermission "http:*" "*:*")
    (java.net.URLPermission "https:*" "*:*")
    (java.net.NetPermission "*")
    (java.lang.RuntimePermission "createClassLoader")
    (java.lang.RuntimePermission "setContextClassLoader")
    (java.lang.RuntimePermission "closeClassLoader")
    (java.lang.RuntimePermission "setSecurityManager")
    (java.lang.RuntimePermission "createSecurityManager")
    (java.lang.RuntimePermission "loadLibrary.*")
    (java.lang.RuntimePermission "exitVM.*")
    (java.lang.RuntimePermission "shutdownHooks")
    (java.lang.RuntimePermission "setIO")
    (java.lang.RuntimePermission "modifyThread")
    (java.lang.RuntimePermission "stopThread")
    (java.lang.RuntimePermission "modifyThreadGroup")
    (java.lang.RuntimePermission "readFileDescriptor")
    (java.lang.RuntimePermission "writeFileDescriptor)
    (java.lang.RuntimePermission "defineClassInPackage.*")
    (java.lang.RuntimePermission "setDefaultUncaughtExceptionHandler")
    (java.lang.RuntimePermission "usePolicy")
    (java.lang.RuntimePermission "accessDeclareMembers")
    (java.lang.RuntimePermission "getProtectionDomain")
    (java.lang.RuntimePermission "getenv.*")
    (java.lang.RuntimePermission "setFactory")
    (java.lang.reflect.ReflectPermission "suppressAccessChecks")
    (java.util.PropertyPermission "*" "read,write")
    (java.awt.AWTPermission "*")
  }
	```
- Go语言
	- [go books](https://github.com/dariubs/GoBooks)
	- [go语言设计与实现](https://draveness.me/golang/)

# ATTACK

- [ATTCK](https://attack.mitre.org/versions/v9/)
- [Microsoft Enterprise Cloud Red Teaming](https://download.microsoft.com/download/C/1/9/C1990DBA-502F-4C2A-848D-392B93D9B9C3/Microsoft_Enterprise_Cloud_Red_Teaming.pdf)
- [Fireeye Redteam Operations](https://www.fireeye.com/content/dam/fireeye-www/services/pdfs/pf/ms/ds-red-team-operations.pdf)
