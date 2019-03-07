---
layout: post
title: Order And Finding
date: 2019-03-06 10:42:19
categories: 
 - [LinuxC] 
 - [Emededded]
 - [Order]
tags: [Linux, C]
---

# LinuxC Order And Finding

+ [Order code](https://github.com/quronghui/LinuxC.git) [order files]

 ## 算法的概念

1. 算法（algorithm）
   + 将一组输入转化成一组输出的一系列计算步骤,其中每个步骤必须能在有限时间内完成。
   + 用来解决一类计算问题的，而不是一个特定的问题 。
2. 最有解和正确算法
   + 对于某个问题求解最优算法很困难，但是某个不正确的算法可以再有限时间内终止，将误差控制在一定范围内；
   + 这样的算法也是有意义的。

## 插入排序

1. 理解循环结构体的算法

   + 满足三条准则，便是 Loop Invariant

     {% asset_img insert_sort.png %}

2. 递归和循环 等价

   + 和证明递归程序的思想一样
   + 第一条便是递归的 Base Case
   + 第二条便是递归的递推关系。

## 时间复杂度

1. 分析算法的时间复杂度

   {% asser_img time.png %}

2. 最坏情况和平均情况的复杂度都是 O(n^2)

3. 时间复杂度有小到大排序

   {% asset_img O.png %}


## 归并排序

1. 区别：

   + 插入排序策略：每次添加一个到已排序的子序列中，时间复杂度是 O(n^2)
   + 归并排序：将时间复杂度降到 O(nlgn)。

2. 递归的思想看代码

   + 递归：如果定义一个概念（函数），需要用到概念（函数）本身，则称之为递归

   + Gdb: 展开的方式看递归（这样很笨） -- 单步加断点的方式调试程序的每步结果。
   + 捉住 Base Case 和 递推关系来理解，不能展开来看，这样就很乱了。

3. 时间复杂度计算

   {% aeest_img divide.png %}

4. 设计不同时间复杂度的算法

   + 这个就是算法的初步体现
   + 通过不同的数据结构，体现算法的效能

## 折半查找

1. 折半查找提供了一种代码测试的思想
   + assert.h 函数进行测试