---
layout: post
title: LinuxC Struct
date: 2019-02-27 21:59:46
categories:
 - [LinuxC] 
 - [Emededded]
tags: [Linux, C]
---

+ [Code link](https://github.com/quronghui/LinuxC.git) -- struct 的相关代码

# LinuxC Struct 

- 学习一门语言要注意的三点

  {% asset_img struct.png 学习语言需要注意的三点 %}

- 本节将以结构体为例来讲解数据类型的组合和抽象。

## 结构体

+ 代码链接

1. 结构体定义

   - 过程抽象：将一组语句通过函数名封装Tag，当做整体调用
   - 结构体

   ```
   结构体：complex_struct不表示变量，而是表示类型,类似于int的符合类型
    	struct complex_struct		
       {
           double x, y;   /* data */
       }z;
   ```

2. 结构体的变量使用

   ```
   结构体变量的初始化和使用
   （1）Ways1
       double x = 3.0;             // 不等同于Tag的z.x；
       z.x = x;                   // 变量访问成员，通过z.x 
       z.y = 4.0;
    (2) Ways:定义的时候直接初始化
    	struct complex_struct z = { 3.0, 4.0 };
    (3)错误的初始化
   	struct complex_struct z1;
   	z1 = { 3.0, 4.0 };
   
   ```

3. 结构体当做函数的参数使用

   ```
   3. 项目描述：将结构体当做函数的参数和返回值来传递
   （1）结构体当做函数的参数，比如 int main,中的int
   (2) struct complex_struct 当做函数 add_complex的参数
   
   struct complex_struct add_complex(struct complex_struct z1, struct complex_struct z2)
   {
       z1.x = z1.x + z2.x;
       z1.y = z1.y + z2.y;
       return z1; 
   }
   ```

## Data Abstraction (数据抽象)

+ ​	{%  asset_img DataAbastraction.png %} 

1. gcc编译时提示对‘sqrt’未定义的引用

   ```
   gcc　-*.c -lm		// 需要链接 libm.so 库
   ```

2. 将复数运算的代码分成块的时候，报错

   + 代码还没有解决。DataAbstraction.cpp

   ​	{%  asset_img redifineBug.png %} 

   + 解决成功

     ```
     为了避免其他文件引用DataAbstraction.h，造成重复定义的问题：
     	add code:
     		#ifndef _TEST_H_ 
     		#define _TEST_H_  
     		{	...  }
     		#endif
     ```

## 数据类型的标志

+ 也就是设立 flag （0/1）标志位

1. Enum 标志位

   ```
   // 枚举类型：枚举类型的成员和变量名在同一个空间，不能定义成同样的名字。
   enum coordinate_type        // 类似于Struct的Tag,enum代表的是枚举类型
   {                           // 代表常量Rectangular（直角坐标） == 0 ；
       Rectangular, Polar      // 代表常量Polar(极坐标) == 1
   };
   ```

2. 还没有实现如何结合struct Tag 一起使用

3. Enum 可以实现递增赋值的Tag 

   ```
   enum Month {Jan=1,Feb,Mar,Apr,May,Jun,Jul,Aug,Sep,Oct,Nov,dec} a,b;
   ```

## 结构体的嵌套

1. 结构体有数据类型定义，结构体本身便是一种数据类型，可以进行嵌套。

   ```
   struct Segment{
       struct complex_struct start;
       struct complex_struct end;
   };
   struct complex_struct{
       double x,y;
   };
   ```

2. 访问结构体的成员应该用多个 . 运算符

   ```
   s.start.x = 1.0;
   s.start.y = 2.0;
   ```

   