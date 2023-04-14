---
title: Cloud Threat Matrix
layout: post
categories: redteaming
tags: redteaming
date: 2021-05-29 10:00
excerpt: Cloud Threat Matrix
---

# 云上威胁矩阵

## 引言

网络空间中的威胁层出不穷，面对日益多样和复杂的APT攻击，如何能够用一个简洁明了的知识框架来对它们进行描述就成了一个问题。MITRE于2013年提出了[ATT&CK](https://attack.mitre.org/matrices/enterprise/)框架，经过不断的完善和改进，形成了如下丰富的内容<br>
![](/assets/img/attck_ent.png)

ATT&CK框架主要包括的三个部分，上图中直接显示出来了两个部分Tactic(战术)和Technique(技术)，还有一个没有显示出来的部分是Procedure(过程)

* Tactic (战术)
  * 战术就是攻击行动的方法论，也可以看作是对攻击行动中所使用的技术的一个分类
* Technique (技术)
  * 攻击行动中所使用到的各种技术手段
* Procedure (过程)
  * 过程即攻击行动的执行过程，根据时间线把攻击涉及到的战术阶段中所使用的技术串联起来，可用于复盘、防御和攻击模拟，例如[PDF](https://attack.mitre.org/docs/APT3_Adversary_Emulation_Plan.pdf)
  ![](/assets/img/attck_pro.jpg)

[ATT&CK框架各个技术点对应测试样例](https://github.com/redcanaryco/atomic-red-team/blob/master/atomics/Indexes/Indexes-Markdown/index.md)

**知识梳理的好处就是可交流、可复制、可分解，伴随着ATT&CK的普及，越来越多的人或企业也开始使用它来描述攻击威胁，如：**

![](/assets/img/k8s-matrix.png)
{: style="width: 100%;" class="center"}
*Fig. 1. 微软的[Threat matrix for Kubernetes](https://www.microsoft.com/security/blog/2020/04/02/attack-matrix-kubernetes/)*
{:.image-caption}

![](/assets/img/ms-k8s-matrix.png)
{: style="width: 100%;" class="center"}
*Fig. 1. 微软新版的[Threat matrix for Kubernetes](https://microsoft.github.io/Threat-Matrix-for-Kubernetes/)*
{:.image-caption}
	
![](/assets/img/aliyun_matrix.png)
{: style="width: 100%;" class="center"}
*Fig. 2. 阿里云的[云上容器攻防矩阵](https://developer.aliyun.com/article/765449)*
{:.image-caption}

![](/assets/img/yunding01.png)
{: style="width: 100%;" class="center"}
*Fig. 3. 腾讯云鼎发布的云安全攻防矩阵*
{:.image-caption}

![](/assets/img/yunding02.png)
{: style="width: 100%;" class="center"}
*Fig. 4. 腾讯云鼎发布的云原生安全攻防全景图*
{:.image-caption}

![](/assets/img/yunding03.jpg)
{: style="width: 100%;" class="center"}
*Fig. 5. 腾讯云鼎发布的[云服务器攻防矩阵](https://zhuanlan.zhihu.com/p/455523946)*
{:.image-caption}

![](/assets/img/yunding04.png)
{: style="width: 100%;" class="center"}
*Fig. 6. 腾讯云鼎发布的[对象存储攻防矩阵](https://www.freebuf.com/articles/database/290463.html)*
{:.image-caption}

![](/assets/img/devops-ms-matrix.png)
{: style="width: 100%;" class="center"}
*Fig. 6. 微软发布的[DevOps攻防矩阵](https://www.microsoft.com/en-us/security/blog/2023/04/06/devops-threat-matrix/)*
{:.image-caption}

[红蓝对抗](https://www.fireeye.com/content/dam/fireeye-www/services/pdfs/pf/ms/ds-red-team-operations.pdf)也是最近很火的一个概念，被很多企业采用。现在的企业基本上都认识到**漏洞是不可避免的，没有攻不破的系统**，那如何提升和检验企业目前的安全性呢？红蓝对抗就是一个很好的方式，红队行动(攻击方)在传统渗透测试的基础上更加注重模拟真实的攻击，比如使用一些隐藏手段等等，以此来检验蓝军的监测和防守能力，不仅仅是单纯的发现和利用漏洞。同样的，对企业而言，单纯利用红蓝对抗来修补漏洞并不能真正提高企业的防御能力，真正需要提升的是防守团队监测与阻断攻击的能力以及企业的安全架构。关于红蓝对抗的更多信息，可以参考[红队的进化](https://devco.re/conf/2019/slides/devcore-conf-2019-shaolin-DEVCORE%20%E7%B4%85%E9%9A%8A%E7%9A%84%E9%80%B2%E5%8C%96%EF%BC%8C%E8%88%87%E4%B8%8B%E4%B8%80%E6%AD%A5.pdf)和[红队成熟度评估矩阵](https://www.redteams.fyi/)

**Kill Chain and TTPs**
![](/assets/img/kill_chain.png)
![](/assets/img/kill_chain_ttps.png)


以下是我对公有云的攻击方法及手段的一些初步和简陋的梳理，一些通用手段就不再列在其中了，主要写一些跟云相关的内容

### 案例
> The More You Know, The More You Know You Don’t Know

* 通过伪造目标节点的证书签名请求获取其证书，通过证书控制节点
  * [Hacking Kubelet on Google Kubernetes Engine](https://www.4armed.com/blog/hacking-kubelet-on-gke/)
  * [GKE Kubelet TLS Bootstrap Privilege Escalation](https://rhinosecuritylabs.com/cloud-security/kubelet-tls-bootstrap-privilege-escalation/)
* 使用serverless函数监控目标的对象存储桶，当监控到有新文件上传时，修改上传的文件。这种攻击手法利用的是时间差，很多服务在运行时需要执行用户对象存储桶中的文件，从用户上传文件到服务拉取文件之间需要一小段时间，攻击者如果能在这段时间内修改用户上传的文件，则可实施攻击
  * [Resource Injection in CloudFormation Templates](https://rhinosecuritylabs.com/aws/cloud-malware-cloudformation-injection/)
* 利用IAM弱配置
  * [Investigating PrivEsc Methods in AWS](https://labs.bishopfox.com/tech-blog/privilege-escalation-in-aws)
  * [Privilege Escalation in Google Cloud Platform – Part 1 (IAM)](https://rhinosecuritylabs.com/gcp/privilege-escalation-google-cloud-platform-part-1/)
* 容器/k8s逃逸
  * [Cross-Account Container Takeover in Azure Container Instances](https://unit42.paloaltonetworks.com/azure-container-instances/)
  * [Hacking DigitalOcean's New Kubernetes Service](https://www.4armed.com/blog/hacking-digitalocean-kubernetes/)
  * [AWS SageMaker Jupyter Notebook Instance Takeover](https://blog.lightspin.io/aws-sagemaker-notebook-takeover-vulnerability)
  * [AWS log4shell热补容器逃逸](https://unit42.paloaltonetworks.com/aws-log4shell-hot-patch-vulnerabilities/)
* agent漏洞或未授权访问
  * [Agent Exposes Azure Customers To Unauthorized Code Execution](https://www.wiz.io/blog/secret-agent-exposes-azure-customers-to-unauthorized-code-execution)
* 命令注入
  * [Azure CSV Injection Vulnerability](https://rhinosecuritylabs.com/azure/cloud-security-risks-part-1-azure-csv-injection-vulnerability/)
  * [CSV Injection in AWS CloudTrail](https://rhinosecuritylabs.com/aws/cloud-security-csv-injection-aws-cloudtrail/)
  * [AWS WorkSpaces Remote Code Execution](https://rhinosecuritylabs.com/aws/cve-2021-38112-aws-workspaces-rce/?__cf_chl_jschl_tk__=pmd_XcEFdL6Sp_PtLOYR.E6GQyPehV7m3LXviDvdyKbv.qI-1632281490-0-gqNtZGzNAfujcnBszQhR)
  * [AWS exploit lambda trigger via S3 filename](https://sysdig.com/blog/exploit-mitigate-aws-lambdas-mitre/)
* SSRF
	* [SSRF vulnerability in AppSheet](https://nechudav.blogspot.com/2021/12/ssrf-vulnerability-in-appsheet-google.html)
	* [A Case Study of the Capital One Data Breach](https://web.mit.edu/smadnick/www/wp/2020-16.pdf)
	* [AWS CloudFormation XXE](https://orca.security/resources/blog/aws-cloudformation-vulnerability/)
	* [EverNote SSRF leak GCP metadata](https://blog.neolex.dev/13/)
* 服务漏洞
	* [AWS RDS PostgreSQL log_fdw插件任意文件读](https://blog.lightspin.io/aws-rds-critical-security-vulnerability)
	
## 侦察 (Reconnaissance)

* 开源情报
  * 在互联网上收集针对云厂商的公开情报。[参考](https://github.com/jivoi/awesome-osint) [安全信息流](https://i.hacking8.com/)
  * 通常云厂商都有ASN(自治系统号)，可通过它收集相关资产信息，例如[阿里的资产](https://i.hacking8.com/src/detail/Alibaba)
  * 利用网络空间测绘工具，如Shodan、fofa、ZoomEye、Censys
  * 根据域名、组织名、哈希来查询证书信息，如[crt.sh](https://crt.sh/)。一些服务在用证书认证的时候使用CN字段作为用户标识，在没有证书的情况下可以通过查询证书信息来获取CN

## 初始访问 (Initial Access)

* 有效账户
  * 用户AK/SK、Token、Password
  * 云服务凭证，云服务本身也可能是云平台上的租户，攻击者如果掌握了泄露的云服务的账号密码、AK/SK等，就可以控制云服务的资源，进而拿到使用该云服务的租户的资源，甚至拿下云管理平台
* 对外服务
  * 通过资产收集发现暴露在公网的服务存在的漏洞或未授权，如：根据ASN查IP段，扫描开放端口的IP，配合常用HOST（比如证书中的）访问
  * 云上租户区可访问的云服务
    * 云公共服务，如dns，每个租户的vpc均可访问
    * 云服务暴露的端口，云服务在提供服务时需要让租户可以访问，大概有以下几种实现方式
      * 建立vpc peering，即建立对等连接，如此便完全打通了租户vpc和服务资源vpc，租户可以访问到服务资源vpc下的所有虚机的所有开放端口，风险很大
      * 建立vpc endpoint，服务向租户暴露指定端口，租户只能访问到这个端口，无法访问服务资源vpc中的其他端口，风险较小
      * 把服务放在公共区，云厂商基本都使用了SDN(软件定义网络)，会在每个region中划出一个或多个网段，其中的服务对同region下的所有租户开放，例如dns。云服务开发人员可能会在此区域部署敏感服务，自认为别人不知道，但在租户vpc中就可以扫描出来
      * 把服务虚机的网卡挂在租户vpc中，这样租户就可以访问到绑定在该网卡上的服务端口。如果服务开发人员把不想让租户访问到的端口绑定在0.0.0.0上，就会造成风险
  * 寻找SSRF注入点，通过SSRF访问metadata或者进行内网扫描
  * 云服务API授权校验漏洞，一般调用云服务API都需要认证，比如token或aksk，通过认证后对该用户有没有权限操作所访问的资源则可能存在校验漏洞，使无权访问该资源的用户有能力操作它，这种情况通常发生在请求body里包含资源ID时
  * 利用云服务的功能或架构进行攻击
  	* 云服务把自身安装在用户完全可控的资源中，则可能在文件或进程中泄漏服务自身的敏感信息
  	* 利用云服务提供的功能实施攻击，很多云服务提供给用户较多的功能，可以上传插件、执行脚本等等，可利用这些功能控制服务所在的容器或虚机以及使用SSRF进行内网探测等
* 供应链
  * 开源镜像，一般云厂商都会提供开源镜像，比如pip mirror、apt mirror等等，如果官方源被污染了，那么云厂商都会受到影响。[参考](https://github.com/ffffffff0x/Dork-Admin#2020%E4%BE%9B%E5%BA%94%E9%93%BE%E6%94%BB%E5%87%BB%E4%BA%8B%E4%BB%B6)
  * 容器镜像，云厂商一般都会提供docker容器镜像，如果污染了云厂商或租户的的docker registry，则会产生较大风险
  * 虚机镜像，云厂商一般都会支持用户上传自定义镜像，可以上传恶意镜像并诱导他人使用。此外，云服务在创建资源虚机时也会使用自建的镜像，通常采取隐藏的手段不使租户发现，然而一旦知道镜像ID(比如从metadata中获取)，租户就可以使用云服务的自建镜像创建虚机，而云服务的镜像中往往存在敏感信息
  * 隐藏镜像：云服务资源所使用的镜像一般是用户不可见的，但假如能够获得镜像ID，用户就可以使用该镜像ID创建虚机，获取镜像中可能存在的敏感信息
  * 对象存储：云服务可能会把agent的安装包放在对象存储服务中（如S3），对于每个region都创建一个固定名字的bucket，当有新建region时，攻击者可以通过抢注bucket来进行劫持，使得此region下的机器安装攻击者的程序
* 混合云
  * 公有云通常会和其他私有云连接建立混合云。由于混合云中的每朵云之间存在互信关系，攻下其中一朵云，便可拿下所有云
* 未授权访问
  * 有些url貌似不能访问，但可通过修改User-Agent或host文件进行访问
* 使用ID获取凭证
	* 云服务通常使用UUID来作为资源的唯一标识，并且可能会使用这个UUID来作为认证凭据，虽然理论上UUID只有用户知晓，也不可能被爆破，但用户可能会泄露UUID。当攻击者拿到UUID时，就可以通过认证并控制用户的资源 [参考](https://andresriancho.com/wp-content/uploads/2019/06/whitepaper-internet-scale-analysis-of-aws-cognito-security.pdf)
* 内部服务挂到公网
	* 有些时候为了方便，会把内部网站开放到公网，通过IP扫描，可发现重定向头`Location`的内容为内部域名，修改host，绑定IP和内部域名，则可访问。进一步可以进行泛扫，把域名列表和IP列表一一绑定进行测试
* 内部使用公网IP段
	* 若云厂商把自己内部使用的IP地址设置为公网IP，则存在暴露风险，如租户设置SNAT网关，如果网关节点路由配置不当，则会把租户访问的公网IP路由到内部节点
	
## 执行 (Execution)

* 云API
  * 利用云厂商提供的api或客户端执行命令
  * 利用隐藏api执行命令，一般云厂商都会有内部使用的api，比如给云服务使用的内部特权接口，这些接口一般是不会开放给租户的，但如果发现其隔离措施的疏漏，则可以利用内部api实施攻击
* 云服务
  * 利用云服务自身的功能执行代码，例如DevOps、AI模型训练推理、大数据map-reduce、Serverless等等
  * 利用云服务未授权或漏洞执行代码，例如云服务rpc命令注入
  * 利用云服务agent漏洞进行本地提权，例如安全防护软件
* 开源组件漏洞
  * 利用云服务使用的开源组件中的漏洞，比如redis、mysql、jenkins、fastjson、docker、git等等
  * 利用java反序列化，很多java组件支持RMI等远程加载对象并执行的功能，如果配置不当则会导致RCE，例如JMX
  * 利用云服务发布的SDK中的漏洞，往往云服务自身也会使用这些SDK
* 子网DNS
	* 创建VPC子网域名，把公共域名解析到自己可控的IP上，则可控制虚机上的服务在进行域名解析时所获得的IP，如果服务会通过域名下载执行代码的话，就可以在虚机上执行任意代码了
* 域名劫持
	* 用户在使用云CDN之后，在删除CDN时忘记删除自己DNS的cname解析记录，导致其他用户可以在云CDN上注册相同的域名进行劫持
	* 用户在使用云WAF时，由于WAF接入的标识是`域名:端口`，故可通过非标端口进行WAF域名劫持，如创建`www.example.com:88`，访问`https://www.example.com:88`时就会跳转到自己指定的源站上

## 权限提升 (Privilege Escalation)

* 云原生漏洞或弱配置
  * Linux内核漏洞、docker逃逸、qemu逃逸、sudo漏洞等
  * k8s弱配置，如挂载可读写的主机目录、挂载docker.sock、pod默认挂载security token、没开启RBAC认证等等
  * 可访问宿主机的kubelet(10250/10255端口)或openstack metadata
  * 使用特权容器或者CAP\_ADMIN
  * docker daemon开启了远程访问
  * 容器内使用root账户运行
  * 容器使用宿主机网络，或者容器内可以访问到宿主机的监听在任意地址的端口，比如22
* 提权程序
  * 利用SUID程序，find / -perm 4000
  * 通过sudo -l查看是否存在可利用的提权脚本，有时开发人员会做一些掩耳盗铃的事情，虽然服务默认使用了低权限账号，但为了执行某些特权操作而在文件系统中提供了提权脚本(假装别人不知道)
  * 若root进程会执行低权限用户可修改的文件或者与低权限用户控制的服务交互，则低权限用户可通过修改文件或服务进行提权
* 认证鉴权配置
  * 通常云厂商都会提供身份认证管理服务，如AWS的IAM或者阿里云的RAM等等，企业租户如果配置不当，就可能被其下的子账户takeover
  * 云服务在设计时没有仔细考虑主账号、子账号的权限问题，即使租户配置得当也会产生越权的问题。例如，主账户只给其下某个子账号A服务的使用权限，但A服务在环境变量或其他使用者可访问的地方存储了使用者的AK/SK，那么只要主账号使用了A服务，子账号就可以获得主账号的AK/SK
  * 租户在使用委托时，被委托人可以用自己的token换取委托人的token，若权限配置不当会产生风险，云服务经常会使用委托功能来管理租户的资源，很多时候也未做到权限最小化
  * 云厂商可能存在不恰当的权限设置，可利用已有的服务权限获得其他服务的权限，或者通过读权限可获得敏感信息或写权限等等
  * 某些云服务或云服务的某些API存在鉴权缺失的情况，即只做了认证而没有鉴权，则凡是通过认证的用户都可以使用该服务，进而可通过获取服务敏感信息等方式提权

## 凭据访问 (Credential Access)

* 侧信道
  * 由于多个虚机共用一台物理机，故可利用cpu、gpu、memory的侧信道攻击技术收集同物理机上其他虚机的信息
* openstack metadata
  * 通过<span>http://169.254.169.254</span>访问metadata，可以收集到主机的信息，甚至敏感信息(常见于user_data中) [参考1](https://pumascan.com/resources/cloud-security-instance-metadata/) [参考2](https://github.com/irsl/gcp-dhcp-takeover-code-exec)
  * 通过读取`/run/cloud-init/instance-data.json`获取metadata，`/var/lib/cloud/instance/user-data.txt`获取userdata
* 云服务资源
  * 在大部分情况下，租户在使用云服务时，用的是云服务的资源，即云服务分配虚机给租户用，租户只能访问虚机上开放的端口，但无法控制虚机。还有一部分服务支持使用租户自己的资源部署，即服务提供容器镜像或虚机镜像给租户用。虽然一般情况下服务提供的镜像不会包含敏感文件，但是镜像中运行的程序在跟管理节点通信的时候可能包含敏感信息，即使是使用https传输，但由于虚机是租户完全可控的，故可通过逆向调试得到明文(如使用gcore获取进程内存，然后用strings + grep查看其中的明文信息)
  * 很多时候云服务会在本地存储服务账号凭证，假如攻击者通过漏洞进入云服务虚机，可从本地文件、bash_history中获取凭证
* 暴力破解
* 未授权访问
  * 很多未授权访问均可获得敏感信息，比如hadoop、hbase、zookeeper、SpringBoot Actuator、etcd、 Elasticsearch、环境变量等等
  * 如果可在服务提供的pod中执行代码，且pod没做安全加固，那么就可以得到k8s的security token，通过它便可进行容器逃逸或控制k8s集群

## 横向移动 (Lateral Movement)

* VPC
  * 利用可控VPC与其他VPC之间的连接(peering、endpoint)进行横移
* 云服务
  * 云服务运行业务所使用的资源虽然也在租户区，但防火墙配置可能不同，可以云服务的vpc为跳板继续深入。如serverless服务，就是利用服务资源执行函数，即用户函数的运行环境是在服务的vpc中。真实案例如[Azure PostgreSQL服务跨租户数据窃取](https://www.wiz.io/blog/wiz-research-discovers-extrareplica-cross-account-database-vulnerability-in-azure-postgresql/)：
  	* A managed cloud service that provides customers a dedicated virtual machine instance within an internal cloud environment
  	* A service that would allow us to execute code, either as part of the standard functionality of the service or through a newly discovered vulnerability. If we could execute code using a vulnerability, we would be more likely to find a less strict environment, since the service developers likely did not expect users to run their code there
  	* Service nature should be of high value, used by many and contain sensitive information
* k8s
  * 利用k8s的证书、token等控制整个集群

## 信息收集 (Collection)

* 云存储
  * 寻找公开可访问的云厂商提供的存储服务链接，例如AWS的S3、阿里云的OSS、华为云的OBS等等。此外利用他人的AK/SK也很可能在对象存储中发现敏感信息
* 文档和SDK
  * 在文档中或公开的SDK里，可能会暴露一些未公开的api接口，默认账号密码等
* 云API
  * 云服务API在设计时如果没有限制访问频率且返回内容过于精确，则可能导致通过暴力破解的方法收集账号等信息(通过浏览器界面+Burpsuite或者直接调用rest api)
  * 利用云服务未公开API获取敏感信息

## 数据渗出 (Exfiltration)

* 云存储
  * 很多云服务在运行时都依赖云存储服务，假设可以在云服务的虚机上执行任意代码，但是这个虚机在内网连不出来，那么可以尝试去连对象存储服务，该服务通常内外网均可访问
	* 如果攻击者具备虚机的操作权限，但无法登陆目标虚机，又不想使用重置密码或卸载磁盘等易被感知的操作，则可通过导出虚机为镜像，然后通过镜像创建新的虚机，再对新的虚机进行重置密码或硬盘卸载的操作
* API网关
  * 如果发现SSRF漏洞，但无法出网，可借助API网关作为跳板，大部分内部服务器都可以访问云上自建的API网关，创建一个API网关把后端指向自己的server即可让内网服务器访问到自己在外网的server

## 防御逃逸 (Defense Evasion)

* HTTP请求
  * 利用`User-Agent`绕过ACL或监控
  * 利用`Host`绕过ACL或监控
* 云服务
  * 利用云服务资源绕过ACL或监控，如API网关、Serverless服务等
  * 利用云上暴露的API代理（一些云服务为了方便会在租户可访问的区域搭建通向内部API的代理）绕过ACL或监控
  * 利用云的各种类型的凭证之间的互换维持权限以防获取的单一凭证被禁用或删除导致无法访问
  * 利用vpn、vpc endpoint等网络隧道服务伪造源IP绕过ACL
* 域前置
	* 可把攻击者的恶意服务器藏在WAF或CDN之后
