---
title: Useful Git Repository (攻防篇)
layout: post
categories: git
tags: git
date: 2021-04-23 18:00
excerpt: useful git repository (攻防篇)
---

# Useful Git Repository (攻防篇)

> 学习记录存档，不定时更新

{:.table-of-content}
* TOC
{:toc}

## 渗透

### 网络扫描工具

- [masscan - 高性能端口扫描工具](https://github.com/robertdavidgraham/masscan)
- [wifite2 - wifi扫描攻击工具](https://github.com/derv82/wifite2)
- [dirmap - web目录扫描工具](https://github.com/H4ckForJob/dirmap)
- [feroxbuster - web文本扫描工具](https://github.com/epi052/feroxbuster)
- [xray - web漏洞扫描工具](https://github.com/chaitin/xray)
- [masscan-nmap - masscan扫描端口并用nmap识别服务](https://github.com/7dog7/masscan_to_nmap)
- [nuclei - 漏洞扫描工具](https://github.com/projectdiscovery/nuclei)
- [tsunami - 漏洞扫描工具](https://github.com/google/tsunami-security-scanner)

### 本地扫描工具

- [linenum - 主机敏感文件扫描](https://github.com/rebootuser/LinEnum)
- [roothelper - 提权辅助工具](https://github.com/NullArray/RootHelper)
- [trufflehog - git仓库敏感信息扫描](https://github.com/dxa4481/truffleHog)
- [vulmap - 扫描本机漏洞，从vulmon.com上获取漏洞信息](https://github.com/vulmon/Vulmap)
- [kernelpop - linux&mac内核漏洞扫描利用工具](https://github.com/spencerdodd/kernelpop)
- [mimipenguin - dump linux桌面用户密码](https://github.com/huntergregal/mimipenguin)
- [rpcview - win下查看rpc的工具](https://github.com/silverf0x/RpcView)
- [docker-bech-security - docker安全配置检查，类似CIS Docker Benchmark](https://github.com/docker/docker-bench-security)
- [openssh-seseeion-key-recovery - openssh会话密钥恢复](https://github.com/fox-it/OpenSSH-Session-Key-Recovery)

### 远控工具

- [serval - 反弹shell工具](https://github.com/tgadola/serval)
- [salsa-tools - win反弹shell工具](https://github.com/Hackplayers/Salsa-tools)
- [merlin - 跨平台c2工具](https://github.com/Ne0nd0g/merlin)

### 渗透工具/框架

- [fsociety - 渗透测试框架，包含多种渗透工具](https://github.com/Manisso/fsociety)
- [commando-vm - win渗透虚拟机](https://github.com/fireeye/commando-vm)
- [bloodhound - 域渗透工具](https://github.com/BloodHoundAD/BloodHound)
- [monkey - 扫描渗透框架](https://github.com/guardicore/monkey)
- [nullsecurity的渗透工具集](https://github.com/nullsecuritynet/tools)
- [metasploit - 渗透框架](https://github.com/rapid7/metasploit-framework)
- [linux-exploit-suggester - linux漏洞利用工具](https://github.com/jondonas/linux-exploit-suggester-2)
- [hadoop-attack-library - hadoop渗透工具](https://github.com/wavestone-cdt/hadoop-attack-library)
- [红队工具集](https://github.com/infosecn1nja/Red-Teaming-Toolkit)
- [winpwn - 基于powershell的win渗透工具](https://github.com/S3cur3Th1sSh1t/WinPwn)
- [springbootvulexploit - sprintboot框架渗透](https://github.com/LandGrey/SpringBootVulExploit)
- [jmet - java jms渗透工具](https://github.com/matthiaskaiser/jmet)
- [discover - 基于bash的渗透框架](https://github.com/leebaird/discover)
- [mimikatz - win渗透工具](https://github.com/gentilkiwi/mimikatz)
- [marshalsec - java远程利用工具，如jndi](https://github.com/mbechler/marshalsec)
- [kubesploit - k8s渗透工具](https://github.com/cyberark/kubesploit)

### 持久化工具

- [reptile - 基于linux内核模块的rootkit](https://github.com/f0rb1dd3n/Reptile)
- [rootkits集合](https://github.com/d30sa1/RootKits-List-Download)
- [rootkit培训](https://github.com/NoviceLive/research-rootkit)
- [brootkit - 使用bash实现的rootkit工具](https://github.com/cloudsec/brootkit)
- [免杀webshell](https://github.com/LandGrey/webshell-detect-bypass)

### OSINT(开源情报)工具

- [cve-search - cve数据库](https://github.com/cve-search/cve-search)
- [vulncode-db - cve数据库](https://github.com/google/vulncode-db)
- [hackertarget - ip/域名信息收集工具](https://github.com/abaykan/53R3N17Y)
- [findsploit - 利用查找脚本](https://github.com/1N3/Findsploit)
- [google-hacking-database - 使用google搜索脆弱服务的技巧](https://www.exploit-db.com/google-hacking-database)
- [数据泄露、供应链攻击事件整理](https://github.com/ffffffff0x/Dork-Admin)
- [opencve - cve订阅预警工具](https://github.com/opencve/opencve)
- [threatingestor - 情报收集工具](https://github.com/InQuest/ThreatIngestor)

### 云原生渗透工具

- [trivy - 容器镜像漏洞扫描工具](https://github.com/aquasecurity/trivy)
- [kube-hunter - k8s弱点扫描](https://github.com/aquasecurity/kube-hunter)
- [cloudgoat - aws渗透工具](https://github.com/RhinoSecurityLabs/cloudgoat)
- [ScoutSuite - 云安全审计工具，支持亚马逊、微软、谷歌、阿里](https://github.com/nccgroup/ScoutSuite)
- [云安全工具集](https://cloudberry.engineering/tool/)
- [cdk - docker&k8s利用工具](https://github.com/cdk-team/CDK)
- [s3-account-search - 通过可访问的s3桶暴力破解出aws账户id](https://github.com/WeAreCloudar/s3-account-search)
- [ccat - 各大云服务厂商容器渗透工具](https://github.com/RhinoSecurityLabs/ccat)
- [kubstriker - k8s安全扫描工具](https://github.com/vchinnipilli/kubestriker)

### 其他

- [渗透工具收集](https://github.com/dloss/python-pentest-tools)
- [kali常用命令](https://github.com/NoorQureshi/kali-linux-cheatsheet)
- [payloadallthethings - 渗透工具、漏洞利用集合](https://github.com/swisskyrepo/PayloadsAllTheThings)
- [evilginx2 - 钓鱼工具](https://github.com/kgretzky/evilginx2)
- [leprechaun - netstat图像化工具](https://github.com/vonahisec/leprechaun)
- [car hacking tools](https://github.com/jgamblin/CarHackingTools)
- [trape - 钓鱼社工工具](https://github.com/jofpin/trape)
- [blind-bash - bash脚本混淆工具](https://github.com/Rizer0/Blind-Bash)
- [octopus - 区块链合约分析工具](https://github.com/pventuzelo/octopus)
- [pcileech - 内存dump工具](https://github.com/ufrisk/pcileech)
- [vmx-overloader - 利用vmware漏洞为win虚机内核加载无签名内核模块](https://github.com/ivildeed/vmw_vmx_overloader)
- [vulhub - 漏洞靶场](https://github.com/vulhub/vulhub)

## 防护

### 主机防护

- [lkrg - linux kernel runtime guard](https://github.com/openwall/lkrg)
- [vbh - 基于虚拟化技术的系统加固](https://github.com/intel/vbh)
- [bluespawn - 主机安全扫描监控工具](https://github.com/ION28/BLUESPAWN)
- [sysmonhunter - sysmon+attck监控](https://github.com/baronpan/SysmonHunter)
- [tyton - linux内核rootkit检测](https://github.com/nbulischeck/tyton)

### 软件防护

- [antifuzz - 为c代码提供抵抗fuzz的功能](https://github.com/RUB-SysSec/antifuzz)
- [kpatch - linux内核热补](https://github.com/dynup/kpatch)
- [sandboxed-api - 为c/c++库提供沙箱保护](https://github.com/google/sandboxed-api)