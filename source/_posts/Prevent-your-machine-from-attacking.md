---
layout: title
title: Prevent your machine from attacking
date: 2017-09-21 09:11:06
tags: Linux
categories: Tech
---

You may heard about botnet, which is a network of infected computers that can be controlled remotely, forcing them to send spam, spread viruses, or stage DDoS attacks without the consent of the computers’ owners.

In the public network, hackers keep cracking your machine and want to capture your machine to become botnet.

However, most of us still feel confident about the cloud vendor and feel relief that we still not losing the control of the machine. But if your carefully check your usage of the cpu/memory, login history and other record. Someone may inject some bitcoin mining scripts on your machine a year ago. 

## Intro.

Try this command to watch the login record:

    du -sh `ls /var/log | grep btmp

This file storage the login fail record of ssh. The larger size of the file, the more dangerous your server is undering. This is a simple and old cracking method, but still efficient.

Larger part of the server use weak password, which using `root` as login username, password is sucession number and still using `22` as default login port. 

## Check More Record

+ `/var/log/wtmp` is used for record sucessful login information. This is a binary format file. Only using `last` command is able to check its contents.

```
root     pts/0        *.*.*.*    Sat Feb 16 12:29   still logged in
root     pts/0        *.*.*.*   Fri Feb 15 20:42 - 20:55  (00:12)
root     pts/0        *.*.*.*   Thu Feb 14 13:27 - 18:55  (05:27)
root     pts/0        *.*.*.*    Wed Feb 13 21:31 - 23:07  (01:36)
```
Check the top 10 malvolence login IP:

    sudo lastb | awk '{ print $3}' | awk '{++S[$NF]} END {for(a in S) print a, S[a]}' | sort -rk2 |head

Check the times of malvolence login time:

    lastb | awk '{ print $3}' | sort | uniq -c | sort -n

If you want to clear this log:

    rm -rf /var/log/btmp
    touch /var/log/btmp
+ `/var/log/btmp` is used to record the failed login IP. Using `lastb` to check its content. 

+ `/var/login/lastlog` is used to record user login history. Using `lastlog`

+ `/var/login/utmp` is used to record current user information. Using `who`

## SSH

+ change `ssh` default port
```
    vi /etc/ssh/sshd_config
```
+ restart `sshd` service 
```
    systemctl restart sshd
    systemctl status sshd
```
+ add `iptables`
```
    # iptables config file location: /etc/sysconfig/iptables
    iptables -A INPUT -m state --state NEW -m tcp -p tcp --dport 1000 -j ACCEPT
    # add 1000 port rule
    service iptables save
    service iptables restart
```
+ or using `firewall-cmd`
```
    firewall-cmd --state

    systemctl start firewalld
    systemctl enable firewalld

    # check default/active zone 
    firewall-cmd --get-default-zone
    firewall-cmd --get-active-zones
    # open port
    firewall-cmd --permanent --zone=public --add-port=22/tcp
    firewall-cmd --permanent --zone=public --add-port=1000/tcp
    # reload firewall 
    firewall-cmd --reload 

    # check exposed port 
    firewall-cmd --permanent --list-port 
    firewall-cmd --zone=public --list-all
```

## Using strong password 

```
    passwd
```

randdom password generator

```
    # echo $(getRandomPwd 10)
    # echo $(getRandomPwd)
    getRandomPwd(){
        num=32
        if [ $# == 1 ];then
            num=$1
        fi
        echo "$(date +%s)$(shuf -i 10000-65536 -n 1)" | sha256sum | base64 | head -c $num ; echo
    }
```

