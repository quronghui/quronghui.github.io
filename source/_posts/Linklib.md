---
layout: post
title: Link lib
date: 2019-03-19 09:34:12
categories: 
 - [LinuxC]
 - [Linklib]
tags: [Linklib]
---

# Link lib

+ [Code link](https://github.com/quronghui/LinuxC.git) -- Link

## 多目标文件链接

1. 编译查看命令

   ```
   $ gcc main.c -o main	//编译可执行文件
   $ readelf -a main 		//查看到个函数的段定义
   ```

   {% asset_img readelf.png %}

2. 目的：

   + 能查看到跟函数的**段定义**
   + Data Segment 后面的一些Segment，主要是调试信息

3. 包含其他的 .c 文件

   + 为什么编译器在处理函数，调用代码时需要有函数原型?
   + 因为必须知道参数的类型和个数以及返回值的类型才知道生成什么样的指令。

## 定义和声明

+ 凡是被多次声明的变量或函数：
  + 必须有且只有**一个声明**是定义
  + 如果有多个定义，或者一个定义都没有,链接器就无法完成链接。
+ 变量和函数的声明不同
  + 函数的声明：extern，可有可无
  + 变量的声明：extern，必须要有  extern int top

### extern 和 static 

1. 包含其他的 .c 文件时    ---    **直接包含// #include "stack.cpp" ，错误的想法**

   ```
   #include <stdio.h>
   // #include "stack.cpp"     // 有了函数的声明，就不需要加引用了
   
   extern void push(char);
   extern char pop(void);
   extern int is_empty(void);
   ```

2. extern : 表示关键字具有 External Linkage 

   + 链接之后是同一个GLOBAL符号,代表同一个地址。

3. static ： 

   + 表示一个Internal Linkage的属性
   + 有些模块不希望被外界访问到，声明为内部的

###　头文件 .h

1. 将变量和函数的声明放在一个 .h 的文件中

   + 在每次调用函数的时候，只需要包含 . h 的头文件；
   + 不需要在函数中对每一个函数进行声明

2. 预处理关键词

   ```
   #ifndef STACK_H     /* 预处理的关键词 */
   #define STACK_H
   ...
   #endif
   ```

   {% asset_img head.png %}

###  直接包含 .c 文件 -- -- 错误的

1. 为什么不在 main.c 中直接包含 stack.c 文件？？

   + 假如又有一个foo.c 也要使用stack.c这个模块。如果在foo.c 里面也包含头文件#include "stack.c"

   + 就相当于push 、pop 、is_empty 这三个函数在main.c和foo.c 中都有定义，那么main.c和foo.c 就不能链接在一起了。

     {% asset_img stack_c.png %}

   + 如果采用包含头文件的办法,那么这三个函数只在stack.c中定义了一次,最后可
     以把main.c、stack.c、foo.c 链接在一起。

     {% asset_img stack_h.png %}

2. 头文件中的函数和变量声明一定不能是定义

   + 如果头文件中出现变量或函数定义，这个头文件又被多个.c 文件包含,那么这些.c 文件就不能链接在一起了。

### 定义声明的详细规则

1. 有相应的作用域和作用范围

   {% asset_img static.png %}

## 静态库

+ 将一组代码编译成一个库
+ 链接器只会取出静态库中：有用的那部分代码。

### 代码结构

1. 代码目录的区别：编译的时候需要指定目录

   {% asset_img staticlib.png %}

2. 便以为目标文件

   ```
   $ gcc -c stack/stack.c stack/push.c stack/pop.c stack/is_empty.c
   // 生成 .o 文件
   ```

3. 打包成静态库

   + 库文件命名：libxxx;
   + 静态库 ： .a为后缀

   ```
   $ ar rs libstack.a stack.o push.o pop.o is_empty.o
   ar: creating libstack.a
   ```

4. 链接主函数 main.c 和 libstack.a

   + -L 选项告诉编译器去哪里找需要的库文件：**-L .**  表示在当前目录找
   + -lstack ：告诉编译器链接 libstack库
   + -Istack：告诉编译器寻找头文件

   ```
   $ gcc main.c -L. -lstack -Istack -o main
   ```

5. 查看编译器会查询的目录

   ```
   $ gcc -print-search-dirs
   ```

## 共享库

### 编译，链接，运行

1. 编译

   ```
   $ gcc -c -fPIC stack/stack.c stack/push.c stack/pop.c
   stack/is_empty.c	// -f 编译选项；PIC 是其中一种
   ```

2. 生成共享库

   + 使用了PIC：共享库的各段加载地址没有定死，可以加载到任意位置

   ```
   $ gcc -shared -o libstack.so stack.o push.o pop.o is_empty.o
   $ objdump -dS libstack.so	//反汇编查看共享库
   ```

3. 链接库

   ```
   $ gcc main.c -g -L. -lstack -Istack -o main
   ```

4. 运行出错

   ```
   $ ./main		// 运行的时候：找不到动态链接库 libstack.so??
   $ ldd main		//ldd查看main函数依赖哪些共享库
   ```

   + 添加动态库的路径
     + pwd : 得到 .so 的绝对路径
     + vi etc/ld.so.conf ：每个路径一行，添加
     + sudo ldconfig -v

### 共享库的命名

1. 按照共享库的命名惯例,每个共享库有三个文件名:real name、soname和linker name。

2. 指定库的名字

   ```
   $ gcc -shared -Wl,-soname,libstack.so.1 -o libstack.so.1.0 stack.o push.o pop.o is_empty.o
   ```

## 虚拟内存管理

### 查看命令

```
$ ps	//查看当前终端下的进程
// bash 进程的 id 是 3279
$ cat /proc/3279/maps		//查看它的虚拟空间地址
// proc 是内核虚拟出来的文件系统
// 当前系统中运行的每个进程在/proc 下都有一个子目录,目录名就是进程的id
```

### 进程地址空间

{% asset_img virtual.png %}

1. 进程空间是独立的：每个进程都有各自的VA 和 PA

2. 系统中可分配的内存总量 = 物理内存的大小 + 交换设备的大小

   