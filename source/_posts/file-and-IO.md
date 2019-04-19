---
layout: post
title: file_and_IO
date: 2019-04-13 09:52:42
categories: 
- [LinuxC]
- [file and io]
tags: [file and io]
---

# FIle and IO

+ 本书中库函数和系统函数的区别和联系
  + 库函数：对应的是C的标准库，针对符号的处理和I/O操作
+ 本书中讲解的计算机的体系结构：好好学习x86平台
  + 只讲Linux平台的特性，只讲Linux内核的工作原理，
  + 涉及体系结构时只讲x86平台

## 汇编程序的Hello world

1. 注意在C语言中字符串的末尾隐含有一个'\0' ，而汇编指示.ascii定义的字符串末尾没有隐含的'\0' 。
2. 在汇编程序中用.可以取出当前地址计数器的值,是一个常量。

##  C标准I/O库函数与Unbuffered I/O函数

1. 对于C标准I/O库来说，打开的文件由FILE *指针标识；
2. 而对于内核来说，打开的文件由文件描述符标识，文件描述符从open 系统调用获得；

### Unbuffered I/O 函数

1. 而Unbuffered I/O函数是UNIX标准的一部分

   + 在所有支持C的平台上应该都可以用C标准库函数(除了有些平台的C编译器没有完全符合C标准之外)

   + 而只有在UNIX平台上才能使用Unbuffered I/O函数

   + ```
     #include <unistd.h>
     ```

2. Man Page中的 COMFORMING TO部分可以看出来一个函数接口属于哪个平台。

3. 我们知道UNIX的传统是Everything is a file，Unbuffered I/O的函数属于无缓存的函数,也就是直接写到设备。

4. 关系

   {% asset_img unbuffer.png %}

### 文件描述符

1. Linux Kernel 中

   + task_struct  ：维护进程想信息，Process Descriptor

     + file_srtuct ：文件描述符表

       + 每个表包含已打开的文件指针

     + 用户程序不能直接访问内核中的文件描述符表,而只能使用文件描述符表的索引(即0、1、2、3这些数字),这些索引就称为文件描述符(File Descriptor)

       {% asset_img file_descriptor.png %}

## Open and Close

### Open 函数flags参数

1. open的flags参数

   + O_CREAT:  若此文件不存在则创建它。使用此选项时需要提供第三个参数mode ,表示该文件的访问权限。
   + O_TRUNC: 如果文件已存在,并且以只写或可读可写方式打开,则将其长度截断
     (Truncate)为0字节。

2. open and fopen 区别

   + 创建新的文件，和文件追加内容那块有区别；

   {% asset_img open_and_fopen.png %}

### open函数 mode参数

1. 文件的权限

   + 文件的权限由open 的mode参数和当前进程的umask 掩码共同决定。

2. 几个权限值

   + Shell进程的umask 

     ```
     $ umask			// 权限值是 0022
     				//umask 掩码：就是取umask的反码
     ```

   + touch file

     ```
     $ touch file	// 用touch 命令创建一个文件时,创建权限是0666
     $ ls -l file	// 看到文件是 -rw;
     ```

     + 而touch 进程继承了Shell进程的umask 掩码,所以最终的文件权限是0666 & ~022=0644。

   + gcc 

     ```
     $ gcc main.c	// 用gcc 编译生成一个可执行文件时,创建权限是0777,
     $ ls -l a.out	// 文件的权限 -rwxr
     ```

     + 同样道理,用gcc 编译生成一个可执行文件时,创建权限是0777,而最终的文件权限
       是0777&~022=0755。

### close

1. 由open 返回的文件描述符一定是该进程尚未使用的最小描述符。

2. 可以利用这一点在标准输入、标准输出或标准错误输出上打开一个新文件,实现重定向的功能。

   {% asset_img close.png %}

## read and write

### read and fgetc

1. 读数据的过程
   + read : 读上来的数据保存在缓冲区buf 中，同时文件的当前**读写位置**向后移；
     + 没有取完的数据继续保存在buf中
     + 读写位置：记录在内核中的。
   + fgetc:  getc 有可能从内核中预读1024个字节到I/O缓冲区中,再返回第一个字节,
     + 这时该文件在内核中记录的读写位置是1024
     + 而在FILE 结构体中记录的读写位置是1。
   + 是ssize_t,表示有符号的size_t 
2. read and write 中的count
   + 面对读写常规文件时：read / write 的返回值通常等于请求写的字节数count
   + 面对的是终端设备Terminal：通常以行为单位,读到换行符就返回，不一定是count。
   + 面对网络读写时：有不同的传输协议，不一定是count

### 阻塞 Block 现象

+ 阻塞状态：针对终端设备和网络读取

1. Sleeping：当进程调用一个阻塞的系统函数时，该进程被置于睡眠(Sleep)状态，这时内核调度其它进程运行，直到该进程等待的事件发生。

2. Running：

   + 正在都被调度执行：

     {% asset_img running.png %}

   + 就绪状态

     + 已经准备好，处于排队中，随时准备被调用
     + 按照优先级进行调用

### Unblocking

+ 如果在open 一个设备时指定了O_NONBLOCK 标志,read / write 就不会阻塞。

1. 轮询（Poll）方式
   + 表示本来应该阻塞在这里(would block,虚拟语气),事实上并没有阻塞而是直接返回错误,调用者应该试着再读一次(again)。
   + 调用者只是查询一下，而不是阻塞在这里死等，这样可以同时监视多个设备:
2. 通过 goto 无条件跳转函数，实现非阻塞读终端

## lseek 移动当前的读写位置

1. lseek 和 标准I/O库的fseek 函数类似,可以移动当前读写位置(或者叫偏移量)。

   + 参数offset和whence的含义和fseek 函数完全相同。只不过第一个参数换成了文件描述符。
   + fseek 成功时返回0失败时返回-1,要返回当前偏移量需调用ftell 

   + 而lseek 成功时返回当前偏移量失败时返回-1。

## Fcntl 

+ 对已经打开的文件，重新设定其属性，新设置读、写、追加、非阻塞等标志 （file status flag）
+ 优点：不用重新打开文件
  + 像标准输入 stdin stdout stderr；这些标准输出文件，在开始运行的时候便已经打开；
  + 或者其他已经打开的文件，需要重新设定其属性

### Shell 的重定向功能

+ 利用Shell的重定向功能在该描述符上打开文件
+ open打开的文件，返回的文件描述符一定是该进程尚未使用的最小描述符；
  + 以利用这一点在标准输入、标准输出或标准错误输出上打开一个新文件,实现重定向的功能。

1. shell重定向语法

   + 如果在<、>、>>、<>前面添一个数字，该数字就表示在哪个文件描述符上打开文件,
   + [file_and_io/fcntl/cmd_flag.c](https://github.com/quronghui/LinuxC.git)

   ```
   $ ./cmd.flag 0 < /dev/tty	//时将它的标准输入重定向到/dev/tty ,并且是只读的。
   // argv[0] 是"./a.out",argv[1] 是"0"
   //重定向由Shell解释,在启动程序时已经生效,程序在运行时并不知道标准输入被重定向了。
   ```

   ```
   $ ./a.out 1 > temp.foo	// 标准输出，重定向到文件temp.foo
   $ ./a.out 2 2>>temp.foo	//,注意2和>>之间不能有空格,否则2就被解释成命令行参数了。
   $ ./a.out 5 5<>temp.foo
   ```

### /dev/null  设备文件

+ /dev/null 设备文件只有一个作用,往它里面写任何数据都被直接丢弃。
+ 因此保证了该命令执行时屏幕上没有任何输出，既不打印正常信息也不打印错误信息，让命令安静地执行。
+ 这种写法在Shell脚本中很常见。

```
$ command > /dev/null 2>&1	//文件描述符数字写在重定向符号右边需要加&号,否则就被解释成文件名，二期不能有空格
```

## ioctl 

1. ioctl 用于向设备发控制和配置命令,有些命令也需要读写一些数据,但这些数据是不能用read /write 读写的,称为Out-of-band数据。
   + read/ write 读写的数据是in-band数据,是I/O操作的主体。
   + 而ioctl 命令传送的是控制信息,其中的数据是辅助的数据。

##  mmap 映射函数

### Introduction

1. mmap 可以把磁盘文件的一部分直接映射到内存,这样文件中的位置直接就有对应的内存地址；

2. 对文件的读写可以直接用指针来做而不需要read /write 函数。

3. strace command

   ```
   $ strace ./a.out
   ```

   