---
layout: post
title: Linux ALSA
date: 2019-09-04 17:21:47
categories: [driver]
tags: [alsa]
---

# Linux ALSA 声卡驱动

| 驱动框架       | ALSA                        | OSS(Open Sound System)    |
| -------------- | --------------------------- | ------------------------- |
| Linux版本支持  | 2.6 kernel 之后             | 2.4 kernel 开放的声音系统 |
| 总线           | I2C                         |                           |
| **设备类型**   | 字符设备 （ls-l  /dev/snd） |                           |
|                | **pcm and control**         |                           |
|                | C0D0 --  声卡0的设备0       |                           |
| 内核设备驱动层 | alsa-driver  (ls -l  sound) |                           |
|                | alsa-soc : 进一步封装driver |                           |
| 用户空间层     | alsa-lib；tinyalsa          |                           |

## ALSA 系统架构

| 系统架构                | 作用                                                         |
| ----------------------- | ------------------------------------------------------------ |
| Native ALSA Application | tinyplay/tinycap/tinymix，直接调用 alsa 用户库接口来实现放音、录音、控制 |
| ALSA Library API        | alsa 用户库接口，常见有 tinyalsa、alsa-lib                   |
| ALSA CORE               | **alsa 核心层，向上提供逻辑设备（PCM/CTL/MIDI/TIMER/…）系统调用，向下驱动硬件设备（Machine/I2S/DMA/CODEC）** |
| ASoC CORE               | asoc 是建立在标准 alsa core 基础上，为了更好支持**嵌入式系统和应用于移动**设备的音频 codec 的一套软件体系 |
| Hardware Driver         | 音频硬件设备驱动，由三大部分组成，分别是 Machine、Platform、Codec |

{% asset_img alsa_core %}

###  ALSA从内核空间到DAC采样

{% asset_img alsa_core.png %}

### [Hardware driver](https://www.jianshu.com/p/359e150ff517)

+ I2C 是传输数据 ,I2S 是传输音频
+ {% asset_img alsa_iic.png %}

### ALSA 驱动具体工作

| ALSA驱动具体工作       | 调用函数                                    |
| ---------------------- | ------------------------------------------- |
| 创建snd_card结构体     | snd_card_create() / snd_ctrl_create()       |
| 初始化                 | snd_pcm_new(): 创建逻辑设备（播放或者录音） |
| 注册 snd_card_register | 注册声卡                                    |

## ALSA(Advanced Linux Sound Architecture)

1. ALSA目前是：linux的主流音频体系结构
2. 用户空间：**alsa-lib**
   + 应用程序提供统一的API接口，这样可以隐藏了驱动层的实现细节
   + 应用程序只要调用alsa-lib提供的API，即可以完成对底层音频硬件的控制
3. 内核空间：**alsa-driver；alsa-soc**
   + alsa-driver：内核设备驱动层
   + alsa-soc：对alsa-driver进一步封装，方便用户空间调用；

### ALSA设备文件结构

1. 查询Linux下alsa驱动的**设备文件结构**

   ```
   $	ls	-al		/dev/snd		// 设备属于字符设备
   ```

2. 目录下的设备用途

   + 我们更关心的是pcm和control这两种设备

   
   
   | 设备类型     | 设备名字  | 作用                                             |
   | ------------ | --------- | ------------------------------------------------ |
   | **字符设备** | controlC0 | 用于声卡的控制，例如通道选择，混音，麦克风的控制 |
   |              | midiC0D0  | 用于播放midi音频                                 |
   | (两组)       | pcmC0D0c  | 用于**录音**的pcm设备；capture                   |
   |              | pcmC0D0p  | 用于**播放**的pcm设备；playback                  |
|              | seq       | 音序器                                           |
   |              | time      | 定时器                                           |

   + C0D0代表的是：声卡0中的设备0
   
   {% asset_img alsa_device.png %}

### ALSA 驱动目录文件

1. linux 查询alsa驱动目录

   ```
   $	ls	-al		/sound			//  将sound
   ```

2. slsa-driver分三层

   + 声卡对象描述层
   + ALSA 核心层 ASLA Core
   + Audio 设备驱动层 Audio device driver

   
   
   | 驱动目录   | 作用                                                         |
   | ---------- | ------------------------------------------------------------ |
   | **core**   | 该目录包含了ALSA驱动的中间层，它是整个ALSA驱动的核心部分     |
   | core/oss   | 包含模拟旧的OSS架构的PCM和Mixer模块                          |
   | core/seq   | 有关音序器相关的代码                                         |
   | include    | ALSA驱动的公共头文件目录，该目录的头文件需要导出给用户空间的应用程序使用 |
   | drivers    | 放置一些与CPU、BUS架构无关的公用代码                         |
   | **i2c**    | ALSA自己的I2C控制代码                                        |
   | **pci**    | pci声卡的顶层目录，子目录包含各种pci声卡的代码               |
   | **isa**    | isa声卡的顶层目录，子目录包含各种isa声卡的代码               |
| soc        | 针对system-on-chip体系的中间层代码                           |
   | soc/codecs | 针对soc体系的各种codec的代码，与平台无关                     |
   
   