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

1. Makefile 文件
   + 从主目录到子目录中都存在
   + 总的Makefile ： make -C 执行每个子目录下的Makefile

```
$ make -n		/*只打印要执行的命令，而不是直接执行；检查makefile是否正确*/
$ make -C testmake	/* 切换到目录testmake下，编译 */
$ make -C			/*执行每个子目录下的Makefile*/
$ make CFLAGS=-g	/*在编译中增加调试选项, gdb调试不能用*/
```

# GNU make

+ [GNU Make](https://docs.huihoo.com/gnu/linux/gmake.html)

+ 编写Makefile文件进行大项目的管理；

## Why Use

1. 明确搜索位置
   + 

