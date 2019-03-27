---
layout: post
title: C语言入门
date: 2019-02-19 09:57:24
categories: 
 - [LinuxC] 
 - [Emededded]
tags: [Linux, C]
---

# Linux C编程一站式学习

+ {% pdf LinuxC.pdf %}
+ [LinuxC 课后习题答案](https://www.zybuluo.com/ChristopherWu/note/72463)
+ [LinuxC.pdf 文档中的代码](https://github.com/quronghui/LinuxC.git)

## C语言入门

+ 程序的五个步骤

  {% asset_img programmer.png 程序实现的五个步骤 %}

1. math函数的gcc编译

   ```
   $ gcc math.cpp -o math -lm 		 // math的编译要加上 "-lm"
   $ gcc hello.c -o hello -Wall 	 // gcc编译带上 -Wall,显示所有警告的信息
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

5. Debug Ways

   + 增量式开发：通过printf的方式，一步步打印结果查看

   + printf (" ")  	// 通过打印进行调试

6. 递归函数：要加上 Base Case

   ```
   int factorial(int n)
   {
       if (n == 0)			//也就是0项
       	return 1;
   }
   ```

   + 递归和循环是等价的;
   + 用循环能做的事用递归都能做

7. 循环函数

   + 循环函数:相当于将函数表达式展开，然后通过while()，进行循环的迭代

   + do / while 的格式

     ```
     do 
     	语句；
     while(); 		// while 后面有个分号
     ```

8. Break and Continue

   + break : 跳出当前循环体，执行后面的语句；
   + Continue : 终止本次循环(循环里面的内容，在continue之后的语句都不执行)，然后回到循环体的开头准备再次执行循环体。

9. 表达式的左值和右值

   + 由 “ = ”进行连接
     + 左边：表示的是存储位置；--- 称为左值
     + 右边：表示要存储的值；-- 称为右值

