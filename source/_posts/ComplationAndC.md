---
layout: post
title: Assembler And C
date: 2019-03-18 08:39:46
categories: 
 - [LinuxC]
 - [Complation]
tags: complation
---

#  Complation And C

# **Assembler And C**

## 汇编代码生成

### C和汇编穿插显示

```
gcc -g main.c -o main -Wall	// 生成可执行文件
objdump -dS main			// 把C代码和汇编代码穿插起来显示
```

### 只生成汇编

```
gcc -S main.c				//只生成汇编代码main.s,而不生成二进制的目标文件。
```

### 汇编调试

```
(gdb) disassemble			//可以反汇编当前函数或者指定的函数
(gdb) si 					//step 命令可以一行代码一行代码地单步调试,而这里用到的si命令可以一条指令一条指令地单步调试。
(gdb) info registers 		//可以显示所有寄存器的当前值。
(gdb) p $esp				//打印esp寄存器的值,
// 在上例中esp 寄存器的值是0xbff1c3f4,所以x/20 $esp 命令查看内存中从0xbff1c3f4地址开始的20个32位数。
```

### 数据的存储

1. 在执行程序时,操作系统为进程分配一块栈空间来存储函数栈帧

2. esp 寄存器总是指向栈顶，ebp指向栈底

   + esp 随着压栈和出栈操作随时变化，ebp保持不变
   + 有高地址想低地址增长
   + 函数的参数和局部变量都是通过ebp 的值加上一个偏移量来访问的

   {% asset_img esp.png %}

## 程序入口

1. 汇编程序入口函数：_start；C程序的入口是：main()

2. 汇编函数编译

   ```
   $ as hello.s -o hello.o		//翻译为汇编代码
   $ ld hello.o -o hello			//ld进行链接库
   ```

3. C程序的编译

   ```
   $ gcc -S main.c				//生成汇编代码
   $ gcc -c main.s				//生成目标文件
   $ gcc main.o				//生成可执行文件
   ```

   {% asset_img gcc.png%}

### C程序链接库的过程

1. 链接和显示

   ```
   $ gcc -v main.c -o main		//了解详细的编译过程
   $ objdump -d main			//通过反汇编查看各目标文件所定义的符号
   ```

2. C链接的过程

   {% asset_img clib.png %}

## 变量的存储布局

1. 查看命令

   ```
   $ gcc -g main.c -o main	
   $ readelf -a main		//查看符号表 global and local
   ```

### 关键字修饰变量

1. 通过一些关键字修饰变量：const 、static、register

2. const 修饰的变量

   + 全局的变量 GLOBAL

   + 变量只读，不可修改
   + const 变量在定义时必须初始化。因为只有初始化时才有机会给它一个值。
   + 一旦定义之后就不能再改写了,也就是不能再赋值了。

3. static 修饰的变量

   + static 修饰的变量，LOCAL
   + LOCAL 的符号只能在某一个目标文件中定义和使用,而不能定义在一个目标文件中却在另一个目标文件中使用。

### 作用域（Scope）些名词,因为我不是在写C标准。

1. 作用域适合于所有的标识符，而不仅仅是变量。
2. 作用域范围
   + 从当前位置，到所在函数结束

### 命名空间 （Name Space）

1. 对于重名标识符，内层作用域的标识符将覆盖外层作用域的标识符。

### 存储类型标识符（Storage Class Specifier）

{%  asset_img specifier.png %}

## 结构体和联合体

### 存储

1. 栈：是从高地址向低地址增长的；
2. 结构体成员：从低地址向高地址排列，这一点和数组类似。但有一点和数组不同,结构体的各成员并不是一个紧挨一个排列的,中间有空隙,称为填充。

## C和内联汇编

+ 内联汇编：为了提高Ｃ的执行效率。因为Ｃ的代码是由编译器进行翻译的。

### 内联方式

1. 内联格式

   ```
   _asm_(assembler code)
   ```

2. C中的内联汇编，需要和Ｃ的变量建立关联

   ```
   __asm__(assembler template
   	: output operands				/* optional */
   	: input operands				/* optional */
   	: list of clobbered registers	/* optional */
   );
   ```

