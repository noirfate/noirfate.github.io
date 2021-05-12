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
- [namedpipepth - 利用用户的NTLM-Hash以用户的身份执行命令](https://github.com/S3cur3Th1sSh1t/NamedPipePTH)
- [ligolo - 反向代理内网穿透工具](https://github.com/sysdream/ligolo)
- [reverse-tunnel - 反向代理内网穿透工具](https://github.com/snsinfu/reverse-tunnel)

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
- [mjet - java jmx利用工具](https://github.com/raystyle/mjet)
- [discover - 基于bash的渗透框架](https://github.com/leebaird/discover)
- [mimikatz - win渗透工具](https://github.com/gentilkiwi/mimikatz)
- [marshalsec - java远程利用工具，如jndi](https://github.com/mbechler/marshalsec)
- [kubesploit - k8s渗透工具](https://github.com/cyberark/kubesploit)
- [dwn - docker渗透工具集](https://github.com/sensepost/dwn)
- [hopla - burpsuite补全插件](https://github.com/synacktiv/HopLa)

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
- [photon - 爬虫工具](https://github.com/s0md3v/Photon)
- [linux kernel cve列表](https://github.com/nluedtke/linux_kernel_cves) [网站](https://linuxkernelcves.com/cves)
- [cve-pylib - 从redhat数据库中获取cve信息](https://github.com/RedHatProductSecurity/cve-pylib)

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
- [whaler - 从docker镜像推导出dockerfile](https://github.com/P3GLEG/Whaler)

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
- [pwin - 逃逸pin沙箱](https://github.com/zhechkoz/PwIN)
- [kdu - win内核驱动工具](https://github.com/hfiref0x/KDU)

## POC

### 合集

- [渗透漏洞利用收集](https://github.com/Mr-xn/Penetration_Testing_POC)
- [github上的poc收集](https://github.com/nomi-sec/PoC-in-GitHub)
- [exploitdb](https://github.com/offensive-security/exploitdb)
- [cve poc列表](https://github.com/qazbnm456/awesome-cve-poc)

### win

- [smbghost - win下smb协议漏洞CVE-2020-0796](https://github.com/ZecOps/CVE-2020-0796-RCE-POC)
- [win下符号链接测试工具](https://github.com/googleprojectzero/symboliclink-testing-tools)
- [wmi提权 - CVE-2020-0683](https://github.com/padovah4ck/CVE-2020-0683)
- [bluekeep - win rdp漏洞CVE-2019-0708](https://github.com/Ekultek/BlueKeep)
- [win内核漏洞列表](https://github.com/SecWiki/windows-kernel-exploits)
- [eternalblue - ms17-010](https://github.com/worawit/MS17-010)

### linux

- [chw00t - chroot逃逸](https://github.com/earthquake/chw00t)
- [几个可用于提权的linux内核漏洞](https://github.com/bcoles/kernel-exploits)
- [blueborne - 蓝牙漏洞CVE-2017-0781](https://github.com/ArmisSecurity/blueborne)
- [bluedroid - 蓝牙漏洞CVE-2017-13281](https://github.com/JiounDai/Bluedroid)
- [16~17年的几个linux内核漏洞](https://github.com/xairy/kernel-exploits)
- [dirtycow漏洞CVE-2016-5195](https://github.com/scumjr/dirtycow-vdso) [官方](https://github.com/dirtycow/dirtycow.github.io)
- [linux内核漏洞列表](https://github.com/SecWiki/linux-kernel-exploits)
- [linux waitid系统调用提权漏洞CVE-2017-5123](https://github.com/nongiach/CVE)
- [vsock漏洞CVE-2021-26708](https://github.com/jordan9001/vsock_poc)
- [linux sudo提权漏洞CVE-2021-3156](https://github.com/worawit/CVE-2021-3156)
- [ubuntu overlayfs 提权CVE-2021-3493](https://ssd-disclosure.com/ssd-advisory-overlayfs-pe/)

### container

- [fdpasser - 容器外非root账户利用容器中的root账户进行提权](https://github.com/FSecureLABS/fdpasser)
- [runc漏洞CVE-2019-5736](https://github.com/Frichetten/CVE-2019-5736-PoC) [另一个](https://github.com/q3k/cve-2019-5736-poc)

### virtualization

- [vmware漏洞利用资料](https://github.com/xairy/vmware-exploitation)
- [vmare vgpu漏洞](https://github.com/Comsecuris/vgpu_shader_pocs)
- [l1tf - guest读取host内存CVE-2018-3646](https://github.com/gregvish/l1tf-poc)
- [virtualbox vgpu漏洞](https://github.com/niklasb/3dpwn)
- [qemu nvme漏洞利用](https://github.com/hustdebug/scavenger)

### side channel

- [spectre swapgs - cpu侧信道攻击CVE-2019-1125](https://github.com/bitdefender/swapgs-attack-poc)
- [igpu leak - gpu信息泄露CVE-2019-14615](https://github.com/HE-Wenjian/iGPU-Leak)
- [ridl - cpu侧信道攻击](https://github.com/vusec/ridl)
- [meltdown](https://github.com/paboldin/meltdown-exploit)

### 其他

- [evilarc - 创建路径穿越压缩包](https://github.com/ptoomey3/evilarc)
- [pwn-mbr - mbr利用工具](https://github.com/DavidBuchanan314/pwn-mbr)
- [pwn2own2018 safari+macos](https://github.com/saelo/pwn2own2018)
- [brokentooth - 蓝牙漏洞CVE-2018-4327](https://github.com/omerporze/brokentooth)
- [clang cfi bypass](https://github.com/0xcl/clang-cfi-bypass-techniques)
- [个人发现的安卓漏洞集](https://github.com/ScottyBauer/Android_Kernel_CVE_POCs)
- [浏览器js引擎漏洞列表](https://github.com/tunz/js-vuln-db)
- [off-path tcp协议栈漏洞CVE-2016-5696](https://github.com/Gnoxter/mountain_goat) [另一个](https://github.com/violentshell/rover)
- [flink未授权rce](https://github.com/LandGrey/flink-unauth-rce)
- [grimm收集的漏洞列表](https://github.com/grimm-co/NotQuite0DayFriday)
- [qemu设备模拟利用模板](https://github.com/farazsth98/hypervisor_exploit_templates)

## 研究资料

- [win漏洞利用资料](https://github.com/yeyintminthuhtut/Awesome-Advanced-Windows-Exploitation-References)
- [linux漏洞利用资料](https://github.com/xairy/linux-kernel-exploitation)
- [安卓利用培训](https://github.com/cloudfuzz/android-kernel-exploitation)
- [electron安全研究资料](https://github.com/doyensec/awesome-electronjs-hacking)
- [侧信道研究资料](https://github.com/Yossioren/AttacksonImplementationsCourseBook)
- [安卓安全研究资料](https://github.com/alphaSeclab/android-security)
- [取证研究资料](https://github.com/alphaSeclab/awesome-forensics)
- [web安全研究资料](https://github.com/CHYbeta/Web-Security-Learning) [另一个](https://github.com/qazbnm456/awesome-web-security)
- [OSINT研究资料](https://github.com/jivoi/awesome-osint)
- [AI安全研究资料](https://github.com/DeepSpaceHarbor/Awesome-AI-Security)
- [ctf提权研究资料](https://github.com/Ignitetechnologies/Privilege-Escalation)
- [基带安全研究资料](https://github.com/lololosys/awesome-baseband-research)
- [IOT安全研究资料](https://github.com/fkie-cad/awesome-embedded-and-iot-security) [另一个](https://github.com/V33RU/IoTSecurity101)
- [win hook/rootkit开发资料](https://github.com/ExpLife0011/awesome-windows-kernel-security-development)
- [cloudflare博客相关代码](https://github.com/cloudflare/cloudflare-blog)
- [linux rootkit工具资料](https://github.com/milabs/awesome-linux-rootkits)
- [linux trace资料](https://github.com/goldshtn/linux-tracing-workshop)
- [kvm学习资料](https://github.com/david942j/kvm-kernel-example)
- [渗透学习资料](https://github.com/rutkai/pentest-bookmarks)
- [网络安全RSS](https://github.com/zer0yu/CyberSecurityRSS)
- [red teaming学习资料](https://github.com/yeyintminthuhtut/Awesome-Red-Teaming)
- [渗透学习资料](https://github.com/Ridter/Intranet_Penetration_Tips) [另一个](https://github.com/Techlord-RCE/Penetration-Testing)
- [恶意软件分析资料](https://github.com/rshipp/awesome-malware-analysis)
- [反汇编资料](https://github.com/nforest/awesome-decompilation)
- [对抗学习资料](https://github.com/yenchenlin/awesome-adversarial-machine-learning)
- [移动安全学习资料](https://github.com/secmobi/wiki.secmobi.com)
- [蜜罐资料](https://github.com/paralax/awesome-honeypots)
- [IOS越狱资料](https://github.com/zhengmin1989/GreatiOSJailbreakMaterial)
- [orangetw出的ctf web题](https://github.com/orangetw/My-CTF-Web-Challenges)
- [免费的编程教学资料](https://github.com/xiaoweiChen/free-programming-books-zh_CN)
- [makefile学习](https://github.com/yyluoyong/Make-3.8-Chinese-Manuals)
- [机器学习投毒研究](https://github.com/mitre/advmlthreatmatrix)
- [linux kernel hacking学习](https://github.com/xcellerator/linux_kernel_hacking)
- [trailofbits发表的文章集](https://github.com/trailofbits/publications)
- [c++程序分析逆向调试资料](https://github.com/MattPD/cpplinks)

## 防护

### 主机防护

- [lkrg - linux kernel runtime guard](https://github.com/openwall/lkrg)
- [vbh - 基于虚拟化技术的系统加固](https://github.com/intel/vbh)
- [bluespawn - 主机安全扫描监控工具](https://github.com/ION28/BLUESPAWN)
- [sysmonhunter - sysmon+attck监控](https://github.com/baronpan/SysmonHunter)
- [tyton - linux内核rootkit检测](https://github.com/nbulischeck/tyton)
- [agentsmith - 主机信息收集工具](https://github.com/bytedance/AgentSmith-HIDS)
- [tracee - 基于ebpf的系统监控工具](https://github.com/aquasecurity/tracee)

### 软件防护

- [antifuzz - 为c代码提供抵抗fuzz的功能](https://github.com/RUB-SysSec/antifuzz)
- [kpatch - linux内核热补](https://github.com/dynup/kpatch)
- [sandboxed-api - 为c/c++库提供沙箱保护](https://github.com/google/sandboxed-api)
- [linux内核加固地图](https://github.com/a13xp0p0v/linux-kernel-defence-map)
- [nsjail - linux进程隔离工具](https://github.com/google/nsjail)
- [chestnut - linux进程动态sandbox工具](https://github.com/chestnut-sandbox/Chestnut)

### 集群防护

- [cilium - k8s网络监控工具](https://github.com/cilium/cilium)
- [firecracker - 轻量级vm](https://github.com/firecracker-microvm/firecracker)
- [firekube - 基于firecracker的k8s](https://github.com/weaveworks/wks-quickstart-firekube)
- [kata-containers - 基于轻量级虚机的容器](https://github.com/kata-containers/kata-containers)
- [starboard - k8s安全扫描工具](https://github.com/aquasecurity/starboard)

### 其他

- [linux加固手册](https://madaidans-insecurities.github.io/guides/linux-hardening.html)
- [linux版的procmon](https://github.com/microsoft/ProcMon-for-Linux)