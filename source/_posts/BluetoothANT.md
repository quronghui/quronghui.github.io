---
layout: post
title: BluetoothANT
date: 2019-02-28 16:14:16
categories: Bluetooth ANT
tags: ANT
---

# Bluetooth ANT

+ 蓝牙天线的设计使用，需要注意的一些事情。

## 无线传感技术

1. 蓝牙技术：要求通讯灵敏度，还需要小型化，更需要低功耗，更重要的是要低成本。
2. 硬件天线设计：IPEX接口外接天线和PCB板载天线。

## 天线

1. 天线是一种用来发射或者接收电磁波的元器件，本质上可以说是一个能量转换器。
2. 发射天线：将发射机的高频电流能量，有效地转换成空间的电磁能量；
3. 接收天线：将空间中的电磁能量，转化为电流能量。

## IPEX接口天线

​		{% asset_img IPEX.png %}

1. 信号的方向指向性好，效率高，抗干扰能力强;
2. 能远离主板上的干扰
3. 不用过多的进行调试匹配

## PCB板载天线

{% asset_img board.png %}

1. PCB天线容易受到主板上的干扰，效率相对较低，牺牲性能。
2. 因为近距离数据传输本身就比较稳定，所以蓝牙模块上的天线其实在近处时的效果是差不多的。但是距离远了，外置天线会有明显的优势。

### **倒F型天线**

1. 特点

   + 状或者片状，当使用介电常数较高的绝缘材料时还可以缩小蓝牙天线尺寸
   + 天线一般放置在PCB顶层，铺地一般放在顶层并位于天线附近，但天线周围务必不能放置地，周围应是净空区。

2. 具体尺寸

   {% asset_img FAntenna.png %}

### **曲流型天线设计**

1. 曲流型天线的长度比较难确定。长度一般比四分之一波长稍长，其长度由其几何拓扑空间及敷地区决定。

2. 天线一般放置在PCB顶层，铺地一般放在顶层并位于天线附近，但天线周围务必不能放置地，周围应是净空区。

   {% asset_img curve.png %}

3. 具体尺寸

   {% asset_img curve1.png %}

### **陶瓷天线设计**

1. 陶瓷天线是另外一种适合于蓝牙装置使用的小型化天线。

2. 陶瓷本身介电常数较PCB电路板高，所以使用陶瓷天线能有效缩小天线尺寸，在介电损耗方面，陶瓷介质也比PCB电路板的介电损失小，所以非常适合低耗电率的的蓝牙模块中使用。

3. 在 PCB设计时，天线周围要净空就可以了，特别注意不能敷铜。

   {% asset_img ceramic.png %}

### **2.4G棒状天线设计**

1. 2.4G棒状蓝牙天线体积大，但传输距离要强于其他天线。在PCB设计时，天线周围也和上述的三种天线设计一样要净空。

   {% asset_img 2.4G.png %}

## 蓝牙天线设计

1. 天线的信号（频率大于400MHz以上）容易受到衰减，因此天线与附近的地的距离至少要大于三倍的线宽。
2.  1GHz=1000MHz 1MHz=1000kHz 1kHz=1000Hz
3. 过孔会产生寄生电感，高频信号对此会产生非常大的衰减，所以走射频线的时候尽量不要有过孔。

## PCB 布线问题

### ANT 和 GND 相连

1. 出现一种现象：RF射频线和GND相连报错。
2. 因为这是RF信号，也就是微波。微波就不能当一般的数字，模拟信号来对待了。虽然用万用表量，这个天线与地是短路的。而对微波，其实这整个天线铜皮其实是相当于包括了很多电阻，电容，电感等组成的等效电路。

   ·{% asset_img AntGnd.png %}

### ANT 天线没有盖油

1. 如何查看是否盖油

   + Altium Design -- >  只显示 Top Sloder /  Bottom Sloder

     {% asset_img ANT.png %}

   + 原因：CC2540 的元件，绘制的时候加了 top sloder 层，导致PCB生成Gerber文件的时候默认为开窗

     {% asset_img topsloder.png %}

2. 如何解决：

   + 找到对应天线的元件库，删除top sloder绘制的Track
   + 