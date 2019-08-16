---
layout: post
title: OS并发
date: 2019-07-18 10:57:22
categories:   [Operate System]
tags: 并发
---

# 操作系统的并发

## 并发的基础知识

1. 并发的基本抽象

   + **问题:**  **多个用户**要快速的抓取并吃掉**多个桃子**;
   + **实现方式:** 多线程的应用程序(*表示多个用户*), 访问内存节点数据(*多个桃子*)
   + **OS的支持:** OS使用锁(lock) 和条件变量(condition variable), 支持多线程应用程序;

2. 线程和进程

   + 线程: **单个运行**进程提供的抽象.

   

   | 区别         | 进程                       | 线程                                                         |
   | ------------ | -------------------------- | ------------------------------------------------------------ |
   | 运行时       | 完成相应的指令             | 每个线程就像独立的进程, 但是**共享地址空间, 访问相同的数据** |
   | 保存状态信息 | PCB                        | TCB Thread control block                                     |
   | 页表         | 地址空间改变, 切换当前页表 | 地址空间不变, 不用切换页表                                   |
   | stack        | 只有一个栈段               | 多个栈段                                                     |

3. 单线程和多线程

   

   | 区别               | 单线程                                         | 多线程                 |
   | ------------------ | ---------------------------------------------- | ---------------------- |
   | 执行点             | 一个执行点(一个程序计数器, 用于存放执行的指令) | 多个执行点(多个计数器) |
   | 临界区互斥         |                                                | 通过锁实现             |
   | 线程交互(减少线程) |                                                | 通过条件变量发送信号   |
   | 共享数据的位置     |                                                | heap 或者全局位置      |
   
4. **实现线程间的同步方法的比较**

   

   | 实现方法 | 锁                                 | 条件变量                                        | 信号量                                                       |
   | -------- | ---------------------------------- | ----------------------------------------------- | ------------------------------------------------------------ |
   | 特点     | 二值信号量 (0/1)                   | 队列(需要记录队列为空还是满)                    | 是一个整数值(初始化赋值)                                     |
   | 需要参数 | 1)共享变量<br />(while自旋的条件); | 1)共享变量<br />(while 进入等待的条件)          | sem                                                          |
   |          | 2) mutex                           | 2)mutex (实现线程间互斥)                        |                                                              |
   |          |                                    | 3)cond(实线线程间同步)                          |                                                              |
   | 函数     | lock() ; unlock()                  | cond_wait(); <br />**线程进入等待状态会释放锁** | sem_init()<br />1)  int pshared: 0 线程间同步;1-进程<br />2) int value : 信号量初始化的值 |
   |          |                                    | cond_signal(); 唤醒线程                         | sem_wait() :**不释放锁, 死锁问题** <br />信号量减一, (与初始值比较)进入等待状态 |
   |          |                                    |                                                 | sem_post();<br />信号量加一, (与初始值比较)唤醒线程          |

   

### [线程的创建和执行顺序](https://github.com/quronghui/OSIntroduction/tree/master/1_thread_create/thread_create.c)

1. **问题一:** 多线程的创建和执行?
   + 记住: **先创建的不一定先执行;**
   + 情况一: 父线程创建子线程后, 父线程自己先运行(单CPU), 然后子线程才运行;
   + 情况二: 父线程创建子线程后, 子线程先运行(单CPU);然后父线程才运行
2. **问题二**: 线程的创建和函数调用之间的关系?
   + 并不是先执行函数, 然后返回给调用者;
   + 而是 被调用的例程(进程)创建一个新的执行线程, 它独立于调用者运行;

### [多线程之间存在的问题](https://github.com/quronghui/OSIntroduction/tree/master/1_thread_create/share_data.c)

1. 同步原语
   
   {% asset_img mutex.jpg %}
   
2. **问题一:** 多数据之间数据共享?

   +  问题: 线程在执行指令过程中, **时钟中断**的产生, 操作系统将当前线程的状态保存在TCB中, 切换到另外的线程;
   +  解决方式: 通过同步原语, 将**临界区指令**构造成**原子性**的执行块

3. **问题二**: 线程之间睡眠/唤醒的交互机制

   + 问题: 一个线程继续执行之前, 要等待另外一个线程完成某些操作;
   + 解决方式: 条件变量和锁

## 线程的API

```
man -k pthread	// 查询线程所有的API
```

### 线程的创建和线程完成

1. 线程的创建函数分析

   ```
   int pthread_create(pthread_t *thread, const pthread_attr_t *attr,  void *(*start_routine) (void *), void *arg);
   ```

   + pthread_t *thread : 与线程交互的参数
   + const pthread_attr_t *attr : 指定线程的属性
     + 栈属性: 栈的大小;
     + 优先级属性
     + **使用前要进行初始化**: pthread_attr_init()
   + void *  (  *start_routine) (void *) : 函数指针
     + **线程需要完成的指令**: 包括所有的临界区 
   + void *arg: 传递给函数指针的参数

2. [如何等待线程函数完成](https://github.com/quronghui/OSIntroduction/tree/master/1_thread_create/thread_join.c)

   + 等待线程的完成, 需要调用函数pthread_join()

   + 能够保证在退出或者进入下一个阶段时, join等待的线程能完成所有的工作;

     ```
     int pthread_join(pthread_t thread, void **retval);
     ```

   + pthread_t thread: 表示需要等待的线程

   + void **retval: 希望得到的返回值;

     + 必须小心如何从线程得到的返回值; 永远不要返回一个指针;

### [锁的API 接口](https://github.com/quronghui/OSIntroduction/tree/master/2_mutex_cond/mutex_api.c)

1. 锁的作用:

   + 保护临界区的代码向单原子式的执行, 不受中断的影响;
   
2. 锁的定义和初始化

   + 没有检测是否初始化成功

   ```
    pthread_mutex_t look = PTHREAD_MUTEX_INITIALIZER;	
   ```

   + 加断言函数, 检测是否初始化成功

     ```
      pthread_mutex_t look;
      int rc = pthread_mutex_init(&lock, NULL);
      assert(rc == 0);
     ```

3. 获取锁和释放锁时, 应该检测是否获取成功

   ```
   // 获取锁的函数接口
   void Pthread_mutex_lock( pthread_mutex_t *mutex ){
   	int rc = pthread_mutex_lock(mutex);
   	assert(rc==0);
   }
   ```

4. 锁使用完之后, 要摧毁

   ```
   pthread_mutex_destroy();
   ```

5. 其他方式获取锁 : **解决死锁问题**

   ```
   pthread_mutex_trylock()  // 尝试获取锁, 如果由程序占用, 则失败
   pthread_mutex_timelock()	// 在超时或者获取到锁后返回
   ```

### [条件变量 API](https://github.com/quronghui/OSIntroduction/tree/master/2_mutex_cond/cond_api.c)

1. 条件变量的作用

   + 解决: 线程之间睡眠/唤醒的交互机制

2. 条件变量的创建和初始化

   + 使用条件变量时, 必须使用与此条件相关的锁

   ```
   pthread_mutex_t lock = PTHREAD_MUTEX_INITIALIZER;
   pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
   ```

3. 条件变量的使用

   ```
   int pthread_cond_wait(pthread_cond_t *cond,  pthread_mutex_t *mutex);	// 进入等待时,会释放锁的;
   int  pthread_cond_signal(pthread_cond_t *cond);
   ```

## 实现锁

+ 锁是一个变量, 互斥量(0/1);

1. 锁的实现
   + 纯硬件的实现;
   + 硬件原语 + OS原语
2. 评价一把锁的效果?
   + 互斥性: 最基本的功能, 锁是否优先, 能够阻止多个线程进入临界区;
   + 公平性: 当锁可用时, 每一个线程都能公平的获得锁;
   + 性能: 加锁之后的时间花费;

### 基于硬件原语实现锁(不基于线程库)

1. [基于硬件原语实现锁, 优缺点](https://github.com/quronghui/OSIntroduction/tree/master/2_mutex_cond/spin_lock.c)

   + 属于自旋式, 永不放弃CPU, 等待的线程一直浪费CPU的时间片

   

| 硬件原语                   | 实现                              | 缺点                                                         |
| -------------------------- | --------------------------------- | ------------------------------------------------------------ |
| 控制中断                   | 在进入临界区时, 关闭中断          | 关闭中断, OS就不能有效介入                                   |
| TestAndSet<br />**自旋锁** | 将互斥量(0/1)在获取锁和释放锁交换 | 将测试和设置合并为一个原子操作<br />等待线程会一直自旋, 永不放弃CPU<br />不保证公平性: 对锁是一种抢占式的 |
| 比较和交换                 | 通过和期望值进行比较              | 无等待同步, 自旋式                                           |
| 链式加载和条件式存取       |                                   |                                                              |
| 获取并增加                 |                                   |                                                              |

### 硬件原语 + OS原语 实现锁

1. OS原语实现

   + 当线程竞争锁失败, 要进入自旋状态时(spin), 放弃CPU.(进行上下文的切换)

     ```
     yield();	//OS 原语
     ```

   + 但是这样的上下文切换, 成本很高; 一直竞争不到, 就得一直切换;

2. 使用队列: 休眠替代自旋

   + 当线程竞争不到锁时, 通过一个队列保存他们的TID;
   + 通过 park() / unpark() 睡眠和唤醒;

3. Linux 支持的软件原语

   ```
   futex;
   ```

##  条件变量 -- 另外的开发原语

1. 条件变量的作用?
   + 线程可以使用使用条件变量, 来等待一个条件变成真; (不是自旋等待)
   + 条件变量: 是一个显示队列
     + 当某些**执行状态**不满足时, 线程可以把自己加入队列, **等待**该条件;
     + 当执行状态满足时, 就可以通过唤醒线程, 让其运行;

### 条件变量的定义和程序

1. [编写代码的几个要求?](https://github.com/quronghui/OSIntroduction/tree/master/2_mutex_cond/condition_vailable.c)

   - 共享变量: 共享变量的重要性, 用于判断某些状态的;
   - 锁: 在使用**条件变量**(睡眠和唤醒机制)时, 必须加锁;

2. 问题一:  done 共享变量, 是否有存在的必要?

   + 睡眠, 唤醒, 锁都离不开共享变量
+ a. 情况一: 父线程创建子线程后, 自己运行(单CPU), 调用thr_join()函数. 
     + 这种情况下 父线程先获得lock, done==0, 子线程还在运行, 调用wait()进入睡眠; 
  + 子线程得以运行,  调用thr_exit()函数发送signal 信号唤醒父线程;
     + 父线程从wait中返回, 释放锁;
+ b.  情况二: 父线程创建子线程后,子线程立即运行, 并且设置 done =1; 
     +   调用signal唤醒其他线程(线程队列为空), 然后结束;
  +  父线程运行后, 调用thr_join(), 发现done = 1, 所以释放锁返回;

3. 问题二:  唤醒和睡眠状态都不加锁?
   + 会被中断信号打断

### 典型模型: 生产者和消费者(存在界缓冲区)

1. Producter / Consumer 问题

   + Producter 产生数据, 并将数据放在buffer;
   + Consumer 从buffer中获取数据
   + Condition: 
     + 只有buffer为空时, producter才能写入数据;
     + 只有buffer满时, Consumer才能得到数据;

2. grep 正则匹配

   ```
   grep  foo	file.txt | wc -l	// Producter / Consumer 的问题; 而我们充当了用户
   ```

   + grep 在file.txt 中查找与"foo"字符相同的值; --- Producter

   + shell 把输出重定向到pipe, pipe的另一端是wc进程的标准输出

     ```
     wc -l	// wc统计foo出现在文件中的次数
     ```

   + 他们之间的交互:通过内核中的有界缓冲区, 共享资源;

3. [代码编写注意三点](https://github.com/quronghui/OSIntroduction/tree/master/2_mutex_cond/producter_comsumer.c)

   + a. 共享变量进行标识: 何时producter能进入buffer?    何时consumer能进入buffer?

   +  b. Mesa语义:    关于条件变量的使用, 总是使用while loop 代替if

   +  c. 条件变量:要具有指向性:
     + 消费者不能指向消费者, 只能指向生产者;

### 覆盖条件

1. 问题: 关于内存分配的问题?

   + 当出现空闲内存时, 唤醒哪一个等待的线程?

2. 解决方式:  覆盖条件

   ```
       pthread_cond_broadcast() ;	// 唤醒所有等待的线程
   ```

   + 覆盖条件: 它能覆盖所有需要唤醒的线程场景,  广播进行全部唤醒; 

## 基于锁的并发数据结构

+ 还没有看

## 信号量 -- 同步原语

1. 信号量 : 是一个**整数值**的对象;

   + 信号量作为同步原语, 可以**替换**锁和条件变量的;

   ```
   #include <semaphore.h>
   int sem_init(sem_t *sem, int pshared, unsigned int value);	// 信号量的声明和初始化
   ```

   + int pshared: 表示信号量可以在多个线程 , 或者进程**实现同步**
     + 0: 表示在多个线程之间进行同步;
     + other value: 表示在进程间同步
   + unsigned int value **信号量的初始化的值**
     + value = 1; 	表示二值信号量(锁)
     + value = 0;   表示条件变量, 用于线程之间的等待和唤醒;

2. 信号量 :  可以使用两个函数来操作它. **通过这两个函数进行唤醒和睡眠**

   + sem_wait(): 	将信号量的值**减一**, 和0比较, 小于0就进入等待状态;
   + sem_post():    将信号量的值**增加一**, 产生数值变化就唤醒信号量的线程

### 二值信号量 (锁)

1. 问题一: 信号量的初始值是多少?

   + 初值为1, 当(sem<0) 进入睡眠, 放弃CPU;

   + 情景一:  只有一个线程

     + 线程A调用sem_wait(), 使得信号量减一, 值为0; 从sem_wait()返回;
     + 线程A进入临界区;没有其他线程获取锁;
     + 线程A调用sem_post(), 使得信号量增加一;

   + 情景二: 两个线程

     {% asset_img semaphore.jpg %}

2. [代码使用]((https://github.com/quronghui/OSIntroduction/tree/master/3_semaphore/semaphore_mutex.c))

   ```
       Sem_wait(&sem);
       // code
       Sem_post(&sem);
   ```

### 信号量实现: 条件变量

1. 信号量作为条件变量: 实现线程间的等待和唤醒?

   + 初始值value = 0;

   + 情景一:  父线程 创建子线程后, 子线程先运行

     {% asset_img semphore_cond.jpg %}

   + 情景二:  父线程 创建子线程后, 父线程先运行

2. [实现方式code](https://github.com/quronghui/OSIntroduction/tree/master/3_semaphore/semaphore_cond.c)

   + 父进程调用sem_wait(), 将sem值减一, sem<0 进入睡眠模式
   + 子进程调用sem_post(), 将sem值加一, sem=0, 唤醒父进程

### 信号量实现生产者和消费者

1. [解题思路注意 :](https://github.com/quronghui/OSIntroduction/tree/master/3_semaphore/sem_ProductAndConsume.c)

   +  a. 信号量的初始值进行标识: 何时producter能进入buffer?    何时consumer能进入buffer?

   + b. 信号量:要具有指向性:

     + 消费者不能指向消费者, 只能指向生产者;

   + c. 全局变量: 存放在程序代码区(静态)

   + d. 还要加一个二值信号量 : 锁 (应对多生产者的情况)

   +  e. 二值信号量放置的位置, 会造成死锁的状况;

     ```
             Sem_wait(&empty);
             Sem_wait(&mutex);	// 锁的信号量处的位置, 放在类似于条件变量之前的位置
             put(i);
             Sem_post(&mutex);
             Sem_post(&full);
     ```

2. **问题一**: 信号量实现的生产者和消费者为什么会产生死锁问题?

   + 信号量实现的模型
     + **先进入函数** : Sem_wait() 
     + **后比较**比较: 进入睡眠模式(sem<0)不会释放锁
  
     ```
     Sem_wait(&mutex);		// 已经获得锁了
     Sem_wait(&empty);  		// 进入等待的时候**不会释放锁**
     ```

   + 条件变量实现的模型: 

     + **先比较** : 有一个全局的共享变量, 进行标识buffer值的大小;
     + **后进入函数**: while 判断, 决定是否要进入 Pthread_cond_wait函数

     ```
     Pthread_mutex_lock(&mutex);		// 已经获得锁了
     while( count == 0 )
                 Pthread_cond_wait(&full, &mutex);   // 进入等待时,会释放锁的;
     ```

### 信号量解决的问题

 1. [读者--写者锁实现方式?](https://github.com/quronghui/OSIntroduction/tree/master/3_semaphore/sem_read_write.c)

    + 读者锁: 一旦一个读者获得读锁, 其他读者也能获得该锁;
    + 写者锁: 但是想要获得写者锁, 必须等待所有的读者结束; 

	2. [哲学家就餐问题?](https://github.com/quronghui/OSIntroduction/tree/master/3_semaphore/sem_fork.c)

    + 问题: 哲学家只有同时拿到左手边和右手边的参叉, 才能吃到东西? 如何进行同步;

    + 解决:  防止出现死锁的状况, 在最后一个哲学家哪里, 调换一次拿叉子顺序

      ```
      void getfork()
      {
          if( p == MAX-1 ){       // 换一下拿叉子的顺序
              Sem_wait( &fork[ right(p) ] );
              Sem_wait( &fork[ left(p) ] );
          }
          else {
              Sem_wait( &fork[ left(p) ] );        
              Sem_wait( &fork[ right(p) ] );
          }
      }
      ```

### 通过锁和条件变量 实现信号量

1. [实现方式code:](https://github.com/quronghui/OSIntroduction/tree/master/3_semaphore/achieve_semaphore.c)

   + 通过一把锁, 一个条件变量, 一个状态变量 来**记录信号量的值**;

   + a. 锁实现时: 共享变量是 0和1之间切换;
     + semaphore 实现时, 是通过wait() 和post() 加1和减1
   + b. 唤醒机制
     +  使用条件变量实现

## 常见的并发问题

### 并发缺陷(非死锁)

| 类型       | 原因                   | 解决                                             |
| ---------- | ---------------------- | ------------------------------------------------ |
| 违反原子性 | 代码执行时, 被中断打断 | 加锁, 实现互斥                                   |
| 违反顺序性 | 先使用, 后初始化       | 添加一个条件变量, 锁, 状态变量( **或者信号量** ) |

### 死锁缺陷

1. 什么是死锁?

   + 线程之间相互依赖, 相互等待对方释放;

   ```
   thread_1:	do_something( lock(L1), lock(L2) )	// 线程各自持有一个锁, 等待对方释放锁
   thread_2:	do_something( lock(L2), lock(L1) )
   ```

   {% asset_img deadlock.jpg %}

2. 死所发生的原因和解决的方法

   {% asset_img deadlock_reason.jpg %}

3. 死锁情况一: 循环等待

   + 解决: 通过一个比较, 让其按照摸个顺序访问.(类似于哲学家就餐问题)

     ```
         if( m1>m2 ){       // 换一下拿叉子的顺序
            pthread_mutex_lock(m1);
            pthread_mutex_lock(m2);
         }
         else {
            pthread_mutex_lock(m2);
            pthread_mutex_lock(m1);
         }
     ```

4. 死锁情况二: 持有并等待

   + 解决: 通过原子性的抢锁;
   + 通过设计一个全局锁;

5. 死锁情况三: 非抢占

   + 解决: pthread_mutex_trylock()  // 尝试获取锁, 如果由程序占用, 则失败

6. 死锁情况四: 互斥

   + 很难解决, 代码存在临界区;

7. 解决死锁方式:

   + 通过调度避免死锁;
   + 在MapReduce (Google)系统中, 可以完成一些并行计算, 无需使用锁;

## 基于事件的并发

1. 基于事件的并发解决哪些问题?
   + 多线程中并发中, 存在并发缺陷的问题;
   + 开发者无法控制某一个时刻的调度, 程序员创建线程后, 依赖操作系统的合理调度;
2. 应用地方? 
   + 图形用户界面的应用
   + 某些网络服务器, socket
3. 阻塞和非阻塞?
   - 阻塞(同步): 在返回给调用者之前完成所有的工作;
   - 非阻塞:  接口开始一些工作后, 立即返回(将控制权让出), 让所 需要完成的工作都在后台进行;

### 其如何工作的?

1. 事件循环

   + 主程序等待某些事件的发生;
   + event handle(事件处理程序): 依次处理事件;
   + 显示调度: 决定处理哪一个事件

2. API: select() and poll()

   ```
   int select(int nfds, fd_set *readfds, fd_set *writefds, fd_set *exceptfds,  struct timeval *timeout);
   ```

   + select: 会依次检查文件描述符 0- ( nfds-1), 中满足后面三个条件的fds;
   + 返回所有集合中就绪描述符的总数;

3. FD_ISSET()

   + 时间服务器可以查看哪些描述符已准备好数据并处理传入的数据;

### 基于事件的并发要求

1. 无须锁:
   + 基于单个CPU和事件的应用程序, 一次只处理一个时间, 
   + 属于单线程, 不存在并发问题;
2. 要求一: 不允许使用阻塞调用
   + **问题一**: I/O请求会阻塞程序?
   + 解决阻塞问题方法:
     + 通过异步I/O进行处理
     + 使用的接口: AIO control block
     + 作用: 接口在接到I/O请求后, 在I/O完成之前, 将控制权返回在调用者;
       + 另外的接口可以查询是否完成;
3. 问题二: 状态管理
   + 收官栈管理;