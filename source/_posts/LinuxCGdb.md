---
layout: post
title: LinuxC Gdb
date: 2019-03-04 16:37:01
categories: 
 - [LinuxC] 
 - [Emededded]
tags: [Linux, C]
---

# LinuxC Gdb

+ [Code link](https://github.com/quronghui/LinuxC.git) -- Gdb的相关代码

## Gdb

### 调试方式

+ 程序中除了一目了然的Bug之外都需要一定的调试手段来分析到底错在哪

1. 根据程序执行时的出错现象假设错误原因,然后在代码中适当的位置插入printf ,
2. 强大的调试工具gdb,可以完全操控程序的运行。

### 调试思想

+ 分析现象 --> 假设错误原因 --> 产生新的现象去验证假设

## 单步执行和跟踪函数调用

### 开始调试

1. gdb -g 编译

   ```
   /*
   *	-g选项的作用是在目标文件中加入源代码的信息,比如目标文件中第几条机器指令对应源代码的第几行；
   *	但并不是把整个源文件嵌入到目标文件中,所以在调试时目标文件时必须保证gdb也能找到源文件。
   */
   $ gcc -g main.cpp -o main -Wall 
   $ gdb main
   ```

2. gdb 命令help

   ```
   $ (gdb)help			// gdb提供一个类似shell下输入help,可以查看命令的类别:
   $ (gdb)help files	// 可以进一步查看某一类别中有哪些命令,例如查看files类别下有哪些命令可以用
   ```

3. 列出源码

   ```
   $(gdb) list	1 		//从第一行开始列出源代码，一次只能10行
   $(gdb) 回车			// 重复上一条命令
   $(gdb) l add_range	// list命令可以用 l 来表示，列出一个函数的源代码
   ```

4. gdb quit 

   + 退出Gdb 调试环境

### 单步调试

1. next 主函数的调试

   ```
   $ gdb main
   $ (gdb) start		//开始执行程序
   $ (gdb) next		//控制主函数的语句，一条条的执行（enter--重复上次命令）
   // 错误不在main()函数，而在功能函数里面
   ```

2. step 功能函数的调试

   ```
   $ (gdb) start			//开始执行程序
   $ (gdb) step			//进入函数中执行
   $ (gdb) bt(backtrace)	//查看函数调用的栈针
   $ (gdb) i locals	// 查看功能函数，局部变量的值；
   ```

   {% asset_img GdbBacktrace.png %}

   + main函数传进来的参数；
   + main函数的栈帧编号为1，add_range 的栈帧编号为0

   ```
   /*查看 main函数当前的局部变量的值*/
   $ (gdb) f(frame) 1	//选择1号栈帧，然后在查看局部变量
   $ (gdb) i locals	// 查看主函数，局部变量的值；
   
   /*在step,跟几步看看*/
   $ (gdb) step
   $ (gdb) finish		//finish 一直运行到当前函数返回为止,得出当前的结果
   $ (gdb) p result	//查看数组result的值，相当于print
   
   /*修改变量值，看还有没有其他bug*/
   $ (gdb) set var sum=0	//修改变量的值
   $ (gdb) finish
   ```

### 调试命令

 	{% asset_img GdbCommand.png  调试命令汇总 %}

1. 总结
   + i locals 查看当前的局部变量，这个是最有用的。

## 断点

