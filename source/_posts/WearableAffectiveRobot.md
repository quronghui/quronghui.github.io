---
layout: post
title: WearableAffectiveRobot
date: 2019-07-29 20:35:59
categories: project
tags:	AIWAC
---

#  WearableAffectiveRobot

+ [项目在2018年发表到IEEE  (Journal Article)期刊和杂志](https://ieeexplore.ieee.org/document/8506341/citations)

## 应用场景

1. 提出一种将情感机器人、社交机器人、大脑可穿戴和可穿戴2.0相结合的可穿戴情感机器人.

2. 提出的可穿戴式情感机器人适用于广大人群，相信它能在**精神层面**上改善人体健康，同时满足**时尚需求**

   {% asset_img  smart.png %}

## 实现理念

1. 结合智能情感交互机器人、智能触觉交互装置和智能大脑穿戴装置，以智能服装的形式实现了一种新型的fitbot社会情感机器人.

   {% asset_img  wearable.png %}

2. fitbot社会情感机器人设计的架构

   + 一个智能终端（智能手机）的隔离层，用于存储智能终端（智能手机），方便其与人体的物理连接和互动。
   + 其他模块，如aiwac智能盒、aiwac智能触觉设备、大脑可穿戴设备、aiwac机器人和云平台。

   {% asset_img robot.png %}

## 嵌入式设计及实现功能

{% asset_img robot_board.png %}

+ 难点：各模块的整合，焊接。
+ 获得：单板设计能力，Linux驱动了解

1. AIWAC智能盒硬件设计

   + **设计过程**: 基于全志 A33 Vstar 进行二次开发, 设计外围硬件接口并修改视频和语音的内核驱动,完成基本的音视频交互功能;

     {% asset_img  hardwater.png %}

   + **实现功能**: 提供视觉和语音交互，提供丰富的触觉感知和交互功能; 通过语音交互识别情感;

2. 大脑可穿戴硬件设计

   + **设计过程**: 基于 ADS1299 单路脑电采集装置, 由三个串联的电极组成：IN1P脑电信号采集电极、参考电信号电极和BIAS1偏执驱动电极;

     {% asset_img brain.png %}

   + **实现功能**: 采集用户脑电信号

     {% asset_img  eeg.png %}

3. AIWAC智能触觉装置

   + **设计过程**: 基于 CH559 和电容触摸片,实现与手机物理连接后简单的控制操作和触觉感知;

   + **实现功能**: 进行简单的游戏测试

     {% asset_img  game.png %}

4. 可穿戴情感机器人原型

   + **设计过程**: 集成aiwac智能盒、aiwac智能触觉设备、大脑可穿戴设备、phone和时尚外套

     {% asset_img core.png %}

   + **实现功能**: 采集的情绪数据主要是语音情绪数据, 机器人和用户之间的语音交流实现用户情感的分析.

     {% asset_img  emotion.png%}

## 情感机器人算法

1. 基于aiwac智能盒的情感识别算法

   + 在RNN算法框架中引入一种注意机制，在网络中引入了一种新的**权值分担策略**，特别注意了**语音的强情感特征**部分。

     {% asset_img  alogithm.png %}

2. 基于脑穿戴设备的用户行为感知

   + 通过一个**眨眼检测**实例，可以介绍大脑穿戴设备对用户行为的感知

     {% asset_img  signal.png %}