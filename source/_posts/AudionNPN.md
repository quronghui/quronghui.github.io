---
layout: post
title: Audion NPN
date: 2019-04-08 17:52:21
categories:
- [NPN]
- [PNP]
tags: -[Audion ]
---

# 三极管的详解

+ [Reference](<http://www.sohu.com/a/127959186_468626>)

## 特性

1. 核心是“PN”结；

   + 电流的流向是PN时，才是正向偏执

   {% asset_img NPN.png %}

2. 发射区：发射的是电子

   + 溶度高的话，利于渗透
   + 集电结面积大：集电区与发射区为同一性质的掺杂半导体，但集电区的掺杂浓度要低，面积要大，便于收集电子。
   + 发射区高掺杂：为了便于发射结发射电子，发射区半导体掺浓度高于基区的掺杂浓度，且发射结的面积较小;
   + 三极管不是两个PN结的间单拼凑，两个二极管是组成不了一个三极管的！

   {% asset_img emitter %}

## 电流控制原理

1. 电流里面的是正离子，电子往相反方向流。

   {% asset_img circuit.png %}

2. 外加电压使发射结正向偏置，集电结反向偏置。

   {% asset_img forward.png %}

   + 集/基/射电流关系：

     IE = IB + IC

     IC = β * IB

     如果 IB = 0, 那么 IE = IC = 0

## 电压控制原理

1. 集-射极电压UCE为某特定值时，基极电流IB与基-射电压UBE的关系曲线。

   {% asset_img voltage.png %}

   + UBE<UBER时，三极管高绝缘，UBE>UBER时，三极管才会启动；
   + UCE增大，特性曲线右移，但当UCE>1.0V后，特性曲线几乎不再移动。

2. 输出特性

   + 基极电流IB一定时，集极IC与集-射电压UCE之间的关系曲线，是一组曲线。

     {% asset_img output.png %}

   + 当IB=0时, IC→0 ,称为三极管处于截止状态，相当于开关断开;

   + 当IB>0时, IB轻微的变化,会在上以几十甚至百多倍放大表现出来;

   + 当IB很大时，IC变得很大，不能继续随IB的增大而增大，三极管失去放大功能，表现为开关导通。

## 三极管核心功能

1. 放大功能：小电流微量变化，在大电流上放大表现出来。
2. 开关功能：以小电流控制大电流的通断。

## NPN and PNP

### 区别

1. NPN 是用 B→E 的电流（IB）控制 C→E 的电流（IC），E极电位最低，且正常放大时通常C极电位最高，即 VC > VB > VE
2. PNP 是用 E→B 的电流（IB）控制 E→C 的电流（IC），E极电位最高，且正常放大时通常C极电位最低，即 VC < VB < VE

### 电路接法

1. NPN的接法

   {% asset_img npnconnect.png %}

2. PNP的接法

   {% asset_img pnpcollect.png %}