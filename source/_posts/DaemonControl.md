---
layout: post
title: DaemonControl
date: 2019-04-28 09:42:24
categories: 
- [LinuxC]
- [Linux system complie]
tags: 
- [Daemon]
- [Control]
---

# Daemon Control

+ 作业控制：将进程放在前台或者后台执行
+ 守护进程：即使关闭了terminal，进程也能继续执行

## Terminal

### Introduction

1. 控制终端(Controlling Terminal)

   + 用户通过终端登录系统后得到一个Shell进程，这个终端成为Shell进程的控制终端
   + 控制终端是保存在PCB中的信息
   + 每个进程的标准输入、标准输出和标准错误输出都指向控制终端
   + 在控制终端输入一些特殊的控制键可以给前台进程发信号
     + 例如 Ctrl-C表示SIGINT
     + Ctrl-\ 表示SIGQUIT

2. ttyname 函数

   + 文件描述符查出对应的文件名
   + 该文件描述符必须指向一个终端设备而不能是任意文件

   ```
   $ printf("fd 0 : %s\n", ttyname(0))；
   ```

### Terminal Login

+ 登录用户模式，或者root模式

1. 一台PC通常只有一套键盘和显示器,也就是只有一套终端设备/dev/tty0

   + 虚拟终端(Virtual Terminal)：设备文件分别是/dev/tty1~ /dev/tty6 

   ```
   $ Ctrl-Alt-F1 ~ Ctrl-Alt-F6		// 切换到6个字符终端
   ```

2. 内核中处理终端设备的模块

   + 包括硬件驱动程序
     + 硬件驱动程序负责读写实际的硬件设备
   + 线路规程(LineDiscipline)
     + 线路规程像一个过滤器
     + 某些特殊字符并不是让它直接通过，而是做特殊处理

3. 终端设备有输入和输出队列缓冲区

   + 命令行键入字符时,该字符不仅可以被程序读取,我们也可以同时在屏幕上看到该字符的回显。

4. Terminal Login

   + 系统启动时，init进程根据配置文件确定需要打开哪些终端。
   + 把文件描述符0、1、2都指向控制终端，然后提示用户输入帐号。
   + login 程序提示用户输入密码(输入密码期间关闭终端的回显),然后验证帐号密码的正确性。

### Network Login

+ 虚拟终端或串口终端的数目是有限的。

1. 伪终端(Pseudo TTY)
   + 实现：网络终端或图形终端窗口的数目却是不受限制的
   + 一套伪终端由一个主设备(PTY Master)和一个从设备(PTY Slave)组成。
     + 主设备在概念上相当于键盘和显示器,只不过它不是真正的硬件而是一个内核模块,操作它的也不是用户而是另外一个进程
     + 从设备和上面介绍的/dev/tty1 这样的终端设备模块类似,只不过它的底层驱动程序不是访问硬件而是访问主设备。
2. Network Login
   + 用户通过telnet客户端连接服务器；服务器监听连接请求是一个telnetd进程。
   + telnetd子进程打开一个伪终端设备,然后再经过fork 一分为二:父进程操作伪终端主设备,子进程将伪终端从设备作为它的控制终端
   + 当用户输入命令时,telnet客户端将用户输入的字符通过网络发给telnetd 服务器,由telnetd 服务器代表用户将这些字符输入伪终端。
3. 交互
   + 我们每按一个键telnet客户端都会立刻把该字符发送给服务器
   + 这个字符经过伪终端主设备和从设备之后被Shell进程读取，同时回显到伪终端从设备
   + 回显的字符再经过伪终端主设备、telnetd服务器和网络发回给telnet 客户端,显示给用户看。
4. 设备
   + ptyXX 是主设备,相对应的ttyXX 是从设备

## Jobs Control

### Session 和进程组

1. Shell分前后台来控制的不是进程而是作业(Job)或者进程组(Process Group)。

2. Jobs Control

   + Shell可以同时运行一个前台作业和任意多个后台作业

   ```
   $ proc1 | proc2 &		//proc1 和proc2 属于同一个后台进程组
   $ proc3 | proc4 | proc5	//前台进程组
   ```

   {% asset_img session.png %}

3. 从Session和进程组的角度重新来看登录和执行命令的过程

   + Session Leader

     + getty 或telnetd进程在打开终端设备之前调用setsid函数创建一个新的Session
     + 该进程的id也是进程组的id。

   + 命令

     ```
     $ ps -o pid,ppid,pgrp,session,tpgid,comm | cat
     $ ps -o pid,ppid,pgrp,session,tpgid,comm | cat &
     ```

     + 这个作业由ps和cat 两个进程组成，分别在前台和后台运行

### 与作业控制有关的信号

1. 后台进程

   + 不能读终端输入的,
   + 因此终端有输入时，内核发SIGTTIN信号给进程；
   +  该信号的默认处理动作是使进程停止。

2. jobs and fg

   ```
   $ jobs 		// jobs 命令可以查看当前有哪些作业
   $ fg %1		// fg命令可以将某个作业提至前台运行，或者将停下的进程开启
   			// 参数%1表示将第1个作业提至前台运行。
   $ bg %1		// bg 命令可以让某个停止的作业在后台继续运行
   $ ps		// 查看当前的控制信号
   ```

3. cat 

   ```
   $ cat & 	// 后台运行进程
   ```

### Daemon Process

1. 守护进程(Daemon)
   + 用户关闭终端窗口或注销也不会影响守护进程的运行。
2.  $ ps axj
   + 查看系统中的进程
     + 参数a 表示不仅列当前用户的进程,也列出所有其他用户的进程
     + 参数x 表示不仅列有控制终端的进程,也列出所有无控制终端的进程
     + 参数j表示列出与作业控制相关的信息。
   + 进程信息
     + 守护进程：没有控制终端的进程，TPGID =  -1
       + 守护进程：通常采用以d结尾的名字,表示Daemon。
     + 内核线程Kernel：用[]括起来的名字，采用以k 开头的名字
3. 创建守护进程
   + 最关键的一步是调用setsid函数创建一个新的Session,并成为Session Leader。
     + 调用这个函数之前,当前进程不允许是进程组的Leader,否则该函数返回-1。
     + 要先fork 再调用setsid，保证当前进程不是Leader。