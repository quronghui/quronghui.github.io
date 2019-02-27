---
layout: post
title: Kinect Sensor
date: 2019-02-27 10:26:48
categories: Kinect 
tags: C++
---

# Kinect Sensor

## Kinect设备

1. 基座和感应器之间有一个电动的马达，通过程序能够调整俯仰角度;
2. 在上面的感应器中有一个红外投影仪，两个摄像头，四个麦克风和一个风扇。、
   + 最左边是红外光源，其次是LED指示灯
   + 中间的是彩色摄像头，用来收集RGB数据
   + 最右边是[红外摄像头](https://www.baidu.com/s?wd=%E7%BA%A2%E5%A4%96%E6%91%84%E5%83%8F%E5%A4%B4&tn=24004469_oem_dg&rsv_dl=gh_pl_sl_csd)用才采集景深数据
3. 成像大小
   + 彩色摄像头最大支持1280*960分辨率成像
   + 红外摄像头最大支持640*480成像
4. 麦克风阵列
   + 一个在左边的[红外发射器](https://www.baidu.com/s?wd=%E7%BA%A2%E5%A4%96%E5%8F%91%E5%B0%84%E5%99%A8&tn=24004469_oem_dg&rsv_dl=gh_pl_sl_csd)下面，
   + 3个在右边景深摄像头下面

{% asset_img kinectsensor.png %}

{% asset_img sensor.png %}

## Kinect in windows

1. 环境的搭建方式。
2. [kinect in windows](https://quronghui.github.io/2019/02/20/Kinect%20in%20Win/#more)

