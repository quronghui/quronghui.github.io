---
layout: post
title: Makefile
date: 2019-03-21 19:25:24
categories: 
 - [Makefile]
 - [LinuxC]
tags: Makefile
---

# Makefile 基础

+ [ Link code ](https://github.com/quronghui/LinuxC.git) -- Makefiles

## Makefile 基本规则

### Makefile

1. 例子

   ```
   main: main.o stack.o maze.o
   		gcc main.o stack.o maze.o -o main
   main.o: main.c main.h stack.h maze.h
   		gcc -c main.c
   stack.o: stack.c stack.h main.h
   		gcc -c stack.c
   maze.o:	maze.c maze.h main.h
   		gcc -c maze.c
   ```

2. Makefile 由一组规则 rule组成

   ```
   target ... : prerequisites ...
   		command1
   		command2
   		...
   ```

   - 目标和条件之间的关系是：欲更新目标，必须首先更新它的所有条件;
   - 所有条件中只要有一个条件被更新了，目标也必须随之被更新。
   - 所谓“更新”就是执行一遍规则中的命令列表；命令列表中的每条命令必须以一个Tab开头；（注意不能是空格）
   - 对于Makefile中的每个以Tab开头的命令,make 会创建一个Shell进程去执行它。

### make 编译

1. make 会自动选择那些受影响的源文件重新编译，不受影响的源文件则不重新编译。

   {% asset_img makerule.png %}

### make clean