---
layout: post
title: 	代码编写注意
date: 2019-08-02 15:41:14
categories: program
tags:	program
---

# Online Judge 

# 代码编写注意

## [OnlineJudge](https://discuss.acmcoder.com/topic/58ca5c6f89e48e1c02e31be5)

1. Online Judge 工作原理

   + OJ 只关心我们的输出, 不管程序细节;

   +  请不要自行输出提示信息，**这将会导致您的答案不正确，因为任何的输出到屏幕都会作为您答案的一部分**。

     ```
     printf("Please input two numbers: ")、raw_input('Please input two numbers: ')
     ```

2. OJ 的输入格式

   {% asset_img OJinput.png %}

   + 整数的输入

     ```
     scanf("%d%d", &a, &b);		// 只能读到文件空白结束;
     ```

   + 字符串的输入

     ```
     char *gets(char *s);		// 读入字符串的时候, 使用gets
     ```

3. OJ的输出格式

   + 主要是空格 / 空行的位置

   {% asset_img OJoutput.png %}

   ```
   scanf("%d", &n);
   for(int i = 0; i<n; i++){
   	int a, b;
   	scanf("%d%d", &a, &b);
   	printf("Case %d %d\n\n", i+1, a+b);		// 每个case之后输出空行
   }
   ```

4. 