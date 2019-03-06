---
layout: post
title: LinuxC Coding Style
date: 2019-03-04 15:39:10
categories: 
 - [LinuxC] 
 - [Emededded]
tags: [Linux, C]
---

#  LinuxC Coding Style

+ [Linux kernel Coding Style](https://www.kernel.org/doc/html/v4.13/translations/zh_CN/coding-style.html)
+ Thus, programs must be written for people to read, and only incidentally for machines to execute.

## 缩进和空白

1. 双目运算符的两侧插入一个空格分隔,单目运算符和操作数之间不加空格,

   ```
   i = i + 1、++i 、!(i < 1)、-x、&a[1] ...
   ```

2. ', ' 号和 ';' 号之后要加空格, 这是英文的书写习惯

   ```
   for (i = 1; i < 10; i++) 、foo(arg1, arg2) ...
   ```

3. switch 的语句块

   {% asset_img switch.png %}

## 注释

1. 顶头源文件的注释
   + 整个源文件的顶部注释。说明此模块的相关信息,例如文件名、作者和版本历史等,顶头写
     不缩进。例如内核源代码kernel/sched.c的开头:
2. 相对独立的语句注释
   + 用	/* hello */
3. 注释尽量少用

## 标识符命名

1. .小写

   + 内核风格规定变量、函数和类型采用全小写

   + 加下划线的方式命名,

   + ```
     上面举例的函数名radix_tree_insert、类型名struct radix_tree_root 
     ```

2. 大写

   + 常量(宏定义和枚举常量enum)采用全大写加下划线的方式命名。

   + ```
     常量名RADIX_TREE_MAP_SHIFT 
     ```

3. 全局变量和全局函数命名

   + 全局变量和全局函数的命名一定要详细,不惜多用几个单词多写几个下划线
   + 因为它们在整个项目的许多源文件中都会用到,必须让使用者明确这个变量或函数是干什么用的。

## 函数

1. 执行函数：
   + 执行函数就是执行一个动作,函数名通常应包含动词,例
   + 如get_current、radix_tree_insert。
2. 分割函数
   + 多个.c的文件
3. 功能函数
   + C语言中的功能函数包含动词
   + 字母加下划线的方式进行。void insertion_sort()

## Indent Tools

1. Indent Tools 将代码格式化为某种风格

   ```
   indent -kr -i8 main.c	/* -kr 表示K&R 的风格；-i8 表示TAB键缩进8个空格的长度 */
   cat main.c
   ```


