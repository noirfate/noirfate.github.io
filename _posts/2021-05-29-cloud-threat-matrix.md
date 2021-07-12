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

知识梳理的好处就是可交流、可复制、可分解，伴随着ATT&CK的普及，越来越多的人或企业也开始使用它来描述攻击威胁，如：

* 微软的[Threat matrix for Kubernetes](https://www.microsoft.com/security/blog/2020/04/02/attack-matrix-kubernetes/)
![](/assets/img/k8s-matrix.png)
* 阿里云的[云上容器攻防矩阵](https://developer.aliyun.com/article/765449)
![](/assets/img/aliyun_matrix.png)

[红蓝对抗](https://www.fireeye.com/content/dam/fireeye-www/services/pdfs/pf/ms/ds-red-team-operations.pdf)也是最近很火的一个概念，被很多企业采用。现在的企业基本上都认识到**漏洞是不可避免的，没有攻不破的系统**，那如何提升和检验企业目前的安全性呢？红蓝对抗就是一个很好的方式，红队行动(攻击方)在传统渗透测试的基础上更加注重模拟真实的攻击，比如使用一些隐藏手段等等，以此来检验蓝军的监测和防守能力，不仅仅是单纯的发现和利用漏洞。同样的，对企业而言，单纯利用红蓝对抗来修补漏洞并不能真正提高企业的防御能力，真正需要提升的是防守团队监测与阻断攻击的能力以及企业的安全架构

以下是我对公有云的攻击方法及手段的一些初步和简陋的梳理，一些通用手段就不再列在其中了，主要写一些跟云相关的内容

PS: 安全只有两种，一种是没有被别人搞所以安全，一种是自己幻想自己安全

## 侦察 (Reconnaissance)

* 开源情报
  * 在互联网上收集针对云厂商的公开情报。[参考](https://github.com/jivoi/awesome-osint) [安全信息流](https://i.hacking8.com/)
  * 通常云厂商都有ASN(自治系统号)，可通过它收集相关资产信息，例如[阿里的资产](https://i.hacking8.com/src/detail/Alibaba)
  * 利用网络空间测绘工具，如Shodan、fofa、ZoomEye

## 初始访问 (Initial Access)

* 有效账户
  * 用户AK/SK、Token、Password
  * 云服务凭证，云服务本身也是云平台上的租户，攻击者如果掌握了泄露的云服务的账号密码、AK/SK等，就可以控制云服务的资源，进而拿到使用该云服务的租户的资源，甚至拿下云管理平台
* 对外服务
  * 通过资产收集发现暴露在公网的服务存在的漏洞或未授权
  * 云上租户区可访问的云服务
    * 云公共服务，如dns，每个租户的vpc均可访问
    * 云服务暴露的端口，云服务在提供服务时需要让租户可以访问，大概有以下几种实现方式
      * 建立vpc peering，即建立对等连接，如此便完全打通了租户vpc和服务资源vpc，租户可以访问到服务资源vpc下的所有虚机的所有开放端口，风险很大
      * 建立vpc endpoint，服务向租户暴露指定端口，租户只能访问到这个端口，无法访问服务资源vpc中的其他端口，风险较小
      * 把服务放在公共区，云厂商基本都使用了SDN(软件定义网络)，会在每个region中划出一个或多个网段，其中的服务对同region下的所有租户开放，例如dns。云服务开发人员可能会在此区域部署敏感服务，自认为别人不知道，但在租户vpc中就可以扫描出来
      * 把服务虚机的网卡挂在租户vpc中，这样租户就可以访问到绑定在该网卡上的服务端口。如果服务开发人员把不想让租户访问到的端口绑定在0.0.0.0上，就会造成风险
* 供应链
  * 开源镜像，一般云厂商都会提供开源镜像，比如pip mirror、apt mirror等等，如果官方源被污染了，那么云厂商都会受到影响。[参考](https://github.com/ffffffff0x/Dork-Admin#2020%E4%BE%9B%E5%BA%94%E9%93%BE%E6%94%BB%E5%87%BB%E4%BA%8B%E4%BB%B6)
  * 容器镜像，云厂商一般都会提供docker容器镜像，如果污染了云厂商或租户的的docker registry，则会产生较大风险
  * 虚机镜像，云厂商一般都会支持用户上传自定义镜像，可以上传恶意镜像并诱导他人使用。此外，云服务在创建资源虚机时也会使用自建的镜像，通常采取隐藏的手段不使租户发现，然而一旦知道镜像ID(比如从metadata中获取)，租户就可以使用云服务的自建镜像创建虚机，而云服务的镜像中往往存在敏感信息
  * 隐藏镜像：云服务资源所使用的镜像一般是用户不可见的，但假如能够获得镜像ID，用户就可以使用该镜像ID创建虚机，获取镜像中可能存在的敏感信息
* 混合云
  * 公有云通常会和其他私有云连接建立混合云。由于混合云中的每朵云之间存在互信关系，攻下其中一朵云，便可拿下所有云
* 未授权访问
  * 有些url貌似不能访问，但可通过修改User-Agent或host文件进行访问
* 使用ID获取凭证
	* 云服务通常使用UUID来作为资源的唯一标识，并且可能会使用这个UUID来作为认证凭据，虽然理论上UUID只有用户知晓，也不可能被爆破，但用户可能会泄露UUID。当攻击者拿到UUID时，就可以通过认证并控制用户的资源 [参考](https://andresriancho.com/wp-content/uploads/2019/06/whitepaper-internet-scale-analysis-of-aws-cognito-security.pdf)

## 执行 (Execution)

* 云API
  * 利用云厂商提供的api或客户端执行命令
  * 利用隐藏api执行命令，一般云厂商都会有内部使用的api，比如给云服务使用的内部特权接口，这些接口一般是不会开放给租户的，但如果发现其隔离措施的疏漏，则可以利用内部api实施攻击
* 云服务
  * 利用云服务自身的功能执行代码，例如DevOps、AI模型训练推理、大数据map-reduce、Serverless等等
  * 利用云服务未授权或漏洞执行代码，例如云服务rpc命令注入
* 开源组件漏洞
  * 利用云服务使用的开源组件中的漏洞，比如redis、mysql、jenkins、fastjson、docker、git等等
  * 利用java反序列化，很多java组件支持RMI等远程加载对象并执行的功能，如果配置不当则会导致RCE，例如JMX

## 权限提升 (Privilege Escalation)

* 云原生漏洞或弱配置
  * Linux内核漏洞、docker逃逸、qemu逃逸、sudo漏洞等
  * k8s弱配置，如挂载可读写的主机目录、挂载docker.sock、pod默认挂载security token、没开启RBAC认证等等
  * 可访问宿主机的kubelet(10250/10255端口)或openstack metadata
  * 使用特权容器或者CAP\_ADMIN
  * docker daemon开启了远程访问
  * 容器内使用root账户运行
* 提权程序
  * 利用SUID程序，find / -perm 4000
  * 通过sudo -l查看是否存在可利用的提权脚本，有时开发人员会做一些掩耳盗铃的事情，虽然服务默认使用了低权限账号，但为了执行某些特权操作而在文件系统中提供了提权脚本(假装别人不知道)
* 身份认证配置
  * 通常云厂商都会提供身份认证管理服务，如AWS的IAM或者阿里云的RAM等等，企业租户如果配置不当，就可能被其下的子账户takeover
  * 云服务在设计时没有仔细考虑主账号、子账号的权限问题，即使租户配置得当也会产生越权的问题。例如，主账户只给其下某个子账号A服务的使用权限，但A服务在环境变量或其他使用者可访问的地方存储了使用者的AK/SK，那么只要主账号使用了A服务，子账号就可以获得主账号的AK/SK
  * 租户在使用委托时，被委托人可以用自己的token换取委托人的token，若权限配置不当会产生风险，云服务经常会使用委托功能来管理租户的资源，很多时候也未做到权限最小化

## 凭据访问 (Credential Access)

* 侧信道
  * 由于多个虚机共用一台物理机，故可利用cpu、gpu、memory的侧信道攻击技术收集同物理机上其他虚机的信息
* openstack metadata
  * 通过<span>http://169.254.169.254</span>访问metadata，可以收集到主机的信息，甚至敏感信息(常见于user_data中) [参考1](https://pumascan.com/resources/cloud-security-instance-metadata/) [参考2](https://github.com/irsl/gcp-dhcp-takeover-code-exec)
* 私有服务
  * 在大部分情况下，租户在使用云服务时，用的是云服务的资源，即云服务分配虚机给租户用，租户只能访问虚机上开放的端口，但无法控制虚机。还有一部分服务支持使用租户自己的资源部署，即服务提供容器镜像或虚机镜像给租户用。虽然一般情况下服务提供的镜像不会包含敏感文件，但是镜像中运行的程序在跟管理节点通信的时候可能包含敏感信息，即使是使用https传输，但由于虚机是租户完全可控的，故可通过逆向调试得到明文(如使用gcore获取进程内存，然后用strings + grep查看其中的明文信息)
* 暴力破解
* 未授权访问
  * 很多未授权访问均可获得敏感信息，比如hadoop、hbase、zookeeper、SpringBoot Actuator、环境变量等等
  * 如果可在服务提供的pod中执行代码，且pod没做安全加固，那么就可以得到k8s的security token，通过它便可进行容器逃逸或控制k8s集群

## 横向移动 (Lateral Movement)

* VPC
  * 利用可控VPC与其他VPC之间的连接(peering、endpoint)进行横移
* 云服务
  * 云服务运行业务所使用的资源虽然也在租户区，但防火墙配置可能不同，可以云服务的vpc为跳板继续深入。如serverless服务，就是利用服务资源执行函数，即用户函数的运行环境是在服务的vpc中
* k8s
  * 利用k8s的证书、token等控制整个集群

## 信息收集 (Collection)

* 云存储
  * 寻找公开可访问的云厂商提供的存储服务链接，例如AWS的S3、阿里云的OSS、华为云的OBS等等。此外利用他人的AK/SK也很可能在对象存储中发现敏感信息
* 文档和SDK
  * 在文档中或公开的SDK里，可能会暴露一些未公开的api接口，默认账号密码等
* 云API
  * 云服务API在设计时如果没有限制访问频率且返回内容过于精确，则可能导致通过暴力破解的方法收集账号等信息(通过浏览器界面+Burpsuite或者直接调用rest api)

## 数据渗出 (Exfiltration)

* 云存储
  * 很多云服务在运行时都依赖云存储服务，假设可以在云服务的虚机上执行任意代码，但是这个虚机在内网连不出来，那么可以尝试去连对象存储服务，该服务通常内外网均可访问

