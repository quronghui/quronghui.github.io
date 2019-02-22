---
layout: post
title: Kinect in Windows
date: 2019-02-20 14:39:36
categories: Kinect
tags: kinect
---

# Kinect in Windows

## 安装 Kinect SDK 

1. Bug
   + 首次安装KinectSDK-v1.8-Setup
   + 连上kinect后，打开一次后，第二次打开提示 “ No kinet to connect ”
   + 重新卸载后，安装KinectSDK-v1.7-Setup，成功
2. 在官方网站下载Kinect for Windows SDK和Developer Toolkit：
   + [KinectSDK-v1.7-Setup.exe](https://www.microsoft.com/en-us/download/details.aspx?id=36996)
   + [KinectDeveloperToolkit-v1.7.0-Setup.exe](<https://www.microsoft.com/en-us/download/details.aspx%3Fid%3D36998>)
   + 安装成功后，连上kinect, 设备管理器出现 “ Kinect for windows ”

## 安装 OpenCV

1. Download [官网下载](http://opencv.org/)最新OpenCV的Windows安装程序

2. 双击运行 .exe

3. 添加环境变量

   ```
   （1）WIN + R 打开 ：cmd
   	setx -mOPENCV_DIR C:\SoftWare\opencv\opencv\build\x64\vc15		
   （2）系统变量修改path
   	%OPENCV_DIR%\bin
   //使用%OPENCV_DIR%变量的好处是万一下次要变动OpenCV（比如安装了两个版本的OpenCV或者改变了路径），只需要修改%OPENCV_DIR%这个变量即可。
   ```

## 安装 Visual Studio

### VS2017

1. Download [Visual Studio Community](https://visualstudio.microsoft.com/free-developer-offers/)免费版

2. 按照需要选择要安装的模块（但是我下载后没有已安装的选项）

3. 报了两个下载错误，因此没有下载成功

4. [尝试教程](https://blog.csdn.net/fengbingchun/article/details/83990685)

   + 选择工作负载这里仅勾选”使用C++的桌面开发”，单个组件和语音包使用默认
   + 还是不能成功

5. Mircosoft 官方给出的解决方案

   + 在注册表上给这个权限
   + Win + R -->  regedit -->  按照下面的代码查找

   + Please check permissions for the key “HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\InternetExplorer\Main\FeatureControl\FEATURE_BLOCK_CROSS_PROTOCOL_FILE_NAVIGATION”, make sure System and Administrators have Full Control to it.

### VS2015 

1. VS2015 选择的是IOS镜像安装；
2. 但是错误更加严重，直接是安装失败

## 配置 Visual Studio的 OpenCV

1. 安装目录：C :\Program Files (x86)\Microsoft Visual Studio\2017\Community

