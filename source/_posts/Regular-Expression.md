---
layout: post
title: Regular_Expression
date: 2019-04-25 15:38:19
categories: 
- [LinuxC]
- [Linux system complie]
tags: grep
---

#  Regular_Expression 

+ POSIX规定了正则表达式的C语言库函数,详见regex(3) 。
+ 本章介绍了正则表达式在grep 、sed、awk 中的用法,学习要能够举一反三,
  + 例如验证用户输入的IP地址或email地址格式是否正确。

## 正则表达式概念

1. 概念

   + 规定一些特殊语法表示字符类、数量限定符和位置关系,然后用这些特殊语法和普通字符一起表示一个模式,这就是正则表达式(Regular Expression)。
   + “正则表达式”就像“变量”，是一个广泛的概念，而不是某一种工具或编程语言的特性。

2. grep

   + 用grep 在一个文件中找出包含某些字符串的行

   + 找出符合某个模式(Pattern)的一类字符串

   + grep 模式包含信息

     {% asset_img grep.png %}

3. grep 搜索例子

   + email 正则表达式

     ```
     [a-zA-Z0-9_.-]+@[a-zA-Z0-9_.-]+\.[a-zA-Z0-9_.-]+ 
     ```

   + IP地址的正则表达式

     ```
     [0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}
     ```

   + 搜索文本 textfile 中的IP

     ```
      $ egrep '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' testfile
     ```

     + egrep 相当于grep -E,表示采用Extended正则表达式语法。

     + 注意正则表达式参数用单引号括起来了

       + 原封不动地传给grep 命令,而不会被Shell解释掉。

     + 搜索结果

       {% asset_img result.png %}

       + 因为grep 找的是包含某一模式的行，这一行包含一个符合模式的字符串234.234.04.567。
       + grep 找的是包含某一模式的行,而不是完全匹配某一模式的行

4. grep 是一种查找过滤工具,正则表达式在grep 中用来查找符合模式的字符串。

   + 其实正则表达式还有一个重要的应用是验证用户输入是否合法,
   + email 地址验证

## 基本语法

+ 以上介绍的是grep正则表达式的Extended规范；
+ 如果用grep 而不是egrep ,并且不加-E参数,则应该遵照Basic规范来写正则表达式。
+ Basic规范也有这些语法；
  + 只是字符?+{}|()应解释为普通字符
  + 要表示上述特殊含义则需要加\ 转义。

### 概念

1. C的变量有各种类型，而Shell脚本变量都是字符串。
   + 各种工具和编程语言所使用的正则表达式规范的语法并不相同,表达能力也各不相同。
2. egrep 正则表达式
   + man 7 regex 

### 字符类

+ 通过字符来限定表示的方式

  {% asset_img charcter.png %}

###  数量限定符

+ 字符表示：出现的次数

  {% asset_img counter.png %}

+ 再次注意grep 找的是包含某一模式的行,而不是完全匹配某一模式的行

###  位置限定符

+ 字符表示：匹配字符的位置

  {% asset_img local.png %}

+ 精确查找

  ```
  $ egrep '^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$' textfile
  ```

### 特殊字符

​	{% asset_img other.png %}

## Sed 流编辑器(Stream Editor)
1. sed 意为流编辑器(Stream Editor),在Shell脚本和Makefile中作为过滤器使用非常普遍

   + 把前一个程序的输出引入sed的输入，经过一系列编辑命令转换为另一种格式输出

2. sed命令行的基本格式

   ```
   sed option 'script' file1 file2 ...		
   sed option -f scriptfile file1 file2 ...
   ```

   + 命令行参数可以一次传入多个文件,sed 会依次处理
   + option : "-n",这种用法相当于grep 命令，查找出相同的并打印
   + 'script'：sed命令
   + scriptfile ：将sed命令写成脚本文件，然后用-f参数指定

3. 常用的sed命令

   {% asset_img sed.png %}

   + 使用p 命令需要注意,sed是把待处理文件的内容连同处理结果一起输出到标准输出的
   + sed 命令
     + 不会修改原文件：删除命令只表示某些行不打印输出，而不是从原文件中删去。
     + 修改原文件：查找替换命令时,可以把匹配pattern1 的字符串复制到pattern2中

## awk

1. sed 以行为单位处理文件,awk 比sed强的地方在于不仅能以行为单位还能以列为单位处理文件。
2. awk缺省的行分隔符是换行,缺省的列分隔符是连续的空格和Tab