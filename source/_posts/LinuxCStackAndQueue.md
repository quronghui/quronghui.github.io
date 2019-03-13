---
layout: post
title: LinuxC Stack And Queue
date: 2019-03-07 11:04:39
categories: 
 - [LinuxC] 
 - [Emededded]
 - [Stack And Queue]
tags: [Linux, C]
---

+ [Code link, Stack and Queue](https://github.com/quronghui/LinuxC.git) 

# LinuxC Stack And Queue

## 数据结构

1. 数据结构(Data Structure)：是数据的组织方式。
   + 程序中用到的数据都不是孤立的，而是有相互联系的，根据访问数据的需求不同，同样的数据可以有多种不同的组织方式。
   + 把同一类型的数据组织成数组，或者把描述同一对象的各成员组织成结构体。
2. 数据的组织方式
   + 包含：存储方式和访问方式
   + 数组的各元素是一个挨一个存储的，并且每个元素的大小相同，因此数组可以提供
     按下标访问的方式。
   + 结构体的各成员也是一个挨一个存储的，但是每个成员的大小不同，所以只能用.运算符加成员名来访问,而不能按下标访问。
3. 数据的存储方式和访问方式，决定了解决问题可以采用什么样的算法。
   + 设计相应的数据结构来支持这种算法
4. [算法+数据结构=程序] Algorithms + Data Structures = Programs. Niklaus Wirth.
   + [Link](https://download.csdn.net/download/mostovoi123/2991516)

## 堆栈

### 概念

1. 堆栈：是一组元素的集合，类似于数组
   + 数组可以按照下标访问元素；
   + 堆栈被限制为Push(入)，Pop(出)
   + 只能访问栈顶元素而不能访问其他元素
2. 所有元素类型相同
   + 堆栈的存储：可以用数组实现
   + 访问操作：通过函数接口提供
3. 数组stack 是堆栈的存储空间
   + top 用作数组stack 的索引，
   + 注意top总是指向栈顶元素的下一个元素,
   + 可以把它称为指针(Pointer)。

### 算法设计

1. 代码 Assert 测试
   + 前提条件 ：注意top总是指向栈顶元素的下一个元素
2. putchar函数的作用是把一个字符打印到屏幕上,和printf的%c作用

## 队列 Queue

### 概念

1. 队列也是一组元素的集合，也提供两种基本操作:
   + Enqueue(入队)将元素添加到队尾
   + Dequeue(出队)从队头取出元素并返回。
   + FIFO(First In First Out,先进先出)

2. 队列的索引
   + 变量head、tail 就像前两节用来表示栈顶的top一样
   + 是queue数组的索引或者叫指针,分别指向队头和队尾。
   + 每个点的predecessor成员也是一个指针,指向它的前趋在queue数组中的位置。

   {% asset_img  queue.png %}

### 算法设计

+ ```
  *       (1) 广度优先是一种步步为营的策略,每次都从各个方向探索一步,将前线推进一步,
  *       (2) 队列中的元素总是由前线的点组成的
  *       (3) 广度优先搜索还有一个特点是可以找到从起点到终点的最短路径
  *       (4)而深度优先搜索找到的不一定是最短路径
  ```

##  堆栈 VS 队列

1. 堆栈

   + 栈操作的top指针在Push（入）时增大
   + Pop（出）时减小
   + 栈空间是可以重复利用的

2. 队列

   + 队列的head、tail指针都在一直增大；
   + 虽然前面的元素已经出队了,但它所占的存储空间却不能重复利用

3. 为了解决队列的问题

   + 引入环形队列
   + 从head到tail之间是队列的有效元素,从tail到head之间是空的存储位置,
   + head追上tail就表示队列空了；tail追上head就表示队列的存储空间满了。

   {%  asset_img round.png  %}