---
layout: post
title: Kinect SDK for Windows
date: 2019-02-26 16:21:04
categories: 
 - [Kinect SDK]
 - [Kinect]
tags: kinect
---

# Kinect SDK for Windows

+ [知识点](https://blog.csdn.net/cz19800823)

## Kinect Sensor

1. 基于Kinect开发的应用程序最开始需要用到的对象就是KinectSensor对象，该对象直接表示Kinect硬件设备。

2. KinectSensor对象是我们想要获取数据。包括ColorImageStream，DepthlmageStream和SkeletonStream。

3.  从KinectSensor获取数据：通过监听该对象的一[**系列**](http://www.hqew.com/tech/led/200010410003/27268.html)事件。

   + 每一个数据流以帧(frame)为单位。
   + 每一种数据流都有对应的事件，当改类型数据流可用时，就会触发改时间。

   + ColorImageStream：触发ColorFrameReady事件