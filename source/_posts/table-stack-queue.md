---
layout: post
title: Abstract Data Type
date: 2019-05-15 09:57:09
categories:
- [data_struct_algorithm]
tags: ADT
---

# Abstract Data Type

+ 理解数据结构的三种类型：看代码实现的细微差别

## 内存分配

1. 所有的ADT都需要确定，如何获取内存存储值；
   + 静态数组：结构长度固定
   + 动态分配的数组结构：重新构建一个数组，复制原先数组到新数组，并删除原先数组
     + **动态分配**：考虑创建，以及销毁
     + 为了避免内存泄露
   + 动态分配的链式结构：每个元素单独分配内存空间

## Link_list

1. 数组存储数据

   + 插入和删除，时间成本很昂贵
+ 简单数组一般不用来实现表这种结构
  
2. [**链表节点的插入和删除**](https://luckywater.top/2019/06/15/单链表和双链表插入/)

## Stack

1. 堆栈的接口：
   + push : 新值压入堆栈顶部；
   + pop：只把顶部元素移出堆栈，不返回值
   + top：返回顶部元素，不进行元素的移除
2. 实现堆栈：
   + push：存储于数组中连续的位置，因此需要考虑empty and full
3. 堆栈的实现方式：
   + [静态数组实现](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/08_stack/static_array_stack.c)
   + [动态分配数组实现](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/08_stack/malloc_array_stack.c)
   + [动态分配链表实现](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/08_stack/link_stack.c)

## Queue

### queue -- array

1. 静态数组实现循环队列麻烦之处：

   ​        a. 判断元素存储在队列循环的位置：(rear = (rear+1) % QUEUE_SIZE)

   ​        b. 判断何时为空，何时为满

   ​            数组中有一个位置空着不用，front出队后比rear大1；

   ​            (rear+1) % QUEUE_SIZE == front      队列为空

   ​            (rear+2) %  QUEUE_SIZE == front     队列为满

   ​        c. a % b :  if(a<b),那么输出的直接是元素a

2. 队列是否为空的方式

   + 定义一个标志位 size，判断是否为空，或者满了

   + 再循环数组中，空出一个位置不用

     ```
     数组中有一个位置空着不用；
     (rear+1) % QUEUE_SIZE == front      队列为空
     (rear+2) %  QUEUE_SIZE == front     队列为满
     ```

   {% asset_img queue.jpg %}

### queue -- pointer

1. Parameter

   *front: 指向队列的头部； 代表的就是队列

   *rear:  指向最后一个元素； 

   *pNext: 用于指向下一个元素

### queue 的实现

- [静态数组实现](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/08_queue/static_array_queue.c)
- [动态分配数组实现](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/08_queue/malloc_array_queue.c)
- [动态分配链表实现](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/08_queue/link_queue.c)

## Tree 

+ [关于树的构建和遍历](https://luckywater.top/2019/05/17/tree/)

