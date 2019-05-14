---
layout: post
title: Thread
date: 2019-05-05 19:11:04
categories: 
- [LinuxC]
- [Linux system complie]
tags: Thread
---

# Thread

## Introduction

1. Why?

   + 有些情况需要在一个进程中同时执行多个控制流程；
     + 比如实现一个图形界面的下载软件：下载和交互多个线程
   + main 函数和信号处理函数是同一个进程地址空间中的多个控制流程
     + 信号处理函数的控制流程只是在信号递达时产生
     + 在处理完信号之后就结束
   + 多线程的控制流程
     + 可以长期并存，操作系统会在各线程之间调度和切换,就像在多个进程之间调度和切换一样。
     + 同一进程的多个线程共享同一地址空间
       + Text Segment、Data Segment都是共享
       + 文件描述符表；每种信号的处理方式；当前工作目录；用户id和组id
     + 线程独立的资源
       + 线程id ....

2. Complie

   + 在Linux上线程函数位于libpthread 共享库中,因此在编译时要加上-lpthread 选项

   ```
   $ gcc main.c -lpthread
   ```

   + 线程库函数是由POSIX标准定义的,称为POSIX thread或者pthread。

     ```
     $ man pthread_
     ```

## Thread Control

+ 变量类型 pthread_t

### thread_create

1. thread_create()
   + 线程 --> pthread_create( )，当前线程从pthread_create()返回继续往下执行;
   + 新线程执行代码：
     + 由函数指针start_routine决定
     + start_routine 函数接收一个参数,是通过pthread_create的arg参数传递给它
     + 类型为void *
     + start_routine 返回时,这个线程就退出
   + 其它线程可以调用pthread_join 得到start_routine的返回值
   
2. Process vs Thread
   + Process
     + id 的类型是pid_t ，id在整个系统中是唯一的；
     + 调用getpid(2)可以获得当前进程的id , 是一个正整数值。
   + Thread
     + 线程id的类型是thread_t，它只在当前进程中保证是唯一的
     + id 值类型不唯一，不能简单地当成整数用printf打印,调用pthread_self(3) 可以获得当前线程的id
   + pid  and tid
     + 多个线程调用getpid(2) 可以得到相同的进程号
     + 而调用pthread_self(3) 得到的线程号各不相同。
   + error
     + fork : 错误码保存在errno 中，直接用perror(3) 打印错误信息,
     + thread：先用strerror(3)把错误码转换成错误信息再打印。
   
3. 中止
   
   + 如果任意一个线程调用了exit 或_exit ,则整个进程的所有线程都终止
   
4. make 编译

   ```
   $ gcc -g -c thread.c -o thread.o
   $ gcc thread.o -plthread -o thread	// -plthread 位置要在后面，才能正常link
   ```


### thread_exit 

1. 三种终止线程的方式

   {% asset_img thread_exit.png %}

2. pthread_join()

   {% asset_img pthread_join.png %}

   + 在Linux的pthread库中常数PTHREAD_CANCELED 的值是-1。可以在头文件pthread.h 中找到它的定义。

3. pthread_detach

   + 线程终止后，其终止状态一直保留到其它线程调用pthread_join获取它的状态为止
   + 线程置为detach状态：这样的线程一旦终止就立刻回收它占用的所有资源,而不保留终止状态。
   + 一个线程调用了pthread_detach 就不能再调用pthread_join 了。

## thread time synchronize

### metux

+ 变量类型：pthread_mutex_t

+ 多个线程同时访问共享数据时可能会冲突,这跟前面讲信号时所说的可重入性是同样的问题。

1. Mutual Excludive Lock 互斥锁

   + 获得锁的线程可以完成“读-修改-写”的操作，然后释放锁给其它线程，没有获得锁的线程只能等待而不能访问共享数据
   + 这样“读-修改-写”三步操作组成一个原子操作，中间不会被打断

2. Metux init

   ```
   $ pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;	//:成功返回0,失败返回错误号
   ```

3. metux lock and unlock

   ```
   int pthread_mutex_lock(pthread_mutex_t *mutex);		// lock
   int pthread_mutex_trylock(pthread_mutex_t *mutex);	// don't hang up
   int pthread_mutex_unlock(pthread_mutex_t *mutex);	//unlock
   ```

   + pthread _mutex_trylock
     + 如果一个线程既想获得锁,又不想挂起等待
     + 如果Mutex已经被另一个线程获得，这个函数会失败返回EBUSY，而不会使线程挂起等待。
   + lock and unlock
     + 互斥锁已经被某个线程获得，其它线程再调用lock只能挂起等待。
     + unlock操作中唤醒等待线程
   + 对Mutex变量的读取、判断和修改不是原子操作
     + 为了实现互斥锁操作,大多数体系结构都提供了swap或exchange指令
   + 避免死锁
     + A 挂起等待B的锁；B也挂起等待A的锁；造成死锁状态
     + 尽量使用pthread_mutex_trylock调用代替pthread_mutex_lock调用,以免死锁。

### Condition Variable

1. 条件时间同步

   + 通过条件变量(Condition Variable)来阻塞等待一个条件,或者唤醒等待这个条件的线程。
   + 用pthread_cond_t 类型的变量表示

2. cond_init

   ```
   $ pthread_cond_t cond = PTHREAD_COND_INITIALIZER; //成功返回0,失败返回错误号。
   ```

3. cond_funcation

   ```
   $  pthread_cond_timedwait()	//可以设置超时时间
   $  pthread_cond_wait()
   $  pthread_cond_signal()	// 唤醒在某个Condition Variable上等待的另一个线程
   $   pthread_cond_broadcast() //唤醒在这个Condition Variable上等待的所有线程。
   ```

   + 一个Condition Variable总是和一个Mutex搭配使用的。

   + 阻塞等待

     {% asset_img cond_wait.png %}

4. code

   + 节生产者-消费者的例子是基于链表的,其空间可以动态分配

### Semaphore

+ man sem_overview
+ semaphore变量的类型为sem_t,

1. Mutex and Semaphore

   + Mutex ：变量是非0即1的，可看作一种资源的可用数量 0/1 
   + Semaphore：可用资源的数量，和Mutex不同的是这个数量可以大于1。

2. semaphore funcation

   ```
   $ int sem_init()	// sem_init()初始化一个semaphore变量
   $ int sem_wait()	// 调用sem_wait()可以获得资源,使 semaphore--
   $ int sem_trywait()	// semaphore = 0；如果不希望挂起等待
   $ int sem_post()	// 释放资源,semaphore++,同时唤醒挂起等待的线程。
   $ int sem_destory() // 销毁变量
   ```

3. code

   + 现在基于固定大小的环形队列重写这个程序。

### Other 

1. 线程冲突概念：
   + 共享数据只读：那么各线程读到的数据应该总是一致的,不会出现访问冲突。
   + 一个线程可以改写数据：就必须考虑线程间同步的问题。
2. 读者写者锁(Reader-Writer Lock)
   + Reader之间并不互斥,可以同时读共享数据
   + 而Writer是独占的(exclusive)
     + ,在Writer修改数据时其它Reader或Writer不能访问数据,
     + 可见Reader-WriterLock比Mutex具有更好的并发性。
3. 并发性
   + 用挂起等待的方式解决访问冲突不见得是最好的办法,因为这样毕竟会影响系统的并发性
   + 例如Linux内核的Seqlock、RCU(read-copy-update)等机制。

## 死锁问题

1. 微秒级延时：加快仿真速度。

   ```
   $ usleep(3)
   ```

   