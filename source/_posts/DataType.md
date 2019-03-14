---
layout: post
title: DataType
date: 2019-03-12 10:03:09
categories: 
 - [LinuxC] 
 - [Emededded]
 - [Data Type]
tags: [Linux, C]
---

# DataType

## 整形

1. 计算机的最小存储单位：**Byte**(不是bit)
2. 1 Byte = 8 bits
3. char 占一个 Byte

## 代码的可移植性

1. 编译器规定 有无符号类型

   {% asset_img char.png %}

### C 规定的Implementation Defined

1. C语言和平台和编译器密不可分的；
2. ASCII 的取值范围是 0-127
   + 这时候char存储一个ASCII，不必写明signed和unsigned
3. 如果char表示8位的整数
   + 为了可移植性就必须写明是signed还是unsigned 
4. 2's Complement : 表示的是补码

### Implementation-defined、Unspecified和Undefined
1. implementation

   {% asset_img implementation.png %}

2. Unspecified

   + C标准没有明确规定按哪种方式处理，编译器可以自己决定，并且也不必写在编译器的文档中；
   + 这样即使用同一个编译器的不同版本来编译也可能得到不同的结果
   + 因为编译器没有在文档中明确写它会怎么处理,那么不同版本的编译器就可以选择不同的处理方式。

3. Undefined

   {% asset_img undefined.png %}

### C标准规定

1. 除了char类型需要表明 signed 和 unsigned

2. 其他整形不明确表明signed 和 unsigned，都表示**有符号**(-127-128)的数
   + 容易造成访问越界的问题
   + 整形数据需要表明有无符号

3. C规定用八进制和十六进制常量，代替二进制常量。

4. 除了char是C明确规定占一个字节，其他的几个字节都是implementation

   {% asset_img LP.png %}

## 浮点型

1. float 型通常是32位，double型通常是64位。
2. 浮点型的后缀和类型
   + double : 没有后缀
   + float : f / F 的后缀
   + long double : l / L的后缀

## 类型转换

+ **C语法中最复杂的一部分**

### Integer Promotion

1. char，short，Bit-field：提升为整形int表示，或者unsigned int 

   ```
   unsigned char c1 = 255, c2 = 2;
   int n = c1 + c2;
   ```

   + 最后结果是257，而unsigned char 范围是0-255;
   + 是先把c1 和c2提升为int类型，然后相加得到的

### Usual Arithmetic Conversion

+ 两边运算的类型不同，低的类型往高的类型转换

  {%  asset_img usual.png %}

### 赋值类型的转换

1. 右边的类型转换为左边的类型，在进行赋值

### 编译器的类型转换处理

+ 规则不用用来记的，而是用来排错误

1. 数据转换最大的问题便是：造成越界或者溢出

   {% asset_img typechange.png %}

