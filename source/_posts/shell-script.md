---

layout: post
title: shell_script
date: 2019-04-22 08:37:13
categories: 
- [LinuxC]
- [shell]
tags: shell
---

# Shell Script 

## Shell History

1. Shell 

   + 用户的命令，用户输入一条命令，Shell就解释执行一条，不需要编译
   + Batch 批处理的方式，便是she'll script

2. Unix She'll

   {% asset_img Unix_shell.png %}

   + 本章只介绍bash 和sh的用法和相关语法,不介绍其它Shell。

3. 切换其他的she'll

   {% asset_img other_shell.png %}

## Shell 如何执行命令

### 执行

1. 用户在命令行输入命令后，一般情况下Shell会 并 该命令，但是Shell的内建命令例外。

2. 内建命令 -- 不创建新的进程

   + 执行内建命令相当于调用Shell进程中的一个函数,并不创建新的进程。
   + 凡是用which 命令查不到程序文件所在位置的命令都是内建命令

   ```
   $ man bash-builtins		//查询内建命令
   ```


### 执行脚本

1. 注释

   + 用# 表示注释,相当于C语言的//注释
   + 当#！作为开头，表示该脚本使用后面指定的解释器/bin/sh解释执行。

   ```
   $ chmod +x script.sh
   $ ./script.sh
   ```

   + Shell会fork 一个子进程并调用exec 执行./script.sh这个程序
   + exec 系统调用应该把子进程的代码段替换成./script.sh程序的代码段，并从它的_start开始执行。

2. shript.sh 文本文件

   + 文本文件根本没有代码段和_start函数,怎么办呢?
   + 其实exec 还有另外一种机制：
     + 如果要执行的是一个文本文件，并且第一行用Shebang指定了解释器
     + 则用解释器程序的代码段替换当前进程,并且从解释器的_start开始执行,而这个文本文件被当作命令行参数传给解释器。

   ```
   script.sh
   	#! /bin/sh
   	cd ..
   	ls
   $ /bin/sh ./script.sh	//  exec 的另外一种机制：
   ```

3. 执行脚本方法 -- 创建了一个子进程

   ```
   $ ./script.sh		---> 	$ (cd ..; ls -l)
   $ sh ./script.sh	
   //cd ..命令改变的是子Shell的PWD ,而不会影响到交互式Shell(也就是不会影响到当前进程)
   ```

4. 执行脚本方法  ---- 直接在交互式Shell下逐行执行脚本中的命令 

   + 但是去掉（），这种方式也不会创建子Shell，而是直接在交互式Shell下逐行执行脚本中的命令。

   ```
   $ cd ..; ls -l	
   --> $ source ./script.sh
   --> $ . ./script.sh
   ```

5. 判断是否创建新的进程

   + 建新的进程但执行结束后也会有一个状态码,也可以用特殊变量$?读出。

   + echo $?  通常也用0表示成功非零表示失败

## Shell 语法

### 变量

1. 环境变量

   + 环境变量可以从父进程传给子进程，进程调用 fork()

2. 本地变量

   + 只存在于当前Shell进程

   ```
   $ printenv	// 显示当前Shell进程的环境变量。
   $ set 		//可以显示当前Shell进程中定义的所有变量(包括本地变量和环境变量)和函数。
   ```

   + 环境变量是任何进程都有的概念,而本地变量是Shell特有的概念。

3. Shell 中变量的定义

   + 环境变量、本地变量 ：变量的定义，等号两边都不能有空格

   ```
   $ VARNAME=value		// 变量的定义	
   $ export VARNAME	// 用export命令可以把本地变量导出为环境变量
   	$ export VARNAME=value
   $ unset VARNAME		// 可以删除已定义的环境变量或本地变量。
   ```

4. Shell 中变量的赋值

   + Shell变量的值都是字符串

   ```
   $ echo $SHELL		// 查看变量$SHELL 的值
   $ echo $SHELL abc	// 给$SHELL 变量赋值字符串 abc
   ```

   + Shell变量不需要先定义后使用,如果对一个没有定义的变量取值,则值为空字符串。

### 文件名替换

+ 这些用于匹配的字符称为通配符(Wildcard)

  {% asset_img wildcard.png %}

+ Globbing所匹配的文件名是由Shell展开的,也就是说在参数还没传给程序之前已经展开

  ```
  $ ls /dev/ttyS*		//匹配/dev/ttyS的所有文件
  ```

### 命令代换

+ 由反引号括起来的也是一条命令

  + Shell先执行该命令,
  + 然后将输出结果立刻代换到当前命令行中。

  ```
  $ DATE='date'
  $ echo $DATE		--> 	$DATE=$(date)
  ```

### 算数代换 $(())

+ $(()) 中的Shell变量取值将转换成整数

+ $(()) 中只能用+-*/和()运算符,并且只能做整数运算。

  ```
  $ VAR=45	// 变量的赋值
  $ echo $(($VRA +3))
  ```

### 转义字符 \

+  \  在Shell中被用作转义字符,用于去除紧跟其后的单个字符的特殊意义(回车除外)

  + 在 \ 后面的字符取字面值

  ```
  $ echo $SHELL	-->		/bin/bash
  $ echo \$SHELL	-->		$SHELL
  ```

+ 建立包含特殊字符的文件名

  ```
  $ touch \$\ \$\		// 创建一个文件名为“$ $”的文件
  ```

### 单引号 ' '

+ 和C语言不一样,Shell脚本中的单引号和双引号一样都是字符串的界定符,而不是字符的界定符

+ 单引号用于保持引号内所有字符的字面值，即使引号内的\和回车也不例外,

  ```
  $ echo '$SHELL'		--> 	$SHELL
  $ echo 'ABC\(回车)		// 单引号需要配对，如果没有配对就输入回车
  > DE'(再按一次回车结束命令)	--> ABC\
  								DE
  ```

### 双引号 ""

+ 双引号用于保持引号内所有字符的字面值(回车也不例外)
+ 有几种例外的情况，用到的时候在说

## Bash 脚本

+ 启动脚本是bash 启动时自动执行的脚本。
+ 用户可以把一些环境变量的设置和alias 、umask 设置放在启动脚本中,这样每次启动Shell时这些设置都自动生效。
+ bash 在执行启动脚本时是以fork 子Shell方式执行的还是以source方式执行的?

### 交互登录Shell启动

1. 交互Shell：是指用户在提示符下输命令的Shell而非执行脚本的Shell,

2. 登录Shell：是在输入用户名和密码登录后得到的Shell

   ```
   /etc/profile	// 用户设置都在这个脚本
   ```

## Shell 脚本语法

### 条件测试

1. 命令test 或[ 可以测试一个条件是否成立

   + 测试结果为真，Exit Status返回 0,

   + 测试结果为假，Exit Status返回 1

     ```
     $ VAR=2
     $ test $VAR -gt 1		-->		$ [ $VAR -gt 3 ]	// 命令和参数要用空格隔开
     $ echo $?				-->		$ echo $?
     0						-->		1
     ```

2. 测试命令

   + 基本命令

     {% asset_img test.png %}

   + 与或非

     - {% asset_img or.png %}

   + 作为一种好的Shell编程习惯，应该总是把变量取值放在双引号之中(展开为[ -d Desktop -a "" = 'abc' ]):

     ```
     $ unset VAR
     $ [ -d Desktop -a $VAR = 'abc' ]
     	bash: [: too many arguments
     $ [ -d Desktop -a "$VAR" = 'abc' ]
     $ echo $?
     	1
     ```

### 分支控制

+ 在Shell中用if 、then 、elif 、else 、fi这几条命令实现分支控制

1. 规则

   + 如果两条命令写在同一行则需要用;号隔开，一行只写一条则不需要
   + 要注意命令和各参数之间必须用空格隔开  [ a b ]
   + Exit Status为0(表示真)
   + Shell脚本没有{}括号,所以用fi 表示if 语句块的结束。

2. " : "号

   ```
   #! /bin/sh
   if [ -f /bin/bash ]		// 一条命令占一行
   then echo "/bin/bash is a file"
   else echo "/bin/bash is NOT a file"
   fi
   
   if :; then echo "always true"; fi	// 有分号隔开
   ```

   + :是一个特殊的命令,称为空命令,该命令不做任何事，但Exit Status总是真。

3. read 

   + 的read 命令的作用是等待用户输入一行字符串,将该字符串存到一个Shell变量中。

     ```
     read YES_OR_NO
     ```

4. Shell还提供了&&和||语法

   + &&相当于“if...then...”,而 || 相当于“if not...then...”
   + 而上面讲的-a和-o仅用于在测试表达式中的两个条件、

   ```
   test "$VAR" -gt 1 -a "$VAR" -lt 3	// -gt 大于； -lt 小于； -a 测试
   test "$VAR" -gt 1 && test "$VAR" -lt 3
   ```

### case/esac

1. case 命令可类比C语言的switch/case 语句,esac 表示case 语句块的结束。

   + Shell脚本的case 可以匹配字符串和Wildcard
   + 末尾必须以;;结束
   + 执行时找到第一个匹配的分支并执行相应的命令,然后直接跳到esac 之后,不需要像C语言一样用break 跳出。

2. $1 是一个特殊变量,

   ```
   case $1 in
   		start)
   			echo "" ;;
   		stop)
   			echo "" ;;
   esac
   ```

   + $1 是一个特殊变量,在执行脚本时自动取值为第一个命令行参数,也就是start 

   + 命令行参数指定为stop 、reload或restart 可以进入其它分支执行停止服务、重新加载配置文件或重新启动服务的相关命令。

     ```
      $ sudo /etc/init.d/apache2 start	// 传入start进行执行
     ```

### for / do / done

1. Shell脚本的for 循环结构和C语言很不一样,它类似于某些编程语言的foreach循环。

   ```
    $ for FILENAME in chap?; do mv $FILENAME $FILENAME~; done	// 将文件chap 替换成chap~
   ```

### while/do/done

1. while 的用法和C语言类似。比如一个验证密码的脚本:

   ```
   #! /bin/sh
   echo "Enter password:"		# ""保留字面值
   read TRY					# 读用户输入
   while [ "$TRY" != "secret" ]; do
   	echo "Sorry, try again"
   	read TRY
   done
   ```

###  位置参数和特殊变量

1. Shell自动赋值的特殊变量

   {% asset_img shell$.png %}

2. 位置参数可以用shift 命令左移
   + 比如shift 3 表示原来的$4 现在变成$1,
   + 原来的$1、$2、$3 丢弃,$0不移动。(不够移动)
   + 不带参数的shift 命令相当于shift 1

### 函数

1. 规则

   + Shell中也有函数的概念,但是函数定义中没有返回值也没有参数列表。

   + 函数体的左花括号：{ 和后面的命令之间必须有空格或换行

   + 最后一条命令和右花括号 } 写在同一行，命令末尾必须有“ ; "号

     ```
     foo(){ echo "Function foo is called";}	# 不在同一行就不需要加
     ```

   + 函数先定义，后使用；

   + 函数调用，foo 后面不加（）

   + Shell脚本中的函数必须先定义后调用,一般把函数定义都写在脚本的前面,把函数调用和其它命令写在脚本的最后

     + 类似C语言中的main 函数,这才是整个脚本实际开始执行命令的地方

2. Shell函数没有参数列表并不表示不能传参数,

   + 在函数内同样是用$0 、$1、$2 等变量来提取参数
   + 函数中的位置参数相当于函数的局部变量,改变这些变量并不会影响函数外面的$0、$1 、$2等变量。
   + 如果return后面跟一个数字则表示函数的Exit Status。

## Shell 调试方法

1. 调试脚本的选项

   {% asset_img script.png %}

   ```
   $ sh -x ./script.sh
   ```

2. 在脚本开头提供参数

   ```
   #! /bin/sh -x
   ```

3. 在脚本中用set命令启用或禁用参数

   + set -x和set +x 分别表示启用和禁用 "-x参数"
   + 这样可以只对脚本中的某一段进行跟踪调试。

