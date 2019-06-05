---
layout: post
title: SerialCommunication
date: 2019-02-19 14:14:43
categories: Communication
tags: [SerialCommunication, Electronic]
---

# GPIO，I2C，SPI，UART，USART，USB的区别

## GPIO（General Purpose Input Output ）

1. 系统需要采用远端串行通信或控制时，GPIO产品能够提供额外的控制和监视功能。

## SPI (Serial Peripheral Interface)

1. 是一种标准的四线同步双向串行总线。
2. SPI接口主要应用在 EEPROM，FLASH，实时时钟，AD转换器，还有数字信号处理器和数字信号解码器之间。
   + **芯片** -- 间的高效通信
3. 数据线
   + 串行时钟(SCLK)、串行数据输出(SDO)、串行数据输入(SDI)
   + SPI总线：一个Master，多个Slave设备
   + 主从设备间可以实现全双工通信
4. 通用IO口模拟SPI总线
   + 主从设备：必须要有一个输出口(SDO)，一个输入口(SDI)，
   + SCLK则视实现的设备类型而定
5. SPI 通信协议
   + 一个主设备启动一个与从设备的同步通讯的协议，从而完成数据的交换
   + 与普通的串行通讯不同，普通的串行通讯一次连续传送至少8位数据，而SPI允许数据一位一位的传送
   + 至少8次时钟信号的改变（上沿和下沿为一次），就可以完成8位数据的传输
   + 主设备通过对SCK时钟线的控制可以完成对通讯的控制

## I2C (INTER IC BUS)

1. 是一种集成电路间的总线标准，用于连接微控制器及其外围设备
2. 非常适合在器件之间进行近距离、非经常性的数据通信
3. 数据传输
   + 传输数据时都会带上目的设备的设备地址，因此可以实现设备组网。
   + 双向、两线(SCL、SDA)、串行、**多主控**（multi-master）接口标准
4. 通用IO口模拟IIC总线
   + 则需一个输入输出口(SDA)，另外还需一个输出口(SCL)
5. I2C通信协议
   + 接到总线的器件都可以通过唯一的地址和一直存在的简单的主机从机关系软件设定地址主机可以作为主机发送器或主机接收器

## UART(Universal Asynchronous Receiver Transmitter)

1. 通用异步接收/发送装置。
2. **复杂** : 异步串口，因此一般比前两种同步串口的结构要复杂很多，半双工通信
3. 数据线
   + 一般由波特率产生器(产生的波特率等于传输波特率的16倍)、UART接收器、UART发送器组成
4. 通用IO口模拟UART总线
   + 需一个输入口，一个输出口

## **USART**

1. 通用同步异步收发器；

## **USB**：Universal Serial BUS

+ 通用串行总线

## **CAN** 现场总线