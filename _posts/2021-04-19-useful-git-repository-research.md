---
title: Useful Git Repository (研究篇)
layout: post
categories: git
tags: git
date: 2021-04-19 18:00
excerpt: useful git repository (研究篇)
---

# Useful Git Repository (研究篇)

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
- [FIDL - 对IDA反汇编工具的脚本封装](https://github.com/fireeye/FIDL)

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
- [污点追踪工具taintgrind](https://github.com/wmkhoo/taintgrind)
- [在qemu里运行macOS](https://github.com/foxlet/macOS-Simple-KVM)
- [p-joker - IOS分析工具](https://github.com/lilang-wu/p-joker)
- [vmhunt - 使用pin记录程序的trace并分析](https://github.com/s3team/VMHunt)
- [使用z3和angr进行程序分析的示例](https://github.com/FSecureLABS/z3_and_angr_binary_analysis_workshop)
- [跨平台插桩框架qbdi](https://github.com/QBDI/QBDI)
- [rvmi - 基于虚拟化的系统分析工具](https://github.com/fireeye/rvmi)
- [符号执行工具z3](https://github.com/Z3Prover/z3)
- [协议逆向工具netzob](https://github.com/netzob/netzob)
- [动态二进制分析框架triton，支持符号执行、污点追踪等](https://github.com/JonathanSalwan/Triton)
- [二进制分析框架angr](https://github.com/angr/angr)
- [firmware_slap - 固件漏洞挖掘工具](https://github.com/ChrisTheCoolHut/Firmware_Slap)

### binary改写

- [PE编辑工具PEzor-注入、反调试等](https://github.com/phra/PEzor)
- [ELF修改工具-替换其中函数](https://github.com/lifting-bits/fennec)
- [把其他cpu架构的二进制转换为本机架构的工具](https://github.com/revng/revng)
- [二进制重写工具E9Patch](https://github.com/GJDuck/e9patch)
- [retrowrite - 为binary添加asan插桩，只支持x86_64、必须没有被strip](https://github.com/HexHive/retrowrite)
- [syzygy - win下插桩工具集](https://github.com/google/syzygy)
- [LIEF - 分析修改多平台的binary](https://github.com/lief-project/LIEF)

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
- [协议逆向工具集](https://github.com/techge/PRE-list)
- [通过深度学习的方法猜测无符号信息二进制程序中的函数名](https://github.com/tech-srl/Nero)
- [恶意程序检测工具capa](https://github.com/fireeye/capa)
- [虚拟机插桩库libvmi](https://github.com/libvmi/libvmi)
- [SVF - 源码分析工具](https://github.com/SVF-tools/SVF)
- [微软开发的攻击面分析工具](https://github.com/microsoft/AttackSurfaceAnalyzer)
- [tripledoggy - 使用符号执行进行源码分析的工具](https://github.com/GoSSIP-SJTU/TripleDoggy)
- [membugtool - 使用pin检测程序的堆相关的内存错误](https://github.com/joxeankoret/membugtool)
- [symbiotic - 源码检查工具](https://github.com/staticafi/symbiotic)
- [kcov - 程序运行覆盖度收集工具](https://github.com/SimonKagstrom/kcov)

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
- [bugid - win下bug分类工具，类似exploitable](https://github.com/SkyLined/BugId)
- [rex - crash分析工具](https://github.com/angr/rex)

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
- [使用qemu运行macos](https://github.com/kholia/OSX-KVM)

## Fuzz

### AFL/LibFuzzer系

- [afl++ - 集成了多种对afl的改进](https://github.com/AFLplusplus/AFLplusplus)
- [winafl - afl的win版](https://github.com/googleprojectzero/winafl)
- [onefuzz - CI/CD fuzz服务](https://github.com/microsoft/onefuzz)
- [kafl - 使用intel pt加速](https://github.com/IntelLabs/kAFL)
- [redqueen - kafl+符号执行](https://github.com/RUB-SysSec/redqueen)
- [symcc - 在编译时插入符号执行代码从而加快符号执行的速度，可以和afl结合使用](https://github.com/eurecom-s3/symcc)
- [symqemu - 基于symcc和qemu的符号执行和fuzz工具](https://github.com/eurecom-s3/symqemu)
- [memlock-fuzz - 基于内存使用指导的fuzzer](https://github.com/wcventure/MemLock-Fuzz)
- [aflnet - 利用afl进行网络协议fuzz](https://github.com/aflnet/aflnet)
- [manul - 并行fuzzer](https://github.com/mxmssh/manul)
- [periscope - fuzz硬件和OS之间的接口](https://github.com/securesystemslab/periscope)
- [unicorefuzz - 基于UnicornAFL和AFL++的内核fuzzer，可针对单个函数或CFG进行fuzz](https://github.com/fgsect/unicorefuzz)
- [qsym - 混合执行fuzzer，afl+符号执行](https://github.com/sslab-gatech/qsym)
- [autopwn - 为afl添加自动自动化样本精简功能](https://github.com/bannsec/autoPwn)
- [janus - 基于afl的文件系统fuzzer](https://github.com/sslab-gatech/janus)
- [phuzzer - 混合执行fuzzer，afl+driller](https://github.com/angr/phuzzer)
- [pe-afl - win版afl](https://github.com/wmliang/pe-afl)
- [angora - 使用污点追踪的方法解决路径约束](https://github.com/AngoraFuzzer/Angora)
- [drafl - 为afl增添DynamoRIO支持](https://github.com/mxmssh/drAFL)
- [ptfuzzer - 为afl增加intel pt支持](https://github.com/hunter-ht-2018/ptfuzzer)
- [afl-unicorn - 为afl增加unicorn支持](https://github.com/Battelle/afl-unicorn)
- [kleefl - 使用符号执行为afl生成样本](https://github.com/julieeen/kleefl)
- [aflgo - 可以指定要fuzz的程序路径的afl](https://github.com/aflgo/aflgo)
- [kafl - 基于qemu和intel pt的内核fuzz](https://github.com/RUB-SysSec/kAFL)
- [afl.rs - 使用afl来fuzz rust代码](https://github.com/rust-fuzz/afl.rs)
- [honggfuzz - 与afl类似的fuzzer](https://github.com/google/honggfuzz)
- [honeybee - 快速inter pt库，可集成进honggfuzz](https://github.com/trailofbits/Honeybee)
- [afl-sancov - afl覆盖度工具](https://github.com/bshastry/afl-sancov)
- [driller-afl - afl混合执行fuzz](https://github.com/shellphish/driller-afl)
- [shellphish-fuzz - 运行driller-afl的工具](https://github.com/shellphish/fuzzer)
- [android-afl - 利用afl fuzz安卓程序](https://github.com/ele7enxxh/android-afl)
- [go-fuzz - fuzz go语言](https://github.com/dvyukov/go-fuzz)
- [aflpin - 为afl增加pin支持](https://github.com/mothran/aflpin)
- [afl-utils - afl工具集](https://gitlab.com/rc0r/afl-utils)
- [afl-xen - afl+xen+libvmi实现内核fuzz](https://github.com/intel/kernel-fuzzer-for-xen-project)
- [efi-fuzz - afl+qiling实现uefi固件fuzz](https://github.com/Sentinel-One/efi_fuzz)
- [crashwalk - 遍历afl产生的crash，计算hash，写入db](https://github.com/bnagy/crashwalk)
- [afl_inmemory - 针对程序局部fuzz](https://github.com/s0i37/afl_inmemory)
- [winafl_inmemory - win下afl_inmemory](https://github.com/s0i37/winafl_inmemory)
- [perf-fuzz - 通过给内核增加snapshot功能为afl加快fuzz速度](https://github.com/sslab-gatech/perf-fuzz)
- [caveman4 - 使用ptrace实现程序snapshot加快fuzz速度](https://github.com/h0mbre/Fuzzing/tree/master/Caveman4)
- [fairfuzz - 引导afl去fuzz较少触发的分支](https://github.com/carolemieux/afl-rb)
- [mopt-afl - 使用粒子群算法优化afl](https://github.com/puppet-meteor/MOpt-AFL)
- [afl相关fuzzer整理](https://github.com/Microsvuln/Awesome-AFL)
- [jazzer - 基于libfuzzer的java fuzz工具](https://github.com/CodeIntelligenceTesting/jazzer)
- [libfuzzer培训](https://github.com/Dor1s/libfuzzer-workshop)
- [oss-fuzz - google的开源软件fuzz框架](https://github.com/google/oss-fuzz)
- [sockfuzzer - xnu网络协议栈fuzz](https://github.com/googleprojectzero/SockFuzzer)

### Syzkaller系

- [syzkaller - 好用的内核fuzz工具](https://github.com/google/syzkaller)
- [Agamotto - 使用checkpoint提高虚机fuzz效率](https://github.com/securesystemslab/agamotto)
- [harbian - 增加权重、状态和webui](https://github.com/hardenedlinux/harbian-qa)
- [moonshine - 为syzkaller生成seed](https://github.com/shankarapailoor/moonshine)

### sanitizer

- [ktsan - kernel thread sanitizer](https://github.com/google/ktsan)
- [qasan - asan based on qemu](https://github.com/andreafioraldi/qasan)
- [centos-kasan - 为centos7内核提供asan支持](https://github.com/kernelim/centos-kasan)
- [drsancov - 在DynamoRIO中实现asan功能](https://github.com/googleprojectzero/DrSancov)
- [cmpcov - c/c++插桩工具，用来提取程序中有关数据比较的信息](https://github.com/googleprojectzero/CompareCoverage)
- [bitype - 类型混淆检测](https://github.com/bin2415/Bitype)
- [vzkernel - 集成asan的3.10内核](https://github.com/OpenVZ/vzkernel)

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
- [grizzly - firefox出的浏览器fuzzer](https://github.com/MozillaSecurity/grizzly)
- [avalanche - 上下文无关的、基于自定义语法的样本生成器](https://github.com/MozillaSecurity/avalanche)
- [对内核历史bug进行分析找出出现最多的错误类型、bug最多的程序等](https://github.com/SergeyStaroletov/LinuxKernelAnalysis)
- [codealchemist - 基于语法的js fuzzer](https://github.com/SoftSec-KAIST/CodeAlchemist)
- [fuzzilli - 基于自定义的中间语言自动生成目标脚本代码，如js](https://github.com/googleprojectzero/fuzzilli)
- [neuzz - 基于神经网络的fuzzer](https://github.com/Dongdongshe/neuzz)
- [kitty - 模块化fuzz框架](https://github.com/cisco-sas/kitty)
- [halfempty - 样本精简工具](https://github.com/googleprojectzero/halfempty)
- [bochspwn - 使用bochs虚拟化工具进行内核fuzz](https://github.com/googleprojectzero/bochspwn-reloaded)
- [dharma - 基于语法生成测试样本](https://github.com/MozillaSecurity/dharma)
- [vusbf - 利用qemu的流量重定向功能实现usb协议fuzz](https://github.com/schumilo/vUSBf)
- [osxfuzz - macos内核fuzz](https://github.com/FSecureLABS/OSXFuzz)
- [domato - 基于语法生成的dom fuzz](https://github.com/googleprojectzero/domato)
- [用来测试fuzz benchmark的用例](https://github.com/google/fuzzer-test-suite)
- [crete - 混合执行框架](https://github.com/SVL-PSU/crete-dev)
- [openxmolar - office openxml fuzzer](https://github.com/debasishm89/OpenXMolar)
- [win下intel pt工具](https://github.com/intelpt/WindowsIntelPT)
- [vuzzer - 基于pin的污点追踪工具](https://github.com/vusec/vuzzer)
- [boofuzz - 基于sulley扩展的协议fuzz](https://github.com/jtpereyda/boofuzz)
- [gueb - 静态分析binary发现uaf漏洞](https://github.com/montyly/gueb)
- [trinity - linux系统调用fuzz](https://github.com/kernelslacker/trinity)
- [aegg - 自动生成利用的工具，仅支持x86](https://github.com/YSc21/aegg)
- [nosy-newt - 基于triton的混合执行fuzz](https://github.com/CIFASIS/nosy-newt)
- [grinder - 浏览器fuzz](https://github.com/stephenfewer/grinder)
- [fuzz相关资料](https://github.com/cpuu/awesome-fuzzing)
- [leak-kptr - linux内核信息泄露利用工具](https://github.com/haehyun/leak-kptr)
- [bpf-fuzzer - 把bpf验证移到用户态进行fuzz](https://github.com/iovisor/bpf-fuzzer)
- [fuzz-lightyear - swagger api fuzzer](https://github.com/Yelp/fuzz-lightyear)
- [atheris - fuzz python code](https://github.com/google/atheris)
- [jsfuzz - fuzz js](https://github.com/fuzzitdev/jsfuzz)
- [JQF - fuzz java](https://github.com/rohanpadhye/JQF)
- [jackalope - win和mac下的覆盖度反馈黑盒fuzz](https://github.com/googleprojectzero/Jackalope)
- [formatfuzzer - 基于010editor模板生成样本进行fuzz](https://github.com/uds-se/FormatFuzzer)
- [bonsai - 编译器fuzz](https://github.com/vasumv/bonsai-fuzzing)
- [regexploit - fuzz正则表达式解析引擎](https://github.com/doyensec/regexploit)