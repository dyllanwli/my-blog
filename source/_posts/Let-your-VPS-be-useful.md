---
layout: title
title: Let your VPS be useful
date: 2018-03-11 09:11:06
tags: linux
categories: Tech
---

I'd tried a wide range of cloud vendor. Just because I feel little bit neat freak on my own machine. On the virtual machine, I don't worry about the overload, the wastage or the upgrade. That is the advantage of the VPS. When you want to add disk size due to the massive data, just few clicks can help you; or when you want to maintain some monitor some metrix on your machine, just keep it running and no need to focus the runtime of the physics device -- a wholesome cloud infrastructure will help you.

However, most people just leave the machine unused, since the cloud vendor, after all, provided the most direct service for customer rather than left ourself to develop. But those service, more or less limiting the usage of single user, annoyed most of us. Why don't we just using the docker to build a own?

## ownCloud
Feel bad about the charging policy or limited size of the Google Drive or BaiduYunPan? It is undisputed for most public cloud drive markets that only subscribed can enjoy the tiny convenience of the cloud drive. 

How about using ownCloud to build our own?

    docker run -p 8081:80 -d imdjh/owncloud-with-ocdownloader

Just one line code with docker can quickly build a private cloud drive.

## MetaBase
Since we got our cloud drive to storage our data, why don't we build a data analysis tool to handle our data on cloud?

> Metabase is the easy, open source way for everyone in your company to ask questions and learn from data.

    docker run -d -p 3000:3000 --name metabase metabase/metabase

## minidlna
Watching TV or PS4 all the day, or we can using the server turn into a mutil media center.

    sudo apt-get install minidlna

Only if you TV supports dlna protocol

## Cloud backup
Time Capsule is good, build our own cloud backup using AFP protocol is also functional achievable. 

    sudo apt-get install netatalk avahi-daemon
    sudo vim /etc/netatalk/AppleVolumes.default

Edit some config file:

    :DEFAULT: options:upriv,usedots
    /home/exampleuser/tm "TimeMachine" options:tm exampleuser


