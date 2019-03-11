---
layout: title
title: Hacker101-CTF-1/2
date: 2018-12-12 09:11:06
tags: hacker101, security
categories: Hack
---
I caught a nice website for learning basic information security recently. Hacker101. That site offers video course for novice to learn cryptography and information security from scratch. Also it has insteresting ctf question for us to solve. 

So I gonna record my journey to the flag. Let's start from the simplest one. 

## CTF - 1 

CTF - 1 Looks pretty simple, it gives a website and we can just inspect its source. Than we found it request a "background.png" as background. It seems weird when something called a resource from local directly. but we can check it our on the frontend.

We enter the `background.png` at the end of the address of website. Then we got the answer no surprisingly. 

## CTF - 2

This question shows us a mini CMS website. IT offers a simple management page to view and edit the page we created. And it use Markdown to help us formating the doc that we writed. 

When we are creating a page, we need edit two post form to fulfill the `POST` method to the server. There must be something hidden in it. Like what if we can write a scripts to inject some code on the front page to help us show the request information? 

### Flag 1

We input this code on the title bar. it ends the last tag and inject a scripts tag on the next line by `>`:
```
><scripts>alert("documents.cookies")</scripts>
```
Also we input `alert("documents.cookies")` stright into the content form. 

Then we got our first flag. The hint shows us:

+ Sometimes a given input will affect more than one page
+ The bug you are looking for doesn't exist in the most obvious place this input is shown

### Flag 2

Now that we can control the page from the script code that we inject, maybe the source page could hide the flag like the CTF-1 shows. 

we should add some tag, like img tag or button tag, into the contant form. 

```
<img src='xxxxx'>
```

Open the page, check the source page. The flag is right on here. Maybe we should know more about the XSS. 

### Flag 3

The flag 3 is actually a little bit tricky. I just don't know why it can cause a bug or some thing. To be honest, I have to check few more hint to get the flag. 

Here is the hint:
+ Make sure you tamper with every input
+ Have you tested for the usual culprits? XSS, SQL injection, path injection
+ Bugs often occur when an input should always be one type and turns out to be another
+ Remember, form submissions aren't the only inputs that come from browsers

We noticed that the address bar shows index to query the page form the server. May those index could exist inject. Like we can add a symbol on the end of address. e.g. `'`

Than we got the flag, but that bug only exists in edit page. 

### Flag 4

The final bug also relate to the index, but this time we should focus how the website arrange the index for searching. When we create a new page, the index starts from 10, rather than 0. 

But when we check the init page, test page and another stuff, we got the 0 and 1 index. So where are those page which index between 2 and 9? We input those index at the end of address page line. One by one, everytime we enter, we got the 404, until the 5th page. It shows `forbidden`. 

That's weird. There must be something hidden in it. Why we just mock the trick used before, try create page or edit page. 

We forcely enter the edit page with index 5. that the flag just lie down the content form. 