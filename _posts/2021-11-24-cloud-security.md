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
- [awesome cloud security](https://github.com/teamssix/awesome-cloud-security)
- [从0开始k8s攻防](https://github.com/neargle/my-re0-k8s-security)
- [云安全知识库](https://cloudsec.huoxian.cn/docs/information)
- [OffensiveClou - AWS、AZure、GCP渗透技巧](https://github.com/lutzenfried/OffensiveCloud)
- [lightspin](https://blog.lightspin.io/)
- [oligo](https://www.oligo.security/resources/blog?category=All)
- [Hacking the Cloud](https://github.com/Hacking-the-Cloud/hackingthe.cloud)
- [The Open Cloud Vulnerability & Security Issue Database](https://www.cloudvulndb.org/)
- [kubenomicon - k8s ATT&CK](https://kubenomicon.com/Kubenomicon.html)

## 开源情报

- [hacking8](https://i.hacking8.com/)
- [osv - 开源软件漏洞库](https://osv.dev/)
- [漏洞信息搜索](https://sca.analysiscenter.veracode.com/vulnerability-database/search)
- [漏洞利用搜索](https://sploitus.com/)
- [云服务商漏洞搜索引擎](https://www.cloudvulndb.org/results?q=)
- [2022 top25漏洞类型](https://cwe.mitre.org/top25/archive/2022/2022_cwe_top25.html)
- [osint框架](https://osintframework.com/)
- [从git commit信息中发现隐藏漏洞](https://github.com/cve-search/git-vuln-finder)
- [AWS、AZure漏洞](https://github.com/CyberSecurityUP/Cloud-Security-Attacks)
- [leakix - 数据泄露查询](https://leakix.net/)
- [breached - 数据泄露市场](https://breached.to/)
- [cracking - 数据泄露等](https://cracking.org/forums/databases.31)
- [oss fuzz vulns](https://github.com/google/oss-fuzz-vulns)
- [hackernews - 安全快讯](https://hackernews.cc/)
- [dayzerosec - 安全资讯](https://dayzerosec.com)
- [synk漏洞库](https://security.snyk.io/)
- [数据泄露分析报告](https://github.com/BushidoUK/Breach-Report-Collection)
- [wiz云威胁情报](https://threats.wiz.io/all-incidents)
- [wiz云漏洞库](https://www.wiz.io/vulnerability-database)

## 云原生知识

- 漏洞信息
	- [kubernetes历史漏洞 - git issue](https://github.com/kubernetes/kubernetes/issues?q=label%3Aarea%2Fsecurity+is%3Aclosed)
	- [kubernetes历史漏洞 - git cve](https://github.com/kubernetes/kubernetes/issues?q=is%3Aclosed+label%3Aofficial-cve-feed+)
	- [kubernetes历史漏洞 - git changelog](https://github.com/kubernetes/kubernetes/tree/master/CHANGELOG)
	- [kubernetes历史漏洞 - git sig](https://github.com/kubernetes/kubernetes/issues?q=label%3Asig%2Fsecurity+)
	- [kubernetes历史漏洞 - hackerone](https://hackerone.com/kubernetes/hacktivity?type=team)
	- [kubernetes历史漏洞 - 官方feed](https://kubernetes.io/docs/reference/issues-security/official-cve-feed/)
	- [docker/moby安全公告](https://github.com/moby/moby/security/advisories)
	- [2022 k8s相关重点漏洞梳理](https://www.armosec.io/blog/kubernetes-vulnerabilities-2022/)
- k8s架构
![](/assets/img/cs2.png)
![](/assets/img/cs3.png)
- [Kubernetes指南](https://feisky.gitbooks.io/kubernetes)
- [kubernetes中文指南](https://jimmysong.io/kubernetes-handbook)
- [kubernetes图书](https://lib.jimmysong.io/)
- [kubernetes RBAC介绍](https://www.cncf.io/wp-content/uploads/2020/08/2020_04_Introduction-to-Kubernetes-RBAC.pdf) [AuthN](http://arthurchiao.art/blog/cracking-k8s-authn/) [AuthZ](http://arthurchiao.art/blog/cracking-k8s-authz-rbac/)
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
- [NSA k8s加固指南](https://media.defense.gov/2022/Aug/29/2003066362/-1/-1/0/CTR_KUBERNETES_HARDENING_GUIDANCE_1.2_20220829.PDF)
- [kubctl top15安全插件](https://malware.news/t/top-15-kubectl-plugins-for-security-engineers/66452)
- [GCP cloud storage威胁建模](https://research.nccgroup.com/2023/01/31/threat-modelling-cloud-platform-services-by-example-google-cloud-storage/)
- [k8s源码分析](https://github.com/rfyiamcool/notes)
- [k8s安全博客](https://raesene.github.io/)

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
- [Azure cloudshell xterm RCE](https://twitter.com/_fel1x/status/1083085715565621250?lang=tr)
- [在容器中偷取主机runc](https://github.com/twistlock/whoc)
- [Azure omi agent rce](https://www.wiz.io/blog/secret-agent-exposes-azure-customers-to-unauthorized-code-execution)
- [Azure omi LPE](https://www.wiz.io/blog/omi-returns-lpe-technical-analysis/)
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
- [AWS VPN Client TOCTOU任意文件写](https://rhinosecuritylabs.com/aws/cve-2022-25165-aws-vpn-client/) [POC](https://github.com/RhinoSecurityLabs/CVEs/tree/master/CVE-2022-25166) [pritunl vpn](https://rhinosecuritylabs.com/penetration-testing/cve-2022-25372-local-privilege-escalation-in-pritunl-vpn-client/)
- [AWS VPN Client Information Disclosure Via UNC Path](https://github.com/RhinoSecurityLabs/CVEs/tree/master/CVE-2022-25165)
- [AWS log4shell热补容器逃逸](https://unit42.paloaltonetworks.com/aws-log4shell-hot-patch-vulnerabilities/)
- [Azure PostgreSQL服务跨租户数据窃取](https://www.wiz.io/blog/wiz-research-discovers-extrareplica-cross-account-database-vulnerability-in-azure-postgresql/)
- [Exploitation of an SSRF vulnerability against EC2 IMDSv2](https://www.yassineaboukir.com//blog/exploitation-of-an-SSRF-vulnerability-against-EC2-IMDSv2/)
- [在有创建pod权限时，即使没有查看secrets的权限，也可以在pod中挂载任意secret](https://suraj.io/post/2021/05/access-k8s-secrets/)
- [GCP IAM提权利用脚本](https://github.com/RhinoSecurityLabs/GCP-IAM-Privilege-Escalation)
- [GCP IAP认证绕过，攻击者使用被害者的Oauth Client ID和任意Secret创建IAP，当被害者访问攻击者的URL时在中间一次redirect时会泄露被害者的token](https://www.seblu.de/2021/12/iap-bypass.html)
- [GCP Dataflow虚机上JMX服务RCE](https://mbrancato.github.io/2021/12/28/rce-dataflow.html)
- [GCP ASM Istio多集群部署时，control plane会使用istio-system中的secret，其中保存了集群的kubeconfig，通过修改kubeconfig增加exec即可在control plane执行任意代码](https://lf.lc/vrp/203177829/)
- [GCP Cloud Shell命令注入](https://docs.google.com/document/d/1-TTCS6fS6kvFUkoJmX4Udr-czQ79lSUVXiWsiAED_bs/edit#) [另一个](https://bugra.ninja/posts/cloudshell-command-injection/)
- [Azure synapse sudo提权](https://medium.com/tenable-techblog/microsoft-azure-synapse-pwnalytics-87c99c036291) [另一种方法](https://orca.security/resources/blog/synapse-local-privilege-escalation-vulnerability-spark/)
- [Azure Synapse Analytics ODBC RCE](https://orca.security/resources/blog/synlapse-critical-azure-synapse-analytics-service-vulnerability/)
- [AWS Cognito错误配置，允许创建新用户，从而获取AWS凭证](https://notsosecure.com/hacking-aws-cognito-misconfigurations)
- [Azure 利用docker remote api逃逸dynamics container sandbox](https://hencohen10.medium.com/microsoft-dynamics-container-sandbox-rce-via-unauthenticated-docker-remote-api-20-000-bounty-7f726340a93b)
- [Azure Fabric服务利用其数据收集agent的读写文件TOCTOU漏洞写入主机任意文件导致容器逃逸](https://unit42.paloaltonetworks.com/fabricscape-cve-2022-30137/)
- [AWS workspace client 命令注入RCE CVE-2021-28112](https://rhinosecuritylabs.com/aws/cve-2021-38112-aws-workspaces-rce/)
- [AWS EKS服务k8s集群IAM认证越权](https://blog.lightspin.io/exploiting-eks-authentication-vulnerability-in-aws-iam-authenticator)
- [利用Google客户端的APIKey访问隐藏API](https://www.ezequiel.tech/p/75k-google-services-mix-up.html)
- [Azure site recovery tool dll hijacking](https://medium.com/tenable-techblog/microsoft-azure-site-recovery-dll-hijacking-cd8cc34ef80c)
- [GCP mysql数据库导出注入代码实现RCE](https://www.ezequiel.tech/2020/08/dropping-shell-in.html)
- [GCP Azure postgresql vulnerabilities](https://www.wiz.io/blog/the-cloud-has-an-isolation-problem-postgresql-vulnerabilities)
- [postgresql使用security definer提权](https://www.cybertec-postgresql.com/en/abusing-security-definer-functions/)
- [大于3/4的app内置了AWS的aksk](https://symantec-enterprise-blogs.security.com/blogs/threat-intelligence/mobile-supply-chain-aws)
- [Azure SFX XSS](https://orca.security/resources/blog/fabrixss-vulnerability-azure-fabric-explorer/)
- [AWS AppSync 跨租户assume role执行任意API](https://thehackernews.com/2022/11/researchers-detail-appsync-cross-tenant.html)
- [IBM cloud postgresql提权并控制集群](https://www.wiz.io/blog/hells-keychain-supply-chain-attack-in-ibm-cloud-databases-for-postgresql)
- [AWS ECR Public服务可使用Cognito临时凭证访问未公开API修改任意租户的公开镜像](https://blog.lightspin.io/aws-ecr-public-vulnerability)
- [Azure Function容器逃逸](https://unit42.paloaltonetworks.com/azure-serverless-functions-security/)
- [Azure 使用CA证书进行驻留](https://posts.specterops.io/passwordless-persistence-and-privilege-escalation-in-azure-98a01310be3f)
- [使用azure outlook作为C2](https://github.com/boku7/azureOutlookC2)
- [Azure 4个服务的ssrf漏洞](https://orca.security/resources/blog/ssrf-vulnerabilities-in-four-azure-services/)
- [AWS 使用内部API绕过cloudtrail监控](https://securitylabs.datadoghq.com/articles/iamadmin-cloudtrail-bypass/)
- [GCP redteam notes](https://gitlab.com/gitlab-com/gl-security/threatmanagement/redteam/redteam-public/red-team-tech-notes/-/tree/master/)
- [GCP SSH-in-browser sshkey注入](https://blog.stazot.com/ssh-key-injection-google-cloud/)
- [GCP cloud workstation窃取用户jwt token](https://blog.stazot.com/auth-bypass-in-google-cloud-workstations/)
- [bypass facebook 2FA](https://medium.com/pentesternepal/two-factor-authentication-bypass-on-facebook-3f4ac3ea139c)
- [Azure AD B2C使用RSA公钥进行加密，若能获取用户公钥即可进行凭据伪造](https://www.praetorian.com/blog/azure-b2c-crypto-misuse-and-account-compromise/)
- [SCARLETEEL: 针对云环境的攻击](https://sysdig.com/blog/cloud-breach-terraform-data-theft/)
- [Azure Super FabriXss](https://orca.security/resources/blog/super-fabrixss-azure-vulnerability/)
- [Azure CI/CD pipelines通过修改代码提交信息改变流水线环境变量的值](https://www.legitsecurity.com/blog/remote-code-execution-vulnerability-in-azure-pipelines-can-lead-to-software-supply-chain-attack)
- [AWS EKS集群从Pod提权到集群管理员](https://blog.calif.io/p/privilege-escalation-in-eks)
- [Azure 使用Storage Account Contributor角色和共享密钥进行提权](https://orca.security/resources/blog/azure-shared-key-authorization-exploitation/)
- [阿里云数据库服务容器逃逸](https://www.wiz.io/blog/brokensesame-accidental-write-permissions-to-private-registry-allowed-potential-r)
- [SCARLETEEL: Operation leveraging Terraform, Kubernetes, and AWS for data theft](https://sysdig.com/blog/cloud-breach-terraform-data-theft/)
- [GCP cloudbuild纵向提权](https://rhinosecuritylabs.com/gcp/iam-privilege-escalation-gcp-cloudbuild/) [另一种方法](https://orca.security/resources/blog/bad-build-google-cloud-build-potential-supply-chain-attack-vulnerability/)
- [利用Azure泄露的私钥伪造认证token](https://www.wiz.io/blog/storm-0558-compromised-microsoft-key-enables-authentication-of-countless-micr)
- [Azure HDinsight XSS漏洞](https://orca.security/resources/blog/cross-site-scripting-vulnerabilities-in-apache-services-azure-hd-insight/)
- [微软员工使用SAS Token分享Azure Storage中的数据，由于token权限过大导致泄露了38T隐私数据](https://www.wiz.io/blog/38-terabytes-of-private-data-accidentally-exposed-by-microsoft-ai-researchers)
- [GKE默认安装的日志服务fluentbit挂载了主机路径，可获取其他Pod的token进而提权](https://unit42.paloaltonetworks.com/google-kubernetes-engine-privilege-escalation-fluentbit-anthos/)
- [Google OAuth2 multilogin token无限续期](https://www.cloudsek.com/blog/compromising-google-accounts-malwares-exploiting-undocumented-oauth2-functionality-for-session-hijacking)
- [GKE权限配置错误（system:authenticated）导致集群被控](https://orca.security/resources/blog/sys-all-google-kubernetes-engine-risk-example/)
- [GCP Dataproc使用default vpc导致可被同vpc的虚机访问泄露数据](https://orca.security/resources/blog/unauthenticated-access-to-google-cloud-dataproc/)
- [通过爆破攻入Azure租户并渗透进其企业账户](https://posts.specterops.io/microsoft-breach-what-happened-what-should-azure-admins-do-da2b7e674ebc)
- [flowfixation：利用AWS的MWAA在未认证的情况下可获得session cookie的漏洞和cookie tossing利用技术劫持MWAA服务](https://www.tenable.com/blog/flowfixation-aws-apache-airflow-service-takeover-vulnerability-and-why-neglecting-guardrails)
- [使用恶意Pickle模型文件攻击huggingface并获取k8s集群权限](https://www.wiz.io/blog/wiz-and-hugging-face-address-risks-to-ai-infrastructure)
- [云上VM攻击路径](https://unit42.paloaltonetworks.com/cloud-virtual-machine-attack-vectors/)
- [aws多个云服务在自动创建存储桶时未检查是否已经存在，可被攻击者抢占实施攻击](https://i.blackhat.com/BH-US-24/Presentations/US24-Kadkoda-Breaching-AWS-Accounts-Through-Shadow-Resources-Wednesday.pdf)
- [aws amplify服务错误配置导致账户接管](https://securitylabs.datadoghq.com/articles/amplified-exposure-how-aws-flaws-made-amplify-iam-roles-vulnerable-to-takeover/)
- [Azure microsofts ai healthcare chatbot service SSRF漏洞从metadata中获取token](https://www.tenable.com/blog/compromising-microsofts-ai-healthcare-chatbot-service)
- [github ci/cd构建产出物和日志中泄露token](https://unit42.paloaltonetworks.com/github-repo-artifacts-leak-tokens/)
- [azure WireServer和HostGAPlugin中的敏感信息](https://cybercx.co.nz/blog/azure-ssrf-metadata/)
- [利用azure WireServer和HostGAPlugin中的敏感信息从pod中进行逃逸](https://cloud.google.com/blog/topics/threat-intelligence/escalating-privileges-azure-kubernetes-services)
- [AWS多个云服务存在对象存储桶抢占的问题；Breaching AWS Accounts Through Shadow Resources](https://i.blackhat.com/BH-US-24/Presentations/US24-Kadkoda-Breaching-AWS-Accounts-Through-Shadow-Resources-Wednesday.pdf)
- [利用GCP CloudBuild使用的pip安装参数--extra-index-url的安全缺陷实施供应链攻击 - The GCP Jenga Tower: Hacking Millions of Google’s Servers With a Single Package](https://vimeo.com/998899530)
- [aws和azure默认安全比较](https://securitycafe.ro/2024/09/03/aws-vs-azure-a-secure-by-default-comparison/)
- [Hijacking Azure Machine Learning Notebooks (via Storage Accounts)](https://www.netspi.com/blog/technical-blog/cloud-pentesting/hijacking-azure-machine-learning-notebooks/)
- [通过构造名称相似的虚机镜像获取AWS服务资源](https://securitylabs.datadoghq.com/articles/whoami-a-cloud-image-name-confusion-attack/)
- [AWS、GCP、Azure无服务函数凭据窃取攻击](https://unit42.paloaltonetworks.com/serverless-authentication-cloud/)
- [Azure Machine Learning (AML) 在训练任务时从存储桶拉取脚本可能存在权限提升漏洞](https://orca.security/resources/blog/azure-machine-learning-privilege-escalation/)
- [Oracle Cloud Infrastructure (OCI) Code Editor CSRF文件上传](https://www.tenable.com/blog/remote-code-execution-on-oracle-cloud-shell-and-code-editor-integrated-services)
- [ECScape - aws ecs容器利用ecs agent获取IAM凭据](https://www.sweet.security/blog/ecscape-understanding-iam-privilege-boundaries-in-amazon-ecs) [代码](https://github.com/naorhaziz/ecscape/tree/main)

## 云原生工具

- [trivy - 云原生扫描工具](https://github.com/aquasecurity/trivy)
- [k8s集群扫描](https://github.com/aquasecurity/starboard)
- [tracee - 入侵检测](https://github.com/aquasecurity/tracee)
- [CDK - 容器逃逸](https://github.com/cdk-team/CDK)
- [ctrsploit - 容器逃逸](https://github.com/ctrsploit/ctrsploit)
- [kubesploit - k8s渗透远控](https://github.com/cyberark/kubesploit)
- [metarget - 云原生靶场](https://github.com/brant-ruan/metarget) [介绍](https://mp.weixin.qq.com/s/EULJgDrCvuq3DwUpGUskfQ)
- [kubernetes-goat - k8s靶场](https://github.com/madhuakula/kubernetes-goat)
- [kubeletctl](https://github.com/cyberark/kubeletctl)
- [解密k8s etcd存储](https://github.com/jpbetz/auger)
- [whaler - 从docker镜像推导出dockerfile](https://github.com/P3GLEG/Whaler) [dfimage](https://github.com/LanikSJ/dfimage)
- [runlike - 从运行的容器反推出启动命令](https://github.com/lavie/runlike)
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
- [kubeclarity - 镜像sbom分析和漏洞扫描工具](https://github.com/openclarity/kubeclarity)
- [rbac-police - k8s提权检查](https://github.com/PaloAltoNetworks/rbac-police)
- [ScoutSuite - 云安全审计工具，支持亚马逊、微软、谷歌、阿里](https://github.com/nccgroup/ScoutSuite)
- [Constellation - k8s加密](https://github.com/edgelesssys/constellation)
- [cloudfox - 云环境攻击面分析](https://github.com/BishopFox/cloudfox)
- [prowler - aws安全检查监控工具](https://github.com/prowler-cloud/prowler)
- [cf - 云环境渗透框架](https://github.com/teamssix/cf)
- [vesta - 云原生漏洞扫描工具](https://github.com/kvesta/vesta)
- [docker-qemu - run qemu in docker](https://github.com/tianon/docker-qemu)
- [kubeletmein - 利用云厂商的metadata服务获取kubelet凭证](https://github.com/4ARMED/kubeletmein)
- [KubiScan - k8s安全扫描工具](https://github.com/cyberark/KubiScan)
- [veinmind - 容器安全工具集](https://github.com/chaitin/veinmind-tools)
- [tetragon - 基于ebpf的安全监控工具](https://github.com/cilium/tetragon)
- [GATOR - GCP利用工具](https://github.com/anrbn/GATOR)
- [rbac-tool - rbac分析可视化工具](https://github.com/alcideio/rbac-tool)
- [RedCloud-OS - AWS,Azure,GCP渗透虚机](https://github.com/RedTeamOperations/RedCloud-OS)
- [Azure JWT token工具](https://github.com/rvrsh3ll/TokenTactics)
- [云原生靶场](https://github.com/iknowjason/Awesome-CloudSec-Labs)
- [vArmor - 字节开源的云原生加固组件](https://github.com/bytedance/vArmor)
- [libkrun - 为oci runtime提供微虚机隔离支持](https://github.com/containers/libkrun)
- [KubeHound - k8s集群攻击路径图](https://github.com/DataDog/KubeHound) [介绍](https://securitylabs.datadoghq.com/articles/kubehound-identify-kubernetes-attack-paths/)
- [DockerRegistryGrabber - 列出docker registry中的镜像](https://github.com/Syzik/DockerRegistryGrabber)
- [MTKPI - k8s渗透镜像](https://github.com/r0binak/MTKPI)
- [kubetcd - 通过修改etcd中的记录实施攻击](https://github.com/nccgroup/kubetcd) [文章](https://research.nccgroup.com/2023/11/07/post-exploiting-a-compromised-etcd-full-control-over-the-cluster-and-its-nodes/)
- [auger - 解码etcd中的存储数据](https://github.com/jpbetz/auger)
- [kubefuzz - 通过对资源yaml变异来验证admission controller](https://github.com/avolens/kubefuzz/tree/master)
- [ADOKit - Azure DevOps渗透工具](https://github.com/rvrsh3ll/ADOKit)
- [kyverno - k8s细粒度安全规则配置插件](https://github.com/kyverno/kyverno)
- [cloudsploit - 云安全态势分析工具，根据账户凭证分析在使用云服务时出现的不安全配置](https://github.com/aquasecurity/cloudsploit)
- [kubesec - k8s资源安全扫描](https://github.com/controlplaneio/kubesec)
- [ebpf-attacks - 绕过云原生安全检测](https://github.com/Vali-Cyber/ebpf-attacks/) [video](https://cloudnativesecurityconna24.sched.com/event/1dCUy/evasive-maneuvers-strategies-to-overcome-runtime-detection-tools-amit-schendel-armo)
- [cncf fuzzer - 云原生fuzzer](https://github.com/cncf/cncf-fuzzing) [blog](https://www.cncf.io/blog/2022/06/28/improving-security-by-fuzzing-the-cncf-landscape/)
- [camblet - 基于内核模块的进程间mtls实现](https://github.com/cisco-open/camblet)
- [mint - 镜像自动化裁剪工具](https://github.com/mintoolkit/mint)

## CVE

- [CVE-2015-2925: 利用kernel bind mount漏洞逃逸](https://github.com/kagami/docker_cve-2015-2925)
- [CVE-2018-6574: go get rce](https://github.com/neargle/Go-Get-RCE-CVE-2018-6574-POC)
- [CVE-2017-1002101: k8s subpath mount符号链接逃逸](http://blog.nsfocus.net/cve-2017-1002101/) [POC](https://github.com/bgeesaman/subpath-exploit)
- [CVE-2018-15664: docker cp symlink-race attack](http://mayoterry.com/index.php/archives/69.html) [POC](https://github.com/Metarget/cloud-native-security-book/tree/main/code/0302-%E5%BC%80%E5%8F%91%E4%BE%A7%E6%94%BB%E5%87%BB/02-CVE-2018-15664/symlink_race)
- [CVE-2018-1002100 CVE-2019-1002101: kubectl cp路径穿越](https://unit42.paloaltonetworks.com/disclosing-directory-traversal-vulnerability-kubernetes-copy-cve-2019-1002101/) [CVE-2018-1002100](https://hansmi.ch/articles/2018-04-openshift-s2i-security)
- [CVE-2018-1002105: k8s apiserver <=> kubelet连接保持提权漏洞](https://paper.seebug.org/757/#1)
- [CVE-2019-5736: docker runc覆盖逃逸](https://unit42.paloaltonetworks.com/breaking-docker-via-runc-explaining-cve-2019-5736/) [POC](https://github.com/BBRathnayaka/POC-CVE-2019-5736)
- [CVE-2019-9512: HTTP/2 DOS](https://github.com/Metarget/cloud-native-security-book/tree/main/code/0404-K8s%E6%8B%92%E7%BB%9D%E6%9C%8D%E5%8A%A1%E6%94%BB%E5%87%BB)
- [CVE-2019-9946: k8s 利用hostport进行中间人攻击](http://blog.champtar.fr/CVE-2019-9946/)
- [CVE-2019-13139: docker build exec](https://staaldraad.github.io/post/2019-07-16-cve-2019-13139-docker-build/)
- [cve-2019-11247: 通过访问namespace api endpoint，越权增删改查全局CRD资源](https://www.stackrox.io/blog/how-to-remediate-kubernetes-security-vulnerability-cve-2019-11247/)
- [CVE-2019-11250: Bearer tokens are revealed in logs](https://github.com/kubernetes/kubernetes/issues/81114) [后续](https://hackerone.com/reports/952771)
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
- [CVE-2022-0847: dirty-pipe container escape](https://securitylabs.datadoghq.com/articles/dirty-pipe-container-escape-poc/) [POC](https://github.com/DataDog/security-labs-pocs/tree/main/proof-of-concept-exploits/dirtypipe-container-breakout)
- [CVE-2022-21701: istio gateway提权不完全分析之模板覆盖](http://noahblog.360.cn/abuse-gateway-api-attack-kubernetes/) [yaml多行注释](https://yaml-multiline.info/)
- [CVE-2022-23648: containerd cri plugin容器镜像路径穿越漏洞](https://bugs.chromium.org/p/project-zero/issues/detail?id=2244)
- [CVE-2022-39253: 利用git漏洞实现docker build读取宿主机任意文件](https://github.com/noirfate/docker-cve-2022-39253-poc)
- [CVE-2022-4886: k8s ingress-nginx-controller pec.rules.http.paths.path RCE](https://hackerone.com/reports/1620702)
- [CVE-2023-5044: k8s nginx.ingress.kubernetes.io/permanent-redirect RCE](https://hackerone.com/reports/2039464)
- [CVE-2024-21626: runc leak fd workdir escape](https://github.com/opencontainers/runc/security/advisories/GHSA-xr7r-f8xq-vfvv)
- [gitRepo容器逃逸漏洞](https://irsl.medium.com/sneaky-write-hook-git-clone-to-root-on-k8s-node-e38236205d54)

## OWASP Kubernetes Top 10 and CNCF projects
> https://owasp.org/www-project-kubernetes-top-ten/
> https://www.cncf.io/project-metrics/
> https://www.cncf.io/reports/cncf-annual-report-2023/

### [K01: Insecure Workload Configurations](https://owasp.org/www-project-kubernetes-top-ten/2022/en/src/K01-insecure-workload-configurations)
#### 安全配置建议
- 不以root运行
- 使用只读根文件系统
- 不使用特权容器
- 使用资源限制
- 不允许提权
#### CNCF相关项目
- [Kyverno](https://github.com/kyverno/kyverno)
CNCF孵化项目，是一个为云原生平台工程团队设计的策略引擎。它通过策略即代码实现安全性、自动化、合规性和治理
- [Falco](https://github.com/falcosecurity/falco)
CNCF毕业项目，是一个针对Linux操作系统的云原生运行时的安全工具。旨在实时检测和警报异常行为和潜在安全威胁
- [OPA](https://github.com/open-policy-agent/opa)
CNCF毕业项目，是一个开源的通用策略引擎，能够在整个技术栈中实现统一的、上下文感知的策略执行
- [Kubescape](https://github.com/kubescape/kubescape)
CNCF沙盒项目，是一个开源的Kubernetes安全平台，提供从左到右覆盖整个开发和部署生命周期的全面安全保障。它提供加固、态势管理和运行时安全功能，以确保对Kubernetes环境的强大保护
- [Kubewarden](https://github.com/kubewarden)
CNCF沙盒项目，是一个Kubernetes的策略引擎，以帮助保持您的Kubernetes集群安全和合规。Kubewarden策略可以使用常规编程语言或DSL编写。策略被编译成WebAssembly模块，然后通过传统的容器注册表进行分发

### [K02: Supply Chain Vulnerabilities](https://owasp.org/www-project-kubernetes-top-ten/2022/en/src/K02-supply-chain-vulnerabilities)
#### 安全配置建议
- 镜像完整性校验
- 使用SBOM
- 使用镜像签名
- 使用最小化镜像
- 镜像漏洞扫描
#### CNCF相关项目
- Kyverno
- Falco
- OPA
- [TUF](https://github.com/theupdateframework/python-tuf)
CNCF毕业项目，是一个安全更新软件包的框架，它旨在帮助开发人员保护软件更新过程，防止各种攻击（如中间人攻击、回滚攻击等）。TUF 提供了一套标准的、可验证的机制来确保软件包的完整性和来源的真实性
- [Harbor](https://github.com/goharbor/harbor)
CNCF毕业项目，是一个开源的可信云原生仓库项目，用于存储、签名和扫描镜像
- [in-toto](https://github.com/in-toto/in-toto)
CNCF孵化项目，提供了一个框架，以保护软件供应链的完整性。它通过验证链中的每个任务是否按计划执行、仅由授权人员进行，以及产品在运输过程中未被篡改来实现这一目标

### [K03: Overly Permissive RBAC Configurations](https://owasp.org/www-project-kubernetes-top-ten/2022/en/src/K03-overly-permissive-rbac)
#### 安全配置建议
- 尽可能减少最终用户对集群的直接访问
- 不要在集群外使用`Service Account Token`
- 避免自动挂载默认`Service Account Token`
- 审计与已安装的第三方组件的RBAC配置
- 部署中心化的策略管理以检测和阻止风险RBAC权限
- 利用`Rolebindings`将权限范围限制在特定命名空间，而不是`cluster-wide`RBAC政策
- 遵循Kubernetes官方[RBAC最佳实践](https://kubernetes.io/docs/concepts/security/rbac-good-practices/)
- 遵循最小权限原则
#### CNCF相关项目
- Kyverno
- Falco
- OPA
- [Keycloak](https://github.com/keycloak/keycloak)
CNCF孵化项目，为应用程序添加身份验证并以最小的努力保护服务，提供用户联邦认证、强身份验证、用户管理、细粒度授权等功能

### [K04: Lack of Centralized Policy Enforcement](https://owasp.org/www-project-kubernetes-top-ten/2022/en/src/K04-policy-enforcement)
#### 安全配置建议
- 定义清晰的策略
- 禁止未授权访问
- 持续审计和监控
- 持续改进
#### CNCF相关项目
- Kyverno
- Falco
- OPA
- [argo](https://github.com/argoproj/argo-cd)
CNCF毕业项目，用于Kubernetes的声明式的、GitOps持续集成部署工具
- [flux](https://github.com/fluxcd/flux2)
CNCF毕业项目，用于保持Kubernetes集群与配置源（如 Git 仓库和OCI组件）同步的工具，并在有新代码要部署时自动更新配置

### [K05: Inadequate Logging and Monitoring](https://owasp.org/www-project-kubernetes-top-ten/2022/en/src/K05-inadequate-logging)
#### 安全配置建议
- 开启详细日志
- 集中化日志管理
- 日志轮转
- 对日志进行监控和分析
- 开启审计日志
- 使用日志工具
#### CNCF相关项目
- [OpenTelemetry](https://github.com/open-telemetry)
CNCF孵化项目，用于软件的性能和行为进行仪表化、生成、收集和导出遥测数据（指标、日志和追踪），以帮助您分析软件的性能和行为
- [Prometheus](https://github.com/prometheus/prometheus)
CNCF毕业项目，用于监控系统和服务，以设定的时间间隔从配置的目标收集监控指标，利用规则表达式进行评估并显示结果，满足指定条件时触发警报
- [Jaeger](https://github.com/jaegertracing/jaeger)
CNCF毕业项目，分布式全链路追踪平台
- [cortex](https://github.com/cortexproject/cortex)
CNCF孵化项目，是一个水平可扩展、高可用性、多租户的 Prometheus 长期存储解决方案

### [K06: Broken Authentication Mechanisms](https://owasp.org/www-project-kubernetes-top-ten/2022/en/src/K06-broken-authentication)
#### 安全配置建议
- 避免在最终用户侧使用证书访问集群
- 开启MFA
- 不要在集群外使用`Service Account Token`
- 使用RBAC进行权限配置管理
#### CNCF相关项目
- Falco
- Keycloak
- [cert manager](https://github.com/cert-manager/cert-manager)
CNCF毕业项目，为k8s集群提供证书管理功能，可以颁发/吊销证书，支撑微服务间的mTLS双向认证

### [K07: Missing Network Segmentation Controls](https://owasp.org/www-project-kubernetes-top-ten/2022/en/src/K07-network-segmentation)
#### 安全配置建议
- 使用`Network Policies`
- 使用`Service Meshes`
- 部署多集群
- 使用CNI插件
#### CNCF相关项目
- [istio](https://github.com/istio/istio)
CNCF毕业项目，开源服务网格，提供了一种统一且更高效的方式来保护、连接和监控服务
- [cilium](https://github.com/cilium/cilium)
CNCF毕业项目，是一个基于eBPF的，用于提供、保护和观察容器工作负载（云原生）之间网络连接的解决方案
- [linkerd](https://github.com/linkerd/linkerd2/)
CNCF毕业项目，是一个超轻量、以安全为首的Kubernetes服务网格

### [K08: Secrets Management Failures](https://owasp.org/www-project-kubernetes-top-ten/2022/en/src/K08-secrets-management)
#### 安全配置建议
- 使用RBAC限制对`secrets`的访问
- 加密存储`secrets`
- 对`secrets`访问进行审计
- 定期轮转`secrets`
#### CNCF相关项目
- cert manager
- [spire](https://github.com/spiffe/spire)
CNCF毕业项目，是SPIFFE统一身份认证标准的官方实现，为服务间通信提供安全的身份认证和加密通道，实现零信任网络

### [K09: Misconfigured Cluster Components](https://owasp.org/www-project-kubernetes-top-ten/2022/en/src/K09-misconfigured-cluster-components)
#### 安全配置建议
- 禁止匿名访问
- 配置强认证
- 限制网络访问
- 遵从安全配置实践
#### CNCF相关项目
- kyverno
- keycloak
- falco
- opa

### [K10: Outdated and Vulnerable Kubernetes Components](https://owasp.org/www-project-kubernetes-top-ten/2022/en/src/K10-vulnerable-components)
#### 安全配置建议
- 跟踪漏洞库
- 持续进行漏洞扫描
- 减少三方依赖
- 做好补丁管理
#### CNCF相关项目
- falco
- kubescape
- argo
- flux

# QEMU/HyperV/VMWare

## 知识

- [QEMU 源码分析](https://airbus-seclab.github.io/qemu_blog/)
- [QEMU 博客](https://airbus-seclab.github.io/qemu_blog/)
- [HyperV攻击面](https://i.blackhat.com/USA21/Wednesday-Handouts/us-21-Mobius-Band-Explore-Hyper-V-Attack-Interface-Through-Vulnerabilities-Internals.pdf)
- [QEMU issues](https://gitlab.com/qemu-project/qemu/-/issues)
- [HyperV vGPU漏洞](https://i.blackhat.com/USA-22/Thursday/US-22-Hong-DirectX-The-New-Hyper-V-Attack-Surface.pdf)
- [windows容器通信](https://www.cyberark.com/resources/threat-research-blog/understanding-windows-containers-communication)
- [firecracker内存破坏漏洞](https://www.graplsecurity.com/post/attacking-firecracker)
- [使用virt-manager启动参数独立启动qemu](https://developers.redhat.com/blog/2020/03/06/configure-and-run-a-qemu-based-vm-outside-of-libvirt)

## 漏洞

- [QEMU Heap Overflow in SDHCI Component](https://starlabs.sg/advisories/21-3409/)
- [QEMU Misuse Error Handling逃逸](https://github.com/hustdebug/scavenger)
- [QEMU Virglrenderer逃逸](https://i.blackhat.com/asia-20/Thursday/asia-20-Shao-3D-Red-Pill-A-Guest-To-Host-Escape-On-QEMUKVM-Virtio-Device-wp.pdf)
- [QEMU vGPU逃逸](https://i.blackhat.com/USA21/Wednesday-Handouts/us-21-Another-Road-Leads-To-The-Host-From-A-Message-To-VM-Escape-On-Nvidia-VGPU.pdf)
- [QEMU QMP migrate任意命令执行](https://cxsecurity.com/issue/WLB-2022020039)
- [Matryoshka Trap: Recursive MMIO Flaws](https://qiuhao.org/Matryoshka_Trap.pdf) [poc](https://github.com/QiuhaoLi/CVE-2021-3929-3947) [blackhat](https://i.blackhat.com/Asia-22/Thursday-Materials/AS-22-Qiuhao-Recursive-MMIO-final.pdf)
- [CVE-2022-31705: vmware ehci漏洞](https://github.com/s0duku/cve-2022-31705)

# KERNEL

## 知识

- [kvm安全](https://github.com/rafaeldtinoco/howtos)

## 博客

- [project zero](https://googleprojectzero.blogspot.com/)
- [Aleph Research](https://alephsecurity.com/)
- [Alexander Popov](https://a13xp0p0v.github.io/)
- [pwn2own 2021 ubuntu lpe](https://flatt.tech/assets/reports/210401_pwn2own/whitepaper.pdf)
- [modprobe内核利用方法](https://sam4k.com/like-techniques-modprobe_path/)
- [uprobe原理及绕过方法](https://blog.quarkslab.com/defeating-ebpf-uprobe-monitoring.html)
- [linux dirty-pipe通用利用方法](https://github.com/veritas501/pipe-primitive)

## CVE

- [CVE-2016-5195: Dirty Cow](https://github.com/dirtycow/dirtycow.github.io/wiki/PoCs)
- [CVE-2017-0781： blueborne - 蓝牙漏洞](https://github.com/ArmisSecurity/blueborne)
- [CVE-2017-5123： linux waitid系统调用提权漏洞](https://github.com/nongiach/CVE)
- [CVE-2019-13272: ptrace_link漏洞本地提权](https://github.com/jas502n/CVE-2019-13272)
- [CVE-2017-13281： bluedroid - 蓝牙漏洞](https://github.com/JiounDai/Bluedroid)
- [CVE-2020-8835: 利用ebpf verification漏洞提权](https://github.com/noirfate/bpf-lpe) [文章](https://www.zerodayinitiative.com/blog/2020/4/8/cve-2020-8835-linux-kernel-privilege-escalation-via-improper-ebpf-program-verification)
- [CVE-2020-12351/CVE-2020-12352: BleedingTooth: Linux Bluetooth Zero-Click Remote Code Execution](https://github.com/google/security-research/tree/master/pocs/linux/bleedingtooth)
- [CVE-2021-3178: nfs leak](https://bugzilla.redhat.com/show_bug.cgi?id=1918179)
- [CVE-2021-3490: ebpf内核提权](https://github.com/chompie1337/Linux_LPE_eBPF_CVE-2021-3490) [文章](https://www.graplsecurity.com/post/kernel-pwning-with-ebpf-a-love-story)
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
- [CVE-2022-0847: 利用管道越权写文件](https://github.com/Arinerron/CVE-2022-0847-DirtyPipe-Exploit) [覆盖容器镜像文件](https://blog.aquasec.com/cve-2022-0847-dirty-pipe-linux-vulnerability) [覆盖runc](https://github.com/DataDog/dirtypipe-container-breakout-poc) [自动提权](https://github.com/EagleTube/CVE-2022-0847)
- [CVE-2022-0995: watch_queue OOB本地提权](https://github.com/Bonfee/CVE-2022-0995)
- [CVE-2022-2588: route4_change uaf本地提权](https://github.com/Markakd/CVE-2022-2588)
- [CVE-2022-2602: io_uring uaf本地提权](https://github.com/kiks7/CVE-2022-2602-Kernel-Exploit) [POC1](https://github.com/LukeGix/CVE-2022-2602)
- [CVE-2022-2639: openvswitch reserve_sfa_size越界访问](https://github.com/veritas501/CVE-2022-2639-PipeVersion)
- [CVE-2022-4543: KASLR Leakage Achievable even with KPTI through Prefetch Side-Channel](https://www.openwall.com/lists/oss-security/2022/12/16/3)
- [CVE-2022-23222: ebpf verify本地提权漏洞](https://github.com/tr3ee/CVE-2022-23222)
- [CVE-2022-25636：netfilter netdev OOB漏洞提权](https://github.com/Bonfee/CVE-2022-25636)
- [CVE-2022-27666：ipsec esp6 OOB漏洞提权](https://github.com/plummm/CVE-2022-27666) [文章](https://etenal.me/archives/1825)
- [CVE-2022-29968: io_uring子系统未初始化内存漏洞](https://github.com/jprx/CVE-2022-29968)
- [CVE-2022-32250: netfilter uaf漏洞](https://blog.exodusintel.com/2022/12/19/linux-kernel-exploiting-a-netfilter-use-after-free-in-kmalloc-cg/) [POC1](https://github.com/theori-io/CVE-2022-32250-exploit) [POC2](https://github.com/ysanatomic/CVE-2022-32250-LPE)
- [CVE-2022-34918 - netfilter类型混淆提权漏洞](https://github.com/trhacknon/CVE-2022-34918-LPE-PoC) [USMA利用方法](https://tttang.com/archive/1706/) [USMA利用代码](https://github.com/veritas501/CVE-2022-34918/tree/master/poc_fs_context_cred_common/src)
- [CVE-2023-0386 - overlayfs setuid file copy bug](https://github.com/xkaneiki/CVE-2023-0386)
- [CVE-2023-32233 - Netfilter nf_tables batch requests uaf](https://github.com/Liuk3r/CVE-2023-32233)

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

- [ATTCK](https://attack.mitre.org/versions/v13)
- [Microsoft Enterprise Cloud Red Teaming](https://download.microsoft.com/download/C/1/9/C1990DBA-502F-4C2A-848D-392B93D9B9C3/Microsoft_Enterprise_Cloud_Red_Teaming.pdf)
- [Fireeye Redteam Operations](https://www.fireeye.com/content/dam/fireeye-www/services/pdfs/pf/ms/ds-red-team-operations.pdf)
