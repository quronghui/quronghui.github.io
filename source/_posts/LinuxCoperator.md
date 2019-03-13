---
layout: post
title: LinuxC Operator
date: 2019-03-12 14:44:44
 - [LinuxC] 
 - [Emededded]
 - [LinuxC Operator]
tags: [Linux, C]
---

# LinuxC Operator

+ 主要是介绍位运算符，通过位运算对整数进行操作。

## 位运算

### 按位与、或、异或、取反

+ 要进行数据类型的转换：Data Type

  {% asset_img operator.png %}

  ```
  unsigned char c = 0xfc;
  unsigned int i = ~c;
  result : ffffff03
  ```

+ 先进行类型的提升，在进行转换。

### 移位运算

1. 移位运算符(Bitwise Shift)包括 左移 << 和 右移 >> 
2. 无符号的移位
   + 左移将一个整数的各二进制位全部左移若干位
3. 有符号的移位
   + 不建议使用，减少出错
   + 正数的高位移入0
4. 移位运算中：不同进制数 和 不同的类型之间的区别
   + 不同的进制数：同一个数用不同的方式进行表示
   + 不同的类型：存储一个数所能提供的空间（位）
   + 同一个数在不同的类型转换中，会发生溢出现象

### 掩码

1. 对一个整数的某些位进行操作

   ```
   define ： mask = 0x0000ff00; //(定义一个32的存储类型int)对一个数的8-15位进行操作
   ```

## 其他运算符

### 复合赋值运算符

1. 在赋值的同时做一次运算

   {% asset_img assignment.png %}

2. 对于有 Side Effect 的表达式，影响是不同的。

### Sizeof and typedef

1. sizeof 是一个特殊的运算符：sizeof 表达式和 sizeof(类型名)
   + 