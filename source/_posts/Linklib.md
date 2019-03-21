---
layout: post
title: Link lib
date: 2019-03-19 09:34:12
categories: 
 - [LinuxC]
 - [Linklib]
tags: [Linklib]
---

# Link lib

+ [Code link](https://github.com/quronghui/LinuxC.git) -- Link

## 多目标文件链接

1. 编译查看命令

   ```
   $ gcc main.c -o main	//编译可执行文件
   $ readelf -a main 		//查看到个函数的段定义
   ```

   {% asset_img readelf.png %}

2. 目的：

   + 能查看到跟函数的**段定义**
   + Data Segment 后面的一些Segment，主要是调试信息