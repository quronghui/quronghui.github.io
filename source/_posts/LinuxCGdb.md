---
layout: post
title: LinuxC Gdb
date: 2019-03-04 16:37:01
categories: 
 - [LinuxC] 
 - [Emededded]
 - [Gdb]
tags: [Linux, C]
---

# LinuxC Gdb

+ [Code link](https://github.com/quronghui/LinuxC.git) -- Gdb的相关代码

| gdb的命令             | 含义                                                         |
| --------------------- | ------------------------------------------------------------ |
| gcc -g main.c -o main | 编译成可调式文件                                             |
| list                  | list  <linenum>   显示linenum行周围的源程序<br />list <funcation>  显示函数名为function<br />list    // 显示后面10行的内容<br />list -  // 显示前面的程序 |
| until （u）           | 直接运行到循环体结束                                         |
| print                 | x  按照十六进制格式显示变量；                                |
| info                  | 查看调试是各寄存器...信息                                    |
| disassemble  <func>   | 用于反汇编                                                   |



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
   + main函数的栈帧编号为1，功能函数add_range 的栈帧编号为0

   ```
   zhi/*查看 main函数当前的局部变量的值*/
   $ (gdb) f(frame) 1	//选择1号栈帧，然后在查看局部变量
   $ (gdb) i locals	// 查看主函数，局部变量的值；
   
   /*在step,跟几步看看*/
   $ (gdb) step		//除了主函数，还有其他功能函数的值
   $ (gdb) finish		//finish 一直运行到当前函数返回为止,得出当前的结果
   $ (gdb) p result	//查看数组result的值，相当于print
   
   /*修改变量值，看还有没有其他bug*/
   $ (gdb) set var sum=0	//修改变量的值
   $ (gdb) finish
   ```
   
3. print

   {% asset_img print.png %}

### 调试命令

 	{% asset_img GdbCommand.png  调试命令汇总 %}

1. 总结
   + i locals 查看当前的局部变量，这个是最有用的。
   + 查询功能函数的变量是否初始化。
   + 通过条件语句来设置终端，这个挺好用的。
2. step 和 next 区别
   + step 用于调到功能函数；
   + next 在调到功能函数的时候，单步执行

## 断点

### 字符型和整形

1. 字符型转化为整形：

   + 整形＝字符型　－　‘０’的ASCII值

   + ASCII码值：'0'＝48; '\0' = 0

### 断点加单步

1. 单词断点流程

   ```
   $ gcc -g main.c -o main
   $ gbd main
   
   $ display sum	//我们可以用display命令使得每次停下来的时候都显示当前sum值
   				//每输入一次print sum ; 打印一次当前的sum值，
   $ break 9		//break命令的参数也可以是函数名,(在第９行设置一个断点)
   $ continue		//连续运行而非单步运行,程序到达断点会自动停下来,这样就可以停在下一次循环的开头。
   $ next 			//单步调试，深入内容
   ```

2. 多个断点的设置

   ```
   $ break 12		//设置另外一个断点
   $ i breakpoints	//一次调试可以设置多个断点,用info命令可以查看已经设置的断点
   $ delete breakpoints 1		//删除编号为１的断点
   
   $ disable breakpoints 1		//通过禁用，而不用删除
   $ enable breakpoints 1		//enable 启用断点１
   ```

3. 条件断点

   ```
   $ break 9 if sum != 0		//在循环开头设置断点,但是仅当sum不等于0时才中断
   $ run 						//然后用命令,重新从程序开头连续执行:
   $ continue					//连续执行到断点的时候停止
   ```

4. 调试Bug

   + Bug: 数组的末位含有一个　‘\0’字符，printf打印的时候遇到'\0'就停止打印。

## 观察点

+ 调试代码Breakpoint.cpp的代码一；数组越界的问题

1. 代码逻辑

   ```
   $ watch input[5]		//设置input[5]为观察点
   $ info watchpoints		//查看当前设置的观察点
   $ x/7b input			//打印数组input才存储器的内容
   						//打印的是字符对应的十六进制ASCII的值
   ```

## 段错误

1. 文章一直在强调，“scanf”函数是一个十分凶险的函数；

   + 用户输入的值是不确定的；
     + 造成数组的越界；'\0'的越界
   + 造成段错误: Segmentation fault

2. 运行逻辑

   ```
   $ run					//运行代码，当出现错误的时候会自动停止运行
   $ bt					//查看那个函数调用产生的错误
   ```

## 反汇编

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



## [valgrind](https://blog.csdn.net/tao_627/article/details/38304903)

+ 查找程序中内存泄露和其他隐藏的内存问题;

1. 安装教程

   ```
   sudo apt-get install valgrind
   ```

2. 使用教程

   ```
   // 编译:  gcc  -Wall -g valgrind_demo.c -o valgrind_demo
   //  执行条件 : valgrind --tool=memcheck --leak-check=full ./valgrind_demo
   // 将错误写进日志: valgrind --tool=memcheck --leak-check=full --log-file=mem_leak.log ./valgrind_demo
   // 和gdb一起调试: valgrind --tool=memcheck --leak-check=full --log-file=mem_leak.log gdb valgrind_demo
   ```

3. [具体代码和调试结果](https://github.com/quronghui/OSIntroduction/tree/master/valgrind/valgrind_demo.c)

   

## DDD图形界面调试工具

1. DDD (Data Display Debugger)

   + DDD、GDB和被调试进程之间的关系：通信都是异步进行

   ```
   ddd --debugger arm-linux-gnueabihf-gdb  <要调试的程序>
   ```

## Linux 内核调试工具

1. 目标机“插桩”：打上KGDB补丁，主机上的GDB可与目标机的KGDB通过串口或网口通信；
2. 仿真器：仿真器可直接连接目标机的JTAG/BDM；
3. 在目标板上通过printk()，Oops，strace 等软件方法进行“观察”调试

### KGDB 

1. 典型的嵌入式系统“插桩”工具，依赖于串口与调试主机通信；
2. 串口驱动实现：轮询收发

### printk()

1. 将内核信息输出到内核信息缓冲区中；
2. 内核信息缓冲区：是一个环形缓冲区（Ring Buffer); 如果塞入消息过多，则就会把之前的消息冲刷；

### /proc

1. /proc虚拟文件系统，将内核信息输出给用户；
2. 使用的命令：ps  : 显示进程pid;  top ：动态显示进行的状态
3. free ： 用于分析/proc/meminfo 得到的内存信息

### Oops

1. 当内核出现类似于用户空间的Segmentation Fault时，Oops会被打印到控制台和写入内核log缓冲区；

   ```
   cat		/dev/globalmem		// 读取设备中节点的段错误信息
   ```

### strace

1. 用于追踪**系统调用**命令的工具

## 总结

1. 学C语言不可能不去了解底层计算机体系结构和操作系统的原理，不了解底层原理连一个scanf函数都没办法用好，更没有办法保证写出正确的程序。

