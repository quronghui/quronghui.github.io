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

3. 从KinectSensor获取数据：通过监听该对象的一[**系列**](http://www.hqew.com/tech/led/200010410003/27268.html)事件。

   + 每一个数据流以帧(frame)为单位。
   + 每一种数据流都有对应的事件，当改类型数据流可用时，就会触发改时间。
   + ColorImageStream：触发ColorFrameReady事件

4. KinectSensor数据流形式

   + 每一种数据流(Color,Depth,Skeleton)都是以数据点的方式，在不同的坐标系中显示的

   + inectSensor对象有一些列的方法能够进行数据流到数据点阵的转换

     ```
     MapDepthToColorImagePoint；
     MapDepthToSkeletonPoint；
     MapSkeletonPointToDepth
     ```

5. Kinect 设备连接检测

   + 通过SDK探测有无Kinect连接

   + ```
     （1）KinectSeneor对象有一个静态的属性KinectSensors
     （2）该属性是一个KinectSensorCollection集合，该集合继承自ReadOnlyCollection
     （3）ReadOnlyCollection集合很简单，他只有一个索引器和一个称之为StatusChanged的事件
     ```

     