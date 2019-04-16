---
layout: post
title: Assembly And C
date: 2019-03-18 08:39:46
categories: 
 - [LinuxC]
 - [Complation]
tags: complation
---

# Assembly And C

## 汇编代码生成

### C和汇编穿插显示

```
gcc -g main.c -o main -Wall	// 生成可执行文件.out
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

+ -o ：作用 --> 只是为了取名字，而不是其他的作用 
+ 编译的作用：翻译高级语言为可执行的二进制语言。

1. 汇编程序入口函数：_start；C程序的入口是：main()

2. 汇编函数编译

   ```
   $ as hello.s -o hello.o		//翻译为汇编代码
   $ ld hello.o -o hello			//ld进行链接库
   ```

3. C程序的编译

   ```
   $ gcc -S main.c -o main.s	//生成汇编代码
   $ gcc -c main.s -o main.o	//生成目标文件 
   $ gcc main.o -o main		//生成可执行文件
   ```

   {% asset_img gcc.png%}

   + 汇编代码：
     + 可以直接命名为 xxx.s ；进行编写
       + 通过as进行编译，ld进行链接。
     + 可以通过 xxx.c 生成
       + 通过 gcc -S 生成 .s汇编代码

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
   $ gcc -g main.c -o main	// gdb 调试文件生成
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

### 标识符的作用域（Scope）

+ 关键字：时用来修饰标识符和变量的。

  + 用来定义他们的作用范围
+ 标识符：作用域适合于所有的标识符，而不仅仅是变量。

  {% asset_img Scope.png %}

### 命名空间 （Name Space）的重名标识符

1. 对于重名标识符，内层作用域的标识符将覆盖外层作用域的标识符。

   {% asset_img nameSpace.png %}

### 标识符的链接属性 Linkage

1. 外部链接（External Linkage）
   + 标识符在任意程序文件中即使声明多次也都代表同一个变量或函数,则这个标识符具有External Linkage。
   + 具有External Linkage的标识符编译后在符号表中是GLOBAL的符号。
2. 内部链接（Internal Linkage）
   + 如果一个标识符在**某个程序文件**中即使声明多次也都代表同一个变量或函数,则这个标识符具有Internal Linkage。
   + 具有Internal Linkage的标识符编译后在符号表中是LOCAL的符号
3. 无链接(No Linkage)。
   + 除以上情况之外的标识符都属于No Linkage的
   + 例如函数的局部变量，以及不表示变量和函数的其它标识符。

### 存储类型修饰符--关键字（Storage Class Specifier）

+ typedef ，static，extern
+ 修饰一个变量的声明

{%  asset_img specifier.png %}

## 结构体和联合体

### 存储

1. 栈：是从高地址向低地址增长的；
2. 结构体成员：从低地址向高地址排列，这一点和数组类似。但有一点和数组不同，结构体的各成员并不是一个紧挨一个排列的，中间有空隙，称为填充。

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

## Volatile 限定符

+ 编译器优化对寄存器代码产生的影响
+ 在为调试而编译时不要指定优化选项,否则可能无法一步步跟踪源代码的执行过程。

### 编译器优化

1. 指令形式

   ```
   gcc main.c -g -O -o main	// -o 对生成的文件进行命名；
   							// -O 制定优化选项
   ```

2.  -O 优化寄存器代码，造成了错误

   + 设备寄存器中的数据不需要改写就可以自己发生变化,每次读上来的值都可能不一样
   + 连续多次向设备寄存器中写数据并不是在做无用功,而是有特殊意义的。

### 如何防止编译器优化造成的影响

1. 加上限定符volatile

   ```
   /* artificial device registers */
   volatile unsigned char recv;	// 仿照寄存器设备
   volatile unsigned char send;
   ```

### Volatile

1. 有了volatile 限定符,是可以防止编译器优化对设备寄存器的访问。
2. 当一个全局变量被同一进程中的多个控制流程访问时也要用volatile限定,比如信号处理函数和多线程。