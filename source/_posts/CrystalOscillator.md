---
layout: post
title: Crystal Oscillator
date: 2019-03-17 09:58:03
categories: 
 - [Oscillator]
 - [Electronic]
tags: [Oscillator]
---

# Oscillator and Crystal 

## 有源晶振 oscillator（振荡器）

+ 有源晶振是右石英晶体组成的。
+ 石英晶片：可以当为振荡器使用，是基于它的压电效应：在晶片的两个极上加一电场，会使晶体产生机械变形；

### 四脚晶振

1. 有源的四脚晶振：有个点标记的为1脚，按逆时针（管脚向下）分别为2、3、4
2. 有源晶振通常的用法：一脚悬空，二脚接地，三脚接输出，四脚接电压。

### 配置电路

1. 有源晶振不需要DSP的内部振荡器，信号质量好，比较稳定，而且连接方式相对简单。
2. 电源滤波：通常使用一个电容和电感构成的PI型滤波网络，
3. 三脚输出端：用一个小阻值的电阻过滤信号。

## 无源晶振 Crystal 

+ 仅由阻容元件组成

### 起振需求

1. 无源晶振是有2个引脚的无极性元件，需要借助于时钟电路才能产生振荡信号，自身无法振荡起来。
2. 两端的匹配电容大小要合适，不然导致无法起振。

## 晶振是否起振测量

### 示波器测量

1. 通电的情况下，测量双脚：

   + 脚1和脚3是通电的，电流从脚1流入、脚3流出。
   + 正接脚1，负接3；
   + 以探头最好打到衰减档进行测试，探头测试晶振管脚有固定正确频率的正弦波信号输出即可。

2. 通电的情况下，测量单脚：

   + 用示波器连接任意一个引脚与地线，
   + 观测到震荡波形且频率与晶振频率相符（频率不对的话是干扰信号）就说明已经起振。

   {% asset_img Crystal.png %}

## 原因分析

### 焊接

1. 晶振的温度范围 -50 -- 85。
2. 焊接时烙铁的温度200 度左右。

### PCB 工艺问题

1. 电容值不匹配，电容值大小和晶振起振相反。
   + 降低电容值，看是否起振
   + 选择的电容的值越大单片机的耗电能力也就越强。而且易造成不起振的情况。
2. 晶振两脚之间有走线
3. 晶振[电路](http://bbs.elecfans.com/zhuti_dianlu_1.html)的走线过长

