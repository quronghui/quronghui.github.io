---
layout: post
title: Funcation Interface
date: 2019-03-25 19:24:34
categories: 
 - [Funcation Interface]
 - [LinuxC]
tags: [Funcation Interface]
---

# Funcation Interface

+ 我们讲过void *类型 和任何指针类型之间可以相互隐式转换。

## 函数接口的定义

1. 函数的**调用者**和函数的**实现者**之间订立了一个契约

   + 调用函数之前：调用者要为实现者提供某些条件
   + 函数返回时：实现者要对调用者尽到某些义务。

2. 首先靠函数接口来描述

   + 即函数名,参数,返回值,只要函数和参数的名字起得合理
   + 参数和返回值的类型定得准确

3. 函数接口并不能表达函数的全部语义

   {%asset_img man_page.png%}

   + 这时文档就起了重要的补充作用，怎么写Man Page
   + [Online man page](http://man7.org/linux/man-pages/)
   + command line --> man strcpy

### strcpy and strncpy

1. man page

   + 命令行输入：man strncpy

     {% asset_img strcpy.png %}

   + dest: Destination（目的）

   + src: Source(源)

   + n :  看下面的文档

2. 注意dest的空间一定要足够大

   + 否则：发生越界
   + 像buf 这种由调用者分配并传给函数读或写的一段内存通常称为缓冲区(Buffer)
   + 缓冲区写越界的错误称为缓冲区溢出(Buffer Overflow)

3. Bug : 数组的长度必须固定，所以strncp容易造成越界；

   + char buf[n+1] = {} ;	// 虽然保证buf 是以 '\n'结尾，但是仍然不够灵活
   + 动态内存分配

### malloc and free

+ C的标准函数，都是可以直接用的，对吧。（在C中定义好了）

1. malloc

   + malloc

     ```
     void *malloc(size_t size);	
     /* void *类型 和任何指针类型之间可以相互隐式转换。 */
     ```

   + 对每次的调用malloc，进行判断函数调用是成功，还是失败。

     ```
     if (p == NULL) {
             printf("out of memory\n");  /* 对每次的调用malloc，判断函数成功/失败的返回值 */
             exit(1);
         }
     ```

2. free

   - 每一次调用malloc，都需要free，对指针内存和地址进行释放
   - **内存泄漏**（Memory leak）:分配完了又不释放,就会慢慢耗尽系统内存
     - 内存泄漏的Bug很难找到,因为它不会像访问越界一样导致程序运行错误

3. 特殊情况

   + free : 只要不是释放野指针就没问题

     ```
     malloc(0);		return 非NULL的指针
     free(NULL);		合法的
     ```

   + free 产生错误

     ```
     malloc(p);
     free(p);
     free(p);	//到这里会报错
     ```

     