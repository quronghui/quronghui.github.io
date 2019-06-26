---
layout: post
title: Electronic Direction
date: 2018-12-25 11:35:03
categories: 
 - [Electronic Direction]
 - [Open Link]
 - [awesome-electronics]
tags: Electronic Direction
---

# Electronic Studying

- 嵌入式学习的一个方向指导
- 嵌入式过程中常用的工具，社区，书籍

## Contents

[TOC]



## Computer history 

- 从嵌入式的元件，到计算机的整体架构；
- [bilibili](https://www.bilibili.com/)  视频学习教程
- 搜索[计算机科学](https://search.bilibili.com/all?keyword=%E8%AE%A1%E7%AE%97%E6%9C%BA%E7%A7%91%E5%AD%A6&from_source=banner_search)----【计算机科学速成课】

## Awesome Electronics

- 介绍嵌入式的一些网址，工具，和开源社区
- GitHub 中[kitspace](https://github.com/kitspace)/**awesome-electronics**
- github 中的 awesome，是一个很强大的 Project

## Book -- 高清完整书签PDF版

+ [收藏的电子书清单（多个学科，含下载链接）(https://github.com/programthink/books)
+ [[**极客侠栈**](https://pymlovelyq.github.io/)]
+ xxx. epub 用亚马逊的账号登录，kindle进行阅读

### PCB

1. Eagle 的学习使用【高质量PCB设计入门--Eagle使用】
   + [PCB SCH 绘制规则参考ESP32](https://www.espressif.com/zh-hans/company/contact-extra/technical-inquiries-hardware-prologue)

### LinuxC

1. LinuxC 编程一站式学习 --  2019.2.14 - 5.14
2. [C和指针.pdf](https://github.com/tolerious/Programming_learning_resource/tree/master/C-Language)
3. [C专家编程.pdf](https://github.com/mymmsc/books/blob/master/c/C专家编程.pdf)
4. 深入理解Linux 内核
5. [鸟哥的Linux私房菜-基础学习篇(第四版)高清完整书签PDF版.pdf](http://itbook1234.com/1093.html)

### data struct

+ [data struct](https://www.infoq.cn/article/ur1QLockeQ*hXobPm0kI)
+ [[数据结构与算法分析：C语言描述_原书第2版_高清版.pdf](https://github.com/Bzhnja/ebooks/blob/master/数据结构与算法分析：C语言描述_原书第2版_高清版.pdf)] -- 2019.5.14 - 5.27

### algorithm

2. [凸优化，嵌入式的算法模型](https://github.com/KeKe-Li/book/tree/master/AI)
3. [C++ Primer第五版中文版](http://itbook1234.com/134.html)

### system

1. [现代操作系统 原书第4版](https://pan.baidu.com/s/1EnlH0saLicZo1uobE7cmBQ)
   - 提取码：j5p9

### 嵌入式

1. CPU 方向：
   + 计算机 / SOC 架构；
   + 脚本语言，Python 优先；
2. 物联网方案
   + 悉 TCP 与 UDP 的特点与使用，了解 Wi-Fi / 蓝牙协议优先；
   + FreeRTOS / uCOS 等嵌入式系统优先；
   + 熟悉脚本语言，掌握 Python 优先；
   + 熟悉计算机网络协议熟悉 802.11 协议或蓝牙协议优先；
   + 熟悉 GCC 和 GDB；

## Tools

### AutoDesk Student

1. [AutoDesk](https://www.autodesk.com/education/home)

2. 选择地区是中国的，为了后面的学校验证

   { % aeest_img autodesk.png % }

3. 用学校邮箱创建账户，进行验证

4. 进入免费软件一栏，可以看到免费软件

   { % aeest_img autodesk_free.png % }

### Eagle

1. PCB绘制工具，相对于AD来说更加轻量级，而且有大量的封装库。

2. 申请免费的Eagle

    { % aeest_img eagle.png % }

3. 学习[【高质量PCB设计入门--Eagle使用】](https://pan.baidu.com/s/1dkkCsLxvMnmt7JEx2uNjbg)

### Adobe Creative Cloud

1. [Adobe Creative Cloud](https://www.adobe.com/cn/creativecloud/catalog/desktop.html)
2. 通过安装Adobe Creative Cloud desk，从而安装 Illustrator (AI的矢量图)
3. Illustrator 能够绘制矢量图，从而导入到 Eagle.
4. Eagle : 不能写中文，而且图形不是矢量的。

## 毕设的方向

+ 基于物联网设备的边缘计算系统的搭建

### 研究背景

​	随着大数据、云计算、物联网、人工智能等技术的快速发展，万物互联时代加速到来，连接到网络的设备数量和数据量都呈现快速增长态势。

​	如果按照传统的方式，将嵌入式设备采集到的数组一起发送到云平台，将会造成网络的严重负载。云计算模式的缺陷日益突出，而边缘计算为解决工业互联网智能制造过程中数据分析和实时控制提供了有效手段。

​	在健康监测等领域，边缘计算可以让需要针对用户进行无监督机器学习的可穿戴设备获益颇多。此外，在未经事先学习的情况下，定制的应用程序若要实现迅速推理，通常需要极高的数据处理能力作为支撑，而这正是边缘人工智能的专长所在。

### 研究内容

1. **边缘人工智能化**：嵌入式设备方案 + 物联网云平台 + 边缘计算框架的搭建和部署

2. 嵌入式设备方案 (嵌入式方案可以更换)

   - [看物联网如何颠覆传统设计，这十个方案给你答案！](https://www.cirmall.com/articles/389181)
   - 题目一：基于STM32单片机的物联网远程数据监控系统

3. 物联网云平台

   + 通过WIFI无线通讯技术将数据上传到物联网云平台，通过物联网云平台将数据可视化，
   + 可进行远程监控和计算

4.  边缘计算框架的搭建和部署

   + 研究边缘计算的相关框架，以及如何将模型迁移到物联网的基础设备上
   + 将一部分的计算放在嵌入式设备上，减少云平台和嵌入式设备间的直接交互；
   + 通过嵌入式设备本地的计算，发送控制信号；

   

5. 物联网 + 边缘计算 ：是一种理论的研究。仿真或者是

   + [边缘智能或将打通物联网应用之路的最后一公里](https://www.eefocus.com/communication/442608)

   + 物联网+边缘计算：减少物联网设备中数据的发送，在边缘进行处理