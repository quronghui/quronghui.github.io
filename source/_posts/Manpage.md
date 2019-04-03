---
layout: post
title: Man Page
date: 2019-04-02 16:17:47
categories: 
- [LinuxC]
- [Man Page]
tags: [Man Page]
---

# LinuxC ManPage

+ Man Page 是linux自带的文档
+ manual  手册

## Command

1. 列出某一个章节

   ```
   man passwd		//这就是第一页
   man 5 passwd	//指定第五页
   ```

2. 列出可查询的章节

   ```
   man -aw printf		//查询文档在第几章节
   result：
   	/usr/share/man/man1/printf.1.gz		// 在第一章和第三章
   	/usr/share/man/man3/printf.3.gz
   select
   	man 1 printf
   	man 3 printf
   ```

3. 一次性查阅所有章节

   ```
   man -a printf	// 显示所有章节
   ```

   + 看完第一章后，按下q退出，会让你选择继续查看还是退出
   + 按下Enter便能继续阅读下一章节

4. 在manual中搜索关键字

   ```
   man -k printf	// 显示printf所在的章节
   ```

   + 根据得到的结果，查询对应的章节

     {% asset_img man-K.png %}

   + 搜索函数名中含有其他关键字

     ```
     man -k "^s.*printf"		//搜索含有s的printf
     ```

     {% asset_img mans-printf.png %}

5. 通过浏览器查看

   ```
   man -Hfirefox printf	// 浏览器打开
   sudo apt-get install groff	// Cannot open firefox
   ```

## 优化界面

1. 给字体分配颜色：这个得加

   ```
   vi ~/.bashrc	// 打开文件
   add code
   	# Less Colors for Man Pages
       export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
       export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
       export LESS_TERMCAP_me=$'\E[0m'           # end mode
       export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
       export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
       export LESS_TERMCAP_ue=$'\E[0m'           # end underline
       export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline	
   source ~/.bashrc
   ```

   