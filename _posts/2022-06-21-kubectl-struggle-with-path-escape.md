---
title: kubectl struggle with path escape
layout: post
categories: k8s
tags: k8s
date: 2022-06-21 08:00
excerpt: kubectl struggle with path escape
---

{:.table-of-content}
* TOC
{:toc}

# 缠斗！kubectl与路径穿越

## kubectl简介

kubectl是Kubernetes命令行工具，使得你可以对Kubernetes集群运行命令，如使用kubectl来部署应用、监测和管理集群资源以及查看日志等等

## 路径穿越简介

目录穿越（也被称为目录遍历/directory traversal/path traversal）是通过使用`../`等目录控制序列或者文件的绝对路径来访问存储在文件系统上的任意文件和目录

## kubectl路径穿越漏洞

### 漏洞命令

`kubectl cp`命令支持从主机拷贝文件到容器中和从容器中拷贝文件到主机，当从攻击者控制的容器中拷贝文件到主机时，如果处理不当可导致覆盖主机上的任意文件

### 漏洞函数

kubectl从容器中拷贝文件到主机时会使用容器中的`tar`命令来打包需要拷贝的文件，在主机上进行解包。以`1.13.0`为例，相关代码为`pkg/kubectl/cmd/cp/cp.go`，入口为`Run`函数
```go
func (o *CopyOptions) Run(args []string) error {
	// ...
	// Pod -> Pod: 如果源目标是一个 Pod 且目标源地址也是一个 Pod
	// 但是 kubectl cp 命令并不支持这一种情况，所以会先判断源目标是否是宿主机地址
	if len(srcSpec.PodName) != 0 && len(destSpec.PodName) != 0 {
		// 判断源目标是否是宿主机地址
		if _, err := os.Stat(args[0]); err == nil {
			// 执行 Host -> Pod 的逻辑
			return o.copyToPod(fileSpec{File: args[0]}, destSpec, &exec.ExecOptions{})
		}
		return fmt.Errorf("src doesn't exist in local filesystem")
	}
	// Pod -> Host: 如果源目标是 Pod 且目标源地址是宿主机地址
	if len(srcSpec.PodName) != 0 {
		return o.copyFromPod(srcSpec, destSpec)
	}
	// Host -> Pod: 如果源目标是宿主机地址且目标地址是 Pod
	if len(destSpec.PodName) != 0 {
		return o.copyToPod(srcSpec, destSpec, &exec.ExecOptions{})
	}
	// ...
}
```
我们这里只关心`Pod -> Host`的情况，即`copyFromPod`函数
```go
func (o *CopyOptions) copyFromPod(src, dest fileSpec) error {
	// ...
	// 建立一个读写的 pipe
	// 从 reader 端进行读操作，从 outStream 端进行写操作
	reader, outStream := io.Pipe()
	// 构造 remote exec 的参数
	options := &exec.ExecOptions{
		StreamOptions: exec.StreamOptions{
			IOStreams: genericclioptions.IOStreams{
				In: nil,
				// 输出
				Out:    outStream,
				ErrOut: o.Out,
			},
			// 对应 Pod 的 Namespace
			Namespace: src.PodNamespace,
			// 对应 Pod 的名称
			PodName: src.PodName,
		},
		// 使用 tar 命令将 Pod 中的目标文件打包成一个二进制文件
		// 然后通过 outStream 进行传送
		// src.File 可以是一个目录，此时就是将一个目录的文件打包成一个 tar 文件
		Command:  []string{"tar", "cf", "-", src.File},
		Executor: &exec.DefaultRemoteExecutor{},
	}
	// 启动一个 goroutine 来执行远程 Pod 的 tar 命令
	go func() {
		defer outStream.Close()
		o.execute(options)
	}()
	// ...
	// getPrefix() 去除前导 '/'
	// 比如 '/home/ubuntu' 将得到 'home/ubuntu'
	// 这点是与 tar 的逻辑保持一致，tar 也是会去除前导 '/'
	prefix := getPrefix(src.File)
	// Clean() 返回最短的等价于原始输入路径的路径
	// Clean() 最主要是去除一些不必要的 '..'
	// 比如 '/path/to/test/../../hello' 将输出 '/path/hello'
	prefix = path.Clean(prefix)
	return untarAll(reader, dest.File, prefix)
}
```
`untarAll`为核心函数，负责把`tar`包解压存放到主机上，所有的路径穿越都发生在这个函数中

### 漏洞历史

#### CVE-2018-1002100
> 以1.9.3为例

##### 漏洞分析
```go
func untarAll(reader io.Reader, destFile, prefix string) error {
		entrySeq := -1
    tarReader := tar.NewReader(reader)
    for {
        header, err := tarReader.Next()
				...
				// mode是文件类型，用它来判断是否为普通文件还是符号链接
				// destFile是文件保存的目标路径，例如：kubectl cp test:/etc/hosts /tmp，/tmp即为destFile
				// header.Name为tar包中的文件名
				// outFileName为目标文件名，如果outFileName不在`destFile`的路径内，就会发生路径穿越
        mode := header.FileInfo().Mode()
        outFileName := path.Join(destFile, header.Name[len(prefix):])
        baseName := path.Dir(outFileName)
				...
        // 处理符号链接的情况，之后的漏洞都出在对符号链接的处理上
        if mode&os.ModeSymlink != 0 {
            err := os.Symlink(header.Linkname, outFileName)
            if err != nil {
                return err
            }
        } else {
            outFile, err := os.Create(outFileName)
						...
            if _, err := io.Copy(outFile, tarReader); err != nil {
                return err
            }
						...
        }
    }
		...
		return nil
```

从以上代码中可以看出，它并没有对`outFileName`进行校验，保证其在用户指定的`destFile`的路径中，从而导致路径穿越

##### 漏洞利用

用恶意的`tar`覆盖容器中的`tar`，当主机调用`kubectl cp`时就会执行容器中恶意的`tar`程序，而恶意的`tar`返回给`kubectl`由攻击者精心构造的`tar`包，实现路径穿越
![](/assets/img/kubectl_path_escape1.png)

##### 漏洞修复

使用`path.Clean`来清除`..`
```
1. 替换多个`/`为一个`/`
2. 清除`.`
3. 计算内部的`..`，往前回溯为实际的路径
4. 清除以`/`开头的后面所有的`..`
```
![](/assets/img/kubectl_path_escape2.png)

补丁新增了`clean`函数，在攻击者构造的路径`heaer.Name`前加`/`，然后调用`path.Clean`清除`..`
![](/assets/img/cve-2018-1002100-patch.jpg)

由于在修复时没有考虑到符号链接的问题，就导致了后续的利用出现

#### CVE-2019-1002101
> 以1.11.1为例

##### 漏洞分析

利用符号链接进行路径穿越
![](/assets/img/kubectl_path_escape3.png)

- `./baddir/twist`是一个符号链接，指向`/proc/self/cwd`，即执行`kubectl`的当前路径
- 在写入`./baddir/twist/.bashrc`时实际写入的路径就是`/proc/self/cwd/.bashrc`

##### 漏洞利用
> tar有两个修改已有tar包的功能，`-u`是`update`，`-r`是`append`

- 创建恶意tar包
```
#!/bin/sh
# 创建符号链接并打包
mkdir ./baddir
ln -sf /proc/self/cwd ./baddir/twist
tar -cf pwn.tar ./baddir
# 把原先符号链接的目录换成普通目录，并在下面创建一个普通文件，追加到原先的tar包中
rm ./baddir/twist
mkdir ./baddir/twist
touch ./baddir/twist/hacked
echo 'You Are Hacked !!!' > ./baddir/twist/hacked
tar -rf pwn.tar ./baddir/twist/hacked
# 列出tar包内容
tar -tvf pwn.tar
echo "[*] Done!"
```
![](/assets/img/kubectl_path_escape4.png)

- 虽然使用`tar`命令解压会报错，但`kubectl`的解压是自己实现的，可以正常解压
![](/assets/img/kubectl_path_escape5.png)
- 在tar包中创建同名文件
```
echo "one" > foo
tar -cf test.tar foo
echo "two" > foo
tar -rf test.tar foo
tar -tvf test.tar
rm foo
tar xf test.tar
cat foo
```
![](/assets/img/kubectl_path_escape6.png)

- 利用
![](/assets/img/kubectl_path_escape7.png)

##### 漏洞修复

增加了两处校验：
- tar包中的文件名必须包含prefix，即拷贝时容器中的文件路径，增加了攻击难度，即如果攻击者在tar包中准备的文件名和从容器中拷贝文件名不同的话，就会拷贝失败
- 校验符号链接必须不能是绝对路径且不能包含`..`，但第二处校验存在问题导致了之后的CVE-2019-11246
![](/assets/img/cve-2019-1002101-patch.png)

#### CVE-2019-11246
> 以1.13.5为例

##### 漏洞分析

```go
// stripPathShortcuts removes any leading or trailing "../" from a given path
func stripPathShortcuts(p string) string {
	...
	return newPath
}
func untarAll(reader io.Reader, destFile, prefix string) error {
	// ...
	if mode&os.ModeSymlink != 0 {
		// ...
		// 由于是逻辑与的关系，当linkname不为绝对路径时就会绕过检查
		if path.IsAbs(linkname) &&
			(err != nil || relative != stripPathShortcuts(relative)) {
			...
			continue
		}
		// ...
	}
}
```

##### 漏洞利用

创建恶意tar包，符号链接指向相对路径
![](/assets/img/kubectl_path_escape8.png)

执行
![](/assets/img/kubectl_path_escape9.png)

##### 漏洞修复

```go
// 添加了linkJoin函数来合并路径
func linkJoin(base, link string) string {
	if filepath.IsAbs(link) {
		return link
	}
	return filepath.Join(base, link)
}
// 判断dest是否处于base之中
func isDestRelative(base, dest string) bool {
	fullPath := dest
	if !filepath.IsAbs(dest) {
		fullPath = filepath.Join(base, dest)
	}
	relative, err := filepath.Rel(base, fullPath)
	if err != nil {
		return false
	}
	return relative == "." || relative == stripPathShortcuts(relative)
}
func untarAll(reader io.Reader, destFile, prefix string) error {
	// ...
	if mode&os.ModeSymlink != 0 {
		linkname := header.Linkname
		if !isDestRelative(destDir, linkJoin(destFileName, linkname)) {
			// ...
			continue
		}
		// ...
	}
	// ...
}
```

#### CVE-2019-11249
> 以1.13.8为例

##### 漏洞分析

在检查路径穿越问题时使用了`linkJoin`函数来拼接链接文件名`destFileName`和链接目标`linkname`，如下所示：
```go
// linkJoin joins base and link to get the final path to be created.
// It will consider whether link is an absolute path or not when returning result.
func linkJoin(base, link string) string {
  if filepath.IsAbs(link) {
    return link
  }
  return filepath.Join(base, link)
}
func untarAll(reader io.Reader, destFile, prefix string) error {
	...
  if mode&os.ModeSymlink != 0 {
    linkname := header.Linkname
    // We need to ensure that the link destination is always within boundries
    // of the destination directory. This prevents any kind of path traversal
    // from within tar archive.
    if !isDestRelative(destDir, linkJoin(destFileName, linkname)) {
      fmt.Fprintf(o.IOStreams.ErrOut, "warning: link %q is pointing to %q which is outside target destination, skipping\n", destFileName, header.Linkname)
      continue
    }
    if err := os.Symlink(linkname, destFileName); err != nil {
      return err
    }
	...
}
```

`linkJoin`在进行拼接时，若`destFileName`不是绝对路径，则使用`filepath.Join(destFileName, linkname)`进行拼接，当`destFileName`不包含路径信息时，拼接结果会抹去`linkname`中的一层`..`，导致绕过校验，实现穿越到上级目录，即：`linkJoin("xxx", "../abc")`会返回abc

##### 漏洞利用

构造恶意tar包
![](/assets/img/kubectl_path_escape12.png)

执行
![](/assets/img/kubectl_path_escape10.png)
![](/assets/img/kubectl_path_escape11.png)

##### 漏洞修复

在拼接时用`destFileName`的路径来代替`destFileName`本身，这样`linkJoin("xxx", "../abc")`就会返回../abc了
![](/assets/img/cve-2019-11249-patch.png)

#### CVE-2019-11251
> 以1.13.10为例

##### 漏洞分析

若链接目标`linkname`本身为符号链接时，用`linkTarget = filepath.Join(evaledPath, linkname)`未取`linkname`真实的路径，而`filepath.Join`只是执行字符串拼接操作，不会把`linkname`作为符号链接来处理，这就会导致Join之后产生的路径与实际路径不符，绕过检查
```go
func untarAll(reader io.Reader, destFile, prefix string) error {
  baseName := filepath.Dir(destFileName)
  evaledPath, err := filepath.EvalSymlinks(baseName)
  if mode&os.ModeSymlink != 0 {
	  linkname := header.Linkname
	  // We need to ensure that the link destination is always within boundries
	  // of the destination directory. This prevents any kind of path traversal
	  // from within tar archive.
	  linkTarget := linkname
	  if !filepath.IsAbs(linkname) {
		  linkTarget = filepath.Join(evaledPath, linkname)
	  }
	  if !isDestRelative(destDir, linkTarget) {
		  fmt.Fprintf(o.IOStreams.ErrOut, "warning: link %q is pointing to %q which is outside target destination, skipping\n", destFileName, header.Linkname)
		  continue
	  }
	  if err := os.Symlink(linkname, destFileName); err != nil {
		  return err
  }
}
```

##### 漏洞利用

创建目录`./xxx`，在`xxx`下创建符号链接`link1`指向`..`，此时`link1`实际指向的路径为`.`，没有发生穿越。再在`xxx`下创建符号链接`link2`，`link2`指向`link1/..`
![](/assets/img/kubectl_path_escape13.png)

执行
![](/assets/img/kubectl_path_escape14.png)

### 回顾

一个小小的`untarAll`函数就出了5个漏洞，最终k8s决定在新版本中不再支持`symbol link`
![](/assets/img/kubectl_path_escape15.png)

这五个漏洞很好的展示了从易到难的一系列的路径穿越利用方法

- 在文件名中直接使用`../`进行穿越
- 使用指向绝对路径的符号链接进行穿越
- 使用指向相对路径的符号链接进行穿越
- 利用`Join`无路径分隔符的文件名和`../abc`时会省略`..`的特性进行穿越，即`linkJoin("xxx", "../abc") = abc`
- 利用多个符号链接进行穿越
	- 创建第一个符号链接`xxx/link1`指向`../`，此时并不会发生路径穿越，可以通过检查
	- 创建第二个符号链接`xxx/link2`指向`link1/../`，由于直接使用文件名进行`Join`，没有判断该文件是否为符号链接，导致检查的路径与真实路径不符，实现穿越
	- 以此类推，创建第三个符号链接`xxx/link3`指向`link2/../`等等
