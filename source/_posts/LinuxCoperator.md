---
layout: post
title: LinuxC Operator
date: 2019-03-12 14:44:44
categories: 
 - [LinuxC] 
 - [Emededded]
 - [LinuxC Operator]
tags: [Linux, C]
---

# LinuxC Operator

+ 主要是介绍位运算符，通过位运算对整数进行操作。

## 位运算

### 按位与、或、异或、取反

+ 要进行数据类型的转换：Data Type

  {% asset_img operator.png %}

  ```
  unsigned char c = 0xfc;
  unsigned int i = ~c;
  result : ffffff03
  ```

+ 先进行类型的提升，在进行转换。

### 移位运算

1. 移位运算符(Bitwise Shift)包括 左移 << 和 右移 >> 
2. 无符号的移位
   + 左移将一个整数的各二进制位全部左移若干位
3. 有符号的移位
   + 不建议使用，减少出错
   + 正数的高位移入0
4. 移位运算中：不同进制数 和 不同的类型之间的区别
   + 不同的进制数：同一个数用不同的方式进行表示
   + 不同的类型：存储一个数所能提供的空间（位）
   + 同一个数在不同的类型转换中，会发生溢出现象

### 掩码

1. 对一个整数的某些位进行操作

   ```
   define ： mask = 0x0000ff00; //(定义一个32的存储类型int)对一个数的8-15位进行操作
   ```

## 其他运算符

### 复合赋值运算符

1. 在赋值的同时做一次运算

   {% asset_img assignment.png %}

2. 对于有 Side Effect 的表达式，影响是不同的。

### Sizeof and typedef

1. sizeof 是一个特殊的运算符：sizeof 表达式和 sizeof(类型名)

   + sizeof(表达式)：

     + （表达式）不进行求值计算，将（表达式）类型所占的字节数，作为整个**sizeof(表达式)**的值
     + sizeof（表达式）的值  =  是size_t类型的

   + size_t 类型名

     + C明确规定：sizeof 的值是无符号整形

     ```
     typedef unsigned long size_t;		// 为了不同平台，规定size_t的类型
     ```

2. typedef 

   + 用于给一个类型取名字

   + ```
     typedef unsigned long size_t;	// size_t是一个类型，代表unsigned long的类型
     unsigned long size_t;			// size_t是一个变量，变量的类型是unsigned long
     ```

   + ```
     typedef char array_t[10];
     array_t a;
     // 定义了一个 char类型的 a[10]
     ```

### Side Effect and Sequence Point

+ 造成的后果：结果出现Undefined

1. Side effect : 针对函数调用过程中，先后顺序不确定，造成结果的Undefined.

2. Sequence Point：调用一个函数时,在所有准备工作做完之后、函数调用开始之前。

   ```
   foo( f(), g());		//调用函数f(),g()的Side Effect发生的顺序不一定；等所有的Side Effect调用完了，才调用foo()
   ```

3. short-circuit : 简写 &&  ||  的逻辑表达式

   ```
   a && b		// &&：a为真才调用b，写成if(a) b; 
   a || b		// ||: a为假才调用b, 写成 if(!a) b;
   ```

4. Sequence Point

   + 哪些地方是一个Sequence Point（序列点）
   + 一个完整的操作前后都可以称之为Sequence Point；
   + 完整的声明；完整表达式的末尾； “ ； ”
   + 像printf 、scanf 这种带转换说明的输入/输出库函数,在处理完每一个转换说明相关的输/输出操作时是一个Sequence Point。

5. 定义规则

   + 在两个Sequence Point之间,同一个变量的值只允许被改变一次。
   + 如果在两个Sequence Point之间既要读一个变量的值又要改它的值,只有在读写顺序确定的情况下才可以这么写。

6. 错误示例

   ```
   int a=0;
   a = (++a)+(++a)+(++a)+(++a);		//对变量a有5次Side Effect
   ```

   ```
   a[i++] = i;				// 变量i的读写顺序不能确定
   ```

## 运算符总结

1. 运算符的规则：也就是优先级

   {% asset_img rule.png %}

2. Bug 查错的规则：优先级的先后顺序

   + 算数 > 移位 > 关系 > 相等性 > 按位操作 > 逻辑操作 > 条件运算符 > 赋值 > 逗号

   {% asset_img summary.png %}