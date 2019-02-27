---
layout: post
title: Kinect SDK for ColorImageStream
date: 2019-02-26 16:21:04
categories: 
 - [Kinect SDK]
 - [Kinect]
 - [c++]
tags: kinect
---

# Kinect SDK for ColorImageStream

+ [网上的知识点](https://blog.csdn.net/cz19800823)
+ 通过安装的SDK包，看相应的代码
+ 下面介绍如何**发现以及初始化**Kinect[**传感器**](http://www.hqew.com/tech/cgq/200010150017/17350.html)，从Kinect的影像摄像头**获取图片**。

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

## ColorImageStream 的获取

1. 初始化和释放KinectSensor和ColorImageStream对象

   ```
   if (value!=null&&value.Status==KinectStatus.Connected)
   {
   	this.kinect=value;
       InitializeKinectSensor(this.kinect);
   }
   ```

2. InitializeKinectSensor对象 ：调用ColorImageStream的Enable方法，注册ColorFrameReady事件并调用start方法。

   + 一旦打开了传感器，当新数据帧大道是就会触发frameready事件，该事件触发频率是每秒30次。

   ```
    if (kinectSensor != null)
       {
           kinectSensor.ColorStream.Enable();
           kinectSensor.ColorFrameReady += new EventHandler<ColorImageFrameReadyEventArgs>				(kinectSensor_ColorFrameReady);
           kinectSensor.Start();
       }
   ```

3. 数据显示

   1. ）ColorFrameReady方法中：打开或者获取一个frame来提取获Frame数据。
   2. ）ColorImageFrameReadyEventArgs对象中的OpenColorImageFrame属性：返回一个当前的ColorImageFrame对象。
   3. ）ColorImageFrame对象：提取像素数据之前需要使用一个Byte数组保存获取到的数据。
   4. ）FrameObject对象的PixelDataLength对象返回数据和序列的具体大小。
   5. ）调用CopyPixelDataTo方法可以填充像素数据，然后将数据展示到image控件上。

## 图像数据获取方式的改进

+ [知识参考](https://blog.csdn.net/cz19800823/article/details/11639625)

### WriteableBitmap对象

1. 它位于System.Windows.Media.Imaging命名空间下面，该对象被用来处理需要频繁更新的像素数据。（之前是更新30幅图像 / 每秒）
2. 创建WriteableBitmap时，应用程序需要指定它的高度，宽度以及格式，以使得能够一次性为WriteableBitmap创建好内存，以后只需根据需要更新像素即可。

### 图像的处理

1. 每一帧ColorImageFrame都是以字节序列的方式返回原始的像素数据：对这些原始数据进行一定的处理，然后再展示出来。
2. for循环遍历每个像素，由于数据的格式是Bgr32，即RGB32位(一个像素共占4个字节，每个字节8位)，所以第一个字节是蓝色通道，第二个是绿色，第三个是红色。
3. 循环体类，将第一个和第二个通道设置为0.所以输出的代码中只用红色通道的信息。这是最基本的图像处理。

### 截图

1. 可能需要从彩色摄像头中截取一幅图像，例如可能要从摄像头中获取图像来设置人物头像。为了实现这一功能，首先需要在界面上设置一个按钮。

## 图片数据格式介绍

1. ImageStream是ColorImageStream的基类。因此ColorImageStream集成了4个描述每一帧每一个像素数据的属性。在之前的代码中，我们使用这些属性创建了一个WriteableBitmap对象。这些属性与ColorImageFormat的设置有关。
2. ImageStream中除了这些属性外还有一个IsEnabled属性和Disable方法。IsEnabled属性是一个只读的。当Stream打开时返回true，当调用了Disabled方法后就返回false了。Disable方法关闭Stream流，之后数据帧的产生就会停止，ColorFrameReady事件的触发也会停止。
3. 当ColorImageStream设置为可用状态后，就能产生ColorImageFrame对象。ColorImageFrame对象很简单。他有一个Format方法，他是父类的ColorImageFormat值。他只有一个CopyPixelDataTo方法，能够将图像的像素数据拷贝到指定的byte数组中，只读的PixelDataLength属性定义了数组的大小PixelDataLength属性通过对象的宽度，高度以及每像素多少位属性来获得的。这些属性都继承自ImageFrame抽象类。
4. 数据流的格式决定了像素的格式，如果数据流是以ColorImageFormat.RgbResolution640*480[**Fps**](http://www.hqew.com/tech/qtdz/200010160031/1305015.html)30格式初始化的，那么像素的格式就是Bgr32，它表示每一个像素占32位(4个字节)，第一个字节表示蓝色通道值，第二个表示绿色，第三个表示红色。第四个待用。当像素的格式是Bgra32时，第四个字节表示像素的[**alpha**](http://www.hqew.com/tech/gdz/200010250015/90000.html)或者透明度值。如果一个图像的大小是640*480，那么对于的字节数组有122880个字节(width*height*BytesPerPixel=640*480*4).在处理影像时有时候也会用到Stride这一术语，他表示影像中一行的像素所占的字节数，可以通过图像的宽度乘以每一个像素所占字节数得到。

## ImageStream 数据获取的方式

### 事件模式

1. 目前为止我们都是使用KinectSensor对象的事件来获取数据的。事件在WPF（为不同用户界面提供统一的显示系统（ Windows Presentation Foundation））中应用很广泛，在数据或者状态发生变化时，事件机制能够通知应用程序。

### "拉"模式

1. 采用拉模式获取数据的性能应该好于事件模式。
2. 唯一不能使用事件模型获取数据的情况是在编写非WPF平台的应用程序的时候。比如，当编写XNA或者其他的采用拉模式架构的应用程序。建议在编写基于WPF平台的Kinect应用程序时采用事件模式来获取数据。只有在极端注重性能的情况下才考虑使用“拉”的方式。