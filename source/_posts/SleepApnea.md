---
layout: post
title: SleepApnea
date: 2019-07-24 21:20:02
categories: [project]
tags: [SleepApnea]
---

# 睡眠呼吸暂停检测方式

## 睡眠检测方式论文

- [ProQuest数据库论文搜索](https://search.proquest.com/healthcomplete/results/B906602FD62C4F5DPQ/1?accountid=11524)

### CNKI关键词:睡眠检测

1. [Abnormal respiratory event detection in sleep: A prescreening system with smart wearables](https://www.sciencedirect.com/science/article/pii/S1532046419301376)
2. [A motion-based waveform for the detection of breathing difficulties during sleep](https://link.springer.com/article/10.1007%2Fs00138-018-0980-5)
3. [Ambulatory detection of sleep apnea using a non-contact biomotion sensor.](https://onlinelibrary.wiley.com/doi/full/10.1111/jsr.12889)
4. [Patent Application Titled "Detection Of Sleep Apnea Using Respiratory Signals"](https://search.proquest.com/healthcomplete/results/B906602FD62C4F5DPQ/1?accountid=11524)

### 关键字: sleep apnea

## [关键词: 睡眠呼吸暂停 检测系统]

1. 睡眠呼吸暂停综合征(sleep apnea syndrome)是什么?
   - 指人体在夜 间 睡 眠 时,口 腔 或 者 鼻 腔 发 生 了 气 流 停止的症状,并且症状持续时间在 10 s 以上,次数超过30 次 
   - 这类呼吸暂停情况切断对身体的氧气供应，时间长达几秒，从而停止对二氧化碳的清除。因此，大脑短时将人唤醒，重新开启呼吸道，并重新启动呼吸。这可能在夜间发生多次，无法适当睡眠。人们在白天可能会出现过度嗜睡，注意力难以集中或头痛。**夜间打鼾**是最常见特征。
2. 医学上: 睡眠呼吸暂停综合症诊断的标准
   - 多导睡眠图 PSG
   - 可以记录睡眠中的脑电图、 心电图、 口鼻气流、 血氧饱和度、 鼾声、 体位、 胸腹等多项生命指征。

### 2019 硕士: 多信息交互的睡眠呼吸暂停综合症无扰检测系统_董雪虎 

1. **设计模型**--多传感器融合

   + 判断出:每小时呼吸均暂停次数, 每次暂停的时间长;

   | 检测指标     | 方法                                                         | 得到什么                                                     |
   | ------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
   | **鼾声检测** | 六麦克风阵列([录音模块代替](https://detail.tmall.com/item.htm?id=42065445482&ali_refid=a3_430583_1006:1109983619:N:NpAPFrS6TLaktaVO79dIvA==:19d4f0f40651bfb794439f604d69b9a4&ali_trackid=1_19d4f0f40651bfb794439f604d69b9a4&spm=a230r.1.14.1)) | 鼾声的分贝值<br />患者无论是正常呼吸,还是呼吸暂停时<br />鼾声共振峰分布,都不太稳定。 |
   | 心率和呼吸率 | 基于光强度的高精度微弯型光纤传感器                           | 光强度曲线值(类似于我们的检测仪)                             |
   | **人体睡姿** | 柔性触觉传感器(压力阵列) 40*40 cm^2                          | 人体六种睡姿判断(通过图像一些滤波处理)                       |

2. [参考模型](https://kns.cnki.net/KCMS/detail/detail.aspx?dbcode=CJFQ&dbname=CJFDLAST2019&filename=ZDYB201903016&v=MzEyODdTN0RoMVQzcVRyV00xRnJDVVJMT2ZZT1JxRnlEZ1Y3N01QeW5TYkxHNEg5ak1ySTlFWW9SOGVYMUx1eFk=)

   

### 2019 硕士[基于微波非接触式呼吸检测及分析系统设计和研究](http://kreader.cnki.net/Kreader/CatalogViewPage.aspx?dbCode=cdmd&filename=1019107830.nh&tablename=CMFDTEMP&compose=&first=1&uid=WEEvREdxOWJmbC9oM1NjYkZCbDdrdXJMdHBCUEI4TWtvekE1UDBzdUZibXE=$R1yZ0H6jyaa0en3RxVUd8df-oHi7XMMDo7mtKT6mSmEvTuk11l2gFA!!)

1. 呼吸病理学原理: 四种异常的呼吸

2. 非接触式呼吸检测方式

   {% asset_img 非接触式.png %}

3. 检测方法: 三路的微波雷达通道睡眠呼吸暂停检测系统;

   + 通过三个方向的雷达进行探测:	得到在不同睡姿情况下的 -- 呼吸的频率和幅度值; 

   

   | 检测指标     | 方法                                                         | 得到什么                                     |
   | ------------ | ------------------------------------------------------------ | -------------------------------------------- |
   | 检测呼吸信号 | 三路的微波雷达通道                                           | 三个方向进行呼吸的检测; 得到呼吸和睡姿的信息 |
   |              | YH-600B睡眠呼吸初筛仪                                        | 医学上正在使用, 用于数据对比                 |
   |              | [24G CDM324-MOD](https://item.taobao.com/item.htm?spm=a1z0d.6639537.1997196601.4.5e447484Lsi8mT&id=592383047704) |                                              |

### [2017 硕士 基于24GHz雷达的SAHS检测系统研究与实现](https://kns.cnki.net/KCMS/detail/detail.aspx?dbcode=CMFD&dbname=CMFD201902&filename=1019830828.nh&uid=WEEvREdxOWJmbC9oM1NjYkZCbDdrdXJLb2F0TUwxOGFxOGxwSUFGQWsxV0k=$R1yZ0H6jyaa0en3RxVUd8df-oHi7XMMDo7mtKT6mSmEvTuk11l2gFA!!&v=MDE4NzJwNUViUElSOGVYMUx1eFlTN0RoMVQzcVRyV00xRnJDVVJMT2ZZT1Z2RnlyZ1U3M1BWRjI2Rjd1N0h0bk8=)

关键词 : 睡眠 呼吸检测 系统

### 2015 专利: 一种睡眠呼吸暂停综合症检测系统

- [搜到了一堆专利](https://patents.google.com/patent/CN104257353A/zh)

  {% asset_img 目前专利.png %}

## 产品模型

### 2019.7.25 

1. 枕头垫模型
   + 声音检测: 放在四个方向;
   + 压力检测: 平躺或者侧睡;
   + 微波检测: 人体的呼吸;