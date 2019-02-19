---
layout: post
title: LinuxC
date: 2019-02-19 09:57:24
categories: 
 - [LinuxC] 
 - [Emededded]
tags: [Linux, C]
---

# Linux C编程一站式学习

+ {% pdf LinuxC.pdf %}

## C语言入门

1. math函数的gcc编译

   ```
   $ gcc math.cpp -o math -lm  // math的编译要加上 "-lm"
   ```

2. [UNIX编程艺术] The Art of UNIX Programming. Eric Raymond.

3. 全局/局部变量

   + 虽然方便，但是要慎用，能用函数传递参数的就不要使用全局变量
   + 局部变量可以用任意类型相符的表达式来初始化,而全局变量只能用常量表达式初始化。
   + **Debug** 
     + 如果全局变量在定义时不初始化,则初始值是0。但是局部变量不初始化时，初值就不确定，局部变量先赋值

4. if/else

   + else 总是和最近的一个if配对
   + 如果需要隔开的话，加 “ { } ” 隔开

