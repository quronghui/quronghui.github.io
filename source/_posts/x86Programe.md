---
layout: post
title: x86Programe
date: 2019-03-14 15:57:10
categories: 
 - [LinuxC]
 - [x86 Programe]
tags: [LinuxC]
---

#  x86 Programe

+ 确实没怎么看懂

## X86的寄存器

1. x86的通用寄存器有eax 、ebx 、ecx、edx 、edi 、esi

   + 前面加 %eax

   {% asset_img Register.png  %}

2. 汇编语句的编译执行

   + 文件命名：.s

   {% asset_img Compile.png %}

   {% asset_img Compile1.png %}

## 代码解读

1.  .globl  name : 需用连接器 ld 知道的名字

2.  edi / ebx / eax

   {% asset_img edi.png %}

##  ELF 文件

1. ELF Header 目标文件布局

   {% asset_img ELF.png %}

   