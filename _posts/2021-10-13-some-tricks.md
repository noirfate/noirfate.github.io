---
title: Some Tricks
layout: post
categories: tool
tags: tool trick
date: 2021-10-13 18:00
excerpt: Some Tricks
---

{:.table-of-content}
* TOC
{:toc}

# 工具

## Linux二进制程序打包
> linuxdploy 文档：https://docs.appimage.org/packaging-guide/from-source/linuxdeploy-user-guide.html

- 下载
	- [linuxdeploy](https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage)
	- [appimage](https://github.com/AppImage/AppImageKit/releases/download/13/appimagetool-x86_64.AppImage)
	- [appicon](https://github.com/linuxdeploy/linuxdeploy/blob/master/resources/linuxdeploy.png)
	- [appdesktop](https://github.com/linuxdeploy/linuxdeploy/blob/master/resources/linuxdeploy.desktop)

- 打包
假设要打包test程序
```bash
linuxdeploy-x86_64 --appdir appdir_test -e test -d linuxdeploy.desktop -i linuxdeploy.png
ln -s appdir_test/test appdir_test/AppRun or echo "#!/bin/bash\nexec $APPDIR/test $@"
appimagetool-x86_64.AppImage appdir_test test.appimage
```

- 运行
```bash
./test.appimage
# 如果没有fuse的话
./test.appimage --appimage-extract-and-run
```

# 系统

## 编写独立内核模块
> `struct module`结构保存在`.gnu.linkonce.this_module`段中，模块名称和内核版本保存在`.modinfo`段中，参考：https://itnext.io/a-standalone-linux-kernel-module-df54283d4803

- 找出init和exit函数在`struct module`中的偏移
code:
```c
#include <linux/init.h>
#include <linux/module.h>
#include <linux/kernel.h>
static int __init lkm_example_init(void) {
    //struct module *mod = THIS_MODULE;
    printk(KERN_INFO "0x%lx 0x%lx 0x%lx\n", sizeof(struct module), offsetof(struct module, init), offsetof(struct module, exit));
    printk(KERN_INFO "Hello, World!\n");
    return 0;
}
static void __exit lkm_example_exit(void) {
    printk(KERN_INFO "Goodbye, World!\n");
}
module_init(lkm_example_init);
module_exit(lkm_example_exit);
```
Makefile:
```makefile
obj-m += example.o
all:
    make -C /lib/modules/$(shell uname -r)/build M=$(PWD) modules
clean:
    make -C /lib/modules/$(shell uname -r)/build M=$(PWD) clean
```
```shell
insmod example.ko
dmesg | tail
```
得到`struct module`的大小为0x340，init的偏移为0x178，exit的偏移为0x308

- 找到printk的函数地址
```shell
cat /proc/kallsyms | grep -E "\bprintk$"
```
得到printk函数的地址为`ffffffff966f4270`

- 编写独立内核模块代码`test_mod.c`
```c
#define NAME "standalone"
#define VERMAGIC "4.15.0-135-generic SMP mod_unload "

__attribute__((section(".modinfo")))
char modinfo_strings[] =
"name=" NAME "\0"
"vermagic=" VERMAGIC;

#define KERN_SOH    "\001"      /* ASCII Start Of Header */
#define KERN_SOH_ASCII  '\001'

#define KERN_EMERG  KERN_SOH "0"    /* system is unusable */
#define KERN_ALERT  KERN_SOH "1"    /* action must be taken immediately */
#define KERN_CRIT   KERN_SOH "2"    /* critical conditions */
#define KERN_ERR    KERN_SOH "3"    /* error conditions */
#define KERN_WARNING    KERN_SOH "4"    /* warning conditions */
#define KERN_NOTICE KERN_SOH "5"    /* normal but significant condition */
#define KERN_INFO   KERN_SOH "6"    /* informational */
#define KERN_DEBUG  KERN_SOH "7"    /* debug-level messages */
int (*printk)(const char *fmt, ...) = 0xffffffff966f4270;

int my_init(void) {
    printk(KERN_INFO "Hello, World!\n");
    return 0;
}
void my_exit(void) {
    printk(KERN_INFO "Bye Bye!\n");
}

__attribute__((section(".gnu.linkonce.this_module")))
struct module {
    char __pad0[0x18];
    char name[sizeof(NAME)];
    char __pad1[0x178 - 0x18 - sizeof(NAME)];
    void *init;
    char __pad2[0x308 - 0x178 - sizeof(void*)];
    void *exit;
    char __pad3[0x340 - 0x308 - sizeof(void*)];
} __attribute__((packed))
__this_module = {
    .name = NAME,
    .init = my_init,
    .exit = my_exit,
};
```

- 编译`test_mod.c`
```shell
gcc -c test_mod.c -o test_mod.ko
```

- 插入模块
```shell
insmod test_mod.ko
dmesg | tail
lsmod | grep standalone
rmmod standalone
```

## 修改内核模块版本号

- 查看`example.ko`模块的版本信息
```shell
objdump -s -j .modinfo example.ko

example.ko:     file format elf64-x86-64

Contents of section .modinfo:
 0000 73726376 65727369 6f6e3d38 44374543  srcversion=8D7EC
 0010 38373342 34323930 39373931 34374338  873B4290979147C8
 0020 45440000 00000000 64657065 6e64733d  ED......depends=
 0030 00726574 706f6c69 6e653d59 006e616d  .retpoline=Y.nam
 0040 653d6578 616d706c 65007665 726d6167  e=example.vermag
 0050 69633d34 2e31352e 302d3133 352d6765  ic=4.15.0-135-ge
 0060 6e657269 6320534d 50206d6f 645f756e  neric SMP mod_un
 0070 6c6f6164 2000                        load .
```

- 保存.modinfo内容到文件
```shell
objcopy -O binary --only-section=.modinfo example.ko modinfo
```

- 使用vim编辑modinfo文件，修改版本号，在编辑时需要设置`:set bin`，否则在保存的时候会在行尾追加换行符
- 更新modinfo
```shell
objcopy --update-section .modinfo=modinfo example.ko
objdump -sj .modinfo example.ko

example.ko:     file format elf64-x86-64

Contents of section .modinfo:
 0000 73726376 65727369 6f6e3d38 44374543  srcversion=8D7EC
 0010 38373342 34323930 39373931 34374338  873B4290979147C8
 0020 45440000 00000000 64657065 6e64733d  ED......depends=
 0030 00726574 706f6c69 6e653d59 006e616d  .retpoline=Y.nam
 0040 653d6578 616d706c 65007665 726d6167  e=example.vermag
 0050 69633d33 2e31352e 302d3133 352d6765  ic=3.15.0-135-ge
 0060 6e657269 6320534d 50206d6f 645f756e  neric SMP mod_un
 0070 6c6f6164 2000                        load .
```

# 容器

# 网站

- https://data.stats.gov.cn (国家数据)
- https://apps.evozi.com/apk-downloader/  (从google play上下载apk)
- https://medium.com/marketingdatascience/selenium%E6%95%99%E5%AD%B8-%E4%B8%80-%E5%A6%82%E4%BD%95%E4%BD%BF%E7%94%A8webdriver-send-keys-988816ce9bed (使用webdriver模拟网页操作）