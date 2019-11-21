---
layout: post
title: BLE
date: 2019-09-05 08:53:36
categories: [driver]
tags: [BLE]
---

# BLE 的GAP 和 GATT协议解析

| 协议    | GAP                                      | GATT                                      |
| ------- | ---------------------------------------- | ----------------------------------------- |
| 作用    | 控制设备连接和广播                       | GAP建立连接之后，发送和接收数据的通用规范 |
| 连接    | 广播建立连接                             | 独占;  client请求建立, server响应         |
| 角色    | 外设S / 中心设备C                        | 外设S / 中心设备C                         |
| 数据    | **不建立连接**，直接广播数据，最大31byte | 建立连接；characteristic来实现通信        |
| 单/双向 | 数据传输**单向**（server --> client）    | 双向（client <-->）                       |
|         |                                          |                                           |

+ 从机端：服务器端；
+ 主机端：客户端；

## BLE 基础知识简介

| 从机--服务端的结构 | 作用                                                        | 位于                 |
| ------------------ | ----------------------------------------------------------- | -------------------- |
| profile            | 一个标准的**通信协议**，每个profile包含多个server           | 从机 -- > 服务端     |
| server             | 可以理解为一个**服务**，包含多个characteristic              | 从机                 |
| characteristic     | 理解为一个**标签**，通过标签读取或者写入想要内容            | **主从机的通信实现** |
| **UUID**           | 统一识别码，service 和 characteristic 都需要一个唯一的 uuid |                      |

1. profile 
   + profile 可以理解为一种规范，一个标准的**通信协议**，它存在于蓝牙**从机**中（**服务端**）；
   + 每个 profile 中会包含**多个 service**，每个 service 代表从机的一种能力
2. server
   + 可以理解为一个服务，在 BLE 从机中有多个服务
   + **每个 service 中又包含多个 characteristic 特征值；**
     + 每个具体的 characteristic 特征值才是 BLE 通信的主题，比如当前的电量是 80%
     + 电量的 characteristic 特征值存在从机的 profile 里，这样主机就可以通过这个 characteristic 来读取 80% 这个数据
3. characteristic
   + BLE **主从机的通信**均是通过 characteristic 来实现，可以理解为一个标签
   + 主机通过：这个标签可以获取或者写入想要的内容。
4. UUID
   + UUID，统一识别码，我们刚才提到的 service 和 characteristic 都需要一个唯一的 uuid 来标识；
   + 16bit的UUID 、 128bit 的uuid
5. 总结
   + 每个**从机(服务端)都会有一个 profile**，不管是自定义的 simpleprofile，还是标准的防丢器 profile，他们都是由一些**service 组成**（代表从机的一种能力）
   + 每个 service 又包含了多个 characteristic
   + **主机和从机之间的通信，均是通过characteristic来实现**

## GATT协议和GAP协议

### GAP 拓扑结构

1. GAP（Generic Access Profile）
   + 作用：**控制设备连接和广播**
   + GAP 使你的设备被其他设备可见，并决定了你的设备是否可以或者怎样与合同设备进行交互；
2. GAP设置角色
   1. **外围设备**（Peripheral - 从机 - 服务端）
      + 低功耗设备，用来**提供数据**，并连接到一个更加相对强大的中心设备
      + 小米手环就等设备就可以与中心设备连接；
   2. **中心设备**（Central - 主机 - 客户端）
      + 中心设备相对比较强大，用来连接其他外围设备
      + 例如手机
3. GAP 广播数据方式
   1. Advertising Data Payload（广播数据）
      + 每种数据最长可以包含 31 byte
      + 这里广播数据是**必需**的，因为外设必需**不停**的向外广播，让中心设备知道它的**存在**；
   2. Scan Response Data Payload（扫描回复）
      + 扫描回复是可选的
      + 中心设备可以向外设请求扫描回复，这里包含一些设备额外的信息:“设备名字”
4. 广播的网络拓扑结构
   + 外设通过**广播自己**来让中心设备发现自己，并建立 GATT 连接，从而进行更多的数据交换；
   + 不需要建立连接：只要外设广播自己的数据即可
   + 因为基于 **GATT 连接**的方式：只能是一个外设连接一个中心设备

### GATT 拓扑结构

1. BLE GATT (Generic Attribute Profile)

   - 作用： **低功耗蓝牙 BLE 的连接**
   - GATT 是一个在蓝牙连接之上：**发送和接收很短的数据段**的通用规范
     - 很短的数据段被称为**属性**（Attribute）

2. GATT 的特点

   + GATT 连接是**独占**的：也就是一个 BLE 外设同时只能被一个中心设备连接；
   + GATT **建立**在GAP协议之上：GAP完成广播和连接建立，GATT完成数据传输；
     + GAP 通信是单向的
     + GATT 通信是双向的
   + GATT **通信**：设备通过 Service 和 Characteristic 进行通信
   + GATT使用ATT协议：ATT 协议把 Service, Characteristic 对应的数据保存在一个**查找表**中，查找表使用 16bit UUID 作为每一项的索引

3. **GATT 通信事务**

   + GATT 通信的双方是 C/S 关系

   1. **外设**作为 GATT **服务端**（Server）
      + 维持了 ATT 的查找表
      + 以及 service 和 characteristic 的定义
   2. **中心设备**是 GATT **客户端**（Client）
      + 所有的通信事件：都是由客户端发起（也叫主设备，Master）
      + 接收服务端（也叫从设备，Slave）的响应
   3. 时间间隔
      + 连接建立后，外设会给中心设备建立一个连接间隔；
      + 中心设备就会在每个连接间隔尝试去重新连接，检查是否有新的数据

4. GATT结构

   + 建立在嵌套的Profiles, Services 和 Characteristics之上的

5. **心率 Profile**（Heart Rate Profile）

   + 结合了 Heart Rate Service 和 Device Information Service

   1. 以 Heart Rate Service
      + 官方通过 16bit UUID 是 0x180D
      +  3 个 Characteristic：Heart Rate Measurement, Body Sensor Location 和 Heart Rate Control Point
      + 数据结构是，开始 8 bit 定义心率数据格式，接下来就是对应格式的实际心率数据

6. [GATT 实现串口的双向通信](https://blog.csdn.net/liwei16611/article/details/80949777)

   