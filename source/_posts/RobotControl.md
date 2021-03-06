---
layout: post
title: RobotControl
date: 2019-07-26 20:28:31
categories: project
tags: robot
---

#  RobotControl

## 2017.08 中国大学生电子设计竞赛 《板球控制系统》 

1. [论文的技术报告-参赛论文当时没有整理](https://github.com/quronghui/Project/blob/master/BachelorWorks/2017.8月板球控制系统.doc)

2. 项目实现:

   + 为了实现小球在65*65cm的白板上做有**规则**运动; 设计**板球平衡**控制系统, 通过**二值化**处理得到小球位置, 使用PID算法调节小球与给定位置的偏差; 最终实现滚球在规定位置完成指定动作;

   {% asset_img 板球控制系统.png %}

3. PID算法测试

   + 在控制中，P比例、I积分、D微分参数必须调试到合适的值才能有一个优良的控制性能。
   + 我们先只用PD控制来观察小球定点的性能，测试出合适的PD值，
   + 然后使用**I消除**稳态误差，由于I会影响控制系统的稳态性能，所以不能太大或者太小，我们采取一次一次尝试的方法得出合适的I值。

4. 定点测试

   + 将小球放在任意一个非指定地方，启动控制系统。测试多长时间才能停在设定位置。

5. 模式切换测试

   + 有触摸屏测试和按键模式两种模式

## 2016.01中国工程机器人大赛暨国际公开赛 《双足竞步工程》

1. [参赛论文](https://github.com/quronghui/Project/blob/master/BachelorWorks/2016.06窄足机器人robocup技术报告.pdf)

2. 项目的实现: 

   + 制作双足竞步机器人(窄足), 通过上位机对**六路舵机**进行PID控制, 调节机器人行进过程中的**步态**, 并设计最终的步态算法; 最后完成了机器人的**直行和行进间的弯曲**功能, 由于翻跟头时步态旋转过大除了比赛场地, 没有实现最后的功能;
   + PID控制: PWM控制脉冲波形的宽度按正弦规律变化

3. Robot的原型

   + 修改了机械结构, 降低了整体的高度;
   + 将电池分布在两侧, 降低头部的重量;

   {% asset_img 双足竞步.png %}

4. Robot前进功能的实现

   {% asset_img robot前进.png %}

