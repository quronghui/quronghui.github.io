---
layout: post
title: Makefile
date: 2019-03-21 19:25:24
categories: 
 - [Makefile]
 - [LinuxC]
tags: Makefile
---

# Makefile 基础

+ [ Link code ](https://github.com/quronghui/LinuxC.git) -- Makefiles
+ 注释是 “#”

## Makefile 基本规则

### Makefile

1. 例子

   ```
   main: main.o stack.o maze.o
   		gcc main.o stack.o maze.o -o main
   main.o: main.c main.h stack.h maze.h
   		gcc -c main.c
   stack.o: stack.c stack.h main.h
   		gcc -c stack.c
   maze.o:	maze.c maze.h main.h
   		gcc -c maze.c
   ```

2. Makefile 由一组规则 rule组成

   ```
   target ... : prerequisites ...
   		command1
   		command2
   		...
   ```

   - 目标和条件之间的关系是：欲更新目标，必须首先更新它的所有条件;
   - 所有条件中只要有一个条件被更新了，目标也必须随之被更新。
   - 所谓“更新”就是执行一遍规则中的命令列表；命令列表中的每条命令必须以一个Tab开头；（注意不能是空格）
   - 对于Makefile中的每个以Tab开头的命令,make 会创建一个Shell进程去执行它。

### make 编译

1. make 会自动选择那些受影响的源文件重新编译，不受影响的源文件则不重新编译。

   {% asset_img makerule.png %}

### make clean

```
clean:
	@echo "cleanning project"
	-rm main *.o
	@echo "clean completed"

.PHONY: clean	/* 声明clean为一个伪目标 */
```

1. clean 目标不依赖于任何条件,并且执行它的命令列表不会生成 clean文件

2. rm and mkdir

   + 命令前面加 “ - ”
   + 即使这条命令出错，也会继续执行后面的命令
   + 因为rm 要删除的文件可能不存在,mkdir 要创建的目录可能已存在

3. 在命令前加 @

   + 加了命令在前面，不显示命令本身 而只显示它的结果;

4.  .PHONY: clean

   + 声明clean为一个伪目标
   + 为了将clean 当做特殊的名字使用

   {% asset_img make.png %}

### 类似于clean的目标名字

​	{% asset_img clean.png%}

## Makefile 隐含规则和模式规则

​	{% asset_img rule.png %}

## 变量

| 符号                                                        | 作用                                     |
| ----------------------------------------------------------- | ---------------------------------------- |
| “ := ”    y := $(x) bar                                     | make 遇到变量定义的时候：立即展开        |
| nullstring :=<br/>space := $(nullstring)  # end of the line | 为了定义变量的值为空格；注释前面是有空格 |
| “ ?= ”   foo ?= $(bar)                                      | 相当于 “ = ”，定义foo的值为$(bar)        |
| “ += ”                                                      | 保持了“ :=  ”的特性                      |

### 特殊变量

+ 可以减少书写错误

1. 特殊变量：替代makefile中的规则，简写

   {% asset_img variable.png %}

2. 特殊变量的使用

   {% asset_img variableuse.png %}

3. " $? "的使用

   + 用于生成静态、共享库

   ```
   libsome.a: foo.o bar.o lose.o win.o
   		ar r libsome.a $?
   		ranlib libsome.a
   ```

### 变量的缺省值

{% asset_img Default_value.png %}

{% asset_img Default_value1.png %}

## 自动处理头文件的依赖关系

+ 省去了手动敲命令

### 命令

```
$ gcc -M main.c		/* 找出所有的依赖头文件 */
$ gcc -MM main.c		/* 排除系统头文件 */
```

## Make命令选项

### 想通过命令行传参数或者缺省参数设置

1. 前提条件：

   - 需要通过隐式规则编写Makefile

   - 将gcc编译省去

   {% asset_img CFLAGS.png %}

2. 在Makefile 文件理添加缺省命令

   ```
   all: main		# 按照惯例,用all 做缺省目标。
   main: main.o
   	gcc $^ -o $@
   main.o:	main.c
   
   CFLAGS = -g
   
   clean:
   	@echo "cleanning project"
   	-rm main *.o
   	@echo "cleanning compile"
   .PHONY:clean
   ```

3. 通过命令行传递缺省参数

   ```
    make CFLAGS=-g	/*在编译中增加调试选项*/
   ```

   

### Makefile 文件

+ 从主目录到子目录中都存在
+ 总的Makefile ： make -C 执行每个子目录下的Makefile

```
$ make -n		/*只打印要执行的命令，而不是直接执行；检查makefile是否正确*/
$ make -C testmake	/* 切换到目录testmake下，编译 */
$ make -C			/*执行每个子目录下的Makefile*/
$ make CFLAGS=-g	/*在编译中增加调试选项*/
```

# GNU make

+ [GNU Make](https://docs.huihoo.com/gnu/linux/gmake.html)

+ 编写Makefile文件进行大项目的管理；

## 概念

### Why Use

1. 明确搜索位置
2. 减少项目的编译时间
   + 只针对改动的项目进行编译
3. 从很多目标文件生成一个程序包 (Library)比从一个单一的大目标文件
   生成要好的多
   + 使用 gcc/ld (一个 GNU C 编译／连接器) 把一个程序包连接到一个程序时；
   + 在连接的过程中，它将不去连接没有使用到的部分。
   + 程序是很模块化的，文件之间的共享部分被减到最少

### When Use

1. 如果你需要开发一个相当大的项目，在开始前，应该考虑一下你将如何实现它，并且生成几个文件（用适当的名字）来放你的代码。
2. 当然，在你的项目开发的过程中，你可以建立新的文件，但如果你这么做的话，说明你可能改变了当初的想法，你应该想想是否需要对整体结构也进行相应的调整。

### How Use

1. 不要用一个 header 文件指向多个源码文件;
2. 如果可以的话，完全可以用超过一个的 header 文件来指向同一个源码文件。
3. 不要在多个 header 文件中重复定义信息。
4. 关键字“static”：要防止一个符号在它被定义的源文件以外被看到

### header

1. 不要在 header 档里定义变量，只能用作声明变量和函数。

2. 你只需要在 header 档里声明，然后在适当的Ｃ源码文件（只在 #include header
   ）里定义一次。

3. 声明和定义

   + 声明：告诉编译器其所声明的符号应该存在，并且要有所指定的类型。但是，它并不会使编译器分配贮存空间。
   + 定义：要求编译器分配贮存空间。

4. 防止出现重复声明

   ```
   #ifndef FILENAME_H
   #define FILENAME_H
   ...
   #endif
   ```

## GUN Make Tools

1. GNU Make 的主要工作是读进一个文本文件--makefile 。
   + 搜索其中的Target and dependencies；
   + 检查磁盘上的文件和目标文件的时间戳；
   + 进而进行目标文件的更新。

### Makefile 变量

1. 如何编写，引用Makefile变量

   + 和变量的赋值规则相似
   + 变量：用大写的字母
   + 引用：通过 “$( CC )”  "$(CFLAGS)"

   ```
   OBJS = main.o			#变量 = 变量的值
   CC = gcc
   CFLAGS = -Wall -O -g	#-Wall 打印所有的警告信息； -O 编译器的优化； -g gdb调试的编译			
   ```

2. 三个特殊的变量

   + "$@" ：扩展成当前规则的目的文件名
   + "$<"  : 扩展成依靠列表中的第一个依靠文件
   + "$^"  :  扩展成整个依靠的列表（除掉了里面所有重复的文件名）

3. Makefile 文件编写

   ```
   # 编译条件
   OBJS = main.o			
   CC = gcc
   CFLAGS = -Wall -O -g
   # 目标文件
   all: main		# 按照惯例,用all 做缺省目标。
   # 编译条件
   main : $(OBJS)
     $(CC) $^ -o $@
   main.o : main.c main.h 
     $(CC) $(CFLAGS) -c $< -o $@	# 类似于 gcc -c main.c
   # clean
   clean:
   	@echo "cleanning project"
   	-rm main *.o
   	@echo "cleanning compile"
   .PHONY:clean
   ```

### 隐含规则

1. Rule

   + 变量CC 做为编译器
   + 传递变量 CFLAGS 给 C 编译器（C++ 编译器用 CXXFLAGS ）
   + CPPFLAGS （ C 预处理器旗标）
   + TARGET_ARCH （现在不用考虑这个）
   + 加入旗标 '-c' ，后面跟变量 $< （第一个依靠名），然后是旗标 '-o' 跟变量 $@ （目的文件名）

   ```
   $(CC) $(CFLAGS) $(CPPFLAGS) $(TARGET_ARCH) -c $< -o $@
   ```

2. 假想可执行文件

   + 为了通过一个Makefile生成多个可执行问价

   ```
   在Makefile开始时输入
   	all: main mymain
   ```