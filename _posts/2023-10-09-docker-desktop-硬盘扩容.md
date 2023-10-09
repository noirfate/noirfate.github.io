---
title: Docker Desktop 硬盘扩容
layout: post
categories: tool
tags: docker
date: 2023-10-09 18:00
excerpt: Docker Desktop 硬盘扩容
---

{:.table-of-content}
* TOC
{:toc}

# Docker Desktop 硬盘扩容
> 如果使用wsl2后端则没有此问题

`Docker Desktop`Windows版使用了Hyper-V虚机，虚机的磁盘大小就决定了整个docker的磁盘大小，在`Docker Desktop`中设置`disk size`是没有效果的。由于所有容器和卷都使用docker虚机的磁盘，且安装`Docker Desktop`时创建的虚机磁盘较小，故很快就会占满磁盘，无法正常运行容器。

解决方法就是为虚机扩容，打开`Hyper-V 管理器`，会看到运行了一个叫做`DockerDesktopVM`的虚机，编辑其磁盘进行扩容，然后重启`Docker Desktop`即可，扩容方法见<https://www.nakivo.com/blog/increase-disk-size-hyper-v-complete-guide/>