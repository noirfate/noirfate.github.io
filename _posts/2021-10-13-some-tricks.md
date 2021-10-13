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

## Linux二进制打包
:::info
linuxdploy 文档：https://docs.appimage.org/packaging-guide/from-source/linuxdeploy-user-guide.html
:::

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

# 容器

# 网站

- https://data.stats.gov.cn (国家数据)
- https://apps.evozi.com/apk-downloader/  (从google play上下载apk)
- https://medium.com/marketingdatascience/selenium%E6%95%99%E5%AD%B8-%E4%B8%80-%E5%A6%82%E4%BD%95%E4%BD%BF%E7%94%A8webdriver-send-keys-988816ce9bed (使用webdriver模拟网页操作）