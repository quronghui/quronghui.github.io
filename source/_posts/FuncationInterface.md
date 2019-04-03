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
     free(p);	//第二次释放的时候，找不到指针，到这里会报错
     ```

   + 正确的free过程

     ```
     free(p->msg);
     free(p);
     p = NULL;
     ```

     

## 传入参数和传出参数

+ [parameter code](https://github.com/quronghui/LinuxC.git)

1. 传入参数：把指针所指向的数据传给函数使用；
2. 传出参数：由函数填充指针所指的内存空间，传回给调用者使用
3. 如果传入参数是NULL表示取缺省值,也可能表示不做特别处理。
4. 如果传出参数是NULL 表示调用者不需要传出值,例如time(2) 的参数。

### 函数

```
void func(const unit_t *p)	//传入参数
void func(unit_t *p)		//传出参数
void func(unit_t *p);		//Value-result参数示例:
```



## 两层指针

+ [TwoPointer](https://github.com/quronghui/LinuxC.git)

### 两层指针的内存分配

{% asset_img malloc_unit.png %}

### 两层指针和单层指针

1. 两层指针只能作为传出参数，两种情况
   + 传出的指针指向静态内存,或者指向已分配的动态内存；
   + 在函数中动态分配内存，然后传出的指针指向这块内存空间,这种情况下调用者应该在使用内存之后调用释放内存的函数。

```
void alloc_unit(unit_t **pp); 	//分配内存
void free_unit(unit_t *p);		//释放内存
```

2. 参数分配内存则需要两层指针

## 返回值是指针的情况

### 返回指向已分配内存的指针示例

+ [FuncationInterface / ReturnPointer](https://github.com/quronghui/LinuxC.git)
+ unit_t *func(void)

###  动态分配内存并返回指针

+ [FuncationInterface / ReturnPointer / Return ](https://github.com/quronghui/LinuxC.git)

  ```
  unit *alloc_unit(void);
  void free_unit(unit *p);
  ```

+ 通过返回值分配内存就只需要一层返回指针；

+ 参数分配内存则需要两层指针

## 回调函数

1. 利用函数指针的方法进行调用

   {% asset_img callback.png %}