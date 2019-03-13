---
layout: post
title: Number Of Computer
date: 2019-03-12 09:03:52
categories: 
 - [LinuxC] 
 - [Emededded]
 - [Number of computer]
tags: [Linux, C]
---

# Number Of Computer

## 进制间的转换

1. 最高位和最低位

   {% asset_img MSB.png %}

2. 十进制转二进制

   + 除二取余
   + 余数倒着写便是

3. 小数转换

   {% asset_img Binary.png %}

   + 十进制转换为二进制
   + 乘二取整，顺序排列。

## 整数的加减运算

1. 负数的加减运算

   + 减法运算：取被减数的补码（取反加一）

   + 采用补码做加减运算时总是忽略MSB的进位？、

   + 判断溢出的办法是这样的:在相加过程中最高位产生的进位和次高位产生的进位如果相同则没有溢出,否则就说明产生了溢出。

     {% asset_img negative.png %}

2. 带符号数和不带符号数

   + 用8个bit既表示正数又表示负数,则能够表示的范围是-128~127,
   + 8个bit全部表示正数,则能够表示的范围是0~255,前者称为有符号数(Signed Number), 后者称为无符号数。

## 浮点数

1. 数的表示：模型的三部分

   + 符号位

   + 指数部分（表示2的多少次方）

   + 尾数部分（只表示小数点后面的数字）--（需要将有效数字全部移到小数点后面）

     {% asset_img float.png %}

2. 尾数部分如何表示？

   {% asset_img sign.png %}

3. 尾数的规定

   + 尾数必须以 0.1 开头

