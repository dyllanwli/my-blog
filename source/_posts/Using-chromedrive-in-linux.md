---
layout: title
title: Using Chromedriver in linux
date: 2018-04-21 09:11:06
tags: Linux
categories: Tech
---

A simple motivation for me to use chromedrive on my server. Someone ask me if I could make some fake youtube view on his channel. I said possible, but haven't tried before. 

Some blogs said it could use Tor browser to refresh the user trace. But the installation of Tor on linux brings me to hell. I know dark net is cool. But I just cannot figure it out how I can quickly achieve my simple goal.

Chromedirve may help me to fake a browser on linux. because I need some long duration view requests on linux.

Then I came across some errors:
```
    APT-GET“Couldn’t create temporary file for passing config to apt-key”
```
or `cannot install unsigned` stuff ...

Using `--allow-unauthenticated` to force pass unsigned repo list, I hope it work but it just throw me different warning error. 

I'd tried add `[trusted=yes]` in the front of `source.list`. It fixed one of two stage error: bypass the key. But still cannot update apt. 

How about `pacman/pacapt`. This time we cannot use this tool, though it still the top way of managing program in ubuntu. 

Then I checked the `/tmp` folder, if there is some error, some lost of premission stuff. To be honest, I have no idea since `/tmp` folder is a important system folder and I'd never ever touched it before. 

But after add `chmod 777 /tmp`. It works out.

We still can use both add `deb` or just using `apt install` to install `google-chrome-stable`; simple command `sudo apt-get install google-chrome-stable`; if got problem or dependencies problem; use `sudo apt-get install -f` 

Notice that `-f` means `--fix-broken` not `--force`; actually you cannot install a program forcely. 

Next article I will write a tuturial about youtube view bot; a way to increase youtube fake view. But this way still depends on a nice proxy pool. Free proxy pool may not help. 