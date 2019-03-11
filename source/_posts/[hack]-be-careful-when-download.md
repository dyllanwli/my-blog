---
layout: title
title: Be careful when we download stuff
date: 2018-12-09 09:11:06
tags: security
categories: Hack
---

I want to share tip for keeping our device in safe with us. Whatever you use Mac or PC, even mobile device, anyone are exposed on the threat of attacker. So be careful whenever we download stuff on the Internet. 

### HTTPS

As we all know, `S` mean secure, is the secure version of HTTP, the protocol over wich data is sent between your browser and the website. Far more better than HTTP. 

So we should, firstly, open the website whose address start with https. The download link provided on the main website should also be https. If the downlaod link is not https, there are at least two way to cause agent hijack attack. DNS hijack or Backdoor Factory. 

### File falsify test

Most people forget this one, the website also tend to be ignore the file falsify test. It should provide MD5, or better SHA256. 

But most of open source tool website offers original signature. We can use the GPG signature verifcation to make sure whether the file is falsified or not. 

```
gpg --verify xxx.zip.sig yyy.zip
```

