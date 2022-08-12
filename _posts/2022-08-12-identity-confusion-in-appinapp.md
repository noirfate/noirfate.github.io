---
title: Identity Confusion in WebView-based Mobile App-in-app Ecosystems
layout: post
categories: app
tags: app
date: 2022-08-12 18:00
excerpt: Identity Confusion in WebView-based Mobile App-in-app Ecosystems
---

{:.table-of-content}
* TOC
{:toc}

# Identity Confusion in WebView-based Mobile App-in-app Ecosystems
## 简介
这篇国内研究者发表的论文获得了`USENIX Security 2022`的`Distinguished Paper Award`，仔细看了下确实是一篇不错的论文，虽然漏洞的原理不新鲜，但应用的领域确实是一个较新的领域。从标题可能还看不出这篇论文要讲的是什么，简言之，就是小程序的认证漏洞。<br>
[论文地址](https://www.usenix.org/system/files/sec22-zhang-lei.pdf)

## 执行逻辑
先明确几个定义，`super-app`即主app或者app应用市场，`sub-app`即小程序或app。这里不考虑应用市场的情况，只关注主app及其小程序，用户安装主app之后，在使用小程序时，主app会动态加载小程序的代码并执行，而小程序主要就是基于网页实现，即运行在主app的`WebView`中
![](/assets/img/app1.png)
下图是一个更加细化的运行逻辑，主app实现了一个`web-to-mobile`的桥梁或通道，它允许小程序通过这个通道去调用`runtime apis`，即主app提供的api，然后`runtime api`会去调用系统api，所以小程序可以`runtime apis`为桥梁去执行系统api。这里面显然就会存在对系统api的滥用问题，所以要有一个访问控制策略，即图中的红框。如果小程序能够绕过这个访问控制策略，那么它就可以对用户的手机实施攻击，比如安装恶意app
![](/assets/img/app2.png)

## 利用方法
### 隐藏api
主app厂商为小程序开发者提供了不少api供其调用，这些api在公开文档中都可见到，但由于各种原因，主app厂商还提供不少隐藏api，它们不出现在公开资料中，但一旦知道了隐藏api的调用方法，就可以对其进行调用，并且往往会忽略鉴权或鉴权不严。这个现象其实很常见，比如硬件设备厂商在其设备中内置管理员密码，这个密码只有内部员工知道，并不公开给他人，但hacker可以通过对设备固件的逆向分析找到这个hardcode的密码。此外很多云服务也存在隐藏api的问题，可以通过特殊的HTTP头或者token来触发这些隐藏api。下面是论文研究者对主流app所做的研究，发现它们都存在有大量的隐藏api
![](/assets/img/app3.png)

### 认证鉴权
总共有三种认证鉴权的方式
- 通过域名
根据域名白名单来进行认证鉴权
- 通过`AppID`
根据小程序ID白名单来进行认证鉴权
- 通过凭证
通过主app签发的凭证进行认证鉴权，论文里称之为`capability`
![](/assets/img/app4.png)

### 案例
当通过微信打开其自定义的协议链接，以`weixin://`开头，后面是对`AppID,path,url`编码后的内容。当微信打开`weixin://`链接时，就会自动打开`AppID`对应的小程序，这里`AppID`就是拼多多的小程序ID，然后把`url`传给拼多多小程序，进而拼多多小程序会打开这个`url`，当把正常的拼多多`url`的内容替换为攻击者可控的恶意链接时，就会触发漏洞，这里面包含了三个安全问题：
- 拼多多小程序在打开`url`时，微信会检查这个`url`是否在白名单内，但微信未能正确解析`url`，导致白名单绕过。比如白名单里面的一个链接为`weixin.com`，那么攻击者通过用户名密码的方式来指定URL时，如`https://weixin.com:abc@malicious.com`，虽然它实际访问的是`malicious.com`，但在检查白名单的时候却被解析成`weixin.com`，从而绕过了白名单检查
- 通过第一个漏洞，拼多多小程序打开了由攻击者指定的恶意链接，加载了恶意网页，当在这个网页中去调用拼多多提供的`Web Service API`时，拼多多小程序没有做认证，使得攻击者可以通过调用拼多多提供的API来获取微信颁发给拼多多小程序的凭证
- 由于拼多多小程序是白名单特权小程序，通过拼多多小程序的凭证，攻击者就可以调用微信的隐藏特权API——addDownloadTask，在安卓系统中下载并安装任意apk
![](/assets/img/app9.png)

### 域名混淆

#### 基于时间差的混淆
如前文所述，小程序都是基于网页开发的，即运行在`WebView`中，而`WebView`在加载网页时会调用两类线程，一个是内容加载线程`Browser Thread`，另一个是渲染线程`Render Thread`。同时主app也会有三类线程，一个是运行小程序`WebView`的线程，一个是做身份检查的线程，还有一个是执行API的线程。以上的五类线程都是异步的，在执行时会存在时间差，利用这个时间差就可以进行身份混淆攻击
- 利用`WebView`的加载线程和渲染线程的时间差<br>
当在`WebView`中打开攻击者控制的`malicious.com`时，攻击者可以通过运行在渲染线程的`JavaScript`脚本把页面重定向到主app白名单里面的链接，从而内容加载线程就会加载这个白名单的链接，这时之前渲染线程中的脚本可能仍在运行。这里面就存在两个异步执行的任务，一个是之前页面执行脚本的渲染线程，另一个是加载白名单URL的加载线程。主app通常会注册加载线程的`onPageStarted()`回调函数，即当加载线程加载页面之前会调用主app注册的函数，主app在这个函数中会去取加载页面的域名用于后续的认证，这时取到的域名就是白名单里面的域名，可以通过认证。这时若之前渲染页面里面的脚本仍在运行，那么在脚本中调用隐藏特权API时，主app就会认为这个调用来自白名单域名，如果它只用域名来认证鉴权的话，即可完成调用。这里面的时间差就是，从`onPageStarted()`回调函数执行完成到`malicious.com`页面的终止
![](/assets/img/app5.png)
![](/assets/img/app6.png)

- 利用主app的API执行线程和身份检查线程的时间差<br>
与上面的情况类似，打开`malicious.com`，渲染线程执行脚本，在脚本中把页面重定向到白名单域名，然后执行隐藏特权API，这时主app会把这个执行API的请求放入执行队列中等待执行。如果主app执行线程从队列中取出这个API开始执行的时候，`WebView`加载线程已经开始加载白名单域名的页面，那么这时去做认证检查时就会取到白名单域名，认为调用这个API的是白名单域名。在这种利用方式下，如果`malicious.com`页面关闭了，但API还没执行结束，那么攻击者就得不到API的返回结果
![](/assets/img/app7.png)

#### 基于页帧的混淆
当一个页面包含多个iframe页帧且主app取到的域名是主页面的域名时，如果攻击者能够以某种方式（比如在线广告）把自己的网页以iframe的方式嵌入到白名单域名的网页中时，就可以白名单域名的身份调用隐藏特权API了

### AppID混淆
#### URL白名单匹配缺陷
URL白名单是由小程序开发者提供，而匹配算法是主app提供，这时就会存在认知偏差。比如，小程序开发者认为是严格的模式匹配，而主app却使用了`endswith`、正则等其他方式来匹配。在用`endswith`匹配时，白名单域名为`weixin.com`，使用`abcdweixin.com`就可以通过白名单检查
#### URL解析缺陷
HTTP的URL支持带用户名密码，如果主app处理不好就会产生问题，就像前面描述的微信的漏洞一样，假设白名单域名为`weixin.com`，使用`weixin.com:abcde@malicious.com`就可以通过白名单检查
#### 缺少对iframe的检查
如果主app没有取检查白名单域名网页中内嵌的iframe的URL，那么就可以使用恶意的iframe来进行攻击

### 凭证混淆
#### 主app未授权API
如果主app自欺欺人，认为无人知道没有写在公开文档里的隐藏API，没有对这些隐藏API做认证鉴权，就会导致任何人都可以去调用它们
#### 小程序未授权API
在白名单内有特权的小程序自己暴露了未授权的API，那么就可以通过这个API获取小程序的凭证并进而调用主app的隐藏特权API，前面拼多多小程序的漏洞即是此类

## 检测结果
可以看到大部分主流app都存在漏洞，所以及时更新很重要哦
![](/assets/img/app8.png)
