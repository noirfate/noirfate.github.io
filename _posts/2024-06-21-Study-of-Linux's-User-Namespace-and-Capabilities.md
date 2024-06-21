---
title: Study of Linux's User Namespace and Capabilities
layout: post
categories: linux
tags: linux
date: 2024-06-21 18:00
excerpt: Study of Linux's User Namespace and Capabilities
---

{:.table-of-content}
* TOC
{:toc}

# 用户命名空间的权限校验分析
> 以内核4.19.315为例

## capable校验
### 入口函数
内核使用`capability`来检查各种权限，检验函数定义在`kernel/capability.c`中，主要涉及以下三个函数：
- capable
```
bool capable(int cap)
{
	return ns_capable(&init_user_ns, cap);
}
```
- ns_capable
```
bool ns_capable(struct user_namespace *ns, int cap)
{
	return ns_capable_common(ns, cap, CAP_OPT_NONE);
}
```
- ns_capable_common
```
static bool ns_capable_common(struct user_namespace *ns,
			      int cap,
			      unsigned int opts)
{
	int capable;

	if (unlikely(!cap_valid(cap))) {
		pr_crit("capable() called with invalid cap=%u\n", cap);
		BUG();
	}

	capable = security_capable(current_cred(), ns, cap, opts);
	if (capable == 0) {
		current->flags |= PF_SUPERPRIV;
		return true;
	}
	return false;
}
```
`ns_capable`是校验特定的`ns`是否具备某`cap`，实际`struct user_namespace`中并不包含`capability`的信息，要检查的`cap`实际是`cred->cap_effective`，`ns`在这里起到一个桥梁的作用，如果`cred->user_ns`和`ns`相同，则校验`cred->cap_effective`，其他情况在后面讲

### 底层函数
可以看到`ns_capable_common`调用`security_capable`，这个函数定义在`security/security.c`中
```
int security_capable(const struct cred *cred,
		     struct user_namespace *ns,
		     int cap,
		     unsigned int opts)
{
	return call_int_hook(capable, 0, cred, ns, cap, opts);
}
```
它实际是调用`LSM`的`hook`函数，`selinux`和`apparmor`等安全模块都会注册自己的`hook`函数，`call_int_hook`会依次调用所有的`hook`函数，如果其中有一个返回失败则无法通过权限校验

默认的`capability`校验函数是定义在`security/commoncap.c`中的`cap_capable`，在初始化的时候使用`capability_add_hooks`把自己添加到`hook`列表中，`cap_capable`的实现如下：
```
int cap_capable(const struct cred *cred, struct user_namespace *targ_ns,
		int cap, unsigned int opts)
{
	struct user_namespace *ns = targ_ns;

	/* See if cred has the capability in the target user namespace
	 * by examining the target user namespace and all of the target
	 * user namespace's parents.
	 */
	for (;;) {
		/* Do we have the necessary capabilities? */
		if (ns == cred->user_ns)
			return cap_raised(cred->cap_effective, cap) ? 0 : -EPERM;

		/*
		 * If we're already at a lower level than we're looking for,
		 * we're done searching.
		 */
		if (ns->level <= cred->user_ns->level)
			return -EPERM;

		/* 
		 * The owner of the user namespace in the parent of the
		 * user namespace has all caps.
		 */
		if ((ns->parent == cred->user_ns) && uid_eq(ns->owner, cred->euid))
			return 0;

		/*
		 * If you have a capability in a parent user ns, then you have
		 * it over all children user namespaces as well.
		 */
		ns = ns->parent;
	}

	/* We never get here */
}
```
其中`targ_ns`就是`ns_capable`传入的`ns`
- 如果当前进程的`user_ns`等于`targ_ns`，那么就检查`cred->cap_effective`中是否包含`cap`
- 如果当前进程的`user_ns`和`targ_ns`不同，且`targ_ns`的`level`更低，即`targ_ns`是`user_ns`的某个父命名空间，那么直接返回无权限。这样做的目的是为了防止权限放宽后可能带来的风险，当使用`ns_capable(&init_user_ns, cap)`或`capable(cap)`进行权限校验时，由于`init_user_ns`的level是0，一定会小于等于进程的`user_ns`的`level`，当程序执行到此处时一定返回无权限，也就是在进程创建新的用户命名空间并获得了所有`capability`时，也无法通过权限检查
- 如果`targ_ns`是`user_ns`的父命名空间，且进程的`euid`为命名空间属主，由于属主有命名空间的全部控制权，故直接通过检查
- 如果`targ_ns`是`user_ns`的祖父或更前辈的命名空间，则向上递归查找`ns->parent`

## capability
### CAP_NET_RAW
CAP_NET_RAW是Linux能力（capability）系统中的一个特权，允许持有该能力的进程执行以下操作：
- 创建原始套接字（RAW sockets）
原始套接字允许直接访问底层协议，如ICMP等。通过原始套接字，进程可以构建自定义的网络包，接收和发送的消息包含完整的协议报头
#### 以inet为例
- 向`inetsw`中注册`SOCK_RAW`类型的`socket`
```
struct proto raw_prot = {
	.name		   = "RAW",
	.owner		   = THIS_MODULE,
	.close		   = raw_close,
	.destroy	   = raw_destroy,
	.connect	   = ip4_datagram_connect,
	.disconnect	   = __udp_disconnect,
	.ioctl		   = raw_ioctl,
	.init		   = raw_init,
	.setsockopt	   = raw_setsockopt,
	.getsockopt	   = raw_getsockopt,
	.sendmsg	   = raw_sendmsg,
	.recvmsg	   = raw_recvmsg,
	.bind		   = raw_bind,
	.backlog_rcv	   = raw_rcv_skb,
	.release_cb	   = ip4_datagram_release_cb,
	.hash		   = raw_hash_sk,
	.unhash		   = raw_unhash_sk,
	.obj_size	   = sizeof(struct raw_sock),
	.useroffset	   = offsetof(struct raw_sock, filter),
	.usersize	   = sizeof_field(struct raw_sock, filter),
	.h.raw_hash	   = &raw_v4_hashinfo,
#ifdef CONFIG_COMPAT
	.compat_setsockopt = compat_raw_setsockopt,
	.compat_getsockopt = compat_raw_getsockopt,
	.compat_ioctl	   = compat_raw_ioctl,
#endif
	.diag_destroy	   = raw_abort,
};

static struct inet_protosw inetsw_array[] = {
    ...

    {
        .type =       SOCK_RAW,
	    .protocol =   IPPROTO_IP,	/* wild card */
	    .prot =       &raw_prot,
	    .ops =        &inet_sockraw_ops,
	    .flags =      INET_PROTOSW_REUSE,
    }
}

static int __init inet_init(void) {
    ...

    for (q = inetsw_array; q < &inetsw_array[INETSW_ARRAY_LEN]; ++q)
		inet_register_protosw(q);
}
```

- 创建`SOCK_RAW`类型的`socket`
```
static int inet_create(struct net *net, struct socket *sock, int protocol, int kern) {
    struct inet_protosw *answer;

    // 查找sock对应的inet_protosw
    list_for_each_entry_rcu(answer, &inetsw[sock->type], list) {
        ...
    }

    // 鉴权
    if (sock->type == SOCK_RAW && !kern && !ns_capable(net->user_ns, CAP_NET_RAW))
		goto out_rcu_unlock;
    
    // 创建socket, 其中sk->sk_prot = sk->sk_prot_creator = answer_prot
    sk = sk_alloc(net, PF_INET, GFP_KERNEL, answer_prot, kern);
}
```

- 发送报文
```
int inet_sendmsg(struct socket *sock, struct msghdr *msg, size_t size) {
    ...
    return sk->sk_prot->sendmsg(sk, msg, size);
}

static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len) {
    ...
}
```
- 接收报文
```
int inet_recvmsg(struct socket *sock, struct msghdr *msg, size_t size, int flags) {
    ...

    err = sk->sk_prot->recvmsg(sk, msg, size, flags & MSG_DONTWAIT, flags & ~MSG_DONTWAIT, &addr_len);
}

static int raw_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int noblock, int flags, int *addr_len) {
    ...
}
```
#### 支持SOCK_RAW的协议
```
root@localhost:~/linux-4.19.315# grep -r --exclude='*.o' 'SOCK_RAW' net/ | awk -F: '{print $1}' | xargs -n1 dirname | sort -u
net/appletalk
net/ax25
net/bluetooth
net/bluetooth/bnep
net/bluetooth/cmtp
net/bluetooth/hidp
net/bluetooth/rfcomm
net/can
net/ieee802154
net/ipv4
net/ipv6
net/key
net/netlink (SOCK_RAW等同于SOCK_DGRAM)
net/nfc
net/packet
net/unix (虽然包含但实际不支持)
net/xdp
```
#### 对CAP_NET_RAW鉴权的协议
```
root@localhost:~/linux-4.19.315# grep -r --exclude='*.o' 'CAP_NET_RAW' net/ | awk -F: '{print $1}' | xargs -n1 dirname | sort -u
net/appletalk
net/ax25
net/bluetooth
net/core
net/ieee802154
net/ipv4
net/ipv6
net/llc
net/nfc
net/packet
net/xdp
```
#### 支持RAW但未使用CAP_NET_RAW鉴权的协议
- can
PF_CAN是Linux内核中用于Controller Area Network (CAN)的协议族。CAN是一种用于汽车和工业自动化中的通信协议，允许微控制器和设备直接通信而无需主机计算机。
- key
PF_KEY是一个用于密钥管理的协议族，通常与IPsec（Internet Protocol Security）相关联。它定义了一个套接字接口，用于在用户空间和内核空间之间传递密钥管理信息。这个接口由RFC 2367规范定义。

#### 使用capable鉴权
以下为内核中调用`capable`鉴权的函数列表，由于调用的是`capable`，故无法使用用户命名空间绕过权限检查
- ax25_create (net/ax25/af_ax25.c)
- atalk_create (net/appletalk/ddp.c)
- mlx5_ib_devx_create (drivers/infiniband/hw/mlx5/devx.c)
- mlx5_ib_devx_create (drivers/infiniband/hw/mlx5/devx.c)
- mlx5_ib_handler_xxx (drivers/infiniband/hw/mlx5/flow.c)
- hci_sock_bind (net/bluetooth/hci_sock.c)
- hci_sock_sendmsg (net/bluetooth/hci_sock.c)
- hci_sock_setsockopt (net/bluetooth/hci_sock.c)
- l2cap_sock_create (net/bluetooth/l2cap_sock.c)
- llcp_sock_create (net/nfc/llcp_sock.c)
- base_sock_create (drivers/isdn/mISDN/socket.c)
- ieee802154_create (net/ieee802154/socket.c)
- create_qp / modify_qp / ib_uverbs_ex_create_flow (drivers/infiniband/core/uverbs_cmd.c)
#### 使用ns_capable鉴权
以下为内核中调用`ns_capable`鉴权的函数列表，由于调用的是`ns_capable`，传入的`targ_ns`是`net->user_ns`，故可用`unshare(CLONE_NEWUSER | CLONE_NEWNS)`绕过权限检查
- inet_create (net/ipv4/af_inet.c)
- inet6_create (net/ipv4/af_inet6.c)
- llc_ui_create (net/llc/af_llc.c)
虽然它使用了`ns_capable`，但后面校验了网络命名空间是否为初始网络命名空间`if (!net_eq(net, &init_net)) return -EAFNOSUPPORT;`，故无法绕过
- packet_create (net/packet/af_packet.c)
- ip6_datagram_send_ctl (net/ipv6/datagram.c)
- do_ipv6_setsockopt (net/ipv6/ipv6_sockglue.c)
- do_ip_setsockopt (net/ipv4/ip_sockglue.c)
- rawsock_create (net/nfc/rawsock.c)
- sock_setbindtodevice (net/core/sock.c)
- dgram_setsockopt (net/ieee802154/socket.c)
- xsk_create (net/xdp/xsk.c)
#### 历史漏洞
##### CVE-2020-14386
> https://seclists.org/oss-sec/2020/q3/146

这是一个整数溢出漏洞，可导致越界写，漏洞触发需要创建RAW套接字`socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL))`，凡是具备操作RAW套接字权限的用户均可触发

包含漏洞的代码如下：
```
static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
               struct packet_type *pt, struct net_device *orig_dev)
{
// ...
    if (sk->sk_type == SOCK_DGRAM) {
        macoff = netoff = TPACKET_ALIGN(po->tp_hdrlen) + 16 +
                  po->tp_reserve;
    } else {
        unsigned int maclen = skb_network_offset(skb);
        
        // tp_reserve是unsigned int, netoff是unsigned short. 故计算结果可能导致溢出unsigned short，得到一个较小的值
        netoff = TPACKET_ALIGN(po->tp_hdrlen +
                       (maclen < 16 ? 16 : maclen)) +
                       po->tp_reserve; // [1]
        if (po->has_vnet_hdr) {
            netoff += sizeof(struct virtio_net_hdr);
            do_vnet = true;
        }
        
        // 攻击者通过控制netoff的值，可以使得macoff的值小于sizeof(struct virtio_net_hdr)
        macoff = netoff - maclen; // [2]
    }
// ...

    // 由于攻击者可以使"macoff - sizeof(struct virtio_net_hdr)"为负, 故可以导致向前越界写
    if (do_vnet &&
        virtio_net_hdr_from_skb(skb, h.raw + macoff -
                    sizeof(struct virtio_net_hdr),
                    vio_le(), true, 0)) {  // [3]
// ...
```

普通用户默认没有`CAP_NET_RAW`的权限，故无法直接利用该漏洞。鉴于之前的分析，`inet`协议族使用的是`ns_capable`进行鉴权，故可以通过创建用户命名空间的方式得到该权限，并利用此漏洞进行提权

![](/assets/img/cve_2020_14386.png)