---
layout: post
title: Pretreatment
date: 2019-03-21 15:15:19
categories:
 - [LinuxC]
 - [Pretreatment]
tags: Pretreatment
---

# Pretreatment 预处理

## 预处理步骤

+ 经过以下步骤之后，把空白字符丢掉，把Token交给C编译器做语法解析,

### 换行符

1. Windows平台的文本文件用\r\n 做行分隔符,而Linux平台用\n做行分隔符；
2. C编译器要能处理差别
3. 把用 “ \ ” 字符续行的多行代码连成一行
4. 把注释都替换为一个空格

### Token

1. 然后预处理器把逻辑代码行划分成Token和空白字符,
2. 这时的Token称为预处理Token：包括标识符、整数常量、浮点数常量、字符常量、字符串、运算符和其它符号

## 宏定义

+ 较大的项目都会用大量的宏定义来组织代码，宏定义很常用

### 函数式宏定义

1. 变量式

   ```
   #define N 20
   ```

2. 函数式

   ```
   #define MAX(a, b) ((a)>(b)?(a):(b))		// 不加括号，展开后会报优先级错误
   k = MAX(i&0x0f, j&0x0f)
   ```

3. 函数式宏定义

   + 不建议使用

### 内联函数

1. 关键词：inline

## 条件预处理提示

### Header Guard

```
#ifndef HEADER_FILENAME		//如果没有定义HEADER_FILENAME，则执行后面的语句
#define HEADER_FILENAME
/* body of header */
#endif

```

1. #ifdef 或 #if 可以嵌套使用,但预处理指示通常都顶头写不缩进,为了区分嵌套的层次

### 预处理过程

1. 先处理defined运算符

   ```
   #if defined x  相当于  #ifdef x
   #if !defined x 相当于	#ifndef x
   ```

2. 展开所有的宏定义

3. 把没有定义的宏换成 0

4. 把得到的表达式 ，像C表达式一样求职

## 其他预处理特性

1. _ FILE _  ：展开为当前源文件的文件名,是一个字符串,
2. _ LINE _  ：展开为当前代码行的行号,是一个整数。
3. _ func _   :  特殊的标识符，打印所在函数的名字

### assert.h 实现

1. #undef assert 确保取笑前面对assert的定义
2. 然后分另种情况：

{% asset_img assert.png %}