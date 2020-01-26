---
layout: title
title: EndNote Debug
date: 2020-01-26 09:11:06
tags: research  
categories: debug
---

EndNote is a nice tool for reference manage. Here is some problem when I getting in to this new area. Some troubleshooting comes subsequently. 

1. `COM Cannot Edit Range X9`

It looks like the EndNote and conflict with Zotero and Mendeley Plugin. Just uninstall all Plugin in the start folder which located at: 

```
~/Library/Group Containers/UBF8T346G9.Office/User Content/Startup/Word (i.e., the Library folder within your home directory). 

The ~/Library folder is hidden by default, but you can open it from the Finder by holding down Option, clicking the Go menu, and selecting Library. You can also press Cmd-Shift-G in Finder and copy in the default location to navigate to that folder.

```
Word for 2016 and 2019 only.
