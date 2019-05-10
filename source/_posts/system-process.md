---
layout: post
title: system_process
date: 2019-04-22 14:11:43
categories: 
- [LinuxC]
- [process]
tags: process
---

# System Process

## Process

1. 每个进程：在内核中都有一个进程控制块(PCB Process control block)来维护进程相关的信息

   + Linux内核的进程控制块是task_struct结构体
   + 结构体包含的信息

   {% asset_img task_struct.png %}

2. fork and exec

   + fork 和exec 是本章要介绍的两个重要的系统调用。
   + fork : 根据一个现有的进程复制出一个新进程
     + 父进程：parent process
     + 子进程：child process
   + exec : 在Shell下输入命令（终端）可以运行一个程序
     + Shell进程在读取用户输入的命令之后会调用fork 复制出一个新的Shell进程
     + 然后新的Shell进程调用exec 执行新的程序。

3. 父进程和子进程

   + 子进程的PCB是根据父进程复制而来的,所以其中的umask 掩码也和父进程一样。

   {% asset_img fork_and_exec.png %}

   + 父进程在创建子进程时会复制一份环境变量给子进程,但此后二者的环境变量互不影响。

## 环境变量

1. exec 系统调用

   + exec 系统调用执行新程序时会把命令行参数和环境变量表传递给main 函数
   + 和命令行参数argv类似,环境变量表也是一组字符串

2. 全局变量 environ

   + libc 中定义的全局变量environ指向环境变量表,

   + environ 没有包含在任何头文件中,所以在使用时要用extern声明。

     ```
     extern char **environ;
     int i;
     for(i=0; environ[i]!=NULL; i++)
     	printf("%s\n", environ[i]);	// 打印出环境变量
     return 0;
     
     ```

3. 环境变量

   + ,环境变量字符串都是name=value 这样的形式,

     + name 由大写字母加下划线组成，叫做环境变量
     + value：,value 的部分则是环境变量的值。

   + 环境变量值含义

     + PATH 

       ```
       $ echo $PATH	// 查看环境变量的值: $xxx
       ```

     + SHELL : 它的值通常是/bin/bash 。

4. gentenv 函数

   + 查找某一个环境变量的值它对应的value ；

5. sentenv 函数

   + 修改环境变量可以用以下函数

   {% asset_img sentenv.png %}

## 进程控制

### fork 函数

1. pid = fork() 调用的返回结果

   {% asset_img fork_result.png %}

2. 调用过程

   + 父进程和子进程的PCB信息相同,用户态代码和数据也相同；
   + 现在有两个一模一样的进程看起来都调用了fork 进入内核等待从内核返回，返回的先后顺序取决于内核的调度算法

3. fork函数

   + fork 函数的特点概括起来就是“调用一次,返回两次”,在父进程中调用一次,在父进程和子进程中各返回一次。
   + 子进程中fork 的返回值是0,而父进程中fork 的返回值则是子进程的id

4. gdb调试

   + gdb只能跟踪一个进程(默认是跟踪父进程)，而不能同时跟踪多个进程，
   + 但可以设置gdb 在fork 之后跟踪父进程还是子进程

   ```
   $ (gdb) set follow-fork-mode child	// gdb 跟踪子进程 
   ```

### exec 函数

1. 子进程如何执行程序

   + 用fork 创建子进程后执行的是和父进程相同的程序，子进程往往要调用一种exec 函数以执行另一个程序。
   + 调用exec 并不创建新进程，以调用exec 前后该进程的id并未改变。

2. exec 函数族

   + 如果调用出错则返回-1，所以exec 函数只有出错的返回值而没有成功的返回值。

   {% asset_img exec.png %}

   + 不带字母p(表示path)的exec函数第一个参数必须是程序的相对路径或绝对路径

     ```
     /bin/ls or ./a.out		不能是  ls or a.out
     ```

   + 于带字母p的函数:

     + 如果参数中包含 / ，则将其视为路径名。
     + 否则视为不带路径的程序名，在PATH环境变量的目录列表中搜索这个程序。

   + 带有字母l(表示list)的exec函数

     + 要求将新程序的每个命令行参数都当作一个参数传给它
     + 命令行参数的个数是可变的

   + 对于带有字母v(表示vector)的函数

     + 则应该先构造一个指向各参数的指针数组,然后将该数组的首地址当作参数传给它,数组中的最后一个指针也应该是NULL 
     + 就像main 函数的argv参数或者环境变量表一样。

   + 对于以e(表示environment)结尾的exec 函数

     + 可以把一份新的环境变量表传给它,其他exec 函数仍使用当前的环境变量表执行新程序。

   + 事实上,只有execve是真正的系统调用,其它五个函数最终都调用execve 

     + man 2 execve

     {% asset_img execve.png %}


### upper 函数

+ 转换小写为大些

1. 函数实现

   ```
   while((ch = getchar()) != EOF) {
   	putchar(toupper(ch));	
   }
   ```

2. she'll的重定向功能 

   + 简单的标准输入输出重定向(<和>)

   ```
   $ cat file.txt
   this is the file, file.txt, it is all lower case.
   $ ./upper < file.txt
   THIS IS THE FILE, FILE.TXT, IT IS ALL LOWER CASE.
   ```

### wait and waitpid 函数

1. 彻底清除进程

   + 一个进程在终止时会关闭所有文件描述符，释放在用户空间分配的内存；
   + 内核在其中保存了一些关于进程是否正确退出
   + Shell是它的父进程,当它终止时Shell调用wait 或waitpid 得到它的退出状态同时彻底清除掉这个进程。

2. 僵尸(Zombie)进程

   + 如果一个进程已经终止,但是它的父进程尚未调用wait 或waitpid对它进行清理
   + 自动调用函数，除非自己写函数进行查看。

   ```
   $ ps u	// 查看进程状态
   STAT 为z时 -- 僵尸进程的状态
   ```

3. 清除僵尸进程

   + 调用函数

   {% asset_img waitpid.png %}

## 进程间通信

###  IPC InterProcess Communication

1. 进程各自有不同的用户地址空间,任何一个进程的全局变量在另一个进程中都看不到。

2. 进程之间要交换数据必须通过内核，进程1把数据从用户空间拷到内核缓冲区,进程2再从内核缓冲区把数据读走。

   {% asset_img ipc.png %}

### Pipe 管道

1. 函数

   ```
   #include <unistd.h>
   int pipe(int filedes[2]);
   ```

   + 数组filedes[0] 指向管道的读端，filedes[1] 指向管道的写端(很好记,就像0是标准输入1是标准输出一样)。

2. 管道单向通信

   {% asset_img pipe.png %}

   + 父进程调用fork创建子进程，那么子进程也有两个文件描述符指向同一管道。
   + 父进程关闭管道读端,子进程关闭管道写端。
   + 数据从写端流入从读端流出,这样就实现了进程间通信

3. 管道通信的特殊情况

   + 进程间通信必须通过内核提供的通道，两个进程通过一个管道只能实现单向通信
   + 管道的读写端通过打开的文件描述符来传递；
   + 通过fork 传递文件描述符使两个进程都能访问同一管道,它们才能通信。

   {% asset_img pipewait.png %}

### 其他 IPC 机制

{% asset_img processC.png %}

