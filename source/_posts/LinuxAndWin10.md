---
layout: '[layout]'
title: Ubuntu18 And Win10
date: 2019-02-18 11:25:12
tags: System
categories:  skill
---

# Win10 + Ubuntu 双系统

## Win10 + Ubuntu环境的搭建

- [参考链接](https://blog.csdn.net/qq_41057206/article/details/80534194) 

- 有些工作需要切换windows,因此才搭建了双系统。

- 主机环境是SSD+HDD

  - 压缩卷的时候，不用压缩SSD，找一个大一点的机械硬盘，直接将其状态删除为未分配的状态。

  {% asset_img ssdandhdd.png %}

1. 准备工作
   - [下载UltralSO，这是用来制作启动盘的软件](https://cn.ultraiso.net/uiso9_cn.exe)
   - [下载Linux系统的镜像ubuntu16.04，可以在官网上下载](https://pan.baidu.com/s/14FLwaGzSlCbuDqnwYNUzCg)
   - （可选）下载启动项编辑工具[EasyBCD]
2. windows系统下进行分盘
   - 我的电脑--计算机管理--压缩的磁盘--右键--压缩卷
   - 选择未分配区域，右键选择“新建卷“ -- 右键“删除卷”可以将这变成可用空间
3. 制作ubunut启动盘
   - 打开UltraSO软件，选择“文件”-“打开”打开之前下好的iso映像文件
   - 选择“启动”-“写入硬盘映像”。此处注意选择正确硬盘驱动器。
   - 依次点击“格式化”和“写入”，完成后它会在消息处提示“刻录成功！”
4. 设置window 下的BIOS
   - 关闭快速启动。选择控制面板-电源选项-选择电源按钮的功能，选择“更改当前不可用的设置”，取消选中“启用快速启动”
5. 安装ubuntu
   - 在下一步之前，一定要先联网，会进行下载
   - 选择 安装音频相关软件......

## Ubuntu 工具的安装

- [参考链接](https://www.jianshu.com/p/19353fbda01e) 
- 用到的时候直接搜索

