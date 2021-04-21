---
title: Useful Git Repository
layout: post
categories: git
tags: git
date: 2021-04-19 18:00
excerpt: useful git repository
---

# Useful Git Repository

> 学习记录存档，不定时更新

{:.table-of-content}
* TOC
{:toc}

## 逆向调试

### IDA插件

- [逆向go程序IDA辅助脚本golang_loader_assist](https://github.com/strazzere/golang_loader_assist)
- [IDA C++ vtable插件](https://github.com/0xgalz/Virtuailor)
- [IDA资源收集](https://github.com/xrkk/awesome-ida)
- [IDA插件 - 高亮反编译代码对应的汇编](https://github.com/patois/dsync)
- [IDA diff插件diaphora](https://github.com/joxeankoret/diaphora)
- [IDA函数调用关系优化插件](https://github.com/hasherezade/ida_ifl)
- [IDA插件](https://github.com/tacnetsol/ida)
- [IDA插件 - 导出dwarf格式的调试信息](https://github.com/ALSchwalm/dwarfexport)
- [IDA插件 - 指令修改](https://github.com/keystone-engine/keypatch)
- [IDA插件 - 反汇编成c++代码](https://github.com/REhints/HexRaysCodeXplorer)
- [IDA覆盖度插件lighthouse - 支持DynamoRIO、Pin、Frida、sancov等格式](https://github.com/gaasedelen/lighthouse)
- [IDA插件 - 通过运行时信息恢复虚函数名称](https://github.com/murx-/devi)

### Ghidra插件

- [把angr符号执行工具集成进Ghidra - AngryGhidra](https://github.com/Nalen98/AngryGhidra)
- [Ghidra覆盖度显示插件Dragon Dance-支持pin和Dynamorio](https://github.com/0ffffffffh/dragondance)
- [Ghidra脚本](https://github.com/PAGalaxyLab/ghidra_scripts)
- [Ghidra脚本](https://github.com/kc0bfv/Saintcon2019GhidraTalk)
- [Ghidra pathdiff插件](https://github.com/threatrack/ghidra-patchdiff-correlator)
- [Ghidra脚本](https://github.com/ghidraninja/ghidra_scripts)
- [Ghidra插件 - 对象结构恢复](https://github.com/grimm-co/GEARSHIFT)

### GDB扩展

- [gdb webui](https://github.com/rohanrhu/gdb-frontend)
- [集成了angr符号执行工具的gdb](https://github.com/andreafioraldi/angrgdb)
- [调试工具pwndbg](https://github.com/pwndbg/pwndbg)
- [gdb管道插件shell-pipe - 把gdb输出传给shell命令](https://github.com/hq6/GdbShellPipe)
- [gdb堆分析插件salt](https://github.com/PaoloMonti42/salt)
- [基于tcp的linux内核调试模块kgdboe](https://github.com/sysprogs/kgdboe)
- [gdb前端cgdb 适合源码调试](https://github.com/cgdb/cgdb)
- [gdb可利用性检测插件exploitable](https://github.com/jfoote/exploitable)

### 逆向分析工具

- [内存取证框架volatility](https://github.com/volatilityfoundation/volatility)
- [固件分析工具binbloom](https://github.com/quarkslab/binbloom)
- [从头文件生成Frida trace配置](https://github.com/nowsecure/frida-trace)
- [linux内存提取模块LiME](https://github.com/504ensicsLabs/LiME)
- [逆向调试框架cutter](https://github.com/radareorg/cutter)
- [把二进制程序转换成LLVM IR的工具mcsema - 支持patching、fuzzing、symbolic executing](https://github.com/lifting-bits/mcsema)
- [符号执行工具klee](https://github.com/lifting-bits/klee)
- [跨平台执行工具usercorn - 类似qemu-user](https://github.com/lunixbochs/usercorn)
- [固件模拟运行框架firmadyne](https://github.com/firmadyne/firmadyne)
- [二进制静态分析框架pharos](https://github.com/cmu-sei/pharos)
- [二进制分析框架bap](https://github.com/BinaryAnalysisPlatform/bap)
- [路由器利用平台](https://github.com/threat9/routersploit)
- [基于Unicorn的二进制动态分析工具flare-emu](https://github.com/fireeye/flare-emu)
- [虚拟化二进制动态分析工具DECAF - 支持污点追踪、动态插桩等](https://github.com/decaf-project/DECAF)
- [逆向框架r2](https://github.com/radareorg/radare2)
- [二进制静态分析工具bincat](https://github.com/airbus-seclab/bincat)
- [基于QEMU的逆向动态分析工具pyrebox](https://github.com/Cisco-Talos/pyrebox)
- [二进制分析修改调试工具miasm](https://github.com/cea-sec/miasm)
- [二进制分析框架barf - 支持Z3和CVC4符号执行工具](https://github.com/programa-stic/barf-project)
- [逆向分析工具panda](https://github.com/panda-re/panda)
- [二进制模拟执行框架qiling](https://github.com/qilingframework/qiling)
- [在docker里运行安卓程序](https://github.com/aind-containers/aind)
- [通过virtualbox虚机进行系统跟踪调试工具icebox](https://github.com/thalium/icebox)
- [arm固件模拟平台工具armx](https://github.com/therealsaumil/armx)
- [s2e符号执行平台](https://github.com/S2E/qemu)

### binary改写

- [PE编辑工具PEzor-注入、反调试等](https://github.com/phra/PEzor)
- [ELF修改工具-替换其中函数](https://github.com/lifting-bits/fennec)
- [把其他cpu架构的二进制转换为本机架构的工具](https://github.com/revng/revng)
- [二进制重写工具E9Patch](https://github.com/GJDuck/e9patch)

### 反编译工具

- [java反编译工具jadx](https://github.com/skylot/jadx)
- [反汇编工具ddisasm - 可以准确的再编译回去](https://github.com/GrammaTech/ddisasm)
- [字节码反编译工具GDA - 支持apk、dex、jar等](https://github.com/charles2gan/GDA-android-reversing-Tool)

### 分析工具

- [USB分析工具Hidviz](https://github.com/ondrejbudai/hidviz)
- [检查可执行程序或内核的安全编译属性](https://github.com/slimm609/checksec.sh)
- [win下通过hook ETW session来hook系统调用](https://github.com/everdox/InfinityHook)
- [win下虚拟化驱动 用来监测系统各种运行信息](https://github.com/tandasat/HyperPlatform)
- [基于web的代码查看工具](https://github.com/woboq/woboq_codebrowser)
- [win系统调用表](https://github.com/j00ru/windows-syscalls)
- [Linux内存扫描工具](https://github.com/rek7/mXtract)
- [USB抓包工具usbpcap](https://github.com/desowin/usbpcap)
- [win内核研究工具](https://github.com/AxtMueller/Windows-Kernel-Explorer)
- [内存分析工具rekall](https://github.com/google/rekall)
- [IOS分析工具](https://github.com/chaitin/passionfruit)
- [IDA命令行工具](https://github.com/nccgroup/idahunt)
- [恶意程序分析沙箱speakeasy](https://github.com/fireeye/speakeasy)
- [固件提取工具binwalk](https://github.com/ReFirmLabs/binwalk)
- [安卓应用层抓包工具](https://github.com/r0ysue/r0capture)
- [FIDL - 对IDA反汇编工具的脚本封装](https://github.com/fireeye/FIDL)
- [协议逆向工具集](https://github.com/techge/PRE-list)
- [通过深度学习的方法猜测无符号信息二进制程序中的函数名](https://github.com/tech-srl/Nero)
- [恶意程序检测工具capa](https://github.com/fireeye/capa)

### 调试工具

- [python调试器pdbpp](https://github.com/pdbpp/pdbpp)
- [汇编调试器SASM](https://github.com/Dman95/SASM)
- [record-replay调试工具rr](https://github.com/rr-debugger/rr)
- [基于libvmi调试虚机中运行的程序](https://github.com/Wenzel/pyvmidbg)
- [python静态代码检查工具](https://github.com/python-security/pyt)
- [ROP查找工具rp++](https://github.com/0vercl0k/rp)
- [python函数执行跟踪工具PySnooper](https://github.com/cool-RR/PySnooper)
- [Ghidra - NSA开源的逆向工具](https://github.com/NationalSecurityAgency/ghidra)
- [为gdb和vs调试提供webui](https://github.com/MicrosoftEdge/JsDbg)
- [xen虚拟化调试器xendbg](https://github.com/nccgroup/xendbg)
- [ROP查找工具ROPgadget](https://github.com/JonathanSalwan/ROPgadget)
- [动态插桩工具frida](https://github.com/frida/frida)
- [cisco asa调试工具](https://github.com/nccgroup/asatools)
- [ROP查找工具Ropper](https://github.com/sashs/Ropper)

### 其他

- [内存运行ELF工具memrun](https://github.com/guitmz/memrun)
- [Linux下改变进程内存权限的工具](https://github.com/perceptionpoint/suprotect)
- [Linux下的调试器qira - 支持回溯](https://github.com/geohot/qira)
- [angr扩展工具](https://github.com/axt/angr-utils)
- [glibc利用技巧](https://github.com/shellphish/how2heap)
- [win10低碎片堆测试用例](https://github.com/corelan/win10_heap)
- [win10低碎片堆堆喷示例](https://github.com/saaramar/Deterministic_LFH)
- [anc侧信道攻击工具](https://github.com/vusec/revanc)
- [glibc tcache利用方法](https://github.com/StarCross-Tech/heap_exploit_2.31)

## Fuzz

### AFL/LibFuzzer系

- [afl++ - 集成了多种对afl的改进](https://github.com/AFLplusplus/AFLplusplus)
- [onefuzz - CI/CD fuzz服务](https://github.com/microsoft/onefuzz)
- [kafl - 使用intel pt加速](https://github.com/IntelLabs/kAFL)
- [redqueen - kafl+符号执行](https://github.com/RUB-SysSec/redqueen)
- [symcc - 在编译时插入符号执行代码从而加快符号执行的速度，可以和afl结合使用](https://github.com/eurecom-s3/symcc)
- [memlock-fuzz - 基于内存使用指导的fuzzer](https://github.com/wcventure/MemLock-Fuzz)
- [aflnet - 利用afl进行网络协议fuzz](https://github.com/aflnet/aflnet)
- [manul - 并行fuzzer](https://github.com/mxmssh/manul)
- [periscope - fuzz硬件和OS之间的接口](https://github.com/securesystemslab/periscope)

### Syzkaller系

- [Agamotto - 使用checkpoint提高虚机fuzz效率](https://github.com/securesystemslab/agamotto)
- [harbian - 增加权重、状态和webui](https://github.com/hardenedlinux/harbian-qa)

### sanitizer

- [ktsan - kernel thread sanitizer](https://github.com/google/ktsan)
- [qasan - asan based on qemu](https://github.com/andreafioraldi/qasan)
- [centos-kasan - 为centos7内核提供asan支持](https://github.com/kernelim/centos-kasan)
- [drsancov - 在DynamoRIO中实现asan功能](https://github.com/googleprojectzero/DrSancov)

### 其他

- [intel PT工具](https://github.com/nyx-fuzz/libxdc)
- [magma - fuzzer性能评测工具](https://github.com/HexHive/magma)
- [FuzzGen - 通过分析对库函数api的使用，自动生成fuzz库函数的代码](https://github.com/HexHive/FuzzGen)
- [fisy-fuzz - 文件系统fuzzer](https://github.com/0xricksanchez/fisy-fuzz)
- [frankenstein - 为无线固件提供fuzz的虚拟环境](https://github.com/seemoo-lab/frankenstein)
- [vfuzz - 集成多种反馈机制的fuzzer](https://github.com/guidovranken/vfuzz)
- [二进制动态插桩资料收集](https://github.com/alphaSeclab/DBI-Stuff)
- [fuzzer性能测试](https://github.com/google/fuzzbench)
- [ltp - linux内核自动化测试](https://github.com/linux-test-project/ltp)
- [atfuzzer - 安卓AT命令fuzzer](https://github.com/Imtiazkarimik23/ATFuzzer)
- [deepstate - 类似gtest的单元测试框架，支持符号执行、afl等](https://github.com/trailofbits/deepstate)
- [google的fuzz tutorials](https://github.com/google/fuzzing)
- [fuzzit - 集成测试框架](https://github.com/fuzzitdev/fuzzit)
- [fuzzing meetup会议资料](https://github.com/FuzzTesting/BayAreaMeetup)
- [virtme - 轻量级内核虚拟化，方便测试内核](https://github.com/amluto/virtme)