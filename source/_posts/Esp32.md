---
layout: post
title: Ubuntu for ESP32
date: 2019-03-12 20:05:09
categories: 
 - [Esp32]
 - [ Ubuntu Vs Code]
tags: Esp32
---

# ESP-IDF  for ESP32

## 前言

1. 通过gcc交叉编译进行开发
2. Esp32，开发类似于ESP8266，乐鑫官方提供相应的开发教程。
3. ESP32的SDK的编程指南，[ESP-IDF编程指南](https://docs.espressif.com/projects/esp-idf/zh_CN/stable/get-started/)

## 开发环境搭建

+ [在Ubuntu下搭建ESP32开发环境](https://blog.csdn.net/weixin_37127273/article/details/84790079)

### 编译依赖工具

1. ESP32 的编译开发主要依赖两大核心工具，一个是乐鑫官方提供的ESP32交叉编译工具链，另外一个是python2.7。

## 配置工程，开始编译

1. 有一个Bug，每次都要重新指定，ESPIDF的实际路径

   ```
   export IDF_PATH=/home/quronghui/HustFiles/Esp32/sources/esp-idf
   ```

# Arduino IDE for ESP32

## 环境搭建

+ [**arduino-esp32**  ](https://github.com/espressif/arduino-esp32/blob/master/docs/arduino-ide/debian_ubuntu.md)

1. 主要是在Arduino IDE 中加载 Esp32 的core;

# PlatformIO for ESP32

## 环境搭建

1. VS Code 中加载组件platform。
2. [在Ubuntu下搭建ESP32开发环境](https://blog.csdn.net/weixin_37127273/article/details/84790079)
   + 需要搭建以下ubunut下的python2环境
   + 先配置一下，使用platform时便能直接使用

## Platform 开发

+ 使用ESP-IDF进行开发

  {% asset_img platform.ong %}

+ 例子的参考 [[espressif](https://github.com/espressif)/**esp-idf**  ]()

# 开发平台比较

+ 在Ubuntu下进行开发
+ 

| 类别     | ESP-IDF  for ESP32         | Arduino IDE for ESP32 | PlatformIO for ESP32 |
| -------- | -------------------------- | --------------------- | -------------------- |
| 环境搭建 | 有明确的文档               | github有说明          | 直接加载平台就行     |
| 编译     | 编写makefile，指定IDF_PATH | 平台操作              | 平台操作             |
| 下载     | 命令行                     | 平台操作              | 平台操作             |
| 开发难度 | 目前来说有点难（make指令） | 加载库                | 加载库               |
| 开发界面 | vs code                    | 不友好                | vs code              |
| 选择     |                            |                       | platformio           |

