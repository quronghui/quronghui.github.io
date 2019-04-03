---
layout: post
title: C Standard Lib
date: 2019-04-02 15:52:18
categories:
- [LinuxC]
- [standard lib]
tags: [standard lib]
---

# C Standard Lib

+ C标准主要由两部分组成，一部分描述C的语法，一部分描述C标准库。
+ 平台支持C语言
  + 实现C编译器
  + 实现C标准库
+ 函数文件的命名，以.c 为准
  + 在 ’.c‘ file：void * 类型的数，做右值的时候会自动进行转换；
  + 在 ’ .cpp ‘file：不会自动的转换
+ POSIX 是Unix系统的标准，不属于C标准库

## String Funcation

+ 程序按功能划分可分为数值运算、符号处理和I/O操作三类,
+ 符号操作：由各种基本的字符串操作组成。
  + 字符串的初始化、取长度、拷贝、连接、比较、搜索等基本操作。
+ 字符串的操作中：' \0 ' 的操作要注意。操作可能是including，excluding

1. size_t 

   + size_t 是一种类型，表示的是操作系统的位数，32位和64位

2. memset

   + 初始化字符串

     ```
     void *memset(void *s, int c, size_t n);// 将指针s指向的存储空间的 n 位数，用 c 代替；
     memset(buf, 0, 10);	//将buf的前10位用0初始化
     ```

3. strlen

   ```
   size_t strlen(const char* s);	计算字符串长度
   ```

   + 注意数组的越界

### 拷贝字符串

+ [SCLib/memcpy](https://github.com/quronghui/LinuxC.git)

1. strcpy and strncpy

   + 拷贝以 ' \0 '结尾的字符串；
   + 属于字符类型
   + 以str开头的函数处理以'\0' 结尾的字符串;

   ```
   char *strcpy(char *dest, const char *src);
   char *strncpy(char *dest, const char *src, size_t n);
   ```

   +  strn 不需要以 '\0'结尾，当source的前n个字节没有NULL（'\0'），那么dest不需要以NULL结尾
   + 当source的字节数，少于n个字节，那么dest将填充足够的NULL（'\0'）直至满足n个字节

2. memcpy and memmove

   + mem*：针对的是memory，存储单元

   + 根据src指向的内存地址，拷贝n个字节（而不一定是字符串）
   + 而以mem开头的函数则不关心'\0' 字符,或者说这些函数并不把参数当字符串看待,因此参数的指针类型是void *而非char * 

   ```
   void *memcpy(void *dest, const void *src, size_t n);
   void *memmove(void *dest, const void *src, size_t n);
   ```

   + memcpy的两个参数src 和dest 所指的内存区间如果重叠，则无法正常拷贝。
   + 可以借助一个临时的缓存区，进行拷贝

3. 在32位的x86平台上,每次拷贝1个字节需要一条指令,每次拷贝4个字节也只需要一条指
   令,memcpy函数的实现尽可能4个字节4个字节地拷贝,因而得到上述结果。

### 连接字符串

1. strcat and strncat
   + 以str开头的函数处理以'\0' 结尾的字符串;
2. strncat
   + strncat总是保证dest 缓冲区以'\0' 结尾，这一点又和strncpy不同，strncpy并不保证dest缓冲区以'\0'结尾
   + dest至少含有的字节数：strlen(dest)+n+1个

### 比较字符串

1. memcmp

   + memcmp - compare memory areas
   + mem*：针对的是memory，存储单元

   ```
   int memcmp(const void *s1, const void *s2, size_t n);
   return 负值，0， 正值
   ```

   + memcmp从前到后逐个比较缓冲区s1和s2的前n个字节(不管里面有没有'\0' )

2. strcmp and strncmp

   + strcmp把s1和s2 当字符串比较,在其中一个字符串中遇到'\0' 时结束;
   + strncmp 遇到'\0' 或者 比较完了n个字节，就结束。

### 搜索字符串

+ 笔试估计会考，还有相应的算法。【算法导论】

1. strchr and strrchr

   ```
   locate character in string
   char *strchr(const char *s, int c);	// 从前到后，找到第一次出现的C就返回
   char *strrchr(const char *s, int c);// 从后到前，
   ```

   + 如果没有找到就返回 NULL
   + 疑问：为什么character 是int型的而不是char类型？

2. strstr

   ```
   char *strstr(const char *haystack, const char *needle);
   返回值:如果找到子串,返回值指向子串的开头,如果找不到就返回NULL
   ```

   + 堆haystack中找一根针needle ，按中文的说法叫大海捞针，显然haystack 是长字符串，needle 是要找的子串。

### 分割字符串

1. 分隔符：符号是‘ ：’；

   + 在编写Makefile 文件的时候；
   + clean : 文件的编写，就需要加分隔符

2. 分割符

   + 很多文件格式或协议格式中会规定一些分隔符或者叫界定符(Delimiter),例如/etc/passwd文件中保存着系统的帐号信息。

3. strken

   + C标准库提供的strtok函数可以很方便地完成分割字符串的操作。
   + tok是Token的缩写,分割出来的每一段字符串称为一个Token

   