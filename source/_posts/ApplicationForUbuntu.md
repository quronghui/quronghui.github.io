---
layout: post
title: Application For Ubuntu
date: 2019-02-26 21:31:51
categories: ubuntu
tags: ubuntu
---

# Application For Ubuntu

## update

```
$ sudo apt update	// 搜索可以更新
$ apt list --upgradable	// 可以看看有哪些可更新的软件
$ sudo apt upgrade 		// 行更新操作
$ sudo apt autoremove	//更新完成之后会有一些不需要的旧组件需要清除
```

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

### VS 更新

```
$ sudo wget https://vscode-update.azurewebsites.net/latest/linux-deb-x64/stable -O /tmp/code_latest_amd64.deb
$ sudo dpkg -i /tmp/code_latest_amd64.deb
$ 关闭vs code，然后再次打开会看到release note的页面，说明已经完成更新。
```

### vs code 代码能编译通过，但是头文件全是红色

1. 删除文件夹下的 .vscode
2. 相当于重新建立索引，应该就能解决。

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

### 单次修改串口波特率

```
stty -F /dev/ttyUSB0				//查看Usb的属性
 stty -F /dev/ttyUSB0  115200		//修改usb的波特率
```

### 修改默认值

1. 进入platformIO的python目录

   ```
   /home/quronghui/.platformio/penv/lib/python2.7/site-packages/serial/tools
   ```

2. 给权限并且修改内容

   ```
   chmod 777 sudo miniterm.py
   /*********find***************/
   parser.add_argument(
       "baudrate",			// 修改波特率这一栏就可以了
       nargs='?',
       type=int,
       help="set baud rate, default: %(default)s",
       default=115200) # default这里改成你想要默认的波特率，115200
   ```

3. 然后删除本目录下的miniterm.pyc文件，再次开启串口监视器时会重新编译生成此文件。

## 声卡无声音

1. Ubuntu 18没有声音
2. [解决方式参考](https://blog.csdn.net/multimicro/article/details/82528730)

## git clone 速度慢

1. git clone https://

   + 克隆的是工程所有的提交历史quronghui

2. 克隆最近一次的commit，然后更新得到所有的提交历史

   ```
   $ git clone http://github.com/large-repository --depth 1
   $ cd large-repository
   $ git fetch --unshallow
   ```

   

## 配置shadowsocket

+ [git](https://github.com/quronghui/shadowsocks.git)

## ubuntu18 误删除 /etc/shadow

### /etc/shadow

1. 是Ubuntu系统的登录和权限认证的文件
2. 保存了密码

### 如何进行恢复

+ [参考博客](http://www.bluestep.cc/ubuntu-17-04-%E4%B8%8D%E5%B0%8F%E5%BF%83%E5%88%A0%E9%99%A4etcpasswd%E6%88%96etcshadow%E6%97%A0%E6%B3%95%E8%BF%9B%E5%85%A5%E7%B3%BB%E7%BB%9F%EF%BC%9A%E4%BF%AE%E6%94%B9root%E5%AF%86%E7%A0%81/)

1. 进去recovery 编辑模式

   {% asset_img recovery.png%}

   + 这里不是 Enter选中，而是直按下e

2. 按e进入如下界面，找到图中红色框的recovery nomodeset并将其删掉，再在这一行的后面输入quiet splash rw init=/bin/bash

   {% asset_img quiet.png %}

   + 我的系统后面没有 find_pressed ....
   + 我是加上后才成功的

3. 接着按F10后出现如下界面

   ```
   passwd username		// 一定要加用户名，不然修改后不能成功
   ```

4. reboot 重启一直报错

   ```
   reboot -f
   ```


## 流程图工具

+ [Reference](https://blog.csdn.net/haohaojian/article/details/8742406)

## 安装Eagle

1. 安装方式

   + Autodesk student 
   + eagle for Linux

2. 报错

   ```
   ./eagle: symbol lookup error: /usr/lib/x86_64-linux-gnu/libGLX_mesa.so.0: undefined symbol: xcb_dri3_get_supported_modifiers
   ```

   {% asset_img eagle.png  没有解决 %}

## 安装WPS

1. 下载wps for linux

   + WPS官网下载deb包：<http://linux.wps.cn/>
   + wps_symbol_fonts.zip: <https://pan.baidu.com/s/1eS6xIzo>

2. 安装

   ```
   $ sudo dpkg -i xxx
   $ cd wps_symbol_fontsls
   $ sudo cp mtextra.ttf  symbol.ttf  WEBDINGS.TTF  wingding.ttf  WINGDNG2.ttf  WINGDNG3.ttf  /usr/share/fonts
   $ sudo apt-get remove libreoffice-common
   ```

## 安装Google

```
$ sudo wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb	// download
$ sudo dpkg -i google-chrome*
$ sudo apt-get -f install
```

## Ubuntu 查看目录

```
$ sudo snap install tree	// 安装tree应用
$ tree -a	// 像树一样显示目录结构
$ tree -d 	#仅显示目录
$ tree -L n 	#n代表数字..表示要显示几层...
$ tree -f 	#显示完整路径..
```



## [生成 GitHub README.md 目录](https://sleepeatcode.com/articles/15/generating-the-github-readme-directory)

1. `gh-md-toc` 项目在 Ubuntu 和 macOS 上测试过。如果要在 Windows 上使用，使用基于 golang 的实现：[github-markdown-toc.go](https://github.com/ekalinin/github-markdown-toc.go)。而且很重要的一点是，它不需要安装额外的依赖。

   ```
   $ wget https://raw.githubusercontent.com/ekalinin/github-markdown-toc/master/gh-md-toc
   $ chmod a+x gh-md-toc
   ```

2. 使用方式: 通过本地输出后复制到README.md

   ```
   $	/gh-md-toc	 ~/projects/Dockerfile.vim/README.md 
   Table of Contents
   =================
      * [Embedded-written-reference](#embedded-written-reference)
         * [Contents](#contents)
         * [7.30诺瓦科技](#730诺瓦科技)
         * [8.1大疆嵌入式参考](#81大疆嵌入式参考)
         * [8.3网易笔试](#83网易笔试)
   ```