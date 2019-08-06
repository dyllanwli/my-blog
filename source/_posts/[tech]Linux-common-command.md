---
layout: title
title: Linux common command
date: 2017-03-11 09:11:06
tags: linux
categories: Tech
---
```
查找超过10M的文件

	find <PATH >-size +10M

Find the files which modified since 120 days before

	find ./ -mtime +120

Find the file haven’t been visited within 90days

	find ./ \! -atime -90

at命令用来安排一个程序在未来的做一次一次性执行。所有提交的任务都被放在 /var/spool/at 目录下并且到了执行时间的时候通过atd守护进程来执行。

lspci命令用来显示你的系统上PCI总线和附加设备的信息。指定-v，-vv或-vvv来获取越来越详细的输出，加上-r参数的话，命令的输出则会更具有易读性。

显示目录和文件的命令
   Ls：用于查看所有文件夹的命令。
   Dir：用于显示指定文件夹和目录的命令   Tree： 以树状图列出目录内容
   Du：显示目录或文件大小 
 
修改目录，文件权限和属主及数组命令
   Chmod：用于改变指定文件的权限命令。
   Chown：用于改变文件拥有属性的命令。
   Chgrp：用于改变文件群组的命令。
   Chattr：用于设置文件具有不可删除和修改权限。
   Lsattr：用于显示文件或目录的隐藏属性。
 
创建和删除目录的命令
   Mkdir：用于创建目录
   Rmdir：用于删除空的目录
   Rm -f：用于删除不为空的目录
 
创建和删除，重命名，复制文件的命令
  Touch：创建一个新的文件
   Vi:创建一个新的文件
   Rm：删除文件或目录
   Mv：重命名或移动文件的命令
   Cp：复制命令

 
显示文件内容的命令
   Cat：用于显示指定文件的全部内容
   More：用分页的形式显示指定文件的内容
   Less：用分页的形式显示指定文件的内容，区别是more和less翻页使用的操作键不同。
   Head：用于显示文件的前n行内容。
   Tail：用于显示文件的后n行内容。
   Tail -f：用于自动刷新的显示文件后n行数据内容。
 
查找命令
   Find：查找指定的文件。
   Whereis：查找指定的文件源和二进制文件和手册等
   Which：用于查询命令或别名的位置。
   Locate：快速查找系统数据库中指定的内容。
   Grep：查找文件里符合条件的字符串。
 
关机和重启计算机的命令
     
   Shutdown：-r 关机后立即重启
             -k 并不真正的关机，而只是发出警告信息给所有用户
             -h 关机后不重新启动
   Poweroff：用于关机和关闭电源
   Init：改变系统运行级别
        0级用于关闭系统
        1 级用于单一使用者模式
        2级用来进行多用户使用模式（但不带网络功能）
        3级用来进行多用户使用模式（带网络全功能）
        4级用来进行用户自定义使用模式
        5级表示进入x  windows时的模式
        6级用来重启系统
   Reboot： 用于计算机重启
   Halt：用于关闭计算机系统
 
压缩和打包命令
   Tar：用于多个文件或目录进行打包，但不压缩，同时也用命令进行解包
   Gzip：用于文件进行压缩和解压缩命令，文件扩展名为.gz结尾。
   Gunzip：用于对gzip压缩文档进行解压缩。
   Bzip2：用于对文件或目录进行压缩和解压缩
   Bzcat：用于显示压缩文件的内容。
   Compress/un compress： 压缩/解压缩.Z文件
   Zcat：查看z或gz结尾的压缩文件内容。
   Gzexe：压缩可执行的文件
   Unarg：解压缩.arj文件
   Zip/unzip:压缩解压缩.zip文件
 
用户操作命令
   Su：切换用户命令
   Sudo：一系统管理员的身份执行命令
   Passwd：用于修改用户的密码
 
改变目录和查看当前目录命令
   Cd：进入工作目录
   Cd 。。：会退到上一级命令
   Pwd：显示当前用户所在工作目录位置
 
文件连接命令
   Ln：为源文件创建一个连接，并不将源文件复制一份，即占用的空间很小。
        可以分为软件连接和硬链接。
        软连接：也称为符号连接，即为文件或目录创建一个快捷方式。
硬链接：给一个文件取多于一个名字，放在不同目录中，方便用户使用。
 
Ln命令参数如下：
   -f：在创建连接时，先将与目的对象同名的文件或目录删除。
   -d：允许系统管理者硬链接自己的目录。
   -i：在删除与目的对象同名文件或目录时先询问用户。
   -n：在创建软连接时，将目的对象视为一般的文件。
   -s：创建软连接，即符号连接。
   -v：在连接之前显示文件或目录名。
   -b：将在连接时会被覆盖或删除的文件进行备份。
 
帮助命令-----man
其他命令
   Who：显示系统中有那些用户在使用。
        -ami  显示当前用户
        -u：显示使用者的动作/工作
        -s：使用简短的格式来显示
        -v：显示程序版本
   Free：查看当前系统的内存使用情况
   Uptime：显示系统运行了多长时间
   Ps：显示瞬间进程的动态
   Top: 动态地显示进程
   Pstree：以树状方式显示系统中所有的进程
   Date：显示或设定系统的日期与时间。
   Last：显示每月登陆系统的用户信息
   Kill： 杀死一些特定的进程
   Logout：退出系统
   Useradd/userdel:添加用户/删除用户
   Clear：清屏
   Passwd：设置用户密码
 
 
vi编辑器
   首先用vi命令打开一个文件
末行模式命令：
   :n,m w path/filename 保存指定范围文档（ n表开始行，m表结束行）
   :q!    对文件做过修改后，强制退出
   :q     没有对文件做过修改退出
   Wq或x  保存退出
   dd   删除光标所在行
   ： set number 显示行号
   ：n 跳转到n行
   ：s  替换字符串 :s/test/test2/g  /g全局替换 /也可以用%代替
   / 查找字符串
 
网络通信常用的命令
   Arp：网络地址显示及控制
   ftp：文件传输
   Lftp：文件传输
   Mail：发送/接收电子邮件
   Mesg：允许或拒绝其他用户向自己所用的终端发送信息
   Mutt E-mail 管理程序
   Ncftp ：文件传输
   Netstat：显示网络连接.路由表和网络接口信息
   Pine：收发电子邮件，浏览新闻组
   Ping：用于查看网络是否连接通畅
   Ssh：安全模式下远程登陆
   Telnet：远程登录
   Talk：与另一用户对话
   Traceroute：显示到达某一主机所经由的路径及所使用的时间。
   Wget：从网路上自动下载文件
   Write：向其它用户终端写信息    Rlogin：远程登录



如今出去面试多少都会被问及个linux的问题， 而且项目进uat后也都要发到linux下， 所以知道几个linux命令是必要的。
 第一个，也是最有用的一个：
man 察看命令详解,只要觉得哪个命令不清楚，man它就可以了.
   man ls
 ln 创建链接文件
  ln -s sourceName destName
 ls 列出文件  -l: 逐行显示且列出详细属性  -a: 列出所有文件包括以.开头的隐藏文件
  ls -lqt /bin
cat 读取文本内容
  -n: 显示行号  -b: 显示行号且忽略空行
  cat -n 1.txt
 
wc: 计数  -l: 行数  -w: 字数  -c: 字符数  wc -l file1 file2 ......可以统计多个文件
 
cp 拷贝文件 目录  -i: 交互模式，如果目标文件存在，则询问是否覆盖  -r: 拷贝目录  cp file1 file2 file3.... dir 表示将file1,file2...拷贝到dir  cp -r dir1 dir2 dir3... dirn 将dir1, dir2,dir3...拷贝到dirn
 
file 察看文件类型
  file test.sh
 
mv 移动文件，更改文件名  -i: 交互模式，如果目标文件存在，则询问是否覆盖  -r: 移动目录，跟改目录名
 
rm 删除文件
  -i: 交互模式，询问是否删除  rm -r dir1 dir2 dir3...可删除多个
 
mkdir 创建目录  -p: parent,父目录不存在，则创建父目录
  mkdir -p test/test
 
rmdir 删除目录  等同与rm -r  rmdir dir1 dir2 dir3 ....  rm -r dir1 dir2 dir3 ....
chmod 更改权限  chmod -R 777 DIR改变目录下所有文件权限为777，必须是-R
 权限 -rwxrwxrwx         421421421  最前面的-表示文件类型为普通文件  接下来三位表示所有者权限  接下来三位表示组权限  最后三位表示其它用户权限  如果某一权限没有被分配，用-表示。-rwxr--rwx表示组没有写和执行权限  文件加夜有可执行权限，但表示是否容许在该目录下寻找文件
chown 改变所有者

chgrp 改变组

command &  命令后面加&表示在后台运行  find . -name "*.sh"&
fg 把后台进程放到前台  fg %1 把后台第一个作业放到前台
bg  把前台进程放到后台
jobs  显示后台或挂起的进程
ps   显示所有进程  ps -f 显示完全信息，包括占用cpu时间，开始时间。。。
kill  -9 强制结束   more 显示文本内容，每次一屏，按空格继续  find / -name "*.sh" | more
tail 从指定的位置开始显示后面得内容  tail -f server.log 用于在server上边运行边察看日志  tail -10 dos2unix.sh 察看最后10行
head  与tail对应
sort 排序  -r 逆序  -d 字典顺序  ls | sort -r
tr  字符替换
  -d 删除指定字符  ls | tr -d 'log'  ls | tr 'd' 'g'把d变成g
at time date job  定时调度
compress  -f 压缩文件  -v 显示压缩比例  compress -vf project.tar 将产生project.tar.Z且project.tar被删除
uncompress  -f 解压缩文件  -v 显示压缩比例  uncompress project.tar.Z 将产生project.tar且project.tar.Z被删除  tar  -c 创建新文档  -x 解包  -v 显示正在处理的文件名  -f 取代默认的文件名  tar -cvf project.tar project/* 把project目录下所有文件打包  tar -xvf project.tar



 crontab 
　　使用权限 : 所有使用者 
　　
　　使用方式 : 
　　
　　crontab [ -u user ] file 
　　crontab [ -u user ] { -l | -r | -e } 
　　

　　crontab   指定使用者在固定时间执行程序，换句话说，即使用者的时程表。-u user 是指设定指定 user 的时程表，这个前提是你必须要有其权限(比如说是 root)才能够指定他人的时程表。如果不使用 -u user 的话，就是表示设定自己的时程表。 
```