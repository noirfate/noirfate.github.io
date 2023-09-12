---
title: ATT&CK Matrix In Chinese
layout: post
categories: redteaming
tags: redteaming
date: 2023-02-21 18:00
excerpt: ATT&CK Matrix 中英文对照表
---

{:.table-of-content}
* TOC
{:toc}

# ATT&CK Matrix 中英文对照表

## 侦察（Reconnaissance）
攻击者试图收集目标信息以用于计划将来的行动

| ID | 名称 | 描述 | Ref |
| :-- | :-- | :-- | :-- |
| T1595 | 主动扫描（Active Scanning） | 攻击者通过网络主动对目标资产进行扫描 | [链接](https://attack.mitre.org/techniques/T1595) |
| T1595.001 | 扫描IP段（Scanning IP Blocks）| 攻击者对目标所在的IP段进行扫描 | [链接](https://attack.mitre.org/techniques/T1595/001) |
| T1595.002 | 漏洞扫描（Vulnerability Scanning）| 攻击者扫描目标主机或服务所存在的漏洞 | [链接](https://attack.mitre.org/techniques/T1595/002)
| T1595.003 | 字典扫描（Wordlist Scanning）| 攻击者利用字典进行暴力破解 | [链接](https://attack.mitre.org/techniques/T1595/003) |
| T1592 | 收集受害者主机信息（Gather Victim Host Information）| 攻击者收集目标受害者主机的相关信息 | [链接](https://attack.mitre.org/techniques/T1592) |
| T1592.001 | 硬件（Hardware）| 攻击者收集目标主机的硬件信息 | [链接](https://attack.mitre.org/techniques/T1592/001) |
| T1592.002 | 软件（Software）| 攻击者收集目标主机的软件信息 | [链接](https://attack.mitre.org/techniques/T1592/002) |
| T1592.003 | 固件（Firmware）| 攻击者收集目标主机的固件信息 | [链接](https://attack.mitre.org/techniques/T1592/003) |
| T1592.004 | 客户端配置（Client Configurations）| 攻击者收集目标的客户端配置信息 | [链接](https://attack.mitre.org/techniques/T1592/004) |
| T1589 | 收集受害者身份信息（Gather Victim Identity Information） | 攻击者收集受害者的身份相关信息 | [链接](https://attack.mitre.org/techniques/T1589) |
| T1589.001 | 凭据（Credentials） | 攻击者收集受害者的凭据信息 | [链接](https://attack.mitre.org/techniques/T1589/001) |
| T1589.002 | 邮箱地址（Email Addresses）| 攻击者收集受害者的邮箱地址信息 | [链接](https://attack.mitre.org/techniques/T1589/002) |
| T1589.003 | 人员姓名（Employee Names）| 攻击者收集目标组织的雇员姓名信息 | [链接](https://attack.mitre.org/techniques/T1589/003) |
| T1590 | 收集受害者网络信息（Gather Victim Network Information）| 攻击者收集收集受害者的网络相关信息 | [链接](https://attack.mitre.org/techniques/T1590) |
| T1590.001 | 域名属性（Domain Properties）| 攻击者收集受害者的网络域名信息 | [链接](https://attack.mitre.org/techniques/T1590/001) |
| T1590.002 | 域名解析（DNS）| 攻击者收集受害者的域名解析信息 | [链接](https://attack.mitre.org/techniques/T1590/002) |
| T1590.003 | 网络信任依赖（Network Trust Dependencies）| 攻击者收集受害者的网络间信任依赖关系 | [链接](https://attack.mitre.org/techniques/T1590/003) |
| T1590.004 | 网络拓扑结构（Network Topology）| 攻击者收集受害者的网络拓扑结构 | [链接](https://attack.mitre.org/techniques/T1590/004) |
| T1590.005 | IP地址（IP Addresses）| 攻击者收集受害者的IP地址信息 | [链接](https://attack.mitre.org/techniques/T1590/005) |
| T1590.006 | 网络安全设备（Network Security Appliances）| 攻击者收集受害者的网络安全设备信息 | [链接](https://attack.mitre.org/techniques/T1590/006) |
| T1591 | 收集受害者组织信息（Gather Victim Org Information）| 攻击者收集受害者组织信息 | [链接](https://attack.mitre.org/techniques/T1591) |
| T1591.001 | 物理位置（Determine Physical Locations）| 攻击者收集受害组织的物理位置信息 | [链接](https://attack.mitre.org/techniques/T1591/001) |
| T1591.002 | 业务关系（Business Relationships）| 攻击者收集受害组织的业务关系信息 | [链接](https://attack.mitre.org/techniques/T1591/002) |
| T1591.003 | 工作时间（Identify Business Tempo）| 攻击者收集受害组织的工作时间信息 | [链接](https://attack.mitre.org/techniques/T1591/003) |
| T1591.004 | 职务角色（Identify Roles）| 攻击者收集受害者在其组织中的职务角色信息 | [链接](https://attack.mitre.org/techniques/T1591/004) |
| T1598 | 网络钓鱼（Phishing for Information）| 攻击者利用虚假消息钓出受害者的敏感信息 | [链接](https://attack.mitre.org/techniques/T1598) |
| T1598.001 | 三方服务（Spearphishing Service）| 攻击者利用第三方服务向受害者发送钓鱼信息 | [链接](https://attack.mitre.org/techniques/T1598/001) |
| T1598.002 | 恶意附件（Spearphishing Attachment）| 攻击者诱导受害者打开其发送的恶意附件来获取敏感信息 | [链接](https://attack.mitre.org/techniques/T1598/002) |
| T1598.003 | 恶意链接（Spearphishing Link）| 攻击者诱导受害者点击其发送的恶意链接来获取敏感信息 | [链接](https://attack.mitre.org/techniques/T1598/003) |
| T1597 | 搜索闭源信息（Search Closed Sources）| 攻击者搜索或购买与受害者相关的未公开数据 | [链接](https://attack.mitre.org/techniques/T1597) |
| T1597.001 | 威胁情报供应商（Threat Intel Vendors）| 攻击者从威胁情报供应商处搜索或购买与受害者相关的数据信息 | [链接](https://attack.mitre.org/techniques/T1597/001) |
| T1597.002 | 购买技术资料（Purchase Technical Data）| 攻击者从可靠的私有源或者暗网中购买与受害者相关的数据信息 | [链接](https://attack.mitre.org/techniques/T1597/002) |
| T1596 | 搜索公开技术数据库（Search Open Technical Databases）| 攻击者从公开的、免费的技术数据库中搜索与受害者相关的信息 | [链接](https://attack.mitre.org/techniques/T1596) |
| T1596.001 | DNS或被动DNS（DNS/Passive DNS）| 攻击者收集受害者的DNS数据信息 | [链接](https://attack.mitre.org/techniques/T1596/001) |
| T1596.002 | WHOIS（WHOIS）| 攻击者搜索与受害者相关的公开WHOIS数据（域名、IP段、DNS服务器等） | [链接](https://attack.mitre.org/techniques/T1596/002) |
| T1596.003 | 数字证书（Digital Certificates）| 攻击者搜索与受害者相关的数字证书 | [链接](https://attack.mitre.org/techniques/T1596/003) |
| T1596.004 | 内容分发网络（CDNs）| 攻击者搜索受害者所使用的CDN信息 | [链接](https://attack.mitre.org/techniques/T1596/004) |
| T1596.005 | 网络扫描数据库（Scan Databases）| 攻击者利用公开的网络扫描/网络测绘服务搜索受害者相关的信息 | [链接](https://attack.mitre.org/techniques/T1596/005) |
| T1593 | 搜索公开网站（Search Open Websites/Domains）| 攻击者通过搜索免费公开的网站数据来获取与受害者相关的信息 | [链接](https://attack.mitre.org/techniques/T1593) |
| T1593.001 | 社交媒体（Social Media）| 攻击者通过搜索社交媒体网站或服务来获取受害者信息 | [链接](https://attack.mitre.org/techniques/T1593/001) |
| T1593.002 | 搜索引擎（Search Engines）| 攻击者通过搜索引擎来搜索受害者信息 | [链接](https://attack.mitre.org/techniques/T1593/002) |
| T1593.003 | 代码仓库（Code Repositories）| 攻击者通过搜索公开的代码仓库来获取受害者相关的信息 | [链接](https://attack.mitre.org/techniques/T1593/003) |
| T1594 | 搜索受害者网站（Search Victim-Owned Websites）| 攻击者在受害者拥有的网站中搜索数据 | [链接](https://attack.mitre.org/techniques/T1594) |

## 资源开发（Resource Development）
攻击者准备实施行动所需的资源

| ID | 名称 | 描述 | Ref |
| :-- | :-- | :-- | :-- |
| T1583 | 基础设施获取（Acquire Infrastructure）| 攻击者通过购买、租借等方式获取用于攻击行动的基础设施资源，如DNS、云服务器等 | [链接](https://attack.mitre.org/techniques/T1583) |
| T1583.001 | 域名（Domains）| 攻击者获取用于攻击的域名 | [链接](https://attack.mitre.org/techniques/T1583/001) |
| T1583.002 | DNS服务器（DNS Server）| 攻击者搭建自己的DNS服务器用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1583/002) |
| T1583.003 | 虚拟主机（Virtual Private Server）| 攻击者购买云服务商提供的虚机或容器用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1583/003) |
| T1583.004 | 服务器（Server）| 攻击者购买物理服务器用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1583/004) |
| T1583.005 | 僵尸网络（Botnet）| 攻击者购买僵尸网络用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1583/005) |
| T1583.006 | Web服务（Web Services）| 攻击者注册web服务（如google、twitter等）用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1583/006) |
| T1583.007 | 无服务器计算（Serverless）| 攻击者购买云厂商提供的Serverless服务用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1583/007) |
| T1586 | 账户侵占（Compromise Accounts）| 攻击者通过侵占他人账户用于攻击行动，如伪装成他人在社工中获取受害者信任 | [链接](https://attack.mitre.org/techniques/T1586) |
| T1586.001 | 社交媒体账户（Social Media Accounts）| 攻击者侵占他人的社交媒体账户用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1586/001) |
| T1586.002 | 邮箱账户（Email Accounts）| 攻击者侵占他人的邮箱账户用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1586/002) |
| T1586.003 | 云账户（Cloud Accounts）| 攻击者侵占他人的云账户用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1586/003) |
| T1584 | 基础设施侵占（Compromise Infrastructure）| 攻击者侵占第三方基础设施用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1584) |
| T1584.001 | 域名（Domains）| 攻击者劫持域名或子域名用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1584/001) |
| T1584.002 | DNS服务器（DNS Server）| 攻击者劫持第三方DNS服务器用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1584/002) |
| T1584.003 | 虚拟主机（Virtual Private Server）| 攻击者攻占第三方虚拟主机用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1584/003) |
| T1584.004 | 服务器（Server）| 攻击者攻占第三方物理服务器用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1584/004) |
| T1584.005 | 僵尸网络（Botnet）| 攻击者通过侵占大量的系统来构建僵尸网络用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1584/005) |
| T1584.006 | Web服务（Web Services）| 攻击者通过攻占第三方web服务账户（如github、twitter等）用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1584/006) |
| T1584.007 | 无服务器计算（Serverless）| 攻击者通过攻占第三方Serverless服务（如AWS Lambda）用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1584/007) |
| T1587 | 能力开发（Develop Capabilities）| 攻击者构建自己的攻击技能用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1587) |
| T1587.001 | 恶意软件（Malware）| 攻击者开发恶意软件用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1587/001) |
| T1587.002 | 代码签名证书（Code Signing Certificates）| 攻击者创建自签名证书用于代码签名 | [链接](https://attack.mitre.org/techniques/T1587/002) |
| T1587.003 | 数字证书（Digital Certificates）| 攻击者创建自签名证书用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1587/003) |
| T1587.004 | 漏洞利用（Exploits）| 攻击者开发漏洞利用用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1587/004) |
| T1585 | 账户建立（Establish Accounts）| 攻击者创建并培育账户用于将来的攻击行动 | [链接](https://attack.mitre.org/techniques/T1585) |
| T1585.001 | 社交媒体账户（Social Media Accounts）| 攻击者建立社交媒体账户用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1585/001) |
| T1585.002 | 邮箱账户（Email Accounts）| 攻击者建立邮箱账户用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1585/002) |
| T1585.003 | 云账户（Cloud Accounts）| 攻击者建立云账户用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1585/003) |
| T1588 | 能力获取（Obtain Capabilities）| 攻击者通过购买或窃取攻击技能来用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1588) |
| T1588.001 | 恶意软件（Malware）| 攻击者通过购买、下载、窃取等方式获得恶意软件并用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1588/001) |
| T1588.002 | 工具（Tool）| 攻击者通过购买、下载、窃取等方式获得软件工具（如PsExec、Cobalt Strike等）并用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1588/002) |
| T1588.003 | 代码签名证书（Code Signing Certificates）| 攻击者通过购买、窃取等方式获取代码签名证书用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1588/003) |
| T1588.004 | 数字证书（Digital Certificates）| 攻击者通过购买、窃取等方式获取数字证书用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1588/004) |
| T1588.005 | 漏洞利用（Exploits）| 攻击者通过购买、下载、窃取等方式获得漏洞利用程序并用于攻击行动 | [链接](https://attack.mitre.org/techniques/T1588/005) |
| T1588.006 | 漏洞（Vulnerabilities）| 攻击者购买攻击行动所需的漏洞信息 | [链接](https://attack.mitre.org/techniques/T1588/006) |
| T1608 | 部署能力（Stage Capabilities）| 攻击者把自己开发或获取的技能工具部署到自己可控的基础设施或公开服务（github、pastbin等）上以便在行动中访问这些工具 | [链接](https://attack.mitre.org/techniques/T1608) |
| T1608.001 | 上传恶意软件（Upload Malware）| 攻击者把恶意软件上传到第三方或自己可控的基础设施上以便在行动中访问 | [链接](https://attack.mitre.org/techniques/T1608/001) |
| T1608.002 | 上传工具（Upload Tool）| 攻击者把工具软件上传到第三方或自己可控的基础设施上以便在行动中访问 | [链接](https://attack.mitre.org/techniques/T1608/002) |
| T1608.003 | 安装数字证书（Install Digital Certificate）| 攻击者在自己可控的服务器上安装数字证书 | [链接](https://attack.mitre.org/techniques/T1608/003) |
| T1608.004 | 搭建恶意网站（Drive-by Target）| 攻击者通过搭建恶意网站使得受害者在访问该站点时被攻击 | [链接](https://attack.mitre.org/techniques/T1608/004) |
| T1608.005 | 部署恶意链接（Link Target）| 攻击者通过在网站上部署恶意链接使得受害者在点击之后跳转到恶意页面（如钓鱼页面）| [链接](https://attack.mitre.org/techniques/T1608/005) |
| T1608.006 | SEO投毒（SEO Poisoning）| 攻击者利用SEO投毒技术污染搜索引擎的返回结果，从而诱导受害者点击恶意链接 | [链接](https://attack.mitre.org/techniques/T1608/006) |


## 初始访问（Initial Access）
攻击者利用各种技术手段获取受害者网络中的一个初始据点

| ID | 名称 | 描述 | Ref |
| :-- | :-- | :-- | :-- |
| T1189 | 利用恶意网站（Drive-by Compromise）| 攻击者通过浏览器漏洞或篡改网站使得受害者在浏览网页时被攻陷 | [链接](https://attack.mitre.org/techniques/T1189) |
| T1190 | 利用面向公网的应用（Exploit Public-Facing Application）| 攻击者利用受害者暴露在公网上的应用程序漏洞来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1190) |
| T1133 | 外部远程服务（External Remote Services）| 攻击者利用外部远程服务（VPN、RDP等）访问受害者系统 | [链接](https://attack.mitre.org/techniques/T1133) |
| T1200 | 接入硬件设备（Hardware Additions）| 攻击者通过向受害者电脑插入硬件设备（网络设备、存储设备等）来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1200) |
| T1566 | 网络钓鱼（Phishing）| 攻击者通过向受害者发送钓鱼信息获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1566) |
| T1566.001 | 恶意附件（Spearphishing Attachment） | 攻击者通过向受害者发送恶意的邮件附件来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1566/001) |
| T1566.002 | 恶意链接（Spearphishing Link）| 攻击者通过向受害者发送恶意网络链接来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1566/002) |
| T1566.003 | 三方服务（Spearphishing via Service）| 攻击者利用第三方服务向受害者发送钓鱼信息来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1566/003) |
| T1091 | 利用可移动媒体传播（Replication Through Removable Media）| 攻击者把恶意程序存储在可移动媒体中，并利用可移动媒体在插入时的自动运行功能来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1091) |
| T1195 | 供应链污染（Supply Chain Compromise）| 攻击者通过篡改受害者产品或服务的上游依赖来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1195) |
| T1195.001 | 污染开发工具和软件依赖包（Compromise Software Dependencies and Development Tools）| 攻击者通过污染受害者应用的软件依赖包（如python、node的模块包）来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1195/001) |
| T1195.002 | 污染软件供应链（Compromise Software Supply Chain）| 攻击者通过污染受害者所使用或依赖的软件来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1195/002) |
| T1195.003 | 污染硬件供应链（Compromise Hardware Supply Chain）| 攻击者通过污染受害者所使用或依赖的硬件或固件来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1195/003) |
| T1199 | 信任关系（Trusted Relationship）| 攻击者通过攻陷受害者信任的组织或系统，进而获取受害者系统的访问权 | [链接](https://attack.mitre.org/techniques/T1199) |
| T1078 | 有效账户（Valid Accounts）| 攻击者通过利用受害者系统中的有效账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078) |
| T1078.001 | 默认账户（Default Accounts）| 攻击者通过利用受害者系统中存在的默认账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078/001) |
| T1078.002 | 域账户（Domain Accounts）| 攻击者利用域账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078/002) |
| T1078.003 | 本地账户（Local Accounts）| 攻击者利用受害者主机上的账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078/003) |
| T1078.004 | 云账户（Cloud Accounts）| 攻击者利用受害者的云账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078/004) |


## 执行（Execution）
攻击者在受害者系统中执行恶意代码或程序

| ID | 名称 | 描述 | Ref |
| :-- | :-- | :-- | :-- |
| T1059 | 命令和脚本解释器（Command and Scripting Interpreter）| 攻击者利用二进制可执行程序或脚本来执行命令 | [链接](https://attack.mitre.org/techniques/T1059) |
| T1059.001 | PowerShell（PowerShell）| 攻击者利用PowerShell命令或脚本来执行命令 | [链接](https://attack.mitre.org/techniques/T1059/001) |
| T1059.002 | AppleScript（AppleScript）| 攻击者利用AppleScript来执行命令 | [链接](https://attack.mitre.org/techniques/T1059/002) |
| T1059.003 | WindowsCMD（Windows Command Shell）| 攻击者利用windows系统中的cmd执行命令 | [链接](https://attack.mitre.org/techniques/T1059/003) |
| T1059.004 | UnixShell（Unix Shell）| 攻击者利用类unix系统中的shell执行命令 | [链接](https://attack.mitre.org/techniques/T1059/004) |
| T1059.005 | VisualBasic（Visual Basic）| 攻击者利用VB脚本执行命令 | [链接](https://attack.mitre.org/techniques/T1059/005) |
| T1059.006 | Python（Python）| 攻击者利用python脚本执行命令 | [链接](https://attack.mitre.org/techniques/T1059/006) |
| T1059.007 | JavaScript（JavaScript）| 攻击者利用JS脚本执行命令 | [链接](https://attack.mitre.org/techniques/T1059/007) |
| T1059.008 | 网络设备CLI（Network Device CLI）| 攻击者利用网络设备命令行接口执行命令 | [链接](https://attack.mitre.org/techniques/T1059/008) |
| T1609 | 容器管理命令（Container Administration Command）| 攻击者利用容器管理命令（如docker、kubectl等）执行命令 | [链接](https://attack.mitre.org/techniques/T1609) |
| T1610 | 部署容器（Deploy Container）| 攻击者通过在目标环境部署容器来执行命令 | [链接](https://attack.mitre.org/techniques/T1610) |
| T1203 | 利用客户端软件漏洞（Exploitation for Client Execution）| 攻击者利用客户端软件漏洞执行命令 | [链接](https://attack.mitre.org/techniques/T1203) |
| T1559 | 进程间通信（Inter-Process Communication）| 攻击者利用进程间通信机制（IPC）来执行命令 | [链接](https://attack.mitre.org/techniques/T1559) |
| T1559.001 | COM（Component Object Model）| 攻击者利用windows系统的COM接口执行命令 | [链接](https://attack.mitre.org/techniques/T1559/001) |
| T1559.002 | DDE（Dynamic Data Exchange）| 攻击者利用windows的DDE技术执行命令 | [链接](https://attack.mitre.org/techniques/T1559/002) |
| T1559.003 | XPC（XPC Services）| 攻击者利用Mac系统中的XPC服务执行命令 | [链接](https://attack.mitre.org/techniques/T1559/003) |
| T1106 | 原生API（Native API）| 攻击者利用系统底层API执行命令 | [链接](https://attack.mitre.org/techniques/T1106) |
| T1053 | 定时任务（Scheduled Task/Job）| 攻击者利用系统中的定时任务来执行命令 | [链接](https://attack.mitre.org/techniques/T1053) |
| T1053.002 | At（At）| 攻击者利用at定时任务执行命令 | [链接](https://attack.mitre.org/techniques/T1053/002) |
| T1053.003 | Cron（Cron）| 攻击者利用cron定时任务执行命令 | [链接](https://attack.mitre.org/techniques/T1053/003) |
| T1053.005 | Windows定时任务（Scheduled Task）| 攻击者利用windows task scheduler定时任务执行命令 | [链接](https://attack.mitre.org/techniques/T1053/005) |
| T1053.006 | Systemd计时器（Systemd Timers）| 攻击者利用systemd提供的timers执行命令（可用systemctl进行管理）| [链接](https://attack.mitre.org/techniques/T1053/006) |
| T1053.007 | 容器定时任务（Container Orchestration Job）| 攻击者利用容器定时任务（docker的HEALTHCHECK、k8s的livenessProbe和CronJob等）执行命令 | [链接](https://attack.mitre.org/techniques/T1053/007) |
| T1648 | 无服务计算（Serverless Execution）| 攻击者利用云厂商的无服务计算功能执行命令 | [链接](https://attack.mitre.org/techniques/T1648) |
| T1129 | 动态库（Shared Modules）| 攻击者利用恶意的动态库执行命令 | [链接](https://attack.mitre.org/techniques/T1129) |
| T1072 | 软件部署工具（Software Deployment Tools）| 攻击者利用企业网络中的软件部署工具（如：SCCM、 HBSS、Altiris等）来执行命令 | [链接](https://attack.mitre.org/techniques/T1072) |
| T1569 | 系统服务（System Services）| 攻击者利用系统服务执行命令 | [链接](https://attack.mitre.org/techniques/T1569) |
| T1569.001 | Launchctl（Launchctl）| 攻击者利用Mac系统中的Launchctl执行命令 | [链接](https://attack.mitre.org/techniques/T1569/001) |
| T1569.002 | SCM（Service Execution）| 攻击者利用Windows service control manage来执行命令 | [链接](https://attack.mitre.org/techniques/T1569/002) |
| T1204 | 用户执行（User Execution）| 攻击者诱导用户去执行恶意命令 | [链接](https://attack.mitre.org/techniques/T1204) |
| T1204.001 | 恶意链接（Malicious Link）| 攻击者诱导用户点击恶意链接来执行命令 | [链接](https://attack.mitre.org/techniques/T1204/001) |
| T1204.002 | 恶意文件（Malicious File）| 攻击者诱导用户打开恶意文件来执行命令 | [链接](https://attack.mitre.org/techniques/T1204/002) |
| T1204.003 | 恶意镜像（Malicious Image）| 攻击者诱导用户运行恶意镜像（云环境中的恶意容器镜像）来执行命令 | [链接](https://attack.mitre.org/techniques/T1204/003) |
| T1047 | WMI（Windows Management Instrumentation）| 攻击者利用windows的WMI接口执行命令 | [链接](https://attack.mitre.org/techniques/T1047) |

## 持久化（Persistence）
攻击者试图维持在受害者系统中建立的据点

| ID | 名称 | 描述 | Ref |
| :-- | :-- | :-- | :-- |
| T1098 | 账户操作（Account Manipulation）| 攻击者通过添加、修改账户等操作来维持权限 | [链接](https://attack.mitre.org/techniques/T1098) |
| T1098.001 | 添加云账户凭据（Additional Cloud Credentials）| 攻击者通过添加云账户凭据（如AKSK、Token等）来维持权限 | [链接](https://attack.mitre.org/techniques/T1098/001) |
| T1098.002 | 添加邮件委托权限（Additional Email Delegate Permissions）| 攻击者通过添加邮件委托权限来维持权限 | [链接](https://attack.mitre.org/techniques/T1098/002) |
| T1098.003 | 添加IAM规则（Additional Cloud Roles）| 攻击者通过添加或修改云账户的IAM角色规则来维持权限 | [链接](https://attack.mitre.org/techniques/T1098/003) |
| T1098.004 | SSH授权密钥（SSH Authorized Keys）| 攻击者通过添加SSH授权密钥来维持权限 | [链接](https://attack.mitre.org/techniques/T1098/004) |
| T1098.005 | 注册设备（Device Registration）| 攻击者通过在多因子认证（MFA）系统中注册认证设备来维持权限 | [链接](https://attack.mitre.org/techniques/T1098/005) |
| T1197 | BITS任务（BITS Jobs）| 攻击者可以利用windows的BITS任务持续在后台执行命令 | [链接](https://attack.mitre.org/techniques/T1197) |
| T1547 | 开机或登录启动程序（Boot or Logon Autostart Execution）| 攻击者配置系统启动或登录时自动执行的命令实施攻击 | [链接](https://attack.mitre.org/techniques/T1547) |
| T1547.001 | 注册表（Registry Run Keys / Startup Folder）| 攻击者通过修改注册表配置系统启动命令 | [链接](https://attack.mitre.org/techniques/T1547/001) |
| T1547.002 | 认证扩展库（Authentication Package）| 攻击者可以在windows系统中配置认证扩展DLL，让LSA服务在系统启动时加载 | [链接](https://attack.mitre.org/techniques/T1547/002) |
| T1547.003 | 时间提供程序（Time Providers）| 攻击者在windows系统中配置时间提供商的DLL，在系统启动时加载 | [链接](https://attack.mitre.org/techniques/T1547/003) |
| T1547.004 | 登录助手（Winlogon Helper DLL）| 攻击者可以在注册表中配置用户登录后，Winlogon自动执行的程序或DLL | [链接](https://attack.mitre.org/techniques/T1547/004) |
| T1547.005 | 安全支持提供程序（Security Support Provider）| 攻击者可以配置SSPs动态库，使得LSA服务在系统启动时加载 | [链接](https://attack.mitre.org/techniques/T1547/005) |
| T1547.006 | 内核模块和扩展（Kernel Modules and Extensions）| 攻击者利用内核模块来维持权限 | [链接](https://attack.mitre.org/techniques/T1547/006) |
| T1547.007 | plist启动脚本（Re-opened Applications）| 攻击者利用Mac系统中的plist脚本设置开机启动程序 | [链接](https://attack.mitre.org/techniques/T1547/007) |
| T1547.008 | LSASS驱动（LSASS Driver）| 攻击者可以添加或修改windows系统的LSASS驱动让lsass进程加载恶意DLL维持权限 | [链接](https://attack.mitre.org/techniques/T1547/008) |
| T1547.009 | 修改快捷方式（Shortcut Modification）| 攻击者通过修改快捷方式或符号链接来维持权限 | [链接](https://attack.mitre.org/techniques/T1547/009) |
| T1547.010 | 端口监视器（Port Monitors）| 攻击者通过在windows系统中调用AddMonitor创建端口监视器加载恶意DLL | [链接](https://attack.mitre.org/techniques/T1547/010) |
| T1547.012 | 打印处理器（Print Processors）| 攻击者利用打印处理器使得windows的spoolsv服务加载恶意DLL | [链接](https://attack.mitre.org/techniques/T1547/012) |
| T1547.013 | XDG启动项（XDG Autostart Entries）| 攻击者利用linux系统X桌面的启动项执行命令 | [链接](https://attack.mitre.org/techniques/T1547/013) |
| T1547.014 | 活动设置（Active Setup）| 攻击者在注册表中配置用户登录命令在登录时执行 | [链接](https://attack.mitre.org/techniques/T1547/014) |
| T1547.015 | 登录命令（Login Items）| 攻击者通过在Mac系统中设置登录命令在用户登录时执行 | [链接](https://attack.mitre.org/techniques/T1547/015) |
| T1037 | 启动或登录初始化脚本（Boot or Logon Initialization Scripts）| 攻击者利用系统启动或登录时自动运行的初始化脚本进行权限维持 | [链接](https://attack.mitre.org/techniques/T1037) |
| T1037.001 | Windows登录脚本（Logon Script Windows）| 攻击者通过配置注册表项UserInitMprLogonScript在用户登录时执行命令 | [链接](https://attack.mitre.org/techniques/T1037/001) |
| T1037.002 | 登录钩子（Login Hook）| 攻击者通过配置Mac系统中的com.apple.loginwindow.plist文件设置登录钩子 | [链接](https://attack.mitre.org/techniques/T1037/002) |
| T1037.003 | 网络登录脚本（Network Logon Script）| 攻击者利用网络登录脚本（如活动目录或组策略）自动执行命令 | [链接](https://attack.mitre.org/techniques/T1037/003) |
| T1037.004 | RC脚本（RC Scripts）| 攻击者通过修改linux系统中的RC启动脚本来执行命令 | [链接](https://attack.mitre.org/techniques/T1037/004) |
| T1037.005 | 系统启动项（Startup Items）| 攻击者通过配置系统启动项来执行命令 | [链接](https://attack.mitre.org/techniques/T1037/005) |
| T1176 | 浏览器扩展（Browser Extensions）| 攻击者利用浏览器扩展插件维持对受害者系统的访问权 | [链接](https://attack.mitre.org/techniques/T1176) |
| T1554 | 污染客户端软件（Compromise Client Software Binary）| 攻击者通过篡改受害者使用的客户端软件的可执行程序来维持权限 | [链接](https://attack.mitre.org/techniques/T1554) |
| T1136 | 创建账户（Create Account）| 攻击者通过在受害者系统中创建账户来维持权限 | [链接](https://attack.mitre.org/techniques/T1136) |
| T1136.001 | 本地账户（Local Account）| 攻击者通过在受害者系统中创建本地账户来维持权限 | [链接](https://attack.mitre.org/techniques/T1136/001) |
| T1136.002 | 域账户（Domain Account）| 攻击者通过创建域账户来维持权限 | [链接](https://attack.mitre.org/techniques/T1136/002) |
| T1136.003 | 云账户（Cloud Account）| 攻击者通过创建云账户来维持权限 | [链接](https://attack.mitre.org/techniques/T1136/003) |
| T1543 | 创建或修改系统进程（Create or Modify System Process）| 攻击者利用系统进程执行恶意代码来维持权限 | [链接](https://attack.mitre.org/techniques/T1543) |
| T1543.001 | Launchd代理（Launch Agent）| 攻击者利用Mac系统中的LaunchAgents执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1543/001) |
| T1543.002 | Systemd服务（Systemd Service）| 攻击者利用linux系统中的systemd service来执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1543/002) |
| T1543.003 | Windows服务（Windows Service）| 攻击者利用windows service执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1543/003) |
| T1543.004 | Launchd后台（Launch Daemon）| 攻击者利用mac系统中的LaunchDaemons执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1543/004) |
| T1546 | 事件触发执行（Event Triggered Execution）| 攻击者利用系统提供的机制，在特定事件触发时执行恶意程序 | [链接](https://attack.mitre.org/techniques/T1546) |
| T1546.001 | 修改默认文件关联（Change Default File Association）| 攻击者通过修改特定文件类型的默认关联程序，使得用户在打开该类型文件时执行攻击者指定的程序 | [链接](https://attack.mitre.org/techniques/T1546/001) |
| T1546.002 | 屏保程序（Screensaver）| 攻击者通过修改windows系统的屏保程序执行命令 | [链接](https://attack.mitre.org/techniques/T1546/002) |
| T1546.003 | WMI事件订阅（Windows Management Instrumentation Event Subscription）| 攻击者通过WMI事件订阅执行命令 | [链接](https://attack.mitre.org/techniques/T1546/003) |
| T1546.004 | 修改shell配置 | 攻击者通过修改类unix系统中的shell配置脚本（如：~/.bashrc、/etc/profile等）执行命令 | [链接](https://attack.mitre.org/techniques/T1546/004) |
| T1546.005 | 信号处理程序（Trap）| 攻击者通过修改特定信号的处理程序来执行命令 | [链接](https://attack.mitre.org/techniques/T1546/005) |
| T1546.006 | 修改LC_LOAD_DYLIB头（LC_LOAD_DYLIB Addition）| 攻击者通过修改Mach-O二进制程序中的LC_LOAD_DYLIB头来添加程序执行时加载的动态库 | [链接](https://attack.mitre.org/techniques/T1546/006) |
| T1546.007 | Netsh助手库（Netsh Helper DLL）| 攻击者通过添加netsh helper dll来加载恶意动态库 | [链接](https://attack.mitre.org/techniques/T1546/007) |
| T1546.008 | 系统辅助功能（Accessibility Features）| 攻击者通过修改系统辅助功能程序（如粘滞键辅助程序sethc.exe）执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1546/008) |
| T1546.009 | AppCert动态库（AppCert DLLs）| 攻击者通过修改注册表中的AppCertDLLs键值使得程序在启动时加载恶意DLL | [链接](https://attack.mitre.org/techniques/T1546/009) |
| T1546.010 | AppInit动态库（AppInit DLLs）| 攻击者通过修改注册表中的AppInit_DLLs键值使得程序在启动时加载恶意DLL | [链接](https://attack.mitre.org/techniques/T1546/010) |
| T1546.011 | 应用程序夹层（Application Shimming）| 攻击者利用windows程序兼容性框架中的应用夹层功能对程序行为进行修改 | [链接](https://attack.mitre.org/techniques/T1546/011) |
| T1546.012 | IFEO镜像劫持（Image File Execution Options Injection）| 攻击者利用注册表中的Image File Execution Options项指定启动特定程序时需要加载的Debugger程序，该Debugger程序可以是任意程序，故攻击者可以在启动指定进程时执行任意程序 | [链接](https://attack.mitre.org/techniques/T1546/012) |
| T1546.013 | PowerShell配置文件 | 攻击者通过修改profile.ps1执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1546/013) |
| T1546.014 | Emond（Emond）| 攻击者通过修改或添加事件监控规则（/etc/emond.d/rules）来执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1546/014) |
| T1546.015 | COM劫持（Component Object Model Hijacking）| 攻击者通过修改注册表对COM对象进行劫持以执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1546/015) |
| T1546.016 | 安装包（Installer Packages）| 攻击者利用安装包中的脚本（如：deb包中的preinst、postinst，msi包中的Prebuild、Postbuild等）执行命令 | [链接](https://attack.mitre.org/techniques/T1546/016) |
| T1574 | 劫持执行流（Hijack Execution Flow）| 攻击者通过劫持进程的执行流来执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1574) |
| T1574.001 | DLL搜索顺序劫持（DLL Search Order Hijacking）| 攻击者利用程序搜索动态库路径的先后顺序，在优先搜索的路径中添加程序需要加载的动态库进行劫持 | [链接](https://attack.mitre.org/techniques/T1574/001) |
| T1574.002 | DLL侧加载（DLL Side-Loading）| 攻击者通过直接替换合法程序或白名单程序运行所需的DLL库来执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1574/002) |
| T1574.004 | Dylib劫持（Dylib Hijacking）| 攻击者利用程序搜索动态库路径的先后顺序，在优先搜索的路径中添加程序需要加载的动态库进行劫持 | [链接](https://attack.mitre.org/techniques/T1574/004) |
| T1574.005 | 安装辅助程序权限设置缺陷（Executable Installer File Permissions Weakness）| 安装程序通常会执行其他的辅助程序来完成特定的功能，当这些助手程序的权限设置存在问题时，攻击者可以通过替换它们来执行命令 | [链接](https://attack.mitre.org/techniques/T1574/005) |
| T1574.006 | 链接器劫持（Dynamic Linker Hijacking）| 通过修改链接器配置（如LD_PRELOAD、DYLD_INSERT_LIBRARIES等）来加载恶意动态库 | [链接](https://attack.mitre.org/techniques/T1574/006) |
| T1574.007 | 利用Path环境变量进行路径拦截（Path Interception by PATH Environment Variable）| 攻击者通过修改Path环境变量，使得在执行时系统首先搜索攻击者指定的路径，从而拦截正常的命令执行 | [链接](https://attack.mitre.org/techniques/T1574/007) |
| T1574.008 | 利用搜索顺序进行路径拦截（Path Interception by Search Order Hijacking）| 若程序调用其他程序时未指定绝对路径，则可通过在其搜索路径中添加指定的恶意程序来进行劫持执行 | [链接](https://attack.mitre.org/techniques/T1574/008) |
| T1574.009 | 劫持未用引号包裹的路径（Path Interception by Unquoted Path）| 若路径包含空格且未用引号包裹，windows则不会把其当作一个完整路径，攻击者可以把第一个空格改为exe进行劫持 | [链接](https://attack.mitre.org/techniques/T1574/009) |
| T1574.010 | 系统服务文件权限缺陷（Services File Permissions Weakness）| 若系统服务相关的可执行程序的权限配置存在缺陷，攻击者可以通过替换这些文件执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1574/010) |
| T1574.011 | 系统服务注册表权限缺陷（Services Registry Permissions Weakness）| 若系统服务相关的注册表项的权限配置存在缺陷，攻击者可以通过修改相关的注册表项来执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1574/011) |
| T1574.012 | COR_PROFILER劫持（COR_PROFILER）| 攻击者可以通过COR_PROFILER环境变量对使用.net CLR的程序进行劫持 | [链接](https://attack.mitre.org/techniques/T1574/012) |
| T1574.013 | KernelCallbackTable劫持（KernelCallbackTable）| 攻击者通过修改PE文件中的KernelCallbackTable的函数指针，使其指向恶意代码来劫持执行 | [链接](https://attack.mitre.org/techniques/T1574/013) |
| T1525 | 镜像植入（Implant Internal Image）| 攻击者通过在受害者云镜像仓库或私有镜像仓库中植入恶意镜像来进行持久化 | [链接](https://attack.mitre.org/techniques/T1525) |
| T1556 | 修改认证程序（Modify Authentication Process）| 攻击者通过修改认证程序或认证程序插件（如：LSASS、SAM、PAM等）来使自己通过认证登入系统 | [链接](https://attack.mitre.org/techniques/T1556) |
| T1556.001 | 域控认证程序（Domain Controller Authentication）| 攻击者通过修改域控认证程序（LSASS）来绕过认证 | [链接](https://attack.mitre.org/techniques/T1556/001) |
| T1556.002 | 密码筛选器（Password Filter DLL）| 攻击者通过在windows系统的LSA中注册密码筛选DLL来获取明文密码 | [链接](https://attack.mitre.org/techniques/T1556/002) |
| T1556.003 | 认证插件（Pluggable Authentication Modules）| 攻击者通过修改linux系统中的PAM组件来绕过认证或窃取密码 | [链接](https://attack.mitre.org/techniques/T1556/003) |
| T1556.004 | 网络设备认证（Network Device Authentication）| 攻击者通过修改网络设备固件来绕过认证 | [链接](https://attack.mitre.org/techniques/T1556/004) |
| T1556.005 | 可逆加密（Reversible Encryption）| 攻击者通过启用活动目录认证加密属性项AllowReversiblePasswordEncryption，则可通过密码密文解密出明文 | [链接](https://attack.mitre.org/techniques/T1556/005) |
| T1556.006 | 多因子认证（Multi-Factor Authentication）| 攻击者禁用受害者账户的多因子认证策略 | [链接](https://attack.mitre.org/techniques/T1556/006) |
| T1556.007 | 混合身份标识（Hybrid Identity）| 攻击者利用云上云下同步用户身份的功能，通过攻占云下的主机并篡改用于与云上认证协同的进程，实现对云账户的控制 | [链接](https://attack.mitre.org/techniques/T1556/007) |
| T1137 | Office启动程序（Office Application Startup）| 攻击者利用各种Office启动时执行命令的机制来执行代码 | [链接](https://attack.mitre.org/techniques/T1137) |
| T1137.001 | Office宏（Office Template Macros）| 攻击者利用Office提供的VBA宏脚本来执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1137/001) |
| T1137.002 | Office测试（Office Test）| 攻击者利用Office Test注册表项加载任意DLL | [链接](https://attack.mitre.org/techniques/T1137/002) |
| T1137.003 | Outlook表单（Outlook Forms）| 攻击者在受害者的Outlook中注入恶意表单来执行代码，当受害者收到攻击者的邮件时触发命令执行 | [链接](https://attack.mitre.org/techniques/T1137/003/) |
| T1137.004 | Outlook主页（Outlook Home Page）| 攻击者利用Outlook主页配置URL的功能，让URL指向恶意的html页面，当受害者打开指定的邮件文件夹时触发执行 | [链接](https://attack.mitre.org/techniques/T1137/004/) |
| T1137.005 | Outlook规则（Outlook Rules）| 攻击者通过在受害者的Outlook中注入恶意的邮件过滤规则来执行代码 | [链接](https://attack.mitre.org/techniques/T1137/005/) |
| T1137.006 | 加载项（Add-ins）| 攻击者通过Office加载项（如：WLL、XLL、COM、VBE等）来执行命令 | [链接](https://attack.mitre.org/techniques/T1137/006) |
| T1542 | 操作系统引导（Pre-OS Boot）| 攻击者在操作系统启动前的引导阶段植入恶意代码 | [链接](https://attack.mitre.org/techniques/T1542) |
| T1542.001 | 系统固件（System Firmware）| 攻击者在系统固件（BIOS、EFI、UEFI等）中植入恶意代码 | [链接](https://attack.mitre.org/techniques/T1542/001) |
| T1542.002 | 组件固件（Component Firmware）| 攻击者在计算机其他组件的固件中植入恶意代码，使其可以在BIOS、操作系统之外运行（如方程式组织能够在某些硬盘厂商的硬盘固件中植入恶意代码）| [链接](https://attack.mitre.org/techniques/T1542/002/) |
| T1542.003 | BootKit（BootKit）| 攻击者在引导套件中（如主引导记录MBR或卷引导记录VBR）中植入恶意代码 | [链接](https://attack.mitre.org/techniques/T1542/003/) |
| T1542.004 | ROMMONkit（ROMMONkit）| 攻击者在Cisco的ROMMONkit中植入恶意代码 | [链接](https://attack.mitre.org/techniques/T1542/004/) |
| T1542.005 | TFTP引导（TFTP Boot）| 攻击者通过网络引导的功能，利用tftp下载并启动恶意固件 | [链接](https://attack.mitre.org/techniques/T1542/005/) |
| T1053 | 定时任务（Scheduled Task/Job）| 攻击者利用系统中的定时任务来执行命令 | [链接](https://attack.mitre.org/techniques/T1053) |
| T1053.002 | At（At）| 攻击者利用at定时任务执行命令 | [链接](https://attack.mitre.org/techniques/T1053/002) |
| T1053.003 | Cron（Cron）| 攻击者利用cron定时任务执行命令 | [链接](https://attack.mitre.org/techniques/T1053/003) |
| T1053.005 | Windows定时任务（Scheduled Task）| 攻击者利用windows task scheduler定时任务执行命令 | [链接](https://attack.mitre.org/techniques/T1053/005) |
| T1053.006 | Systemd计时器（Systemd Timers）| 攻击者利用systemd提供的timers执行命令（可用systemctl进行管理）| [链接](https://attack.mitre.org/techniques/T1053/006) |
| T1053.007 | 容器定时任务（Container Orchestration Job）| 攻击者利用容器定时任务（docker的HEALTHCHECK、k8s的livenessProbe和CronJob等）执行命令 | [链接](https://attack.mitre.org/techniques/T1053/007) |
| T1505 | 服务器软件组件（Server Software Component）| 攻击者利用服务器上运行的软件执行命令维持权限 | [链接](https://attack.mitre.org/techniques/T1505) |
| T1505.001 | SQL存储过程（SQL Stored Procedures）| 攻击者利用SQL存储过程在受害者数据库中储存SQL语句（如xp_cmdshell）以维持执行命令的权限 | [链接](https://attack.mitre.org/techniques/T1505/001/) |
| T1505.002 | 传输代理（Transport Agent）| 攻击者利用Microsoft Exchange的传输代理功能，使受害者在收到邮件时执行攻击者指定的恶意代码 | [链接](https://attack.mitre.org/techniques/T1505/002) |
| T1505.003 | WebShell（Web Shell）| 攻击者在受害者的web服务器上放置恶意脚本文件，当攻击者访问时得到受害者系统的终端 | [链接](https://attack.mitre.org/techniques/T1505/003) |
| T1505.004 | IIS组件（IIS Components）| 攻击者通过安装IIS组件（如ISAPI扩展）来执行命令 | [链接](https://attack.mitre.org/techniques/T1505/004) |
| T1505.005 | 终端服务DLL（Terminal Services DLL）| 攻击者通过修改TermService注册表项下面的ServiceDll来加载恶意DLL | [链接](https://attack.mitre.org/techniques/T1505/005/) |
| T1205 | 流量信号（Traffic Signaling）| 攻击者利用特殊的网络报文在被控的受害者机器上执行指定命令 | [链接](https://attack.mitre.org/techniques/T1205) |
| T1205.001 | 端口敲门（Port Knocking）| 攻击者通过向被控的受害者机器上处于关闭状态的端口发送特定报文来触发攻击行为 | [链接](https://attack.mitre.org/techniques/T1205/001) |
| T1205.002 | 包过滤（Socket Filters）| 攻击者在受害者机器上植入包过滤处理函数，在受害者接收到特定报文时执行攻击 | [链接](https://attack.mitre.org/techniques/T1205/002) |
| T1078 | 有效账户（Valid Accounts）| 攻击者通过利用受害者系统中的有效账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078) |
| T1078.001 | 默认账户（Default Accounts）| 攻击者通过利用受害者系统中存在的默认账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078/001) |
| T1078.002 | 域账户（Domain Accounts）| 攻击者利用域账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078/002) |
| T1078.003 | 本地账户（Local Accounts）| 攻击者利用受害者主机上的账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078/003) |
| T1078.004 | 云账户（Cloud Accounts）| 攻击者利用受害者的云账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078/004) |

## 权限提升（Privilege Escalation）
攻击者试图得到更高的权限

| ID | 名称 | 描述 | Ref |
| :-- | :-- | :-- | :-- |
| T1548 | 滥用提权机制（Abuse Elevation Control Mechanism）| 攻击者通过滥用系统提供的权限控制机制来进行提取 | [链接](https://attack.mitre.org/techniques/T1548) |
| T1548.001 | Setuid和Setgid（Setuid and Setgid）| 攻击者利用linux和mac系统上的setuid和setgid程序提取 | [链接](https://attack.mitre.org/techniques/T1548/001) |
| T1548.002 | 绕过UAC（Bypass User Account Control）| 攻击者通过绕过windows的UAC机制提权 | [链接](https://attack.mitre.org/techniques/T1548/002) |
| T1548.003 | sudo和sudo缓存（Sudo and Sudo Caching）| 攻击者利用sudo缓存或者sudoers配置提权 | [链接](https://attack.mitre.org/techniques/T1548/003) |
| T1548.004 | 提示用户输入凭据（Elevated Execution with Prompt）| 攻击者通过提示框让用户自己输入凭证并以其权限执行（如：调用AuthorizationExecuteWithPrivileges）| [链接](https://attack.mitre.org/techniques/T1548/004) |
| T1134 | 访问令牌操作（Access Token Manipulation）| 攻击者通过操作进程的用户访问令牌进行提权 | [链接](https://attack.mitre.org/techniques/T1134) |
| T1134.001 | 令牌仿冒或窃取（Token Impersonation/Theft）| 攻击者通过仿冒其他用户的令牌进行提取（调用ImpersonateLoggedOnUser）| [链接](https://attack.mitre.org/techniques/T1134/001) |
| T1134.002 | 使用令牌创建进程（Create Process with Token）| 攻击者使用其他用户的令牌创建进程（调用CreateProcessWithTokenW）| [链接](https://attack.mitre.org/techniques/T1134/002) |
| T1134.003 | 创建仿冒令牌（Make and Impersonate Token）| 当攻击者拥有用户名和密码但没登进系统时，可调用LogonUser创建会话并获得令牌 | [链接](https://attack.mitre.org/techniques/T1134/003/) |
| T1134.004 | 伪造父进程（Parent PID Spoofing）| 攻击者通过伪造父进程绕过监控 | [链接](https://attack.mitre.org/techniques/T1134/004) |
| T1134.005 | SID-History注入（SID-History Injection）| 攻击者通过修改SID-History以其他账户身份执行命令 | [链接](https://attack.mitre.org/techniques/T1134/005) |
| T1547 | 开机或登录启动程序（Boot or Logon Autostart Execution）| 攻击者配置系统启动或登录时自动执行的命令实施攻击 | [链接](https://attack.mitre.org/techniques/T1547) |
| T1547.001 | 注册表（Registry Run Keys / Startup Folder）| 攻击者通过修改注册表配置系统启动命令 | [链接](https://attack.mitre.org/techniques/T1547/001) |
| T1547.002 | 认证扩展库（Authentication Package）| 攻击者可以在windows系统中配置认证扩展DLL，让LSA服务在系统启动时加载 | [链接](https://attack.mitre.org/techniques/T1547/002) |
| T1547.003 | 时间提供程序（Time Providers）| 攻击者在windows系统中配置时间提供商的DLL，在系统启动时加载 | [链接](https://attack.mitre.org/techniques/T1547/003) |
| T1547.004 | 登录助手（Winlogon Helper DLL）| 攻击者可以在注册表中配置用户登录后，Winlogon自动执行的程序或DLL | [链接](https://attack.mitre.org/techniques/T1547/004) |
| T1547.005 | 安全支持提供程序（Security Support Provider）| 攻击者可以配置SSPs动态库，使得LSA服务在系统启动时加载 | [链接](https://attack.mitre.org/techniques/T1547/005) |
| T1547.006 | 内核模块和扩展（Kernel Modules and Extensions）| 攻击者利用内核模块来维持权限 | [链接](https://attack.mitre.org/techniques/T1547/006) |
| T1547.007 | plist启动脚本（Re-opened Applications）| 攻击者利用Mac系统中的plist脚本设置开机启动程序 | [链接](https://attack.mitre.org/techniques/T1547/007) |
| T1547.008 | LSASS驱动（LSASS Driver）| 攻击者可以添加或修改windows系统的LSASS驱动让lsass进程加载恶意DLL维持权限 | [链接](https://attack.mitre.org/techniques/T1547/008) |
| T1547.009 | 修改快捷方式（Shortcut Modification）| 攻击者通过修改快捷方式或符号链接来维持权限 | [链接](https://attack.mitre.org/techniques/T1547/009) |
| T1547.010 | 端口监视器（Port Monitors）| 攻击者通过在windows系统中调用AddMonitor创建端口监视器加载恶意DLL | [链接](https://attack.mitre.org/techniques/T1547/010) |
| T1547.012 | 打印处理器（Print Processors）| 攻击者利用打印处理器使得windows的spoolsv服务加载恶意DLL | [链接](https://attack.mitre.org/techniques/T1547/012) |
| T1547.013 | XDG启动项（XDG Autostart Entries）| 攻击者利用linux系统X桌面的启动项执行命令 | [链接](https://attack.mitre.org/techniques/T1547/013) |
| T1547.014 | 活动设置（Active Setup）| 攻击者在注册表中配置用户登录命令在登录时执行 | [链接](https://attack.mitre.org/techniques/T1547/014) |
| T1547.015 | 登录命令（Login Items）| 攻击者通过在Mac系统中设置登录命令在用户登录时执行 | [链接](https://attack.mitre.org/techniques/T1547/015) |
| T1037 | 启动或登录初始化脚本（Boot or Logon Initialization Scripts）| 攻击者利用系统启动或登录时自动运行的初始化脚本进行权限维持 | [链接](https://attack.mitre.org/techniques/T1037) |
| T1037.001 | Windows登录脚本（Logon Script Windows）| 攻击者通过配置注册表项UserInitMprLogonScript在用户登录时执行命令 | [链接](https://attack.mitre.org/techniques/T1037/001) |
| T1037.002 | 登录钩子（Login Hook）| 攻击者通过配置Mac系统中的com.apple.loginwindow.plist文件设置登录钩子 | [链接](https://attack.mitre.org/techniques/T1037/002) |
| T1037.003 | 网络登录脚本（Network Logon Script）| 攻击者利用网络登录脚本（如活动目录或组策略）自动执行命令 | [链接](https://attack.mitre.org/techniques/T1037/003) |
| T1037.004 | RC脚本（RC Scripts）| 攻击者通过修改linux系统中的RC启动脚本来执行命令 | [链接](https://attack.mitre.org/techniques/T1037/004) |
| T1037.005 | 系统启动项（Startup Items）| 攻击者通过配置系统启动项来执行命令 | [链接](https://attack.mitre.org/techniques/T1037/005) |
| T1543 | 创建或修改系统进程（Create or Modify System Process）| 攻击者利用系统进程执行恶意代码来维持权限 | [链接](https://attack.mitre.org/techniques/T1543) |
| T1543.001 | Launchd代理（Launch Agent）| 攻击者利用Mac系统中的LaunchAgents执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1543/001) |
| T1543.002 | Systemd服务（Systemd Service）| 攻击者利用linux系统中的systemd service来执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1543/002) |
| T1543.003 | Windows服务（Windows Service）| 攻击者利用windows service执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1543/003) |
| T1543.004 | Launchd后台（Launch Daemon）| 攻击者利用mac系统中的LaunchDaemons执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1543/004) |
| T1484 | 域策略修改（Domain Policy Modification）| 攻击者通过修改域的配置策略进行提权 | [链接](https://attack.mitre.org/techniques/T1484) |
| T1484.001 | 组策略修改（Group Policy Modification）| 攻击者通过修改组策略配置进行提权 | [链接](https://attack.mitre.org/techniques/T1484/001) |
| T1484.002 | 域信任关系修改（Domain Trust Modification）| 攻击者通过修改不同域之间的信任关系（如联邦认证）进行提权 | [链接](https://attack.mitre.org/techniques/T1484/002) |
| T1611 | 容器逃逸（Escape to Host）| 攻击者通过容器逃逸获取宿主机权限 | [链接](https://attack.mitre.org/techniques/T1611) |
| T1546 | 事件触发执行（Event Triggered Execution）| 攻击者利用系统提供的机制，在特定事件触发时执行恶意程序 | [链接](https://attack.mitre.org/techniques/T1546) |
| T1546.001 | 修改默认文件关联（Change Default File Association）| 攻击者通过修改特定文件类型的默认关联程序，使得用户在打开该类型文件时执行攻击者指定的程序 | [链接](https://attack.mitre.org/techniques/T1546/001) |
| T1546.002 | 屏保程序（Screensaver）| 攻击者通过修改windows系统的屏保程序执行命令 | [链接](https://attack.mitre.org/techniques/T1546/002) |
| T1546.003 | WMI事件订阅（Windows Management Instrumentation Event Subscription）| 攻击者通过WMI事件订阅执行命令 | [链接](https://attack.mitre.org/techniques/T1546/003) |
| T1546.004 | 修改shell配置 | 攻击者通过修改类unix系统中的shell配置脚本（如：~/.bashrc、/etc/profile等）执行命令 | [链接](https://attack.mitre.org/techniques/T1546/004) |
| T1546.005 | 信号处理程序（Trap）| 攻击者通过修改特定信号的处理程序来执行命令 | [链接](https://attack.mitre.org/techniques/T1546/005) |
| T1546.006 | 修改LC_LOAD_DYLIB头（LC_LOAD_DYLIB Addition）| 攻击者通过修改Mach-O二进制程序中的LC_LOAD_DYLIB头来添加程序执行时加载的动态库 | [链接](https://attack.mitre.org/techniques/T1546/006) |
| T1546.007 | Netsh助手库（Netsh Helper DLL）| 攻击者通过添加netsh helper dll来加载恶意动态库 | [链接](https://attack.mitre.org/techniques/T1546/007) |
| T1546.008 | 系统辅助功能（Accessibility Features）| 攻击者通过修改系统辅助功能程序（如粘滞键辅助程序sethc.exe）执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1546/008) |
| T1546.009 | AppCert动态库（AppCert DLLs）| 攻击者通过修改注册表中的AppCertDLLs键值使得程序在启动时加载恶意DLL | [链接](https://attack.mitre.org/techniques/T1546/009) |
| T1546.010 | AppInit动态库（AppInit DLLs）| 攻击者通过修改注册表中的AppInit_DLLs键值使得程序在启动时加载恶意DLL | [链接](https://attack.mitre.org/techniques/T1546/010) |
| T1546.011 | 应用程序夹层（Application Shimming）| 攻击者利用windows程序兼容性框架中的应用夹层功能对程序行为进行修改 | [链接](https://attack.mitre.org/techniques/T1546/011) |
| T1546.012 | IFEO镜像劫持（Image File Execution Options Injection）| 攻击者利用注册表中的Image File Execution Options项指定启动特定程序时需要加载的Debugger程序，该Debugger程序可以是任意程序，故攻击者可以在启动指定进程时执行任意程序 | [链接](https://attack.mitre.org/techniques/T1546/012) |
| T1546.013 | PowerShell配置文件 | 攻击者通过修改profile.ps1执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1546/013) |
| T1546.014 | Emond（Emond）| 攻击者通过修改或添加事件监控规则（/etc/emond.d/rules）来执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1546/014) |
| T1546.015 | COM劫持（Component Object Model Hijacking）| 攻击者通过修改注册表对COM对象进行劫持以执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1546/015) |
| T1546.016 | 安装包（Installer Packages）| 攻击者利用安装包中的脚本（如：deb包中的preinst、postinst，msi包中的Prebuild、Postbuild等）执行命令 | [链接](https://attack.mitre.org/techniques/T1546/016) |
| T1068 | 利用软件漏洞提权（Exploitation for Privilege Escalation）| 攻击者通过利用软件漏洞进行提权 | [链接](https://attack.mitre.org/techniques/T1068) |
| T1574 | 劫持执行流（Hijack Execution Flow）| 攻击者通过劫持进程的执行流来执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1574) |
| T1574.001 | DLL搜索顺序劫持（DLL Search Order Hijacking）| 攻击者利用程序搜索动态库路径的先后顺序，在优先搜索的路径中添加程序需要加载的动态库进行劫持 | [链接](https://attack.mitre.org/techniques/T1574/001) |
| T1574.002 | DLL侧加载（DLL Side-Loading）| 攻击者通过直接替换合法程序或白名单程序运行所需的DLL库来执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1574/002) |
| T1574.004 | Dylib劫持（Dylib Hijacking）| 攻击者利用程序搜索动态库路径的先后顺序，在优先搜索的路径中添加程序需要加载的动态库进行劫持 | [链接](https://attack.mitre.org/techniques/T1574/004) |
| T1574.005 | 安装辅助程序权限设置缺陷（Executable Installer File Permissions Weakness）| 安装程序通常会执行其他的辅助程序来完成特定的功能，当这些助手程序的权限设置存在问题时，攻击者可以通过替换它们来执行命令 | [链接](https://attack.mitre.org/techniques/T1574/005) |
| T1574.006 | 链接器劫持（Dynamic Linker Hijacking）| 通过修改链接器配置（如LD_PRELOAD、DYLD_INSERT_LIBRARIES等）来加载恶意动态库 | [链接](https://attack.mitre.org/techniques/T1574/006) |
| T1574.007 | 利用Path环境变量进行路径拦截（Path Interception by PATH Environment Variable）| 攻击者通过修改Path环境变量，使得在执行时系统首先搜索攻击者指定的路径，从而拦截正常的命令执行 | [链接](https://attack.mitre.org/techniques/T1574/007) |
| T1574.008 | 利用搜索顺序进行路径拦截（Path Interception by Search Order Hijacking）| 若程序调用其他程序时未指定绝对路径，则可通过在其搜索路径中添加指定的恶意程序来进行劫持执行 | [链接](https://attack.mitre.org/techniques/T1574/008) |
| T1574.009 | 劫持未用引号包裹的路径（Path Interception by Unquoted Path）| 若路径包含空格且未用引号包裹，windows则不会把其当作一个完整路径，攻击者可以把第一个空格改为exe进行劫持 | [链接](https://attack.mitre.org/techniques/T1574/009) |
| T1574.010 | 系统服务文件权限缺陷（Services File Permissions Weakness）| 若系统服务相关的可执行程序的权限配置存在缺陷，攻击者可以通过替换这些文件执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1574/010) |
| T1574.011 | 系统服务注册表权限缺陷（Services Registry Permissions Weakness）| 若系统服务相关的注册表项的权限配置存在缺陷，攻击者可以通过修改相关的注册表项来执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1574/011) |
| T1574.012 | COR_PROFILER劫持（COR_PROFILER）| 攻击者可以通过COR_PROFILER环境变量对使用.net CLR的程序进行劫持 | [链接](https://attack.mitre.org/techniques/T1574/012) |
| T1574.013 | KernelCallbackTable劫持（KernelCallbackTable）| 攻击者通过修改PE文件中的KernelCallbackTable的函数指针，使其指向恶意代码来劫持执行 | [链接](https://attack.mitre.org/techniques/T1574/013) |
| T1055 | 进程注入（Process Injection）| 攻击者通过向进程注入恶意代码进行提权 | [链接](https://attack.mitre.org/techniques/T1055) |
| T1055.001 | 动态库注入（Dynamic-link Library Injection）| 攻击者通过向目标进程注入动态链接库进行提权 | [链接](https://attack.mitre.org/techniques/T1055/001) |
| T1055.002 | 可执行文件注入（Portable Executable Injection）| 攻击者通过向目标进程注入二进制可执行文件进行提权 | [链接](https://attack.mitre.org/techniques/T1055/002) |
| T1055.003 | 线程执行劫持（Thread Execution Hijacking）| 攻击者首先挂起目标线程（如调用OpenThread），然后替换其内存（如WriteProcessMemory、SetThreadContext等）为恶意代码，最后恢复线程运行（如调用ResumeThread）| [链接](https://attack.mitre.org/techniques/T1055/003) |
| T1055.004 | 异步过程调用（Asynchronous Procedure Call）| 攻击者利用windows系统的APC机制向目标进程注入恶意代码 | [链接](https://attack.mitre.org/techniques/T1055/004) |
| T1055.005 | 线程本地存储（Thread Local Storage）| 攻击者利用TLS回调函数向目标进程注入恶意代码 | [链接](https://attack.mitre.org/techniques/T1055/005) |
| T1055.008 | Ptrace系统调用（Ptrace System Calls）| 攻击者利用ptrace系统调用向目标进程注入恶意代码 | [链接](https://attack.mitre.org/techniques/T1055/008) |
| T1055.009 | Proc文件系统（Proc Memory）| 攻击者利用proc文件系统（如/proc/$pid/mem）向目标进程注入恶意代码 | [链接](https://attack.mitre.org/techniques/T1055/009) |
| T1055.011 | 额外窗口内存（Extra Window Memory Injection）| 攻击者利用windows系统桌面程序的窗口对象中的额外存储空间（EWM）注入恶意代码 | [链接](https://attack.mitre.org/techniques/T1055/011) |
| T1055.012 | 进程掏空（Process Hollowing）| 攻击者首先以挂起状态创建进程，然后清除其内存并替换为恶意代码 | [链接](https://attack.mitre.org/techniques/T1055/012) |
| T1055.013 | TxF事务回滚（Process Doppelgänging）| 攻击者利用NTFS事务回滚的机制实现无文件执行恶意代码，首先创建TxF事务把合法文件替换为恶意文件，此时恶意文件只存在于事务的上下文内存中，然后把恶意文件的内容加载到内存中并回滚事务，最后执行内存中的恶意代码 | [链接](https://attack.mitre.org/techniques/T1055/013) |
| T1055.014 | VDSO劫持（VDSO Hijacking）| 攻击者通过修改VDSO内存劫持系统调用 | [链接](https://attack.mitre.org/techniques/T1055/014) |
| T1055.015 | 列表视图控件植入（ListPlanting）| 攻击者通过修改windows窗口程序列表试图控件对象（SysListView32）的内存，把函数指针指向恶意代码 | [链接](https://attack.mitre.org/techniques/T1055/015) |
| T1053 | 定时任务（Scheduled Task/Job）| 攻击者利用系统中的定时任务来执行命令 | [链接](https://attack.mitre.org/techniques/T1053) |
| T1053.002 | At（At）| 攻击者利用at定时任务执行命令 | [链接](https://attack.mitre.org/techniques/T1053/002) |
| T1053.003 | Cron（Cron）| 攻击者利用cron定时任务执行命令 | [链接](https://attack.mitre.org/techniques/T1053/003) |
| T1053.005 | Windows定时任务（Scheduled Task）| 攻击者利用windows task scheduler定时任务执行命令 | [链接](https://attack.mitre.org/techniques/T1053/005) |
| T1053.006 | Systemd计时器（Systemd Timers）| 攻击者利用systemd提供的timers执行命令（可用systemctl进行管理）| [链接](https://attack.mitre.org/techniques/T1053/006) |
| T1053.007 | 容器定时任务（Container Orchestration Job）| 攻击者利用容器定时任务（docker的HEALTHCHECK、k8s的livenessProbe和CronJob等）执行命令 | [链接](https://attack.mitre.org/techniques/T1053/007) |
| T1078 | 有效账户（Valid Accounts）| 攻击者通过利用受害者系统中的有效账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078) |
| T1078.001 | 默认账户（Default Accounts）| 攻击者通过利用受害者系统中存在的默认账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078/001) |
| T1078.002 | 域账户（Domain Accounts）| 攻击者利用域账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078/002) |
| T1078.003 | 本地账户（Local Accounts）| 攻击者利用受害者主机上的账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078/003) |
| T1078.004 | 云账户（Cloud Accounts）| 攻击者利用受害者的云账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078/004) |

## 防御绕过（Defense Evasion）
攻击者试图绕过安全监测

| ID | 名称 | 描述 | Ref |
| :-- | :-- | :-- | :-- |
| T1548 | 滥用提权机制（Abuse Elevation Control Mechanism）| 攻击者通过滥用系统提供的权限控制机制来进行提取 | [链接](https://attack.mitre.org/techniques/T1548) |
| T1548.001 | Setuid和Setgid（Setuid and Setgid）| 攻击者利用linux和mac系统上的setuid和setgid程序提取 | [链接](https://attack.mitre.org/techniques/T1548/001) |
| T1548.002 | 绕过UAC（Bypass User Account Control）| 攻击者通过绕过windows的UAC机制提权 | [链接](https://attack.mitre.org/techniques/T1548/002) |
| T1548.003 | sudo和sudo缓存（Sudo and Sudo Caching）| 攻击者利用sudo缓存或者sudoers配置提权 | [链接](https://attack.mitre.org/techniques/T1548/003) |
| T1548.004 | 提示用户输入凭据（Elevated Execution with Prompt）| 攻击者通过提示框让用户自己输入凭证并以其权限执行（如：调用AuthorizationExecuteWithPrivileges）| [链接](https://attack.mitre.org/techniques/T1548/004) |
| T1134 | 访问令牌操作（Access Token Manipulation）| 攻击者通过操作进程的用户访问令牌进行提权 | [链接](https://attack.mitre.org/techniques/T1134) |
| T1134.001 | 令牌仿冒或窃取（Token Impersonation/Theft）| 攻击者通过仿冒其他用户的令牌进行提取（调用ImpersonateLoggedOnUser）| [链接](https://attack.mitre.org/techniques/T1134/001) |
| T1134.002 | 使用令牌创建进程（Create Process with Token）| 攻击者使用其他用户的令牌创建进程（调用CreateProcessWithTokenW）| [链接](https://attack.mitre.org/techniques/T1134/002) |
| T1134.003 | 创建仿冒令牌（Make and Impersonate Token）| 当攻击者拥有用户名和密码但没登进系统时，可调用LogonUser创建会话并获得令牌 | [链接](https://attack.mitre.org/techniques/T1134/003/) |
| T1134.004 | 伪造父进程（Parent PID Spoofing）| 攻击者通过伪造父进程绕过监控 | [链接](https://attack.mitre.org/techniques/T1134/004) |
| T1134.005 | SID-History注入（SID-History Injection）| 攻击者通过修改SID-History以其他账户身份执行命令 | [链接](https://attack.mitre.org/techniques/T1134/005) |
| T1197 | BITS任务（BITS Jobs）| 攻击者可以利用windows的BITS任务持续在后台执行命令 | [链接](https://attack.mitre.org/techniques/T1197) |
| T1612 | 本地构建镜像（Build Image on Host）| 攻击者直接再受害者机器上构建容器镜像以绕过对镜像拉取的监测 | [链接](https://attack.mitre.org/techniques/T1612) |
| T1622 | 规避调试（Debugger Evasion）| 攻击者通过检测调试器是否存在来规避调试分析 | [链接](https://attack.mitre.org/techniques/T1622) |
| T1140 | 反混淆（Deobfuscate/Decode Files or Information）| 攻击者在攻击时会对C2通信、恶意代码等信息进行加密、编码或混淆，所以攻击者还需要对其进行解密、反混淆 | [链接](https://attack.mitre.org/techniques/T1140) |
| T1610 | 部署容器（Deploy Container）| 攻击者通过在目标环境部署容器来执行命令 | [链接](https://attack.mitre.org/techniques/T1610) |
| T1006 | 直接访问存储卷（Direct Volume Access）| 攻击者通过直接读写硬盘卷来绕过文件系统的权限校验和监控 | [链接](https://attack.mitre.org/techniques/T1006) |
| T1484 | 域策略修改（Domain Policy Modification）| 攻击者通过修改域的配置策略进行提权 | [链接](https://attack.mitre.org/techniques/T1484) |
| T1484.001 | 组策略修改（Group Policy Modification）| 攻击者通过修改组策略配置进行提权 | [链接](https://attack.mitre.org/techniques/T1484/001) |
| T1484.002 | 域信任关系修改（Domain Trust Modification）| 攻击者通过修改不同域之间的信任关系（如联邦认证）进行提权 | [链接](https://attack.mitre.org/techniques/T1484/002) |
| T1480 | 执行护栏（Execution Guardrails）| 攻击者在执行恶意代码时会检测环境信息，只在满足特定条件的情况下执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1480) |
| T1480.001 | 环境密钥（Environmental Keying）| 攻击者通过主机信息生成加密密钥对恶意代码或通信进行加密 | [链接](https://attack.mitre.org/techniques/T1480/001) |
| T1211 | 利用漏洞绕过防御（Exploitation for Defense Evasion）| 攻击者利用软件漏洞来绕过安全机制或安全监控 | [链接](https://attack.mitre.org/techniques/T1211) |
| T1222 | 文件目录权限修改（File and Directory Permissions Modification）| 攻击者通过修改文件或目录的权限或属性绕过ACL | [链接](https://attack.mitre.org/techniques/T1222) |
| T1222.001 | windows文件目录权限修改（Windows File and Directory Permissions Modification）| 攻击者修改windows上的文件和目录权限 | [链接](https://attack.mitre.org/techniques/T1222/001) |
| T1222.002 | Linux和Mac文件目录权限修改（Linux and Mac File and Directory Permissions Modification）| 攻击者修改Linux或Mac系统上的文件和目录权限 | [链接](https://attack.mitre.org/techniques/T1222/002) |
| T1564 | 隐藏执行痕迹（Hide Artifacts）| 攻击者通过隐藏在目标机器上的执行痕迹来绕过防御监测 | [链接](https://attack.mitre.org/techniques/T1564) |
| T1564.001 | 隐藏文件目录（Hidden Files and Directories）| 攻击者通过隐藏自己创建的文件和目录来避免被发现 | [链接](https://attack.mitre.org/techniques/T1564/001) |
| T1564.002 | 隐藏账户（Hidden Users）| 攻击通过隐藏自己创建或修改的账户来避免被发现 | [链接](https://attack.mitre.org/techniques/T1564/002) |
| T1564.003 | 隐藏窗口（Hidden Window）| 攻击者通过隐藏程序运行窗口来避免被发现 | [链接](https://attack.mitre.org/techniques/T1564/003) |
| T1564.004 | NTFS文件属性（NTFS File Attributes）| 攻击者通过NTFS文件属性（存储在MFT中）来保存恶意代码 | [链接](https://attack.mitre.org/techniques/T1564/004) |
| T1564.005 | 隐藏文件系统（Hidden File System）| 攻击者使用自己的文件系统存储恶意文件（如利用未使用的硬盘空间）| [链接](https://attack.mitre.org/techniques/T1564/005) |
| T1564.006 | 虚拟化执行（Run Virtual Instance）| 攻击者通过在虚拟化环境中（qemu、hyper-v等）执行恶意代码去规避检测防御 | [链接](https://attack.mitre.org/techniques/T1564/006) |
| T1564.007 | VBA混淆（VBA Stomping）| 攻击者利用Office显示的VBA宏源码和实际执行的p-code可以不同的特点，用正常的宏代码来隐藏实际执行的恶意p-code以迷惑用户 | [链接](https://attack.mitre.org/techniques/T1564/007) |
| T1564.008 | 邮件隐藏（Email Hiding Rules）| 攻击者利用邮箱的邮件过滤功能来转移受害者收件箱中的邮件以实现隐藏 | [链接](https://attack.mitre.org/techniques/T1564/008) |
| T1564.009 | 资源分离（Resource Forking）| 攻击者把恶意代码存放在文件的扩展属性或者文件包中的资源文件中 | [链接](https://attack.mitre.org/techniques/T1564/009) |
| T1564.010 | 进程启动参数伪造（Process Argument Spoofing）| 攻击者通过修改进程的内存来修改进程启动参数，以隐藏实际的启动参数 | [链接](https://attack.mitre.org/techniques/T1564/010) |
| T1574 | 劫持执行流（Hijack Execution Flow）| 攻击者通过劫持进程的执行流来执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1574) |
| T1574.001 | DLL搜索顺序劫持（DLL Search Order Hijacking）| 攻击者利用程序搜索动态库路径的先后顺序，在优先搜索的路径中添加程序需要加载的动态库进行劫持 | [链接](https://attack.mitre.org/techniques/T1574/001) |
| T1574.002 | DLL侧加载（DLL Side-Loading）| 攻击者通过直接替换合法程序或白名单程序运行所需的DLL库来执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1574/002) |
| T1574.004 | Dylib劫持（Dylib Hijacking）| 攻击者利用程序搜索动态库路径的先后顺序，在优先搜索的路径中添加程序需要加载的动态库进行劫持 | [链接](https://attack.mitre.org/techniques/T1574/004) |
| T1574.005 | 安装辅助程序权限设置缺陷（Executable Installer File Permissions Weakness）| 安装程序通常会执行其他的辅助程序来完成特定的功能，当这些助手程序的权限设置存在问题时，攻击者可以通过替换它们来执行命令 | [链接](https://attack.mitre.org/techniques/T1574/005) |
| T1574.006 | 链接器劫持（Dynamic Linker Hijacking）| 通过修改链接器配置（如LD_PRELOAD、DYLD_INSERT_LIBRARIES等）来加载恶意动态库 | [链接](https://attack.mitre.org/techniques/T1574/006) |
| T1574.007 | 利用Path环境变量进行路径拦截（Path Interception by PATH Environment Variable）| 攻击者通过修改Path环境变量，使得在执行时系统首先搜索攻击者指定的路径，从而拦截正常的命令执行 | [链接](https://attack.mitre.org/techniques/T1574/007) |
| T1574.008 | 利用搜索顺序进行路径拦截（Path Interception by Search Order Hijacking）| 若程序调用其他程序时未指定绝对路径，则可通过在其搜索路径中添加指定的恶意程序来进行劫持执行 | [链接](https://attack.mitre.org/techniques/T1574/008) |
| T1574.009 | 劫持未用引号包裹的路径（Path Interception by Unquoted Path）| 若路径包含空格且未用引号包裹，windows则不会把其当作一个完整路径，攻击者可以把第一个空格改为exe进行劫持 | [链接](https://attack.mitre.org/techniques/T1574/009) |
| T1574.010 | 系统服务文件权限缺陷（Services File Permissions Weakness）| 若系统服务相关的可执行程序的权限配置存在缺陷，攻击者可以通过替换这些文件执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1574/010) |
| T1574.011 | 系统服务注册表权限缺陷（Services Registry Permissions Weakness）| 若系统服务相关的注册表项的权限配置存在缺陷，攻击者可以通过修改相关的注册表项来执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1574/011) |
| T1574.012 | COR_PROFILER劫持（COR_PROFILER）| 攻击者可以通过COR_PROFILER环境变量对使用.net CLR的程序进行劫持 | [链接](https://attack.mitre.org/techniques/T1574/012) |
| T1574.013 | KernelCallbackTable劫持（KernelCallbackTable）| 攻击者通过修改PE文件中的KernelCallbackTable的函数指针，使其指向恶意代码来劫持执行 | [链接](https://attack.mitre.org/techniques/T1574/013) |
| T1562 | 破坏防御（Impair Defenses）| 攻击者通过破坏或禁用受害者环境的防御机制来隐藏攻击 | [链接](https://attack.mitre.org/techniques/T1562) |
| T1562.001 | 禁用或修改安全工具（Disable or Modify Tools）| 攻击者通过禁用或修改安全工具来隐藏攻击 | [链接](https://attack.mitre.org/techniques/T1562/001) |
| T1562.002 | 禁用windows事件日志（Disable Windows Event Logging）| 攻击者通过禁用windows的事件日志来隐藏攻击 | [链接](https://attack.mitre.org/techniques/T1562/002) |
| T1562.003 | 破坏命令历史记录（Impair Command History Logging）| 攻击者通过破坏命令执行的历史记录来隐藏攻击 | [链接](https://attack.mitre.org/techniques/T1562/003) |
| T1562.004 | 禁用或修改防火墙（Disable or Modify System Firewall）| 攻击者通过禁用或修改系统防火墙来突破防御 | [链接](https://attack.mitre.org/techniques/T1562/004) |
| T1562.006 | 阻止告警（Indicator Blocking）| 攻击者通过禁用或修改受害者主机上的监控软件（如ETW）来规避告警提示 | [链接](https://attack.mitre.org/techniques/T1562/006) |
| T1562.007 | 禁用或修改云防火墙（Disable or Modify Cloud Firewall）| 攻击者通过禁用或修改受害者云环境上的防火墙规则来突破防御 | [链接](https://attack.mitre.org/techniques/T1562/007) |
| T1562.008 | 禁用云日志（Disable Cloud Logs）| 攻击者通过禁用受害者云环境上的日志记录（如AWS CloudTrail）来规避检测 | [链接](https://attack.mitre.org/techniques/T1562/008) |
| T1562.009 | 安全模式启动（Safe Mode Boot）| 攻击者利用windows的安全模式来禁用EDR软件 | [链接](https://attack.mitre.org/techniques/T1562/009) |
| T1562.010 | 降级攻击（Downgrade Attack）| 攻击者通过将受害者系统或软件降级到老的或有漏洞的版本来实施攻击 | [链接](https://attack.mitre.org/techniques/T1562/010) |
| T1070 | 移除攻击痕迹（Indicator Removal）| 攻击者通过清除系统上的各种日志记录、文件等来清除攻击痕迹 | [链接](https://attack.mitre.org/techniques/T1070) |
| T1070.001 | 清除windows事件日志（Clear Windows Event Logs） | 攻击者通过清除windows事件日志来消除攻击痕迹 | [链接](https://attack.mitre.org/techniques/T1070/001) |
| T1070.002 | 清除Linux或Mac的系统日志（Clear Linux or Mac System Logs） | 攻击者通过清除/var/log下的日志文件来消除攻击痕迹 | [链接](https://attack.mitre.org/techniques/T1070/002) |
| T1070.003 | 清除命令执行历史（Clear Command History）| 攻击者通过清除命令执行历史来消除攻击痕迹 | [链接](https://attack.mitre.org/techniques/T1070/003) |
| T1070.004 | 文件删除（File Deletion）| 攻击者通过删除文件来消除攻击痕迹 | [链接](https://attack.mitre.org/techniques/T1070/004) |
| T1070.005 | 移除网络共享（Network Share Connection Removal）| 攻击者通过移除网络共享（如SMB）来消除攻击痕迹 | [链接](https://attack.mitre.org/techniques/T1070/005) |
| T1070.006 | 时间混淆（Timestomp）| 攻击者通过修改文件时间戳（如创建时间、修改时间、访问时间等）来消除攻击痕迹 | [链接](https://attack.mitre.org/techniques/T1070/006) |
| T1070.007 | 清除网络连接历史和配置（Clear Network Connection History and Configurations）| 攻击者通过清除网络连接历史记录和配置来消除攻击痕迹 | [链接](https://attack.mitre.org/techniques/T1070/007) |
| T1070.008 | 清除邮箱数据（Clear Mailbox Data）| 攻击者通过清除邮箱数据来消除攻击痕迹 | [链接](https://attack.mitre.org/techniques/T1070/008) |
| T1070.009 | 移除驻留（Clear Persistence）| 攻击者通过移除部署在受害者环境上的持久化驻留程序、服务或文件来消除攻击痕迹 | [链接](https://attack.mitre.org/techniques/T1070/009) |
| T1202 | 间接命令执行（Indirect Command Execution）| 攻击者利用其他程序作为跳板来执行命令，以规避针对命令执行工具的安全检测（如cmd、bash等）| [链接](https://attack.mitre.org/techniques/T1202) |
| T1036 | 伪装（Masquerading）| 攻击者利用各种方法把攻击行为伪装成正常合法的行为 | [链接](https://attack.mitre.org/techniques/T1036) |
| T1036.001 | 无效的代码签名（Invalid Code Signature）| 攻击者利用无效的、未认证的代码签名来降低受害者的警觉性（比没有签名强）| [链接](https://attack.mitre.org/techniques/T1036/001) |
| T1036.002 | 左右颠倒（Right-to-Left Override）| 攻击者利用控制字符（RTLO）来颠倒字符串的显示顺序来迷惑受害者 | [链接](https://attack.mitre.org/techniques/T1036/002) |
| T1036.003 | 重命名系统工具（Rename System Utilities）| 攻击者通过重命名系统工具（如rundll32.exe、bash等）来规避基于文件名的安全检测 | [链接](https://attack.mitre.org/techniques/T1036/003) |
| T1036.004 | 进程名伪装（Masquerade Task or Service）| 攻击者把自己的进程或服务的名字改成和系统服务一样来伪装自己 | [链接](https://attack.mitre.org/techniques/T1036/004) |
| T1036.005 | 文件名伪装（Match Legitimate Name or Location）| 攻击者把自己的恶意文件放在白名单路径中或把文件名改为白名单文件名来进行伪装 | [链接](https://attack.mitre.org/techniques/T1036/005) |
| T1036.006 | 文件后缀空格（Space after Filename）| 攻击者通过在文件扩展名后面添加空格来改变系统打开该文件的行为（如在Mac系统中，如果末尾有空格，则其打开方式不以扩展名为准，而已实际文件类型打开）| [链接](https://attack.mitre.org/techniques/T1036/006) |
| T1036.007 | 双重文件扩展（Double File Extension）| 攻击者利用多个文件后缀来实施伪装，如（test.php.xxxx可能会被当作php来执行）| [链接](https://attack.mitre.org/techniques/T1036/007) |
| T1556 | 修改认证程序（Modify Authentication Process）| 攻击者通过修改认证程序或认证程序插件（如：LSASS、SAM、PAM等）来使自己通过认证登入系统 | [链接](https://attack.mitre.org/techniques/T1556) |
| T1556.001 | 域控认证程序（Domain Controller Authentication）| 攻击者通过修改域控认证程序（LSASS）来绕过认证 | [链接](https://attack.mitre.org/techniques/T1556/001) |
| T1556.002 | 密码筛选器（Password Filter DLL）| 攻击者通过在windows系统的LSA中注册密码筛选DLL来获取明文密码 | [链接](https://attack.mitre.org/techniques/T1556/002) |
| T1556.003 | 认证插件（Pluggable Authentication Modules）| 攻击者通过修改linux系统中的PAM组件来绕过认证或窃取密码 | [链接](https://attack.mitre.org/techniques/T1556/003) |
| T1556.004 | 网络设备认证（Network Device Authentication）| 攻击者通过修改网络设备固件来绕过认证 | [链接](https://attack.mitre.org/techniques/T1556/004) |
| T1556.005 | 可逆加密（Reversible Encryption）| 攻击者通过启用活动目录认证加密属性项AllowReversiblePasswordEncryption，则可通过密码密文解密出明文 | [链接](https://attack.mitre.org/techniques/T1556/005) |
| T1556.006 | 多因子认证（Multi-Factor Authentication）| 攻击者禁用受害者账户的多因子认证策略 | [链接](https://attack.mitre.org/techniques/T1556/006) |
| T1556.007 | 混合身份标识（Hybrid Identity）| 攻击者利用云上云下同步用户身份的功能，通过攻占云下的主机并篡改用于与云上认证协同的进程，实现对云账户的控制 | [链接](https://attack.mitre.org/techniques/T1556/007) |
| T1578 | 利用云服务（Modify Cloud Compute Infrastructure）| 攻击者利用云服务来绕过防御 | [链接](https://attack.mitre.org/techniques/T1578) |
| T1578.001 | 创建快照（Create Snapshot）| 攻击者通过创建虚机或硬盘快照来绕过限制访问数据 | [链接](https://attack.mitre.org/techniques/T1578/001) |
| T1578.002 | 创建虚机（Create Cloud Instance）| 攻击者通过创建虚机来绕过网络访问限制，或者通过快照创建虚机来访问数据 | [链接](https://attack.mitre.org/techniques/T1578/002) |
| T1578.003 | 删除虚机（Delete Cloud Instance）| 攻击者在攻击完成后删除创建的虚机以规避检测取证 | [链接](https://attack.mitre.org/techniques/T1578/003) |
| T1578.004 | 恢复虚机（Revert Cloud Instance）| 攻击通过把虚机回退到之前的状态（如利用快照）来清除所有攻击痕迹 | [链接](https://attack.mitre.org/techniques/T1578/004) |
| T1112 | 修改注册表（Modify Registry）| 攻击者通过注册表存放恶意代码或配置 | [链接](https://attack.mitre.org/techniques/T1112) |
| T1601 | 修改系统镜像（Modify System Image）| 攻击者通过修改系统镜像来引入新功能或脆弱性以在系统启动后进行利用 | [链接](https://attack.mitre.org/techniques/T1601) |
| T1601.001 | 修改镜像（Patch System Image）| 攻击者通过修改系统镜像来规避防御（如替换网络设备固件或替换系统内核等） | [链接](https://attack.mitre.org/techniques/T1601/001) |
| T1601.002 | 系统降级（Downgrade System Image）| 攻击者通过把系统镜像替换为旧版本来规避防御或利用漏洞 | [链接](https://attack.mitre.org/techniques/T1601/002) |
| T1599 | 网络边界桥接（Network Boundary Bridging）| 攻击者通过网络边界桥接来绕过访问限制 | [链接](https://attack.mitre.org/techniques/T1599) |
| T1599.001 | 网络地址转换（Network Address Translation Traversal）| 攻击者通过修改NAT配置来伪装IP绕过防火墙ACL规则 | [链接](https://attack.mitre.org/techniques/T1599/001) |
| T1027 | 文件或信息混淆（Obfuscated Files or Information）| 攻击者通过编码、加密等方式对文件或信息内容进行混淆 | [链接](https://attack.mitre.org/techniques/T1027) |
| T1027.001 | 二进制填充（Binary Padding）| 攻击者通过往二进制文件中填充垃圾数据来绕过检测 | [链接](https://attack.mitre.org/techniques/T1027/001) |
| T1027.002 | 软件加壳（Software Packing）| 攻击者通过压缩、加密、虚拟机等方式对恶意代码进行打包以规避检测 | [链接](https://attack.mitre.org/techniques/T1027/002) |
| T1027.003 | 数据隐写（Steganography）| 攻击者利用数据隐写技术把恶意代码藏在图片、音频等文件中 | [链接](https://attack.mitre.org/techniques/T1027/003) |
| T1027.004 | 本地编译（Compile After Delivery）| 攻击者把源码作为攻击载荷下发到受害者机器上，之后再进行编译执行，以绕过一些特征检测 | [链接](https://attack.mitre.org/techniques/T1027/004) |
| T1027.005 | 特征移除（Indicator Removal from Tools）| 攻击者通过修改恶意文件中可能被检测到的特征来规避基于特征的检测 | [链接](https://attack.mitre.org/techniques/T1027/005) |
| T1027.006 | HTML走私（HTML Smuggling）| 攻击者把恶意载荷藏再HTML文件中 | [链接](https://attack.mitre.org/techniques/T1027/006) |
| T1027.007 | 动态API解析（Dynamic API Resolution）| 攻击者动态解析系统原生API的地址以增加逆向分析的难度 | [链接](https://attack.mitre.org/techniques/T1027/007) |
| T1027.008 | 精简载荷（Stripped Payloads）| 攻击者通过移除符号、字符串等直接可读的信息来增加逆向分析难度 | [链接](https://attack.mitre.org/techniques/T1027/008) |
| T1027.009 | 载荷嵌入（Embedded Payloads）| 攻击者把恶意载荷嵌入到看似正常的文件中以规避检测 | [链接](https://attack.mitre.org/techniques/T1027/009) |
| T1647 | plist文件修改（Plist File Modification）| 攻击者通过修改Mac系统中的plist文件来影响系统行为，如隐藏程序窗口、启动额外命令等 | [链接](https://attack.mitre.org/techniques/T1647) |
| T1542 | 操作系统引导（Pre-OS Boot）| 攻击者在操作系统启动前的引导阶段植入恶意代码 | [链接](https://attack.mitre.org/techniques/T1542) |
| T1542.001 | 系统固件（System Firmware）| 攻击者在系统固件（BIOS、EFI、UEFI等）中植入恶意代码 | [链接](https://attack.mitre.org/techniques/T1542/001) |
| T1542.002 | 组件固件（Component Firmware）| 攻击者在计算机其他组件的固件中植入恶意代码，使其可以在BIOS、操作系统之外运行（如方程式组织能够在某些硬盘厂商的硬盘固件中植入恶意代码）| [链接](https://attack.mitre.org/techniques/T1542/002/) |
| T1542.003 | BootKit（BootKit）| 攻击者在引导套件中（如主引导记录MBR或卷引导记录VBR）中植入恶意代码 | [链接](https://attack.mitre.org/techniques/T1542/003/) |
| T1542.004 | ROMMONkit（ROMMONkit）| 攻击者在Cisco的ROMMONkit中植入恶意代码 | [链接](https://attack.mitre.org/techniques/T1542/004/) |
| T1542.005 | TFTP引导（TFTP Boot）| 攻击者通过网络引导的功能，利用tftp下载并启动恶意固件 | [链接](https://attack.mitre.org/techniques/T1542/005/) |
| T1055 | 进程注入（Process Injection）| 攻击者通过向进程注入恶意代码进行提权 | [链接](https://attack.mitre.org/techniques/T1055) |
| T1055.001 | 动态库注入（Dynamic-link Library Injection）| 攻击者通过向目标进程注入动态链接库进行提权 | [链接](https://attack.mitre.org/techniques/T1055/001) |
| T1055.002 | 可执行文件注入（Portable Executable Injection）| 攻击者通过向目标进程注入二进制可执行文件进行提权 | [链接](https://attack.mitre.org/techniques/T1055/002) |
| T1055.003 | 线程执行劫持（Thread Execution Hijacking）| 攻击者首先挂起目标线程（如调用OpenThread），然后替换其内存（如WriteProcessMemory、SetThreadContext等）为恶意代码，最后恢复线程运行（如调用ResumeThread）| [链接](https://attack.mitre.org/techniques/T1055/003) |
| T1055.004 | 异步过程调用（Asynchronous Procedure Call）| 攻击者利用windows系统的APC机制向目标进程注入恶意代码 | [链接](https://attack.mitre.org/techniques/T1055/004) |
| T1055.005 | 线程本地存储（Thread Local Storage）| 攻击者利用TLS回调函数向目标进程注入恶意代码 | [链接](https://attack.mitre.org/techniques/T1055/005) |
| T1055.008 | Ptrace系统调用（Ptrace System Calls）| 攻击者利用ptrace系统调用向目标进程注入恶意代码 | [链接](https://attack.mitre.org/techniques/T1055/008) |
| T1055.009 | Proc文件系统（Proc Memory）| 攻击者利用proc文件系统（如/proc/$pid/mem）向目标进程注入恶意代码 | [链接](https://attack.mitre.org/techniques/T1055/009) |
| T1055.011 | 额外窗口内存（Extra Window Memory Injection）| 攻击者利用windows系统桌面程序的窗口对象中的额外存储空间（EWM）注入恶意代码 | [链接](https://attack.mitre.org/techniques/T1055/011) |
| T1055.012 | 进程掏空（Process Hollowing）| 攻击者首先以挂起状态创建进程，然后清除其内存并替换为恶意代码 | [链接](https://attack.mitre.org/techniques/T1055/012) |
| T1055.013 | TxF事务回滚（Process Doppelgänging）| 攻击者利用NTFS事务回滚的机制实现无文件执行恶意代码，首先创建TxF事务把合法文件替换为恶意文件，此时恶意文件只存在于事务的上下文内存中，然后把恶意文件的内容加载到内存中并回滚事务，最后执行内存中的恶意代码 | [链接](https://attack.mitre.org/techniques/T1055/013) |
| T1055.014 | VDSO劫持（VDSO Hijacking）| 攻击者通过修改VDSO内存劫持系统调用 | [链接](https://attack.mitre.org/techniques/T1055/014) |
| T1055.015 | 列表视图控件植入（ListPlanting）| 攻击者通过修改windows窗口程序列表试图控件对象（SysListView32）的内存，把函数指针指向恶意代码 | [链接](https://attack.mitre.org/techniques/T1055/015) |
| T1620 | 反射代码加载（Reflective Code Loading）| 攻击者通过直接在内存中执行二进制文件来避免落盘（如Cobalt Strike的execute-assembly可在内存中运行.net程序）| [链接](https://attack.mitre.org/techniques/T1620) |
| T1207 | 伪造域控（Rogue Domain Controller）| 攻击者通过伪造域控来操作活动目录数据 | [链接](https://attack.mitre.org/techniques/T1207) |
| T1014 | Rootkit（Rootkit）| 攻击者通过Rootkit技术来隐藏进程、文件、网络流量等 | [链接](https://attack.mitre.org/techniques/T1014) |
| T1553 | 破坏信任控制（Subvert Trust Controls）| 攻击者利用各种方法使安全防护软件信任自己 | [链接](https://attack.mitre.org/techniques/T1553) |
| T1553.001 | 绕过GateKeeper（Gatekeeper Bypass）| 攻击者利用苹果GateKeeper安全机制的缺陷来伪装成合法程序 | [链接](https://attack.mitre.org/techniques/T1553/001) |
| T1553.002 | 代码签名（Code Signing）| 攻击者利用合法的代码签名来伪装成合法程序 | [链接](https://attack.mitre.org/techniques/T1553/002) |
| T1553.003 | SIP和信任提供商劫持（SIP and Trust Provider Hijacking）| 攻击者通过劫持系统提供的信任扩展接口来绕过安全校验（如劫持CryptSIPDllGetSignedDataMsg、CryptSIPDllVerifyIndirectData等）| [链接](https://attack.mitre.org/techniques/T1553/003) |
| T1553.004 | 安装根证书（Install Root Certificate）| 攻击者通过安装根证书来绕过安全校验（如浏览器的证书校验）| [链接](https://attack.mitre.org/techniques/T1553/004) |
| T1553.005 | MOTW标记绕过（Mark-of-the-Web Bypass）| 攻击者通过特殊的文件（如.arj、.gzip、.iso等）来绕过windows的MOTW标记，当用户从互联网下载文件时会在隐藏属性（Zone.Identifier）中打上Mark-of-the-Web标签，以限制其行为 | [链接](https://attack.mitre.org/techniques/T1553/004) |
| T1553.006 | 代码签名策略修改（Code Signing Policy Modification）| 攻击者通过修改代码签名策略来执行未签名或自签名的程序 | [链接](https://attack.mitre.org/techniques/T1553/006) |
| T1218 | 系统命令代理执行（System Binary Proxy Execution）| 攻击者利用现成合法的系统命令代理执行其恶意代码（如GTFOBins中所列的大部分命令，例如：split --filter=/bin/sh /dev/stdin）| [链接](https://attack.mitre.org/techniques/T1218) |
| T1218.001 | CHM（Compiled HTML File）| 攻击者利用CHM隐藏恶意脚本（如VBA、ActiveX等）| [链接](https://attack.mitre.org/techniques/T1218/001) |
| T1218.002 | 控制面板扩展（Control Panel）| 攻击者利用cpl文件加载恶意dll | [链接](https://attack.mitre.org/techniques/T1218/002) |
| T1218.003 | CMSTP（CMSTP）| 攻击者利用INF文件使CMSTP.exe加载恶意dll | [链接](https://attack.mitre.org/techniques/T1218/003) |
| T1218.004 | InstallUtil（InstallUtil）| 攻击者利用InstallUtil.exe执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1218/004) |
| T1218.005 | Mshta（Mshta）| 攻击者通过在.hta文件嵌入恶意脚本让mshta.exe执行 | [链接](https://attack.mitre.org/techniques/T1218/005) |
| T1218.007 | Msiexec（Msiexec）| 攻击者利用msiexec.exe执行恶意.msi文件 | [链接](https://attack.mitre.org/techniques/T1218/007) |
| T1218.008 | Odbcconf（Odbcconf）| 攻击者利用odbcconf.exe加载恶意dll（如：odbcconf.exe /S /A {REGSVR "C:\Users\Public\file.dll"}）| [链接](https://attack.mitre.org/techniques/T1218/008) |
| T1218.009 | Regsvcs或Regasm（Regsvcs/Regasm）| 攻击者利用regsvcs.exe或regasm.exe执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1218/009) |
| T1218.010 | Regsvr32（Regsvr32）| 攻击者利用regsvr32.exe加载恶意dll | [链接](https://attack.mitre.org/techniques/T1218/010) |
| T1218.011 | Rundll32（Rundll32）| 攻击者利用rundll32.exe加载恶意dll | [链接](https://attack.mitre.org/techniques/T1218/011) |
| T1218.012 | Verclsid（Verclsid）| 攻击者利用verclsid.exe加载或执行恶意COM对象（verclsid.exe /S /C {CLSID}）| [链接](https://attack.mitre.org/techniques/T1218/012) |
| T1218.013 | Mavinject（Mavinject）| 攻击者利用mavinject.exe向进程注入恶意dll | [链接](https://attack.mitre.org/techniques/T1218/013) |
| T1218.014 | MMC（MMC）| 攻击者利用mmc.exe执行恶意任务或恶意.msc文件 | [链接](https://attack.mitre.org/techniques/T1218/014) |
| T1216 | 系统脚本代理执行（System Script Proxy Execution）| 攻击者利用系统中合法的脚本代理执行其恶意代码 | [链接](https://attack.mitre.org/techniques/T1216) |
| T1216.001 | PubPrn（PubPrn）| 攻击者利用具有合法签名的脚本PubPrn.vbs来执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1216/001) |
| T1221 | 文档模板注入（Template Injection）| 攻击者通过创建或修改文档中的模板引用来隐藏并执行恶意代码（如在word中添加远程模板，当用户打开文档时会去攻击者控制的服务器上下载恶意载荷）| [链接](https://attack.mitre.org/techniques/T1221) |
| T1205 | 流量信号（Traffic Signaling）| 攻击者利用特殊的网络报文在被控的受害者机器上执行指定命令 | [链接](https://attack.mitre.org/techniques/T1205) |
| T1205.001 | 端口敲门（Port Knocking）| 攻击者通过向被控的受害者机器上处于关闭状态的端口发送特定报文来触发攻击行为 | [链接](https://attack.mitre.org/techniques/T1205/001) |
| T1205.002 | 包过滤（Socket Filters）| 攻击者在受害者机器上植入包过滤处理函数，在受害者接收到特定报文时执行攻击 | [链接](https://attack.mitre.org/techniques/T1205/002) |
| T1127 | 可信开发工具代理执行（Trusted Developer Utilities Proxy Execution）| 攻击者利用可信的开发工具代理执行恶意代码 | [链接](https://attack.mitre.org/techniques/T1127) |
| T1127.001 | MSBuild（MSBuild）| 攻击者利用msbuild.exe执行xml文件中的恶意VB脚本 | [链接](https://attack.mitre.org/techniques/T1127/001) |
| T1535 | 未使用的云区域（Unused/Unsupported Cloud Regions）| 攻击者使用用户未使用或未监控的云区域来实施攻击 | [链接](https://attack.mitre.org/techniques/T1535) |
| T1550 | 利用替代认证凭据（Use Alternate Authentication Material）| 攻击者利用密码哈希、token、ticket等凭据来规避常规的系统访问控制 | [链接](https://attack.mitre.org/techniques/T1550) |
| T1550.001 | 应用访问凭据（Application Access Token）| 攻击者利用窃取的应用访问凭据获取权限（如AWS、GCP等云厂商生成的临时凭证）| [链接](https://attack.mitre.org/techniques/T1550/001) |
| T1550.002 | 使用哈希（Pass the Hash）| 攻击者利用密码哈希获取权限 | [链接](https://attack.mitre.org/techniques/T1550/002) |
| T1550.003 | 使用票据（Pass the Ticket）| 攻击者利用票据获取权限 | [链接](https://attack.mitre.org/techniques/T1550/003) |
| T1550.004 | 网站会话cookie（Web Session Cookie）| 攻击者使用网站cookie获取权限 | [链接](https://attack.mitre.org/techniques/T1550/004) |
| T1078 | 有效账户（Valid Accounts）| 攻击者通过利用受害者系统中的有效账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078) |
| T1078.001 | 默认账户（Default Accounts）| 攻击者通过利用受害者系统中存在的默认账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078/001) |
| T1078.002 | 域账户（Domain Accounts）| 攻击者利用域账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078/002) |
| T1078.003 | 本地账户（Local Accounts）| 攻击者利用受害者主机上的账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078/003) |
| T1078.004 | 云账户（Cloud Accounts）| 攻击者利用受害者的云账户来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1078/004) |
| T1497 | 沙箱规避（Virtualization/Sandbox Evasion）| 攻击者在执行攻击前对当前环境进行检测，如果在虚机或沙箱中则改变攻击行为 | [链接](https://attack.mitre.org/techniques/T1497) |
| T1497.001 | 系统检查（System Checks）| 攻击者通过对比沙箱环境和真实环境的系统配置差别来进行识别 | [链接](https://attack.mitre.org/techniques/T1497/001) |
| T1497.002 | 用户行为检查（User Activity Based Checks）| 攻击者通过检测用户的行为（如键盘输入、鼠标移动等）来识别沙箱 | [链接](https://attack.mitre.org/techniques/T1497/002) |
| T1497.003 | 运行时间检查（Time Based Evasion）| 攻击者通过沙箱环境和真实环境的执行时长差别来进行识别 | [链接](https://attack.mitre.org/techniques/T1497/003) |
| T1600 | 加密弱化（Weaken Encryption）| 攻击者通过弱化加密配置以方便解密 | [链接](https://attack.mitre.org/techniques/T1600) |
| T1600.001 | 降低密钥空间（Reduce Key Space）| 攻击者通过降低攻占的系统或网络设备的密钥长度来降低加密强度 | [链接](https://attack.mitre.org/techniques/T1600/001) |
| T1600.002 | 禁用硬件加密（Disable Crypto Hardware）| 攻击者通过禁用硬件加密来减低加密强度 | [链接](https://attack.mitre.org/techniques/T1600/002) |
| T1220 | XSL脚本（XSL Script Processing）| 攻击者通过在xsl文件中嵌入恶意脚本来规避检测 | [链接](https://attack.mitre.org/techniques/T1220) |

## 凭据访问（Credential Access）
攻击者试图去窃取受害者凭据

| ID | 名称 | 描述 | Ref |
| :-- | :-- | :-- | :-- |
| T1557 | 中间人（Adversary-in-the-Middle）| 攻击者利用处于受害者和目标的网络中间位置实施攻击 | [链接](https://attack.mitre.org/techniques/T1557) |
| T1557.001 | LLMNR/NBT-NS投毒和SMB中继（LLMNR/NBT-NS Poisoning and SMB Relay）| 攻击者通过伪造LLMNR/NBT-NS协议的权威域名解析响应把受害者的访问请求导向攻击者的服务器，攻击者通过重放NTML认证协议的哈希来对SMB、LDAP等服务器进行攻击 | [链接](https://attack.mitre.org/techniques/T1557/001) |
| T1557.002 | ARP缓存投毒（ARP Cache Poisoning）| 攻击者通过在局域网中响应ARP请求，把受害者的流量导向攻击者的机器 | [链接](https://attack.mitre.org/techniques/T1557/002) |
| T1557.003 | DHCP仿冒（DHCP Spoofing）| 攻击者通过仿冒DHCP服务器来把受害者的流量导向攻击者的机器 | [链接](https://attack.mitre.org/techniques/T1557/003) |
| T1110 | 暴力破解（Brute Force）| 攻击者通过穷举的方式破解加密的信息 | [链接](https://attack.mitre.org/techniques/T1110) |
| T1110.001 | 密码猜测（Password Guessing）| 攻击者通过瞎猜的方式试图获得受害者的明文密码 | [链接](https://attack.mitre.org/techniques/T1110/001) |
| T1110.002 | 密码破解（Password Cracking）| 攻击者通过破解受害者密码哈希来获取明文密码 | [链接](https://attack.mitre.org/techniques/T1110/002) |
| T1110.003 | 密码喷射（Password Spraying）| 攻击者利用密码字典来进行爆破 | [链接](https://attack.mitre.org/techniques/T1110/003) |
| T1110.004 | 凭据碰撞（Credential Stuffing）| 攻击者利用在其他网站平台上或社工库中获取的受害者密码来尝试登进目标系统 | [链接](https://attack.mitre.org/techniques/T1110/004) |
| T1555 | 密码存储区中的凭证（Credentials from Password Stores）| 攻击者在系统中的密码存储区中获取用户密码 | [链接](https://attack.mitre.org/techniques/T1555) |
| T1555.001 | Keychain（Keychain）| 攻击者通过Mac系统中的keychain服务来获取登录凭据 | [链接](https://attack.mitre.org/techniques/T1555/001) |
| T1555.002 | Securityd服务内存（Securityd Memory）| 攻击者通过读取securityd服务内存来获取凭据 | [链接](https://attack.mitre.org/techniques/T1555/002) |
| T1555.003 | 浏览器中的凭据（Credentials from Web Browsers）| 攻击者获取浏览器存储的凭据 | [链接](https://attack.mitre.org/techniques/T1555/003) |
| T1555.004 | Windows凭证管理器（Windows Credential Manager）| 攻击者从Windows凭证管理器中获取凭据 | [链接](https://attack.mitre.org/techniques/T1555/004) |
| T1555.005 | 密码管理应用（Password Managers）| 攻击者从第三方密码管理服务或应用中获取凭据 | [链接](https://attack.mitre.org/techniques/T1555/005) |
| T1212 | 利用漏洞获取凭据（Exploitation for Credential Access）| 攻击者利用软件漏洞获取凭据 | [链接](https://attack.mitre.org/techniques/T1212) |
| T1187 | 强制认证（Forced Authentication）| 攻击者通过强制或诱导用户进行登录来获取密码 | [链接](https://attack.mitre.org/techniques/T1187) |
| T1606 | 伪造网站凭据（Forge Web Credentials）| 攻击者通过窃取的私钥来伪造合法的凭据 | [链接](https://attack.mitre.org/techniques/T1606) |
| T1606.001 | 网站cookie（Web Cookies）| 攻击者通过伪造网站cookie来进行访问 | [链接](https://attack.mitre.org/techniques/T1606/001) |
| T1606.002 | SAML凭据（SAML Tokens）| 攻击者通过伪造SAML凭据来进行访问 | [链接](https://attack.mitre.org/techniques/T1606/002) |
| T1056 | 输入捕获（Input Capture）| 攻击者通过捕获用户的输入来获取凭据 | [链接](https://attack.mitre.org/techniques/T1056) |
| T1056.001 | 键盘记录器（Keylogging）| 攻击者通过捕获用户键盘输入来获取密码 | [链接](https://attack.mitre.org/techniques/T1056/001) |
| T1056.002 | 图形应用输入捕获（GUI Input Capture）| 攻击者通过捕获图形应用程序中的用户输入来获取凭据 | [链接](https://attack.mitre.org/techniques/T1056/002) |
| T1056.003 | 网站登录捕获（Web Portal Capture）| 攻击者通过伪造网站登录页来捕获用户密码 | [链接](https://attack.mitre.org/techniques/T1056/003) |
| T1056.004 | 凭据处理API劫持（Credential API Hooking）| 攻击者通过劫持凭据处理相关的API，从函数参数中获取明文密码 | [链接](https://attack.mitre.org/techniques/T1056/004) |
| T1556 | 修改认证程序（Modify Authentication Process）| 攻击者通过修改认证程序或认证程序插件（如：LSASS、SAM、PAM等）来使自己通过认证登入系统 | [链接](https://attack.mitre.org/techniques/T1556) |
| T1556.001 | 域控认证程序（Domain Controller Authentication）| 攻击者通过修改域控认证程序（LSASS）来绕过认证 | [链接](https://attack.mitre.org/techniques/T1556/001) |
| T1556.002 | 密码筛选器（Password Filter DLL）| 攻击者通过在windows系统的LSA中注册密码筛选DLL来获取明文密码 | [链接](https://attack.mitre.org/techniques/T1556/002) |
| T1556.003 | 认证插件（Pluggable Authentication Modules）| 攻击者通过修改linux系统中的PAM组件来绕过认证或窃取密码 | [链接](https://attack.mitre.org/techniques/T1556/003) |
| T1556.004 | 网络设备认证（Network Device Authentication）| 攻击者通过修改网络设备固件来绕过认证 | [链接](https://attack.mitre.org/techniques/T1556/004) |
| T1556.005 | 可逆加密（Reversible Encryption）| 攻击者通过启用活动目录认证加密属性项AllowReversiblePasswordEncryption，则可通过密码密文解密出明文 | [链接](https://attack.mitre.org/techniques/T1556/005) |
| T1556.006 | 多因子认证（Multi-Factor Authentication）| 攻击者禁用受害者账户的多因子认证策略 | [链接](https://attack.mitre.org/techniques/T1556/006) |
| T1556.007 | 混合身份标识（Hybrid Identity）| 攻击者利用云上云下同步用户身份的功能，通过攻占云下的主机并篡改用于与云上认证协同的进程，实现对云账户的控制 | [链接](https://attack.mitre.org/techniques/T1556/007) |
| T1111 | MFA窃取（Multi-Factor Authentication Interception）| 攻击者通过键盘记录、短信侦听等方式窃取多因子认证的凭据 | [链接](https://attack.mitre.org/techniques/T1111) |
| T1621 | MFA请求生成（Multi-Factor Authentication Request Generation）| 攻击者利用社工方式（如获取用户邮箱）获得MFA凭据，或者诱导用户通过MFA提示框 | [链接](https://attack.mitre.org/techniques/T1621) |
| T1040 | 网络嗅探（Network Sniffing）| 攻击者通过网络嗅探获取敏感信息，在云上还可以利用云服务来进行嗅探（如：AWS Traffic Mirroring、GCP Packet Mirroring和Azure vTap等）| [链接](https://attack.mitre.org/techniques/T1040) |
| T1003 | 系统凭证转储（OS Credential Dumping）| 攻击者通过转储系统凭证来获取密码或密码哈希 | [链接](https://attack.mitre.org/techniques/T1003) |
| T1003.001 | LSASS内存（LSASS Memory）| 攻击者从LSASS进程内存中获取凭证 | [链接](https://attack.mitre.org/techniques/T1003/001) |
| T1003.002 | SAM数据库（Security Account Manager）| 攻击者从SAM数据库中获取凭据 | [链接](https://attack.mitre.org/techniques/T1003/002) |
| T1003.003 | NTDS数据库（NTDS）| 攻击者从活动目录数据库（NTDS.dit）中获取凭证 | [链接](https://attack.mitre.org/techniques/T1003/003) |
| T1003.004 | LSA凭据（LSA Secrets）| 攻击者从注册表或内存中获取LSA凭据（可借助Mimikatz工具获取） | [链接](https://attack.mitre.org/techniques/T1003/004) |
| T1003.005 | 域凭据缓存（Cached Domain Credentials）| 攻击者从域凭据缓存中获取哈希（可借助Mimikatz工具获取）| [链接](https://attack.mitre.org/techniques/T1003/005) |
| T1003.006 | DCSync（DCSync）| 攻击者利用DCSync从活动目录中密码数据 | [链接](https://attack.mitre.org/techniques/T1003/006) |
| T1003.007 | Proc文件系统（Proc Filesystem）| 攻击者利用proc文件系统读取目标进程内存并从中获得密码 | [链接](https://attack.mitre.org/techniques/T1003/007) |
| T1003.008 | passwd和shadow文件（/etc/passwd and /etc/shadow）| 攻击者从passwd或shadow文件中获取密码哈希 | [链接](https://attack.mitre.org/techniques/T1003/008) |
| T1528 | 窃取服务访问凭据（Steal Application Access Token）| 攻击者利用各种手法获取SaaS服务的凭据（如k8s的service account token和oauth token等）| [链接](https://attack.mitre.org/techniques/T1528) |
| T1649 | 窃取或伪造认证证书（Steal or Forge Authentication Certificates）| 攻击者窃取认证证书或者窃取CA私钥伪造认证证书的方式实施攻击 | [链接](https://attack.mitre.org/techniques/T1649) |
| T1558 | 窃取或伪造Kerberos票据（Steal or Forge Kerberos Tickets）| 攻击者通过窃取或伪造Kerberos票据进行认证（windows系统可用klist命令获取，Linux和Mac系统可从ccache中获取） | [链接](https://attack.mitre.org/techniques/T1558) |
| T1558.001 | 黄金票据（Golden Ticket）| 攻击者利用KRBTGT账号密码哈希生成TGT票据（即ticket granting tickets，也被称为黄金票据）进行认证 | [链接](https://attack.mitre.org/techniques/T1558/001) |
| T1558.002 | 白银票据（Silver Ticket）| 攻击者利用MSSQL、SharePoint等服务的账号密码哈希生成TGS票据（即ticket granting service）来访问对应的服务 | [链接](https://attack.mitre.org/techniques/T1558/002) |
| T1558.003 | Kerberoasting（Kerberoasting）| 攻击者通过普通域账号权限查询域内SPN，然后获取服务的TGS哈希并导出进行离线破解 | [链接](https://attack.mitre.org/techniques/T1558/003) |
| T1558.004 | AS-REP Roasting（AS-REP Roasting）| 攻击者在域用户设置了不需要kerberos预身份验证的条件下，可从session key中暴力破解出用户明文密码 | [链接](https://attack.mitre.org/techniques/T1558/004) |
| T1539 | 窃取网站会话cookie（Steal Web Session Cookie）| 攻击者通过窃取cookie来绕过认证 | [链接](https://attack.mitre.org/techniques/T1539) |
| T1552 | 不安全的凭据（Unsecured Credentials）| 攻击者在攻占的系统上寻找不安全的凭据（如：明文密码、证书私钥等）| [链接](https://attack.mitre.org/techniques/T1552) |
| T1552.001 | 文件中的凭据（Credentials In Files）| 攻击者从文件中获取凭据 | [链接](https://attack.mitre.org/techniques/T1552/001) |
| T1552.002 | 注册表中的凭据（Credentials in Registry）| 攻击者从注册表中获取凭据 | [链接](https://attack.mitre.org/techniques/T1552/002) |
| T1552.003 | Bash历史记录（Bash History）| 攻击者从bash历史记录（如.bash_history）中获取凭据 | [链接](https://attack.mitre.org/techniques/T1552/003) |
| T1552.004 | 证书私钥（Private Keys）| 攻击者获取证书私钥 | [链接](https://attack.mitre.org/techniques/T1552/004) |
| T1552.005 | 云上元数据API（Cloud Instance Metadata API）| 攻击者从云实例的元数据API中获取凭据（如：访问169.254.169.254）| [链接](https://attack.mitre.org/techniques/T1552/005) |
| T1552.006 | 组策略首选项（Group Policy Preferences）| 攻击者从GPP中获取凭据 | [链接](https://attack.mitre.org/techniques/T1552/006) |
| T1552.007 | 云原生API（Container API）| 攻击者利用云原生API（如docker、k8s等）获取凭据 | [链接](https://attack.mitre.org/techniques/T1552/007) |

## 信息发现（Discovery）
攻击者试图摸清攻占的系统和网络环境

| ID | 名称 | 描述 | Ref |
| :-- | :-- | :-- | :-- |
| T1087 | 账户发现（Account Discovery）| 攻击者试图在攻占环境中获取账户信息 | [链接](https://attack.mitre.org/techniques/T1087) |
| T1087.001 | 本地账户（Local Account）| 攻击者在攻占环境中获取系统本地账户 | [链接](https://attack.mitre.org/techniques/T1087/001) |
| T1087.002 | 域账户（Domain Account）| 攻击者在攻占环境中获取域账户 | [链接](https://attack.mitre.org/techniques/T1087/002) |
| T1087.003 | 邮箱账户（Email Account）| 攻击者在攻占环境中获取邮箱账户 | [链接](https://attack.mitre.org/techniques/T1087/003) |
| T1087.004 | 云账户（Cloud Account）| 攻击者在攻占环境中获取云或云上服务的账户信息 | [链接](https://attack.mitre.org/techniques/T1087/004) |
| T1010 | 窗口应用发现（Application Window Discovery）| 攻击者获取系统中正在运行的窗口应用程序列表 | [链接](https://attack.mitre.org/techniques/T1010) |
| T1217 | 浏览器书签发现（Browser Bookmark Discovery）| 攻击者获取浏览器书签内容 | [链接](https://attack.mitre.org/techniques/T1217) |
| T1580 | 云基础设施资源发现（Cloud Infrastructure Discovery）| 攻击者获取IaaS层的资源信息（如虚机、对象存储域名）| [链接](https://attack.mitre.org/techniques/T1580) |
| T1538 | 云服务看板（Cloud Service Dashboard）| 攻击者通过云服务看板了解受害者的云环境 | [链接](https://attack.mitre.org/techniques/T1538) |
| T1526 | 云服务发现（Cloud Service Discovery）| 攻击者枚举受害者使用的云服务信息 | [链接](https://attack.mitre.org/techniques/T1526) |
| T1619 | 对象存储枚举（Cloud Storage Object Discovery）| 攻击者枚举受害者的对象存储数据（如ListBuckets等）| [链接](https://attack.mitre.org/techniques/T1619) |
| T1613 | 云原生资源发现（Container and Resource Discovery）| 攻击者试图发现云原生环境中的资源（如docker、k8s等）| [链接](https://attack.mitre.org/techniques/T1613)
| T1622 | 规避调试（Debugger Evasion）| 攻击者通过检测调试器是否存在来规避调试分析 | [链接](https://attack.mitre.org/techniques/T1622) |
| T1482 | 域信任关系发现（Domain Trust Discovery）| 攻击者枚举与当前域存在信任关系的域 | [链接](https://attack.mitre.org/techniques/T1482) |
| T1083 | 文件和目录发现（File and Directory Discovery）| 攻击者枚举本地或网络上的文件或目录 | [链接](https://attack.mitre.org/techniques/T1083) |
| T1615 | 组策略发现（Group Policy Discovery）| 攻击者收集组策略配置信息 | [链接](https://attack.mitre.org/techniques/T1615) |
| T1046 | 网络服务发现（Network Service Discovery）| 攻击者扫描当前环境中存在的网络服务（开放端口） | [链接](https://attack.mitre.org/techniques/T1046) |
| T1135 | 网络共享发现（Network Share Discovery）| 攻击者扫描当前环境中存在的网络共享目录或磁盘（如NFS、SMB、webDAV等）| [链接](https://attack.mitre.org/techniques/T1135) |
| T1040 | 网络嗅探（Network Sniffing）| 攻击者通过网络嗅探获取敏感信息，在云上还可以利用云服务来进行嗅探（如：AWS Traffic Mirroring、GCP Packet Mirroring和Azure vTap等）| [链接](https://attack.mitre.org/techniques/T1040) |
| T1201 | 密码规则发现（Password Policy Discovery）| 攻击者通过密码强度检验规则（如包含大小写字母和数字）来生成对应的字典以提高爆破效率 | [链接](https://attack.mitre.org/techniques/T1201) |
| T1120 | 外设发现（Peripheral Device Discovery）| 攻击者收集连接到系统中的外设信息（如键盘、鼠标、打印机等）| [链接](https://attack.mitre.org/techniques/T1120) |
| T1069 | 权限组发现（Permission Groups Discovery）| 攻击者试图找出权限组配置以及受害者属于哪个权限组以确定后续提权或利用方式 | [链接](https://attack.mitre.org/techniques/T1069) |
| T1069.001 | 本地组（Local Groups）| 攻击者找出系统本地用户组和权限组配置 | [链接](https://attack.mitre.org/techniques/T1069/001) |
| T1069.002 | 域环境组（Domain Groups）| 攻击者找出域环境的用户组和权限组配置 | [链接](https://attack.mitre.org/techniques/T1069/002) |
| T1069.003 | 云环境组（Cloud Groups）| 攻击者找出云环境下的用户组和权限组配置 | [链接](https://attack.mitre.org/techniques/T1069/003) |
| T1057 | 进程发现（Process Discovery）| 攻击者收集系统中运行的进程信息 | [链接](https://attack.mitre.org/techniques/T1057) |
| T1012 | 查询注册表（Query Registry）| 攻击者收集注册表中的信息 | [链接](https://attack.mitre.org/techniques/T1012) |
| T1018 | 远程系统发现（Remote System Discovery）| 攻击者收集在当前环境中可以连接到的其他系统（如执行net view）| [链接](https://attack.mitre.org/techniques/T1018) |
| T1518 | 软件发现（Software Discovery）| 攻击者收集当前环境中安装的软件列表和版本信息 | [链接](https://attack.mitre.org/techniques/T1518) |
| T1518.001 | 安全软件发现（Security Software Discovery）| 攻击者收集当前环境中的安全配置和安装的安全软件信息 | [链接](https://attack.mitre.org/techniques/T1518/001) |
| T1082 | 系统信息发现（System Information Discovery）| 攻击者收集系统的详细信息，如版本、补丁等信息 | [链接](https://attack.mitre.org/techniques/T1082) |
| T1614 | 系统地理位置发现（System Location Discovery）| 攻击者找出受害者主机的地理位置信息 | [链接](https://attack.mitre.org/techniques/T1614) |
| T1614.001 | 系统语言发现（System Language Discovery）| 攻击者找出当前系统所使用的语言信息 | [链接](https://attack.mitre.org/techniques/T1614/001) |
| T1016 | 系统网络配置发现（System Network Configuration Discovery）| 攻击者找出当前系统的网络配置信息（如ip、arp、route等）| [链接](https://attack.mitre.org/techniques/T1016) |
| T1016.001 | 网络连通性发现（Internet Connection Discovery）| 攻击者通过ping、traceroute等命令检查当前环境的网络连通性 | [链接](https://attack.mitre.org/techniques/T1016/001) |
| T1049 | 系统网络连接发现（System Network Connections Discovery）| 攻击者收集系统中的网络连接信息 | [链接](https://attack.mitre.org/techniques/T1049) |
| T1033 | 系统用户发现（System Owner/User Discovery）| 攻击者试图找出当前系统的主要用户（如管理员账号）、当前登录用户、登陆过的用户等信息 | [链接](https://attack.mitre.org/techniques/T1033) |
| T1007 | 系统服务发现（System Service Discovery）| 攻击者试图找出系统中运行的服务信息（如执行sc query、tasklist /svc、systemctl --type=service等）| [链接](https://attack.mitre.org/techniques/T1007) |
| T1124 | 系统时间发现（System Time Discovery）| 攻击者收集系统时间、时区的信息 | [链接](https://attack.mitre.org/techniques/T1124) |
| T1497 | 沙箱规避（Virtualization/Sandbox Evasion）| 攻击者在执行攻击前对当前环境进行检测，如果在虚机或沙箱中则改变攻击行为 | [链接](https://attack.mitre.org/techniques/T1497) |
| T1497.001 | 系统检查（System Checks）| 攻击者通过对比沙箱环境和真实环境的系统配置差别来进行识别 | [链接](https://attack.mitre.org/techniques/T1497/001) |
| T1497.002 | 用户行为检查（User Activity Based Checks）| 攻击者通过检测用户的行为（如键盘输入、鼠标移动等）来识别沙箱 | [链接](https://attack.mitre.org/techniques/T1497/002) |
| T1497.003 | 运行时间检查（Time Based Evasion）| 攻击者通过沙箱环境和真实环境的执行时长差别来进行识别 | [链接](https://attack.mitre.org/techniques/T1497/003) |

## 横向移动（Lateral Movement）
攻击者试图在受害者环境中进行移动

| ID | 名称 | 描述 | Ref |
| :-- | :-- | :-- | :-- |
| T1210 | 利用远程服务（Exploitation of Remote Services） | 攻击者利用远程服务中的漏洞进行攻击 | [链接](https://attack.mitre.org/techniques/T1210) |
| T1534 | 内部钓鱼（Internal Spearphishing）| 攻击者利用受害组织内部的账号发送钓鱼信息 | [链接](https://attack.mitre.org/techniques/T1534) |
| T1570 | 横向工具转移（Lateral Tool Transfer）| 攻击者在受害者环境中的系统之间拷贝攻击工具 | [链接](https://attack.mitre.org/techniques/T1570) |
| T1563 | 远程服务会话劫持（Remote Service Session Hijacking） | 攻击者通过劫持已经存在的远程会话进入系统（如VNC、RDP、SSH等）| [链接](https://attack.mitre.org/techniques/T1563) |
| T1563.001 | SSH会话劫持（SSH Hijacking）| 攻击者通过劫持已经存在的SSH会话进入目标系统（如攻陷ssh-agent）| [链接](https://attack.mitre.org/techniques/T1563/001) |
| T1563.002 | RDP会话劫持（RDP Hijacking）| 攻击者通过劫持已经存在的RDP会话进入目标系统（如利用tscon.exe）| [链接](https://attack.mitre.org/techniques/T1563/002) |
| T1021 | 远程服务（Remote Services）| 攻击者利用有效凭据登录远程服务，如SSH、RDP、VNC等 | [链接](https://attack.mitre.org/techniques/T1021) |
| T1021.001 | 远程桌面服务（Remote Desktop Protocol）| 攻击者利用有效凭据登录远程桌面服务RDP | [链接](https://attack.mitre.org/techniques/T1021/001) |
| T1021.002 | 网络共享服务（SMB/Windows Admin Shares）| 攻击者利用有效凭据登录网络共享服务，如SMB、NFS等 | [链接](https://attack.mitre.org/techniques/T1021/002) |
| T1021.003 | DCOM（Distributed Component Object Model）| 攻击者利用有效凭据调用远程COM对象 | [链接](https://attack.mitre.org/techniques/T1021/003) |
| T1021.004 | SSH（SSH） | 攻击者利用有效凭据登录SSH | [链接](https://attack.mitre.org/techniques/T1021/004) |
| T1021.005 | VNC（VNC）| 攻击者利用有效凭据登录VNC | [链接](https://attack.mitre.org/techniques/T1021/005) |
| T1021.006 | WinRM（Windows Remote Management）| 攻击者利用有效凭据使用windows远程管理服务 | [链接](https://attack.mitre.org/techniques/T1021/006) |
| T1091 | 利用可移动媒体传播（Replication Through Removable Media）| 攻击者把恶意程序存储在可移动媒体中，并利用可移动媒体在插入时的自动运行功能来获取系统访问权 | [链接](https://attack.mitre.org/techniques/T1091) |
| T1072 | 软件部署工具（Software Deployment Tools）| 攻击者利用企业网络中的软件部署工具（如：SCCM、 HBSS、Altiris等）来执行命令 | [链接](https://attack.mitre.org/techniques/T1072) |
| T1080 | 污染网络共享数据（Taint Shared Content）| 攻击者通过污染网络上共享的数据（如网盘中的文件）来对访问该数据的人进行攻击 | [链接](https://attack.mitre.org/techniques/T1080) |
| T1550 | 利用替代认证凭据（Use Alternate Authentication Material）| 攻击者利用密码哈希、token、ticket等凭据来规避常规的系统访问控制 | [链接](https://attack.mitre.org/techniques/T1550) |
| T1550.001 | 应用访问凭据（Application Access Token）| 攻击者利用窃取的应用访问凭据获取权限（如AWS、GCP等云厂商生成的临时凭证）| [链接](https://attack.mitre.org/techniques/T1550/001) |
| T1550.002 | 使用哈希（Pass the Hash）| 攻击者利用密码哈希获取权限 | [链接](https://attack.mitre.org/techniques/T1550/002) |
| T1550.003 | 使用票据（Pass the Ticket）| 攻击者利用票据获取权限 | [链接](https://attack.mitre.org/techniques/T1550/003) |
| T1550.004 | 网站会话cookie（Web Session Cookie）| 攻击者使用网站cookie获取权限 | [链接](https://attack.mitre.org/techniques/T1550/004) |

## 信息收集（Collection）
攻击者收集感兴趣的信息

| ID | 名称 | 描述 | Ref |
| :-- | :-- | :-- | :-- |
| T1557 | 中间人（Adversary-in-the-Middle）| 攻击者利用处于受害者和目标的网络中间位置实施攻击 | [链接](https://attack.mitre.org/techniques/T1557) |
| T1557.001 | LLMNR/NBT-NS投毒和SMB中继（LLMNR/NBT-NS Poisoning and SMB Relay）| 攻击者通过伪造LLMNR/NBT-NS协议的权威域名解析响应把受害者的访问请求导向攻击者的服务器，攻击者通过重放NTML认证协议的哈希来对SMB、LDAP等服务器进行攻击 | [链接](https://attack.mitre.org/techniques/T1557/001) |
| T1557.002 | ARP缓存投毒（ARP Cache Poisoning）| 攻击者通过在局域网中响应ARP请求，把受害者的流量导向攻击者的机器 | [链接](https://attack.mitre.org/techniques/T1557/002) |
| T1557.003 | DHCP仿冒（DHCP Spoofing）| 攻击者通过仿冒DHCP服务器来把受害者的流量导向攻击者的机器 | [链接](https://attack.mitre.org/techniques/T1557/003) |
| T1560 | 数据存档（Archive Collected Data）| 攻击者通过加密、压缩的方式对收集到的数据进行存档 | [链接](https://attack.mitre.org/techniques/T1560) |
| T1560.001 | 使用工具存档（Archive via Utility）| 攻击者使用打包或压缩攻击进行数据存档，如tar、zip等 | [链接](https://attack.mitre.org/techniques/T1560/001) |
| T1560.002 | 使用三方库存档（Archive via Library）| 攻击者使用第三方打包或压缩库进行数据存档，如zlib等 | [链接](https://attack.mitre.org/techniques/T1560/002) |
| T1560.003 | 自定义存档（Archive via Custom Method）| 攻击者使用自己的方法进行数据存档 | [链接](https://attack.mitre.org/techniques/T1560/003) |
| T1123 | 音频捕获（Audio Capture）| 攻击者使用软件或外设来捕获受害者机器上的音频信息 | [链接](https://attack.mitre.org/techniques/T1123) |
| T1119 | 自动收集（Automated Collection）| 攻击者利用脚本、工具、云API等方式自动化地进行信息收集 | [链接](https://attack.mitre.org/techniques/T1119) |
| T1185 | 浏览器会话劫持（Browser Session Hijacking）| 攻击者利用漏洞获取网站cookie，劫持用户会话 | [链接](https://attack.mitre.org/techniques/T1185) |
| T1115 | 剪贴板数据（Clipboard Data）| 攻击者收集剪贴板中的数据 | [链接](https://attack.mitre.org/techniques/T1115) |
| T1530 | 云存储中的数据（Data from Cloud Storage）| 工具利用不安全的云存储配置获取其中的数据 | [链接](https://attack.mitre.org/techniques/T1530) |
| T1602 | 配置库中的数据（Data from Configuration Repository）| 攻击者从配置库中收集设备信息，如从MIB库中收集SNMP管理的设备信息 | [链接](https://attack.mitre.org/techniques/T1602) |
| T1602.001 | SNMP配置（SNMP (MIB Dump)）| 攻击者利用SNMP协议获取MIB库中存储的设备信息 | [链接](https://attack.mitre.org/techniques/T1602/001) |
| T1602.002 | 网络设备配置（Network Device Configuration Dump）| 攻击者从配置文件或配置数据库中获取设备信息 | [链接](https://attack.mitre.org/techniques/T1602/002) |
| T1213 | 信息库中的数据（Data from Information Repositories）| 攻击者从各种信息库中获取数据，如wiki、blog等 | [链接](https://attack.mitre.org/techniques/T1213) |
| T1213.001 | Confluence（Confluence）| 攻击者从Confluence知识库中获取数据 | [链接](https://attack.mitre.org/techniques/T1213/001) |
| T1213.002 | Sharepoint（Sharepoint）| 攻击者从Sharepoint协作文档平台获取数据 | [链接](https://attack.mitre.org/techniques/T1213/002) |
| T1213.003 | 代码仓库（Code Repositories）| 攻击者从代码仓库中获取数据 | [链接](https://attack.mitre.org/techniques/T1213/003) |
| T1005 | 本地系统中的数据（Data from Local System）| 攻击者在受害者的本地系统中获取数据 | [链接](https://attack.mitre.org/techniques/T1005) |
| T1039 | 网盘中的数据（Data from Network Shared Drive）| 攻击者从网络共享磁盘中获取数据（如共享目录、SMB、NFS等）| [链接](https://attack.mitre.org/techniques/T1039) |
| T1025 | 可移动媒介中的数据（Data from Removable Media）| 攻击者从可移动媒介中获取数据（如U盘）| [链接](https://attack.mitre.org/techniques/T1025) |
| T1074 | 数据暂存（Data Staged）| 攻击者在从受害者环境中导出数据前，把收集的数据暂存在某个地方，如受害者本地系统或受害者云存储中 | [链接](https://attack.mitre.org/techniques/T1074) |
| T1074.001 | 本地数据暂存（Local Data Staging）| 攻击者把收集到的数据暂存于受害者的本地系统上 | [链接](https://attack.mitre.org/techniques/T1074/001) |
| T1074.002 | 远程数据暂存（Remote Data Staging）| 攻击者把从受害者环境中的多个系统上收集的数据进行集中存储 | [链接](https://attack.mitre.org/techniques/T1074/002) |
| T1114 | 邮件收集（Email Collection）| 攻击者收集受害者的邮件数据 | [链接](https://attack.mitre.org/techniques/T1114) |
| T1114.001 | 本地邮件收集（Local Email Collection）| 攻击者收集受害者机器上本地存储的邮件数据 | [链接](https://attack.mitre.org/techniques/T1114/001) |
| T1114.002 | 远端邮件收集（Remote Email Collection）| 攻击者利用受害者凭据收集远端存储的邮件数据，如Exchange Server、Office 365、Google Workspace等 | [链接](https://attack.mitre.org/techniques/T1114/002) |
| T1114.003 | 邮件转发（Email Forwarding Rule）| 攻击者通过设置受害者邮箱的邮件转发规则，把受害者收到的邮件转发到外部，如攻击者的邮箱中 | [链接](https://attack.mitre.org/techniques/T1114/003) |
| T1056 | 输入捕获（Input Capture）| 攻击者通过捕获用户的输入来获取凭据 | [链接](https://attack.mitre.org/techniques/T1056) |
| T1056.001 | 键盘记录器（Keylogging）| 攻击者通过捕获用户键盘输入来获取密码 | [链接](https://attack.mitre.org/techniques/T1056/001) |
| T1056.002 | 图形应用输入捕获（GUI Input Capture）| 攻击者通过捕获图形应用程序中的用户输入来获取凭据 | [链接](https://attack.mitre.org/techniques/T1056/002) |
| T1056.003 | 网站登录捕获（Web Portal Capture）| 攻击者通过伪造网站登录页来捕获用户密码 | [链接](https://attack.mitre.org/techniques/T1056/003) |
| T1056.004 | 凭据处理API劫持（Credential API Hooking）| 攻击者通过劫持凭据处理相关的API，从函数参数中获取明文密码 | [链接](https://attack.mitre.org/techniques/T1056/004) |
| T1113 | 屏幕捕获（Screen Capture）| 攻击者对受害者的屏幕进行截屏 | [链接](https://attack.mitre.org/techniques/T1113) |
| T1125 | 视频捕获（Video Capture）| 攻击者利用外设或软件对受害者的机器进行录屏 | [链接](https://attack.mitre.org/techniques/T1125) |

## 命令与控制（Command and Control）
攻击者试图对被害者的系统进行远程控制

| ID | 名称 | 描述 | Ref |
| :-- | :-- | :-- | :-- |
| T1071 | 应用层协议（Application Layer Protocol）| 攻击者利用应用层协议对受害者进行远控 | [链接](https://attack.mitre.org/techniques/T1071) |
| T1071.001 | WEB协议（Web Protocols）| 攻击者利用web协议（如HTTP/S）远控受害者 | [链接](https://attack.mitre.org/techniques/T1071/001) |
| T1071.002 | 文件传输协议（File Transfer Protocols）| 攻击者利用文件传输协议（如FTP/S、SMB）远控受害者 | [链接](https://attack.mitre.org/techniques/T1071/002) |
| T1071.003 | 邮件协议（Mail Protocols）| 攻击者利用邮件协议（如SMTP/S、POP3/S、IMAP）远控受害者 | [链接](https://attack.mitre.org/techniques/T1071/003) |
| T1071.004 | DNS协议（DNS）| 攻击者利用DNS协议远控受害者 | [链接](https://attack.mitre.org/techniques/T1071/004) |
| T1092 | 可移动媒介通信 | 攻击者利用可移动媒介（如U盘）传输控制指令 | [链接](https://attack.mitre.org/techniques/T1092) |
| T1132 | 数据编码（Data Encoding）| 攻击者对远控消息进行编码以规避检测 | [链接](https://attack.mitre.org/techniques/T1132) |
| T1132.001 | 标准编码（Standard Encoding）| 攻击者利用标准的编码方式（如base64）对远控消息进行编码 | [链接](https://attack.mitre.org/techniques/T1132/001) |
| T1132.002 | 非标准编码（Non-Standard Encoding）| 攻击者利用自定义编码方式对远控消息进行编码 | [链接](https://attack.mitre.org/techniques/T1132/002) |
| T1001 | 数据混淆（Data Obfuscation）| 攻击者通过对远控消息进行混淆来规避检测 | [链接](https://attack.mitre.org/techniques/T1001) |
| T1001.001 | 垃圾数据（Junk Data）| 攻击者通过添加垃圾数据的方式对远控消息进行混淆 | [链接](https://attack.mitre.org/techniques/T1001/001) |
| T1001.002 | 数据隐写（Steganography）| 攻击者通过把数据隐写到图片、音视频等文件中对远控消息进行隐藏 | [链接](https://attack.mitre.org/techniques/T1001/002) |
| T1001.003 | 协议仿冒（Protocol Impersonation）| 攻击者通过把远控消息仿冒成正常的协议通信以规避检测，如仿冒SSL握手信息 | [链接](https://attack.mitre.org/techniques/T1001/003) |
| T1568 | 动态解析（Dynamic Resolution）| 攻击者通过动态的方式计算出远控服务器的域名、IP地址和端口 | [链接](https://attack.mitre.org/techniques/T1568) |
| T1568.001 | 域名快速稀释（Fast Flux DNS）| 攻击者将多个IP与一个域名关联起来并迅速更换这些IP，通常一个IP只存活几秒钟或几分钟 | [链接](https://attack.mitre.org/techniques/T1568/001) |
| T1568.002 | 域名生成算法（Domain Generation Algorithms）| 攻击者通过域名生成算法（DGA）动态生成远控域名 | [链接](https://attack.mitre.org/techniques/T1568/002) |
| T1568.003 | DNS计算（DNS Calculation）| 攻击者利用DNS的返回结果计算远控的IP和端口 | [链接](https://attack.mitre.org/techniques/T1568/003) |
| T1573 | 加密信道（Encrypted Channel）| 攻击者利用加密算法来加密远控通信 | [链接](https://attack.mitre.org/techniques/T1573) |
| T1573.001 | 对称加密（Symmetric Cryptography）| 攻击者利用对称加密算法来加密远控通信 | [链接](https://attack.mitre.org/techniques/T1573/001) |
| T1573.002 | 非对称加密（Asymmetric Cryptography）| 攻击者利用非对称加密算法来加密远控通信 | [链接](https://attack.mitre.org/techniques/T1573/002) |
| T1008 | 备用信道（Fallback Channels）| 攻击者通过设立备用信道来防止主信道无法访问时所造成的通信中断 | [链接](https://attack.mitre.org/techniques/T1008) |
| T1105 | 工具传入（Ingress Tool Transfer）| 攻击者在受害者系统中下载攻击工具 | [链接](https://attack.mitre.org/techniques/T1105) |
| T1104 | 多阶段信道（Multi-Stage Channels）| 攻击者通过建立多阶段信道进行运控来克服受害者环境的严苛限制 | [链接](https://attack.mitre.org/techniques/T1104) |
| T1095 | 非应用层协议（Non-Application Layer Protocol）| 攻击者通过非应用层协议（如ICMP、UDP、SOCKS等）建立远控信道 | [链接](https://attack.mitre.org/techniques/T1095) |
| T1571 | 非标准端口（Non-Standard Port）| 攻击者利用非标准端口进行远控，如用8088端口作为HTTPS通信端口 | [链接](https://attack.mitre.org/techniques/T1571) |
| T1572 | 协议封装（Protocol Tunneling）| 攻击者通过对通信协议进行封装来建立网络隧道，如把DNS封装在HTTPS之中 | [链接](https://attack.mitre.org/techniques/T1572) |
| T1090 | 网络代理（Proxy）| 攻击者通过网络代理来进行远控（如frp、ExpressVPN等）| [链接](https://attack.mitre.org/techniques/T1090) |
| T1090.001 | 内部代理（Internal Proxy）| 攻击者利用攻占的机器或系统作为代理服务器 | [链接](https://attack.mitre.org/techniques/T1090/001) |
| T1090.002 | 外部代理（External Proxy）| 攻击者利用外部资源（如购买云资源）作为代理服务器 | [链接](https://attack.mitre.org/techniques/T1090/002) |
| T1090.003 | 多层代理（Multi-hop Proxy）| 攻击者通过搭建代理链来规避溯源 | [链接](https://attack.mitre.org/techniques/T1090/003) |
| T1090.004 | 域前置（Domain Fronting）| 攻击者利用域前置（如CDN资源）来隐藏自身 | [链接](https://attack.mitre.org/techniques/T1090/004) |
| T1219 | 远程访问软件（Remote Access Software）| 攻击者利用远程访问软件（如：Team Viewer、AnyDesk、Go2Assist、LogMein、AmmyyAdmin等）访问目标系统 | [链接](https://attack.mitre.org/techniques/T1219) |
| T1205 | 流量信号（Traffic Signaling）| 攻击者利用特殊的网络报文在被控的受害者机器上执行指定命令 | [链接](https://attack.mitre.org/techniques/T1205) |
| T1205.001 | 端口敲门（Port Knocking）| 攻击者通过向被控的受害者机器上处于关闭状态的端口发送特定报文来触发攻击行为 | [链接](https://attack.mitre.org/techniques/T1205/001) |
| T1205.002 | 包过滤（Socket Filters）| 攻击者在受害者机器上植入包过滤处理函数，在受害者接收到特定报文时执行攻击 | [链接](https://attack.mitre.org/techniques/T1205/002) |
| T1102 | Web服务（Web Service）| 攻击者利用合规的web服务或社交媒体服务作为远控的通信信道（如：Dropbox、Amazon S3、Google Drive、Pastebin、GitHub、Twitter等） | [链接](https://attack.mitre.org/techniques/T1102) |
| T1102.001 | DDR（Dead Drop Resolver）| 攻击者利用合规的web服务存储远控的IP、域名等信息，如Twitter、Facebook、YouTube、Reddit、S3 buckets、Google Docs等 | [链接](https://attack.mitre.org/techniques/T1102/001) |
| T1102.002 | 双向通信（Bidirectional Communication）| 攻击者利用合规的web服务向受害者发送控制命令并接收返回结果，如Telegram、Google Drive、OneDrive、GitHub、WordPress、Blogspot等 | [链接](https://attack.mitre.org/techniques/T1102/002) |
| T1102.003 | 单向通信（One-Way Communication）| 攻击者利用合规的web服务向受害者发送控制命令 | [链接](https://attack.mitre.org/techniques/T1102/003) |

## 数据渗出（Exfiltration）
攻击者试图窃取受害者的数据

| ID | 名称 | 描述 | Ref |
| :-- | :-- | :-- | :-- |
| T1020 | 自动渗出（Automated Exfiltration）| 攻击者在攻击过程中自动收集并传输受害者数据到攻击者控制的资源上 | [链接](https://attack.mitre.org/techniques/T1020) |
| T1020.001 | 流量镜像（Traffic Duplication）| 攻击者利用流量复制或镜像自动获取受害者的流量 | [链接](https://attack.mitre.org/techniques/T1020/001) |
| T1030 | 数据传输大小限制（Data Transfer Size Limits）| 攻击者可能会限制传输数据包的大小 | [链接](https://attack.mitre.org/techniques/T1030) |
| T1048 | 使用数据信道渗出（Exfiltration Over Alternative Protocol）| 攻击者不使用远控的通信信道，而使用独立的数据信道传输数据 | [链接](https://attack.mitre.org/techniques/T1048) |
| T1048.001 | 对称加密数据信道（Exfiltration Over Symmetric Encrypted Non-C2 Protocol）| 攻击者使用对称加密算法对数据信道进行加密 | [链接](https://attack.mitre.org/techniques/T1048/001) |
| T1048.002 | 非对称加密数据信道（Exfiltration Over Asymmetric Encrypted Non-C2 Protocol）| 攻击者使用非对称加密算法对数据信道进行加密 | [链接](https://attack.mitre.org/techniques/T1048/002) |
| T1048.003 | 未加密数据信道（Exfiltration Over Unencrypted Non-C2 Protocol）| 攻击者使用未加密的数据信道 | [链接](https://attack.mitre.org/techniques/T1048/003) |
| T1041 | 使用远控信道渗出（Exfiltration Over C2 Channel）| 攻击者利用远控信道来传输数据 | [链接](https://attack.mitre.org/techniques/T1041) |
| T1011 | 使用网络媒介渗出（Exfiltration Over Other Network Medium）| 攻击者使用网络媒介（如：WIFI、4G、蓝牙、射频等）进行数据渗出 | [链接](https://attack.mitre.org/techniques/T1011) |
| T1011.001 | 使用蓝牙信道渗出（Exfiltration Over Bluetooth）| 攻击者使用蓝牙信道进行数据渗出 | [链接](https://attack.mitre.org/techniques/T1011/001) |
| T1052 | 使用物理媒介渗出（Exfiltration Over Physical Medium）| 攻击者使用物理媒介（如：SD卡、U盘、手机等）进行数据渗出 | [链接](https://attack.mitre.org/techniques/T1052) |
| T1052.001 | 使用USB信道渗出（Exfiltration over USB）| 攻击者使用USB设备进行数据渗出 | [链接](https://attack.mitre.org/techniques/T1052/001) |
| T1567 | 使用Web服务渗出（Exfiltration Over Web Service）| 攻击者使用合规的web服务（如：Google Drive、S3 Bucket等）进行数据渗出 | [链接](https://attack.mitre.org/techniques/T1567) |
| T1567.001 | 使用代码仓渗出（Exfiltration to Code Repository）| 攻击者利用代码仓（如Github）进行数据渗出 | [链接](https://attack.mitre.org/techniques/T1567/001) |
| T1567.002 | 使用云存储渗出（Exfiltration to Cloud Storage）| 攻击者利用云存储进行数据渗出 | [链接](https://attack.mitre.org/techniques/T1567/002) |
| T1029 | 定时传输（Scheduled Transfer）| 攻击者可能只在某些时刻进行数据传输 | [链接](https://attack.mitre.org/techniques/T1029) |
| T1537 | 使用云账户渗出（Transfer Data to Cloud Account）| 攻击者把受害者云账户中的资源导出到攻击者自己的云账户中 | [链接](https://attack.mitre.org/techniques/T1537) |

## 影响（Impact）
攻击者攻击所造成的影响，如篡改、中断或摧毁受害者的系统或数据

| ID | 名称 | 描述 | Ref |
| :-- | :-- | :-- | :-- |
| T1531 | 账户访问权限删除（Account Access Removal）| 攻击者通过删除、修改、锁定等方法阻止用户对系统的访问 | [链接](https://attack.mitre.org/techniques/T1531) |
| T1485 | 数据销毁（Data Destruction）| 攻击者对受害者系统上的数据进行销毁 | [链接](https://attack.mitre.org/techniques/T1485) |
| T1486 | 数据加密（Data Encrypted for Impact）| 攻击者对受害者的数据进行加密以进行勒索或破坏 | [链接](https://attack.mitre.org/techniques/T1486) |
| T1565 | 数据操纵（Data Manipulation）| 攻击者通过操纵（增删改查）目标系统中的数据来影响系统运行、业务逻辑或隐藏攻击痕迹等 | [链接](https://attack.mitre.org/techniques/T1565) |
| T1565.001 | 存储数据操纵（Stored Data Manipulation）| 攻击者对系统中的存储数据，如数据库、文件等进行操纵来影响系统运行、业务逻辑或隐藏攻击痕迹等 | [链接](https://attack.mitre.org/techniques/T1565/001) |
| T1565.002 | 传输数据操纵（Transmitted Data Manipulation）| 攻击者对系统网络中传输的数据进行操纵（如劫持网络连接）来影响系统运行、业务逻辑或隐藏攻击痕迹等 | [链接](https://attack.mitre.org/techniques/T1565/002) |
| T1565.003 | 运行数据操纵（Runtime Data Manipulation）| 攻击者对用户可访问的数据进行操纵来误导用户 | [链接](https://attack.mitre.org/techniques/T1565/003) |
| T1491 | 可见破坏（Defacement）| 攻击者利用各种方式（如图片）向受害者展示自己以达到炫耀、恐吓等作用 | [链接](https://attack.mitre.org/techniques/T1491) |
| T1491.001 | 内部可见破坏（Internal Defacement）| 攻击者在受害者环境内部展示自己以达到炫耀、恐吓等作用 | [链接](https://attack.mitre.org/techniques/T1491/001) |
| T1491.002 | 外部可见破坏（External Defacement）| 攻击者通过篡改受害者公网上的网站来展示自己以达到炫耀、恐吓等作用 | [链接](https://attack.mitre.org/techniques/T1491/002) |
| T1561 | 磁盘擦除（Disk Wipe）| 攻击者对受害者磁盘上的裸数据或数据结构（如MBR）进行擦除 | [链接](https://attack.mitre.org/techniques/T1561) |
| T1561.001 | 磁盘数据擦除（Disk Content Wipe）| 攻击者对受害者磁盘上的底层裸数据内容进行擦除 | [链接](https://attack.mitre.org/techniques/T1561/001) |
| T1561.002 | 磁盘结构擦除（Disk Structure Wipe）| 攻击者对受害者磁盘上的底层数据结构（如：MBR、分区信息等）进行擦除 | [链接](https://attack.mitre.org/techniques/T1561/002) |
| T1499 | 端点拒绝服务（Endpoint Denial of Service）| 攻击者对目标服务端点进行拒绝服务攻击以中断服务 | [链接](https://attack.mitre.org/techniques/T1499) |
| T1499.001 | 系统资源耗尽（OS Exhaustion Flood）| 攻击者试图耗尽端点服务所在操作系统的资源或使系统资源达到人为设定的限制值 | [链接](https://attack.mitre.org/techniques/T1499/001) |
| T1499.002 | 网络服务资源耗尽（Service Exhaustion Flood）| 攻击者试图耗尽端点网络服务的资源或使其达到认为设定的限制值（如：HTTP洪水、SSL握手/重协商攻击） | [链接](https://attack.mitre.org/techniques/T1499/002) |
| T1499.003 | 应用服务资源耗尽（Application Exhaustion Flood）| 攻击者试图耗尽应用服务的资源或使其达到认为设定的限制值 | [链接](https://attack.mitre.org/techniques/T1499/003) |
| T1499.004 | 应用或系统漏洞（Application or System Exploitation）| 攻击者利用应用软件或操作系统漏洞来实施拒绝服务攻击 | [链接](https://attack.mitre.org/techniques/T1499/004) |
| T1495 | 固件破坏（Firmware Corruption）| 攻击者通过破坏闪存中的固件（如：BIOS）使系统无法启动 | [链接](https://attack.mitre.org/techniques/T1495) |
| T1490 | 禁止系统恢复（Inhibit System Recovery）| 攻击者破坏系统的恢复机制（如：恢复服务、备份数据等）来禁止被破坏的系统复原 | [链接](https://attack.mitre.org/techniques/T1490) |
| T1498 | 网络拒绝服务（Network Denial of Service）| 攻击者利用大量的网络流量对目标进行拒绝服务攻击 | [链接](https://attack.mitre.org/techniques/T1498) |
| T1498.001 | 直接网络洪水（Direct Network Flood）| 攻击者直接向目标发送大量网络报文进行拒绝服务攻击 | [链接](https://attack.mitre.org/techniques/T1498/001) |
| T1498.002 | 反射放大（Reflection Amplification）| 攻击者利用第三方服务对目标进行拒绝服务攻击（如：DNS反射、NTP反射等）| [链接](https://attack.mitre.org/techniques/T1498/002) |
| T1496 | 资源掠夺（Resource Hijacking）| 攻击者利用受害者的资源进行耗资源类型的工作（如挖矿）| [链接](https://attack.mitre.org/techniques/T1496) |
| T1489 | 停止服务（Service Stop）| 攻击者通过停止或禁用服务进行拒绝服务攻击 | [链接](https://attack.mitre.org/techniques/T1489) |
| T1529 | 系统关机或重启（System Shutdown/Reboot）| 攻击者通过关机或重启的方式进行拒绝服务攻击 | [链接](https://attack.mitre.org/techniques/T1529) |