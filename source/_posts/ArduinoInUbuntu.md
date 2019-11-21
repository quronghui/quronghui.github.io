---
layout: post
title: Ubuntu for Arduino  
date: 2019-03-12 17:16:26
categories: 
 - [Arduino]
 - [PlatformIO]
tags: arduino
---

# Ubuntu for Arduino  

+ 将嵌入式设备的开发从Windows，迁移到了Linux下
+ Ubuntu + Vs Code + PlatfromIO 

## Port Permission denied

1. 问题：下载程序到arduino时，端口权限报错。

   ```
   Auto-detected: /dev/ttyACM0
   *** [upload] could not open port /dev/ttyACM0: [Errno 13] Permission denied: '/dev/ttyACM0'
   ```

2. 重启后权限消失

   ```
   给端口权限
   sudo chmod 666 /dev/ttyACM0  
   ```

3. 永久权限

   ```
   sudo gedit /etc/udev/rules.d/70-ttyacm.rules		// 添加权限文件
   KERNEL=="ttyACM[0-9]*",MODE="0666" 					// 添加权限文件
   ```

## 串口显示问题

1. 问题：串口一直不能输出

   ```
   Serial.begin(9600);		// 需要在step中设置波特率
   ```

2. 解决：代码错误

   ```
   Serial.print("hello\n");						// 不是 printf("")
   ```

   