---
layout: post
title: ESP32 Feature
date: 2019-03-30 08:41:25
categories: 
 - [Esp32]
 - [Feature]
tags: esp32
---

# Esp32 Feature

## 基本特性

1. 蓝牙和WiFi的特性

   {% asset_img feature.png %}

2. 分双核和单核DE模组

   + 淘宝上买的板子估计是自己生产的，不是乐鑫的(以后买板子，先查查正品`是哪些，在进行购买)

   + [ESP32-WROOM-32 模组](https://www.espressif.com/zh-hans/products/hardware/modules)
   + **ESP32-WROOM-32D**语音编码、音频流和 MP3 解码

## ESP32 硬件特性

+ [其他绘制也可参考 SCH_PCB的审查规则查看](https://www.espressif.com/zh-hans/company/contact-extra/technical-inquiries-hardware-prologue)

### 电源和地

#### SCH Check

1. 睡眠电流小于 5 μA，适用于电池供电的可穿戴电子设备。
2. 外部供电电源电压及供电电流是否满足需求（500mA 及以上）。
3. 芯片设计唯一接地的管脚在芯片下方，绘制原理图注意是否有添加并连接至地。

#### PCB Check

1. 电源输入接口的 ESD 管是否有靠近端口放置。
2. 电源走线进入芯片之前是否有添加 10uF 去耦电容。情况允许，可搭配 0.1uF 电容一起使用。
3. 芯片底部的 Ground PAD 是否有至少通过 **9 个地孔**(CC2540的就需要)连接到地平面。

### 射频

#### SCH

1. 是否有预留 π 型匹配网络（推荐优先采用 CLC 结构）用于外部天线的阻抗匹配。
2. RF 测试点添加的位置是否合适（建议添加在第一个 π 匹配电路之后）

#### PCB

1. RF 走线线宽是否有突变。是否存在分支走线。是否有采用 135°走线或圆弧走线。RF 走线两侧是否有密集地孔进行屏蔽。RF 走线需尽量短。
2. 芯片到天线的 RF 走线是否有过孔，天线需与芯片在同一层。
3. RF 走线附近不能有高频信号线。RF 上的天线必须远离所有传输高频信号的器件，比如晶振，DDR，一些高频时钟（SDIO_CLK 等）。USB 端口、USB 转串口信号的芯片、UART 信号线（包括走线、过孔、测试点、插针引脚等）都必须尽可能地远离天线。且 UART 信号线做包地处理，周围加地孔屏蔽。

### 复位

1. 复位功能

   {% asset_img Esp32Reset.png %}

### 睡眠和唤醒

​	{% asset_img LowerPower.png %}

+ 通过控制某几个GPIO口的引脚进行控制状态
+ 检测一种状态：BT模式下进行

#### BT模式下进行

​	{% asset_img wake.png %}

+ 为了通过Wi-Fi或BT源唤醒芯片，芯片将在Active、Modem-sleep和Light-sleep之间进行切换，CPU、Wi-Fi、Bluetooth和射频模块均将在预设间隔中唤醒，保证Wi-Fi/蓝牙的正常连接。

  {% asset_img poweruse.png %}

#### Light_sleep

+ [Light_sleep](https://blog.csdn.net/espressif/article/details/79361641)

+ 但是esp_sleep.h 的头文件中唤醒模式没有BT

  {% asset_img espsleep.png %}

## Datasheet

### Pin Mode

1. EN : Module-enable signal. Active high.

2. Software can read the values of these five bits from register ”GPIO_STRAPPING”.

   + MTDI -- > gpio12
   + MTDO --> gpio15

   {% asset_img gpio.png %}

3. GPIO0

   + 首先长按Boot键，同时按 reset键，系统将会进入下载模式，然后 make flash
   + 长按boot键，就是将其拉低。

### Download

1. 通过CP2102  USB to TTL 
   + ESP32 通过串口进行下载
