---
layout: post
title: Kinect SDK for Windows
date: 2019-02-26 16:21:04
categories: 
 - [Kinect SDK]
 - [Kinect]
 - [c++]
tags: kinect
---

# Kinect SDK for Windows

+ [网上的知识点](https://blog.csdn.net/cz19800823)
+ 通过安装的SDK包，看相应的代码

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

### Kinect 设备的发现和引用

1. 通过SDK探测有无Kinect连接

   ```
   （1）KinectSeneor对象有一个静态的属性KinectSensors
   （2）该属性是一个KinectSensorCollection集合，该集合继承自ReadOnlyCollection
   （3）ReadOnlyCollection集合很简单，他只有一个索引器和一个称之为StatusChanged的事件
   ```

2. Kinect 的初始化

   ```
   When : Connect --- 才进行赋值操作 
   	   not connect  --- KinectSensor对象抛出InvalidOperationException异常
   ```

3. Load and Unload 事件

   ```
   （1）窗口的Loaded事件中程序通过DiscoverKinectSensor方法试图调用一个连接了的传感器
   （2）窗体的Loaded和Unloaded事件中注册这两个事件用来初始化和释放Kinect对象
   note :
   	 DiscoverKinectSensor方法只有两行代码，第一行代码注册StatusChanged事件，第二行代码通过lambda表达式查询集合中第一个处在Connected状态的传感器对象，并将该对象复制给Kinect属性。Kinect属性的set方法确保能都赋值一个合法的Kinect对象。
   ```

4. StatusChanged事件: 

   + 当状态为KinectSensor.Connected的时候，if 语句限制了应用程序只能有一个kinect传感器，他忽略了电脑中可能连接的其他Kinect传感器。

5. **以上代码展示了用于发现和引用Kinect设备的最精简的代码。**

### Kinect Sensor 的打开和关闭

1. Connect 初始化传感器

   + Enable  数据流 ：Color,Depth,Skeleton

   + 数据流使用：使用Kinect对象的一些列事件

     ```
     ColorImageStream  ----  ColorFrameReady 事件
     DepthImageStream  ----  DepthFrameReady事件
     SkeletonStream    ----  SkeletonFrameReady事件
     	AllFramesReady 事件在任何一个数据流状态enabled时就能使用
     ```

   + 应用程序调用KinectSensor对象的Start方法

     + frame-ready事件就会触发从而产生数据

2. Stop Kinect

   + 先检测Kinect sensor 是否为空；然后监听frameready事件

     ```
     Using KinectSensor对象的 : Stop ways 
     ```

   + 应用程序在不需要使用KinectSensor对象时，释放这些资源

     ```
     Stop ways 
     注销frameready事件
     ```

   + Notes

     + (1)不要去调用KinectSensor对象的Dispose方法。这将会阻止应用程序再次获取传感器。
     + (2)应用程序必须从启或者将Kinect从新拔出然后插入才能再次获得并使用对象