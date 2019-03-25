---
layout: title
title: k3s-轻量级Kubernetes上手
date: 2019-03-09 16:48:27
tags: Kubernetes
categories: Tech
---

## intro

k3s已经发布了几天时间，趁着手头的Vultr优惠券还没有过期，正好可以开几台机器尝试一下这个很热门的新项目。

这个项目是RancherLab所开发的，之前使用k8s和swarm的时候也用过不少rancher，对其很方便的图形化容器管理感到很惊艳。感觉rancher和k8s其实应该算是竞争关系。rancher的两个版本都提供容器编排和调度，但是k8s的社区发展的越来越强大，rancher慢慢变成算是提供k8s的上层服务了，通过rancher管理多个k8s。

好了vultr上的机器开好了，使用Ubuntu 18.04 x64 的快照，之前预装了docker之类的工具。虽然开了三台机器，不过首先还是试试单机的k3s吧。

通过github的项目repo找到Readme先了解一下：https://github.com/rancher/k3s

## Quick Start

k3s已经使用了containerd替换Docker来做runtime，所以我们可以在RancherOS停止Docker。containerd本身就是Docker的一部分，完全兼容我们所熟悉的Docker。

官网提供了两种方法，一种就是下载下载repo的release然后自行安装
```
cd /opt && wget https://github.com/rancher/k3s/releases/download/v0.2.0/k3s
chmod +x k3s && ./k3s server &
```
另外一种是通过类似于getdocker之类的官方脚本

```
curl -sfL https://get.k3s.io | sh -
```
我们试试第二种
```
[INFO]  Finding latest release
[INFO]  Using v0.2.0 as release
[INFO]  Downloading hash https://github.com/rancher/k3s/releases/download/v0.2.0/sha256sum-amd64.txt
[INFO]  Downloading binary https://github.com/rancher/k3s/releases/download/v0.2.0/k3s
[INFO]  Verifying binary download
[INFO]  Installing k3s to /usr/local/bin/k3s
[INFO]  Creating /usr/local/bin/kubectl symlink to k3s
[INFO]  Creating /usr/local/bin/crictl symlink to k3s
[INFO]  Creating uninstall script /usr/local/bin/k3s-uninstall.sh
[INFO]  systemd: Creating environment file /etc/systemd/system/k3s.service.env
[INFO]  systemd: Creating service file /etc/systemd/system/k3s.service
[INFO]  systemd: Enabling k3s unit
Created symlink /etc/systemd/system/multi-user.target.wants/k3s.service → /etc/systemd/system/k3s.service.
[INFO]  systemd: Starting k3s
```
当起了k3s之后检查一下`netstat -tnlp`，我们可以发现k3s一并起了多个端口6444/6445应该是主程序，因为再起一次会提示端口占用，还有10010的containerd，以及10248到10252等几个未知服务。

之前网上搜一搜k3s的信息，发现都是起亚k3s的车[lol]。

这样启动的k3s会自带agent，也就是kubernetes的节点，使用`k3s server --disable-agent`来起k3s就可以单纯的将其作为server。

接下来尝试一下添加deployment。

我们使用官方提供的yaml template

```
k3s kubectl create -f https://kubernetes.io/docs/user-guide/nginx-deployment.yaml
```

通过`k3s kubectl get deployment`和`k3s kubectl get pods`查看创建的pods


## node
如果我们需要添加agent呢，添加一个node？

首先查看一下原来的node`k3s kubectl get node`拿到的是

```
NAME          STATUS   ROLES    AGE   VERSION
vultr.guest   Ready    <none>   11d   v1.13.4-k3s.1
```

然后需要拿到机器上的node token，位置在`/var/lib/rancher/k3s/server/node-token`

拿到之后使用，来加入node。

```
k3s agent -s ${YOUR_SERVER_IP} -t ${NODE_TOKEN}
```

但是发现一个问题，vultr的机器是默认没有开通LAN的或者是硬件配有配置好。

比如这里用的是ubuntu的机器，我们需要自己添加LAN的固件。ubuntu 18的网卡配置需要创建一个10-ens7.yaml的文件在`/etc/netplan/`的目录下
```
network:
  version: 2
  renderer: networkd
  ethernets:
    ens7:
       match:
         macaddress: 56:00:01:f2:8e:fb
       mtu: 1450
       dhcp4: no
       addresses: [10.8.96.4/16]
```

其中addresses，就是vultr提供的private netowrk地址，使用`netplan apply`来配置设置。

配置之后可以试一试能不能够ping通关联的机器。也可能需要重启类配置。

这样多节点的k3s部署好了，就像swarm一样方便感觉。之后再尝试部署一些复杂的应用吧。

### Reference 

+ https://github.com/rancher/k3s
