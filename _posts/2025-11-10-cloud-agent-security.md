---
title: Cloud Agent Security
layout: post
categories: redteaming
tags: cloud security
date: 2025-11-10 08:00
excerpt: Cloud Agent Security
---

{:.table-of-content}
* TOC
{:toc}

# Cloud Agent Security

## 背景

随着Cloud Native的普及和企业上云的加速，云安全越来越受到重视，例如google以320亿美元收购云安全公司Wiz。在这其中，有一类安全问题虽屡屡出现，但未得到专门的分类研究，这里暂称之为云上agent安全

## 定义

云上agent是指在云环境中运行的辅助性功能代理服务，以及用于接入云环境的各种客户端应用，它们往往用来提供一些便捷性功能、辅助管理或操作功能、安全监控功能、日志记录功能等等，最典型和广为人知的就是IMDS服务

## 类型

* 云提供商Agent
  * **AWS:** SSM Agent（管理）、CloudWatch Agent（监控）、GuardDuty Agent（安全）…
  * **Azure:** Azure Monitor Agent（监控）、Defender for Cloud Agent（安全）、Azure Arc Agent（管理）…
  * **GCP:** Ops Agent（监控）、Security Command Center Agent（安全） …
  * …
* 云原生Agent
  * **监控类:** Prometheus Node Exporter、kube-state-metrics …
  * **日志类:** FluentBit …
  * **安全类:** Falco、OPA Gatekeeper …
  * **网络类:** kube-proxy …
  * **存储类:** gitrepo …
  * **管理类:** dashboard …
  * …

## 部署

* 主机

安装在客户虚机/物理机上的agent

* 容器

以容器方式运行的agent，如：DaemonSet、Sidecar

* 服务

以服务的方式供客户使用，如IMDS

## 案例

### 本地提权

* [CVE-2022-29527: AWS SSM Agent 本地提权漏洞](https://www.wiz.io/vulnerability-database/cve/cve-2022-29527)

此漏洞存在于 amazon-ssm-agent 的 agent/session/utility/utilityunix.go 文件。在创建 sudoers 文件时，代码使用了 os.Create()，该函数以默认权限（0666）创建文件，使其可被所有用户写入。尽管代码随后将权限更改为 0440，但仍存在一段时间窗口，在此期间该文件对所有用户可写。该问题在 /etc/sudoers.d 为全局可读的系统上尤其令人担忧，例如权限为 755 的 Debian Linux

* [CVE-2025-49692: Azure Connected Machine Agent 本地提权漏洞](https://windowsforum.com/threads/cve-2025-49692-azure-arc-connected-machine-agent-elevation-of-privilege-patch-defend.380260/)

Azure Connected Machine (aka "Azure Arc" / connected‑machine) agent 在windows/linux主机上运行，以启用管理、扩展和身份功能。由于该代理会安装服务、本地接口和本地元数据端点，该软件中的权限提升（EoP）漏洞可能允许低权限的本地用户，或已获得有限本地访问的攻击者，提升到更高的权限（可能为 SYSTEM/ root），并从被攻陷的主机执行持久性或面向云的操作

* [CVE-2022-25166：AWS VPN Client TOCTOU 本地提权漏洞](https://rhinosecuritylabs.com/aws/cve-2022-25165-aws-vpn-client/)

AWS VPN Client 先校验openvpn配置，然后启动openvpn，在校验之后、启动之前，攻击者可以利用这个时间窗注入恶意配置，实现以SYSTEM权限写任意文件，进而提权

* [CVE-2022-25165：AWS VPN Client UNC路径信息泄露](https://github.com/RhinoSecurityLabs/CVEs/blob/master/CVE-2022-25165/CVE-2022-25165.ovpn)

AWS VPN Client 在对文件路径校验的时候没有处理UNC路径，导致可以通过传入UNC路径读取凭据

* [CVE-2022–33675：Azure Site Recovery DLL劫持](https://medium.com/tenable-techblog/microsoft-azure-site-recovery-dll-hijacking-cd8cc34ef80c)

Azure Site Recovery是一个灾备应用，它的安装路径`E:\Program Files (x86)\Microsoft Azure Site Recovery\home\svsystems\transport\`可被普通用户写，普通用户可通过往其中写入恶意DLL进行提权

### RCE

* **Azure's Cosmos DB 漏洞**
  * [ChaosDB](https://www.wiz.io/blog/chaosdb-explained-azures-cosmos-db-vulnerability-walkthrough): 2021年wiz发现的漏洞，从cosmos db notebook容器中访问wireserver（类似metadata服务，地址为168.63.129.16），从中获取当前VM安装的扩展并拿到凭据，从`ServiceFabricNodeExtension`中得到了集群中大量其他租户的存储密钥
  * [CosMiss](https://orca.security/resources/blog/cosmiss-vulnerability-azure-cosmos-db/): 2022年orca发现的漏洞，cosmos db notebook访问无需认证，只要知道`forwardingId`这个uuid即能访问，通过修改`/home/cosmosuser/.local/lib/python3.6/site-packages/jupyter_client/kernelspec.py`，可在租户打开时执行任意代码
* [CVE-2025-47988: Azure Monitor Agent 代码注入漏洞](https://zeropath.com/blog/azure-monitor-agent-cve-2025-47988-code-injection)

该漏洞源于 Azure Monitor Agent 未能对来自遥测数据流的输入进行充分清理。具体而言，来自外部的输入在未经足够验证或转义的情况下被不当嵌入到动态生成的可执行代码中。处于同一网段的攻击者可以通过构造恶意遥测输入利用此缺陷，从而导致未经授权的远程代码执行

* [GCP 利用DHCP伪造metadata服务](https://github.com/irsl/gcp-dhcp-takeover-code-exec)

利用isc dhcp服务的弱随机性，伪造DHCPACK（其中包含`metadata.google.com`的地址），修改受害者虚机dhcp的配置，从而诱导受害者虚机上的`google_guest_agent`访问攻击者伪造的metadata服务，获取ssh公钥配置，写入客户的`/root/.ssh/authorized_keys`中，之后攻击者可直接登录受害者的虚机

* [Azure OMIGOD](https://www.wiz.io/blog/secret-agent-exposes-azure-customers-to-unauthorized-code-execution)

开放管理基础设施（OMI）是一个由微软与开放组（The Open Group）合作赞助的开源项目。本质上，它是针对 UNIX/Linux 系统的 Windows 管理基础设施（WMI）。当用户使用Azure Automation、Azure Automatic Update、Azure Operations Management Suite (OMS)、Azure Log Analytics、Azure Configuration Management等服务或工具时，会在客户虚机上静默安装OMI。OMI 代理以 root 身份运行，具有最高权限。任何用户都可以通过 UNIX 套接字与其通信，或者在配置为允许外部访问时通过 HTTP API 与其通信。一些Azure产品，如Azure Configuration Management，会暴露一个无认证的用于与 OMI 交互的 HTTPS 端口（端口 5986），可导致RCE。

* [Azure Microsoft Dynamics Container Sandbox RCE](https://hencohen10.medium.com/microsoft-dynamics-container-sandbox-rce-via-unauthenticated-docker-remote-api-20-000-bounty-7f726340a93b)

在Azure上创建了Dynamics Sandbox后，可以访问docker remote api，可在任意容器执行任意命令


### 信息泄露

* [CVE-2025-9039](https://github.com/advisories/GHSA-wm7x-ww72-r77q)

Amazon ECS container agent暴露了一个无认证的introspection server port (51678)，可从中获取ECS中所有容器的信息

* [AWS Ecsape](https://www.sweet.security/blog/ecscape-understanding-iam-privilege-boundaries-in-amazon-ecs)

AWS ECS集群的node节点上安装了ECS Agent，会和管理面进行通信获取节点上所有任务的IAM凭据，攻击者可以通过伪造ECS Agent获取这些凭据


### 容器逃逸

* [GKE AutoPilot datadog 逃逸](https://unit42.paloaltonetworks.com/gke-autopilot-vulnerabilities/)

GKE AutoPilot禁止用户创建可能导致容器逃逸的pod配置，但它有一个白名单，唯一允许datadog代理使用一些特权功能配置，用户可以创建使用datadog镜像的pod，执行任意代码，进而逃逸

* [AWS Hotpatch Daemonset 逃逸](https://unit42.paloaltonetworks.com/aws-log4shell-hot-patch-vulnerabilities/)

为应对log4shell漏洞，AWS EKS集群推出了热修复解决方案，会在EKS中安装一个Daemonset，扫描容器中的java进程并实施热补。它使用nsenter的方式进入容器并在容器中执行java，由于nsenter没有启用user namespace，且没有应用seccomp、capability，导致攻击者可以通过伪造java获取节点root权限，并保有全部capability，从而可逃逸到node节点上

* [CVE-2022-30137：FabricScape](https://unit42.paloaltonetworks.com/fabricscape-cve-2022-30137/)

Service Fabric 是一个应用托管平台，支持不同形式的打包和管理服务，包括但不限于容器。Service Fabric 支持将应用作为容器进行部署，并且在每个容器初始化期间，都会创建一个新的日志目录并以读写权限挂载到每个容器中。所有这些目录在每个节点上的一个路径中集中存放。例如，在 Azure Service Fabric 服务中，这些目录位于`/mnt/sfroot/log/Containers`。Service Fabric 的组件之一是Data Collection Agent（DCA），会收集这些目录中的日志以供以后处理。为了访问这些目录，它需要高权限，因此在每个节点上以 root 身份运行。攻击者可以利用符号链接进行竞争条件漏洞利用，在日志文件中写入恶意内容，当DCA读取日志时，将日志文件链接到其他任意想覆盖的文件，当DCA保存内容时就会把恶意内容保存到攻击者指定的文件中

* [Azure Function sidecar逃逸](https://unit42.paloaltonetworks.com/azure-serverless-functions-security/)

可以通过环境变量查看函数容器使用的镜像，从网上获取镜像并进行逆向，发现其在启动的时候执行了`launch.sh`脚本，其中使用`init_server_pkg_mount_BindMount`把容器中的目录挂载到容器中，可以通过访问`http://localhost:6060/?operation=bind-mount&sourcePath=xxx&targetPath=xxx`来实施挂载，可覆盖`/etc/shadow`进行提权