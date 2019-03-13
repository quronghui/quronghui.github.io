---
layout: post
title: Application For Ubuntu
date: 2019-02-26 21:31:51
categories: ubuntu
tags: ubuntu
---

# Application For Ubuntu

## VS code 

### 安装

```
sudo add-apt-repository ppa:ubuntu-desktop/ubuntu-make
sudo apt-get update
sudo apt-get install ubuntu-make
sudo umake ide visual-studio-code
```

### 配置C/C++编译环境

+ [C/C++](https://blog.csdn.net/qq_34347375/article/details/80851417)

## PDF阅读器Okular

```
$ sudo apt-get install okular 
```

## Typora

```
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys BA300B7755AFCFAE
sudo add-apt-repository 'deb http://typora.io linux/'
sudo apt-get update
sudo apt-get install typora
```

## Sougou

+ [link](https://blog.csdn.net/areigninhell/article/details/79696751)

```
Download : http://pinyin.sogou.com/linux/ 
	sudo dpkg -i sogoupinyin_2.1.0.0082_amd64.deb  	
```

## Arduino 

+ [ link ](https://blog.csdn.net/wowocpp/article/details/81175478)

1. Extensions 安装

   + 搜索 arduino
   + vs code --> 首选项 --> 设置 --> 搜索arduino --> 设置 arduino.path

   ```
   查看软件安装目录：
   	$ aptitude show sublime-text-installer 		//列出软件信息
   	$ dpkg -l  					//列车所有安装的软件
   	$ dpkg -l firefox 			//列出firefox 软件安装信息
   	
   	$ dpkg -L 软件名			//没有在PATH路径下保存，通过下面命令寻找安装目录
   ```


## Screenshot

1. ubuntu 自带的截图工具
2. 用用软件进行下载更新

## Port Question

### 查看设备的 Serial Devide

```
cd /dev
ls ttyUSB*				//esp32的端口Serial查询
ls ttyACM*				//arduino 端口的serial
```

### Port Permission denied

1. 问题：下载程序到arduino时，端口权限报错。

   ```
   Auto-detected: /dev/ttyACM0
   *** [upload] could not open port /dev/ttyACM0: [Errno 13] Permission denied: '/dev/ttyACM0' ('/dev/ttyUSB0')
   ```

2. 重启后权限消失

   ```
   给端口权限
   sudo chmod 666 /dev/ttyACM0  ('/dev/ttyUSB0')
   ```

3. 永久权限

   ```
   sudo gedit /etc/udev/rules.d/70-ttyacm.rules('/dev/ttyusb')	// 添加权限文件
   KERNEL=="ttyACM[0-9]*",MODE="0666" 		('/dev/ttyUSB0')	// 添加权限文件
   reboot
   ```

## Vi 编辑时上下左右键出现字母

1.  ubuntu默认安装装的是vim tiny版本，而需要的是vim full版本。

   ```
   $sudo apt-get remove vim-common
   $sudo apt-get install vim
   ```

## 环境变量的设置

1. 配置/etc/enviroment	

   ```
   sudo su					// 用户权限
   vi /etc/enviroment
   PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/home/quronghui/HustFiles/Esp32/crossTools/xtensa-esp32-elf/bin
   source /etc/enviroment	//使之生效
   ```

2. 配置 /etc/profile （这个不用配置）

   ```
   sudo su					// 用户权限
   vi /etc/profile
   export PATH=/home/yan/share/usr/local/arm/3.4.1/bin:$PATH
   source /etc/profile		//使之生效
   ```

## Linux 下的串口

+ [minicom](https://jingyan.baidu.com/article/6b182309f9dd6dba59e1597a.html)

  ```
   sudo apt-get install minicom
   sudo minicom						// 需要在root权限下开启minicom
   ctrl-a	 o		//进入端口配置,先按下 Ctrl + a;放开Ctrl + a，按下 o
   
   select ：A 							//修改端口 和 波特率
   change : /dev/ttyUSB0
   
   select : Save setup as dfl
   ctrl-a x							// 退出minicon
  ```


## 查看已安装文件的目录

1. dpkg

   ```
   dpkg -l "*sougou*"		//来查看软件的状态。
   dpkg -P					//来卸载软件,或者 dpkg --purge完全删除,包括配置文件
   ```

2. 查看目录

   ```
   ps -e 								//查看软件对应的名字
   sudo find / -name "platform"		//查询得到软件的目录
   ```

   {% asset_img FindContent.png %}

## 设置PlatformIo 串口的波特率

```
stty -F /dev/ttyUSB0				//查看Usb的属性
 stty -F /dev/ttyUSB0  115200		//修改usb的波特率
```

