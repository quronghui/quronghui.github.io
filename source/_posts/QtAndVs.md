---
layout: post
title: QtAndVs
date: 2019-03-01 16:09:43
categories: 
 - [Qt Ui]
 - [Visiual Studio]
tags: Qt
---

# Qt and Visiual Studio

+ 通过创建Qt GUI 的程序，实现按键的点击和事件的响应。
+ [参考链接](https://blog.csdn.net/mieleizhi0522/article/details/79259222)

## 文章的几个注意点

1. Qt Gui 文件的类型介绍。

   {% asset_img Qtfile.png %}

   + （1）是Qt设计师文件，双击可以打开Qt可视化设计
   + （2）Qt界面的代码文件，Qt设计师设计的界面以代码的形式存储在这里，比如Button的位置，大小，名字。
   + （3）Widget类的头文件，定义一些字段和函数声明，包括最重要的slots（槽）函数的声明，以及界面ui句柄，以便通过“ui.***”的方式访问到界面的各个控件，比如访问界面的Label控件里的文字可以这样：ui.label->text();就是字面意思，很容易理解。
   + （4）资源文件，相当于AndroidStudio里面的rcs文件夹，里面存放需要用到的.ico图标或者图片。
   + （5）主函数文件，程序的入口，不必解释，其实一般不会在这个里面修改什么。
   + （6）Widget类完成的主要文件，在widget.h里面定义之后的字段以及函数声明，以及槽的实现，都是在这里，Qt的逻辑功能设计主要是修改这个文件。

2. 添加事件发现的函数  -- 槽函数

   + 发生事件的方式（Click()）

   + 槽函数：接收函数

   + 他们之间的连接

     ```
     Widget::Widget(QWidget *parent)
     	: QWidget(parent)
     {
     	ui.setupUi(this);
     	connect(ui.checkBox,SIGNAL(clicked()),this,SLOT(on_checkBox_clicked()));
     	connect(ui.checkBox_2, SIGNAL(clicked()), this, SLOT(on_checkBox_2_clicked()));
     	connect(ui.pushButton, SIGNAL(clicked()), this, SLOT(on_pushButton_clicked()));
     }
     // ui.checkBox : ui控件
     // SIGNAL(clicked()) : 发生事件的方式（Click()）
     // SLOT(on_checkBox_clicked()))：槽函数，响应事件的方式
     ```

## Qt 里面的函数

### Gui 窗口大小的设置

1. Qt Gui窗口大小的设置方式

   {% asset_img QtWindowSize.png %}

   ```
   this->setWindowState(Qt::WindowMaximized);
   ```


## Question

### VS 里面在哪里添加 Qt的函数

1. 还没有解决