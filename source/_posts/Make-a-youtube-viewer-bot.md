---
layout: title
title: Make a youtube viewer bot
date: 2018-02-30 10:21:00
tags: Linux
categories: Tech
---


Well I think I should show my code first, then talk about the method. 

```
import os
import re
import requests
from os import _exit
from time import sleep
from random import choice,uniform
from threading import Thread
from argparse import ArgumentParser
from selenium import webdriver
from selenium.webdriver.common.proxy import Proxy,ProxyType
from fake_useragent import UserAgent
from os import path
osproxy = "http://127.0.0.1:8888"
sysProxy = False
test = False
proxy_pool_url = 'http://ip.jiangxianli.com'
# os.environ['http_proxy'] = osproxy 
# os.environ['HTTP_PROXY'] = osproxy
# os.environ['https_proxy'] = osproxy
# os.environ['HTTPS_PROXY'] = osproxy

def load_arg():
    args = {}
    args["url"] = "https://youtu.be/0eG76YapPPE"
    args["threads"] = 10
    args["duration"] = 5
    args["proxies"] = None
    return args


def test_proxy(osproxy):
    print(osproxy)
    os.environ['http_proxy'] = osproxy 
    os.environ['HTTP_PROXY'] = osproxy
    os.environ['https_proxy'] = osproxy
    os.environ['HTTPS_PROXY'] = osproxy
    result = requests.get("http://www.baidu.com")
    print(result)
    
def load_proxy():
    if args["proxies"] is not None:
        proxies=open(args["proxies"],'r').read().split('\n')
    else:
        proxies=re.findall(re.compile('<td>([\d.]+)</td>'),str(requests.get(proxy_pool_url).content))
        proxies=['%s:%s'%x for x in list(zip(proxies[1::3],proxies[2::3]))]
        
    print('%d proxies successfully loaded!'%len(proxies))
    p=Proxy()
    p.proxy_type=ProxyType.MANUAL
    return p, proxies

def bot_config(url):
    proxy, proxies = load_proxy()
    if sysProxy:
        proxy.http_proxy = osproxy
    else: 
        proxy.http_proxy=choice(proxies)
        
    proxy.autodetect = False
    proxy.ssl_proxy=proxy.http_proxy
    print(proxy.http_proxy)
    chrome_options=webdriver.ChromeOptions()
    chrome_options.add_argument('--mute-audio')
    chrome_options.add_argument('--no-sandbox')
    chrome_options.add_argument('ignore-certificate-errors')
    chrome_options.add_argument('----headless')
    chrome_options.add_argument('--no-startup-window')
    chrome_options.add_argument('user-agent="{}"'.format(agent.random))
    chrome_options.add_argument("--proxy-server=http://{}".format(proxy.http_proxy))
    print(chrome_options.arguments)
    print("loaded add_argument")
    capabilities=webdriver.DesiredCapabilities.CHROME
    proxy.add_to_capabilities(capabilities)
    print("loaded capabilities")
    chrome_options.binary_location = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe"
    chrome_driver_binary = "./chromedriver.exe"
    driver=webdriver.Chrome(executable_path = chrome_driver_binary,  options=chrome_options,desired_capabilities=capabilities)
    print("loaded driver")
    print(driver.get(args["url"]))
    print("sleeping",args["duration"])
    sleep(args["duration"])
    driver.close()
    print("driver closed")
    
def bot(url):
    try:
        while True:
            bot_config(url)
    except Exception as e:
        print(e)
        _exit(0)
    
def Ebot(url):
    while True:
        bot_config(url)
        


def main():
    args = load_arg()
    agent=UserAgent()
    for i in range(args["threads"]):
        t=Thread(target=Ebot,args=(args["url"],))
        t.deamon=True
        t.start()
        sleep(uniform(1.5,3.0))
    
if __name__ = "__main__":
    if test:                
        args = load_arg()
        proxy, proxies = load_proxy() 
        test_proxy(choice(proxies))
    else:
        main()
```