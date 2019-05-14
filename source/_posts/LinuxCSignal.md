---
layout: post
title: LinuxC Signal
date: 2019-04-26 09:42:38
categories: 
- [LinuxC]
- [Linux system complie]
tags: signal
---

# LinuxC Signal 

+ 进程在执行代码时，收到内核的Signal，使得进程终止
+ 代码遇到一个问题：头文件包含函数，但是函数调用不成功

## Signal

1. 查询 

   ```
   $ man 7 signal	//详细说明
   ```

   + Ctrl-C产生的信号只能发给前台进程。
   +  “wait和waitpid函数”中我们看到一个命令后面加个& 可以放到后台运行
     + 这样Shell不必等待进程结束就可以接受新的命令

2. 信号：

   + 使用该进程，执行用户空间代码时，执行到任何地方都有可能收到SIGINT信号终止进程。
   + 信号相对于进程的控制流程来说是异步(Asynchronous)的。

   ｛% asset_img signal_start.png %｝

3. 不想按默认动作处理信号

   + 用户程序可以调用sigaction(2) 函数告诉内核如何处理某种信号

4. SIGINT的默认处理动作是终止进程
   
   + SIGQUIT的默认处理动作是终止进程并且CoreDump

## 产生信号

### 通过终端按键产生信号

1. CoreDump (核心转存)

   + 当一个进程要异常终止时,可以选择把进程的用户空间内存数据全部保存到磁盘上；
   + 文件名通常是core，这叫做Core Dump

2. 进程异常终止

   + 有Bug,比如非法内存访问导致段错误；
   + 事后可以用调试器检查core 文件以查清错误原因，做Post-mortem Debug。

3. Core 文件

   + 一个进程允许产生多大的core 文件取决于进程的Resource Limit
   + 默认是不允许产生core 文件的,因为core 文件中可能包含用户密码等敏感信息,不安全。

   ```
   $ ulimit -c 1024	// ulimit命令改变这个限制,允许产生core文件，最大值是1024
   ```

4. 按键产生signal

   ```
   $ ./a.out	// press ctrl+c 
   $ ./a.out 	// press ctrl+\
   $ ls -l core	//core dump
   ```

### 调用系统函数向进程发信号

1. 后台运行程序

   ```
   $ ./a.out &		//首先在后台执行这个程序;数字代表进程的id
   $ kill -SIGSEGV 7940
   $ 再次回车			// ,Shell不希望Segmentation fault 信息和用户的输入交错在一起
   ```

   + 以往遇到的段错误都是由非法内存访问产生的,而这个程序本身没错,给它发SIGSEGV 也能产生段错误。

2. 也可以调用函数

   ```
   int kill(pid_t pid, int signo);
   int raise(int signo);
   ```

3. abort函数

   + abort 函数使当前进程接收到SIGABRT 信号而异常终止。
   + 就像exit 函数一样,abort 函数总是会成功的,所以没有返回值。

### 由软件条件产生信号

1. SIGPIPE是一种由软件条件产生的信号
2. alarm 和SIGALRM 信号
   + 调用alarm 函数可以设定一个闹钟,也就是告诉内核在seconds秒之后给当前进程发SIGALRM 信号
   + 该信号的默认处理动作是终止当前进程。

## 阻塞信号

### 信号在内核中的表示

1. 信号递达Delivery

   + 而实际执行信号的处理动作

2. 信号未决 Pending

   + 信号从产生到递达之间的状态

3. 阻塞Block：进程可以选择阻塞某个信号

   + 被阻塞的信号产生时将保持在未决状态,直到进程解除对此信号的阻塞,才执行递达的动作。

4. 忽略某个信号

   +  只要信号被阻塞就不会递达,而忽略是在递达之后可选的一种处理动作。

5. 每个信号包含三个要素

   + 都有两个标志位：分别表示阻塞block和未决pending
     + 还有一个函数指针sighandler表示处理动作。

   + 信号产生时，内核在进程控制块中设置该信号的未决标志,直到信号递达才清除该标志。

6. sigset_t 称为信号集

   +  sigset_t来存储：未决和阻塞标志
   + 阻塞信号集中：“有效”和“无效”的含义是该信号是否被阻塞,
   + 未决信号集中：“有效”和“无效”的含义是该信号是否处于未决状态。

7. 阻塞信号集

   + 也叫做当前进程的信号屏蔽字(Signal Mask)

### 信号集操作函数

1. sigset_t 类型对于每种信号用一个bit表示“有效”或“无效”状态
2. sigemptyset
   + 初始化set 所指向的信号集,使其中所有信号的对应bit清零
   + 在使用sigset_t 类型的变量之前,一定要调用sigemptyset或sigfillset 做初始化,使信号集处于确定的状态。
3. sigprocmask
   + 调用函数sigprocmask可以读取或更改进程的信号屏蔽字。
   + 如果调用sigprocmask解除了对当前若干个未决信号的阻塞，则在sigprocmask返回前，至少将其中一个信号递达。
4. sigpending
   + sigpending 读取当前进程的未决信号集,通过set参数传出。

## 捕捉信号

### 内核捕捉信号

1. 捕捉信号

   + 如果信号的处理动作是用户自定义函数,在信号递达时就调用这个函数
   + 用户注册SIGQUIT信号的处理函数：sighandler

2. 内核捕捉函数

   + 第一次进入内核：发生中断或异常切换到内核态。
   + 第二次进入内核：中断处理完后，检查到有信号SIGQUIT递达，执行sighandler 函数；系统调用sigreturn 再次进入内核态。
   + 如果没有新的信号要递达,这次再返回用户态就是恢复main 函数的上下文继续执行了。如果有信号递达，在执行（第二次进入内核）

   {% asset_img signalhandler.png %}

### sigaction

+ sigaction 函数可以读取和修改与指定信号相关联的处理动作

1. sigaction：两个参数指向 struct signaction 结构体
2. sa_sigaction 是实时信号的处理函数。

### pause

1. pause 函数使调用进程挂起直到有信号递达。
   + 如果信号的处理动作是捕捉,则调用了信号处理函数之后pause 返回-1,errno 设置为EINTR ,所以pause 只有出错的返回值
   + 如果信号的处理动作是终止进程,则进程终止,pause 函数没有机会返回;

### 可重入函数

1. 引入了信号处理函数sighandler：使得一个进程具有多个控制流程。

2. 重入函数：

   + 如果一个函数只访问自己的局部变量或参数,则称为可重入(Reentrant )函数。
   + 函数被不同的控制流程调用
   + 有可能在第一次调用还没返回时就再次进入该函数(两次进内核函数)

3. 不可重入函数：

   + insert函数访问一个全局链表,有可能因为重入而造成错乱,像这样的函数称为不可重入函数,

   {% asset_img unreentrant.png %}

###  sig_atomic_t类型与volatile限定符

+ 在使用sig_atomic_t类型时，加上volatile限定符

1. 为了避免重入造成的链表错乱现象
   + 线程会讲到如何保证一个代码段以原子操作完成。
   + 在使用sig_atomic_t类型时，加上volatile限定符，也能保证原子操作
2. 编译器无法识别
   + 只能说编译器无法识别程序中存在多个执行流程。
   + 比如sigaction 、pthread_create ,这些不是C语言本身的规范,不归编译器管,程序员应该自己处理这些问题

### 竞态条件

1. 竞态条件(Race Condition):
   + 由于异步事件在任何时候都有可能发生(这里的异步事件指出现更高优先级的进程)
   + 如果我们写程序时考虑不周密,就可能由于时序问题而导致错误
2. sigsuspend 函数
   + 要是“解除信号屏蔽”和“挂起等待信号”这两步能合并成一个原子操作的功能。
   + 进程的信号屏蔽字由sigmask参数指定,可以通过指定sigmask来临时解除对某个信号的屏蔽,然后挂起等待

### SIGCHLD 信号

1. 为了避免僵尸程序的产生
   + 子进程在终止时会给父进程发SIGCHLD信号
2. 方法
   + 父进程调用sigaction 将SIGCHLD 的处理动作置为SIG_IGN ,这样fork 出来的子进程在终止时会自动清理掉,不会产生僵尸进程,也不会通知父进程。