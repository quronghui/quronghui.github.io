---
layout: post
title: Kinect in Ubuntu
date: 2019-02-20 14:39:36
categories: Kinect
tags: kinect
---

# OpenKinect Application for Ubuntu

## OpenKinect on linux 环境搭建

+ [[OpenKinect](https://github.com/OpenKinect)/**libfreenect**](https://github.com/OpenKinect/libfreenect.git)

### libusb的安装

1. Download [libusb](http://libusb.info/) >= 1.0.18

2. [安装过程](https://blog.csdn.net/gd6321374/article/details/79903132)

3. ./configure执行报错时

   ```
    ./configure --build=x86_64-linux --disable-udev
   ```

4. sudo make install

5. Use

   + 提示安装好了lib，目录所在。

   ```
   make[1]: 离开目录“/home/quronghui/Kinect/libusb-1.0.22”
   ```

   + 所以我们基于libusb编程的时候，需要包含这个库 */  编译时加上  --lusb-1.0 就是这个原因，库放在这个目录下，需要链接上。

### CMake安装方法

1. Download : Source Distribution 或者 Binary Distribution，前者是源代码版，你需要自己编译成可执行软件。后者是已经编译好的可执行版，直接可以拿来用的。
2. [安装教程](https://blog.csdn.net/qq_24011271/article/details/82498381)

### Python3 安装方法

1. [参考教程](https://blog.csdn.net/zhangdongren/article/details/82685932)
2. 下载Python3 时候特别的慢，一直在等。

### Libfreenect 安装

1. 编译

   ```
   git clone https://github.com/OpenKinect/libfreenect
   cd libfreenect
   mkdir build
   cd build			// 在这之后的操作需要插入设备
   					// 尽量带sudo ,不然会少安装一些东西
   sudo cmake -L .. # -L lists all the project options
   sudo make
   ```

2. 更新依赖库

   ```
   sudo apt-get install git cmake build-essential libusb-1.0-0-dev
   sudo apt-get install freeglut3-dev libxmu-dev libxi-dev
   ```

3. 测试设备

   ```
   cd build/bin
   sudo ./freenect-glview 
   ```

   

## QTGUI for linux



# Kinect for Windows

## Kinect SDK 安装

1. Bug
   + 首次安装KinectSDK-v1.8-Setup



