---
layout: post
title: Kinect Sdk SkeletonStream
date: 2019-03-01 13:58:40
categories: 
 - [Kinect SDK]
 - [Kinect]
 - [c++]
tags: kinect
---

# Kinect Sdk SkeletonStream

- [网上的知识点](https://blog.csdn.net/cz19800823)
- 骨骼追踪技术通过处理景深数据来建立人体各个关节的坐标,骨骼追踪能够确定人体的各个部分。
- 骨骼追踪产生X,Y,Z的三维数据，从而确定这些骨骼点的坐标。

## Gain Skeleton Data

1. 骨骼数据来自：SkeletonStream

   + KinectSensor对象有一个名为SkeletonFrameReady事件。
   + 当SkeletonStream中有新的骨骼数据产生时就会触发该事件。
   + SkeletonStream产生的每一帧数据Frame，都是一个骨骼对象集合。

2. Kinect SDK在SkeletonStream对象

   + Kinect能够追踪到的骨骼数量是一个常量。
   + 定义了一个能够追踪到的骨骼个数常量FrameSkeletonArrayLength，使用这个常量可以方便的对数组进行初始化。

3. SkeletonFrameReady事件的响应方法

   + 每一次事件被激发时，通过调用事件参数的OpenSkeletonFrame方法就能够获取当前的骨骼数据帧。
   + 剩余的代码遍历骨骼数据帧的Skeleton数组frameSkeletons，在UI界面通过关节点将骨骼连接起来，用一条直线代表一根骨骼。

4. 骨骼数据的检测

   + 使用Skeleton对象的 TrackingState 属性来判断，只有骨骼追踪引擎追踪到的骨骼我们才进行绘制。
   + Kinect能够探测到6个游戏者，但是同时只能够追踪到2个游戏者的骨骼关节位置信息。、、

5. 绘制骨骼直线

   + CreateFigure方法为每一根骨骼绘制一条直线。
   + GetJointPoint方法以关节点的三维坐标作为参数，然后调用 KinectSensor 对象的MapSkeletonPointToDepth 方法将骨骼坐标转换到 深度影像坐标上去。
   + 骨骼坐标系和深度坐标及彩色影像坐标系不一样，甚至和UI界面上的坐标系不一样。

6. 三维数据处理

   + 骨骼关节点的三维坐标中我们舍弃了Z值，只用了X,Y值。
   + 可以发现图像的大小是和Z值(深度)成反的。深度值越小，图像越大，即人物离Kinect越近，骨骼数据越大。

   {% asset_img skeleton.png %}

## Skeleton 对象模型

1. 对象模型有四个最主要的对象，他们是SkeletonStream，SkeletonFrame，Skeleton和Joint。

   {% asset_img mode.jpg %}

### SkeletonStream对象

1. Enable SkeletonStream对象，才能产生数据SkeletonFrame。
2. 骨骼数据处理是很耗费计算性能的操作。打开骨骼追踪是可以观察的到[**CPU**](http://www.hqew.com/tech/detail/CPU.html)的占用率明显增加。当不需要骨骼数据时，关闭骨骼追踪很有必要。

#### 骨骼关节点帧与帧之间的位置差异。

1. Enable SkeletonStream对象时，调用重载的方法传入一个TransformSmoothParameters参数。
2. SkeletonStream对象有两个与平滑有关只读属性：IsSmoothingEnabled和SmoothParameters。
3. SmoothParameters属性用来存储定义平滑参数。

#### 骨骼追踪对象选择

1. 默认情况下，骨骼追踪引擎会对视野内的所有活动的游戏者进行追踪。但只会选择两个可能的游戏者产生骨骼数据。
2. 如果要自己选择追踪对象，需要使用AppChoosesSkeletons属性和ChooseSkeletons方法。
3. 要手动选择追踪者，需要将AppChoosesSkeleton设置为true，并调用ChooseSkeletons方法，传入TrackingIDs已表明需要追踪那个对象。

### SkeletonFrame

1. SkeletonStream产生SkeletonFrame对象,使用事件模型从事件参数中调用OpenSkeletonFrame方法来获取SkeletonFrame对象.
2. 调用SkeletonFrame 对象的 CopySkeletonDataTo方法将其保存的数据拷贝到骨骼对象数组.
3. SkeletonFrame对象有一个SkeletonArrayLength的属性，这个属性表示追踪到的骨骼信息的个数。

#### 时间标记字段

+  SkeletonFrame的FrameNumber和Timestamp字段表示当前记录中的帧序列信息。
+ FrameNumber和Timestamp这两个字段在分析处理帧序列数据时很重要

1. FrameNumber 是景深数据帧中的用来产生骨骼数据帧的帧编号。帧编号通常是不连续的，但是之后的帧编号一定比之前的要大。
   + FrameNumber是一个32位的整型
2. Timestap字段记录字Kinect传感器初始化以来经过的累计毫秒时间。
   + imestamp是64位整型
3. 在未来SDK中加入手势引擎之前，我们需要自己编写算法来对帧时间序列进行处理来识别手势，这样就会大量依赖这两个字段。

#### Frame 描述信息

1.  FloorClipPlane字段是一个有四个元素的元组Tuple<int,int,int,int>，每一个都是Ax+By+Cz+D=0地面平面(floor plane)表达式里面的系数项。
2. D 通常为负数，是Kinect距离地面高度。

### Skeleton

1. Skeleton类定义了一[**系列**](http://www.hqew.com/tech/led/200010410003/27268.html)字段来描述骨骼信息，包括描述骨骼的位置以及骨骼中关节可能的位置信息。
2. 骨骼数据可以通过调用SkeletonFrame对象的CopySkeletonDataTo方法获得Skeleton数组。

#### TrackingID

1. 骨骼追踪引擎对于每一个追踪到的游戏者的骨骼信息都有一个唯一编号。
2. 应用程序使用TrackingID来指定需要骨骼追踪引擎追踪那个游戏者。
3. 这个值是整型，他会随着新的追踪到的游戏者的产生添加增长。(不连续的)
4. Kinect追踪到了一个新的游戏者，他会为其分配一个新的唯一编号。
5. 编号值为0表示这个骨骼信息不是游戏者的，他在集合中仅仅是一个占位符。
6. 调用SkeletonStream对象的ChooseSkeleton能以初始化对指定游戏者的追踪。

#### TrackingState

+ 该字段表示当前的骨骼数据的状态。
+ {% asset_img trackstate.png %}

#### Position

1. Position一个SkeletonPoint类型的字段，代表所有骨骼的中间点。
2. 该字段提供了一个最快且最简单的所有视野范围内的游戏者位置的信息，而不管其是否在追踪状态中。
3. 例如，应用程序可能需要追踪距离Kinect最近的且处于追踪状态的游戏者，那么该字段就可以用来过滤掉其他的游戏者。

#### ClippedEdges

1. ClippedEdges字段用来描述追踪者的身体哪部分位于Kinect的视野范围外，提供了一个追踪这的位置信息。

2. 该字段类型为FrameEdges，他是一个枚举并且有一个FlagsAtrribute自定义属性修饰。

3. FrameEdges 值

   {% asset_img frameedge.png %}

4. Kinect底座上面有一个小的马达能够调整Kinect的俯仰角度。

   + 俯仰角度可以通过更改KinectSensor对象的ElevationAnagle属性来进行调整。
   + 如果应用程序对于游戏者脚部动作比较关注，那么通过程序调整Kinect的俯仰角能够决绝脚部超出视场下界的情况。

5. KinectSensor的MaxElevationAngle和MinElevationAngle确定了可以调整角度的上下界。

   + 任何将ElevationAngle设置超出上下界的操作将会掏出ArgumentOutOfRangeExcepthion异常。
   + 微软建议不要过于频繁重复的调整俯仰角以免损坏马达。

### Joints

1. 该字段是一个JointsCollection类型，它存储了一些列的Joint结构来描述骨骼中可追踪的关节点(如head,hands,elbow等等)

2. 应用程序使用JointsCollection索引获取特定的关节点，并通过节点的JointType枚举来过滤指定的关节点。

   {% asset_img joint.png %}

3. 骨骼追踪引擎能够跟踪和获取每个用户的近20个点或者关节点信息。

4. 关节点

   + 都有类型为SkeletonPoint的Position属性，
   + 他通过X,Y,Z三个值来描述关节点的控件位置。
   + X,Y值是相对于骨骼平面空间的位置，他和深度影像，彩色影像的空间坐标系不一样。

5. 最后每一个Skeleton对象还有一个JointTrackingState属性

   {% asset_img jointtrackingstate.png %}

