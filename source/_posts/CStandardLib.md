---
layout: post
title: C Standard Lib
date: 2019-04-02 15:52:18
categories: 
- [LinuxC]
- [standard lib]
tags: [standard lib]
---

# C Standard Lib

+ C标准主要由两部分组成，一部分描述C的语法，一部分描述C标准库。
+ 平台支持C语言
  + 实现C编译器
  + 实现C标准库
+ 函数文件的命名，以.c 为准
  + 在 ’.c‘ file：void * 类型的数，做右值的时候会自动进行转换；
  + 在 ’ .cpp ‘file：不会自动的转换
+ POSIX 是Unix系统的标准，不属于C标准库

## String Funcation

+ 程序按功能划分可分为数值运算、符号处理和I/O操作三类,
+ 符号操作：由各种基本的字符串操作组成。
  + 字符串的初始化、取长度、拷贝、连接、比较、搜索等基本操作。
+ 字符串的操作中：' \0 ' 的操作要注意。操作可能是including，excluding

1. size_t 

   + size_t 是一种类型，表示的是操作系统的位数，32位和64位

2. memset

   + 初始化字符串

     ```
     void *memset(void *s, int c, size_t n);// 将指针s指向的存储空间的 n 位数，用 c 代替；
     memset(buf, 0, 10);	//将buf的前10位用0初始化
     ```

3. strlen

   ```
   size_t strlen(const char* s);	计算字符串长度
   ```

   + 注意数组的越界

### 拷贝字符串

+ [SCLib/memcpy](https://github.com/quronghui/LinuxC.git)

1. strcpy and strncpy

   + 拷贝以 ' \0 '结尾的字符串；
   + 属于字符类型
   + 以str开头的函数处理以'\0' 结尾的字符串;

   ```
   char *strcpy(char *dest, const char *src);
   char *strncpy(char *dest, const char *src, size_t n);
   ```

   +  strn 不需要以 '\0'结尾，当source的前n个字节没有NULL（'\0'），那么dest不需要以NULL结尾
   + 当source的字节数，少于n个字节，那么dest将填充足够的NULL（'\0'）直至满足n个字节

2. memcpy and memmove

   + mem*：针对的是memory，存储单元

   + 根据src指向的内存地址，拷贝n个字节（而不一定是字符串）
   + 而以mem开头的函数则不关心'\0' 字符,或者说这些函数并不把参数当字符串看待,因此参数的指针类型是void *而非char * 

   ```
   void *memcpy(void *dest, const void *src, size_t n);
   void *memmove(void *dest, const void *src, size_t n);
   ```

   + memcpy的两个参数src 和dest 所指的内存区间如果重叠，则无法正常拷贝。
   + 可以借助一个临时的缓存区，进行拷贝

3. 在32位的x86平台上,每次拷贝1个字节需要一条指令,每次拷贝4个字节也只需要一条指
   令,memcpy函数的实现尽可能4个字节4个字节地拷贝,因而得到上述结果。

### 连接字符串

1. strcat and strncat
   + 以str开头的函数处理以'\0' 结尾的字符串;
2. strncat
   + strncat总是保证dest 缓冲区以'\0' 结尾，这一点又和strncpy不同，strncpy并不保证dest缓冲区以'\0'结尾
   + dest至少含有的字节数：strlen(dest)+n+1个

### 比较字符串

1. memcmp

   + memcmp - compare memory areas
   + mem*：针对的是memory，存储单元

   ```
   int memcmp(const void *s1, const void *s2, size_t n);
   return 负值，0， 正值
   ```

   + memcmp从前到后逐个比较缓冲区s1和s2的前n个字节(不管里面有没有'\0' )

2. strcmp and strncmp

   + strcmp把s1和s2 当字符串比较,在其中一个字符串中遇到'\0' 时结束;
   + strncmp 遇到'\0' 或者 比较完了n个字节，就结束。

### 搜索字符串

+ 笔试估计会考，还有相应的算法。【算法导论】

1. strchr and strrchr

   ```
   locate character in string
   char *strchr(const char *s, int c);	// 从前到后，找到第一次出现的C就返回
   char *strrchr(const char *s, int c);// 从后到前，
   ```

   + 如果没有找到就返回 NULL
   + 疑问：为什么character 是int型的而不是char类型？

2. strstr

   ```
   char *strstr(const char *haystack, const char *needle);
   返回值:如果找到子串,返回值指向子串的开头,如果找不到就返回NULL
   ```

   + 堆haystack中找一根针needle ，按中文的说法叫大海捞针，显然haystack 是长字符串，needle 是要找的子串。

### 分割字符串

1. 分隔符：符号是‘ ：’；

   + 在编写Makefile 文件的时候；
   + clean : 文件的编写，就需要加分隔符

2. 分割符

   + 很多文件格式或协议格式中会规定一些分隔符或者叫界定符(Delimiter),例如/etc/passwd文件中保存着系统的帐号信息。

3. strtok

   + C标准库提供的strtok函数可以很方便地完成分割字符串的操作。
   + tok是Token的缩写,分割出来的每一段字符串称为一个Token

   ```
   #include <string.h>
   char *strtok(char *str, const char *delim);
   char *strtok_r(char *str, const char *delim, char **saveptr);
   ```

   + 每次都是改写的str

4. 第一次调用时把字符串传给strtok,以后每次调用时第一个参数只要传NULL 就可以了,strtok函数自己会记住上次处理到字符串的什么位置(显然这是通过strtok 函数中的一个静态指针变量记住的)。

## 标准I/O库函数

### 文件的基本概念

+ 用C标准库对文件进行读写操作,对文件的读写也属于I/O操作的一种

+ 十六进制数，十六进制的ASCII值

  ```
  十六进制数			十六进制的ASCII值
  	5					  32
  ```

+ ASCII 码值 

  + 0 - 127 : 128位的ASCII码值
  + 有33位不能显示出来，只能显示95个

#### 文本文件（Text file）

1. Text file --> Source file

   + 文本文件是用来保存字符的
   + 文件中的字节都是字符的某种编码(例如ASCII或UTF-8)

2. 编写和查看

   + vi : 进行编辑
   + cat : 查看里面的内容

3. 查看text file的长度

   ```
   $ ls -l textfile	/* 查看文本的长度，vi会自动在文件末尾加一个换行符 */
   ```

   {% asset_img ls-l.png  textfile输入了5678，可以看到文本长度 %}

4. **od Command**

   + -tx1：将文件中的字节以**十六进制码**的形式列出来
   + -tc :    将文件中的ASCII码以字符形式列出来。
   + -Ax :   要求以十六进制显示文件中的地址。（类似于hexdump）

   ```
   $ od -tx1 -tc -Ax textfile 
   000000  35  36  37  38  0a		// 十六进制的ASCII码值
            5   6   7   8  \n		// 十六进制数
   000005							// 地址
   ```

   ```
   hexdump textfile 
   0000000 3635 3837 000a                         
   0000005
   ```

#### 二进制文件 Binary file

1. Binary file
   + 目标文件，库文件和可执行文件
   + 有些字节表示各Section和Segment在文件中的位置,有些字节表示各Segment的加载地址。
2. 查看
   + hexdump command :进行查看

### fopen / fclose

1. fopen : 就是在操作系统中分配一些资源用于保存该文件的状态信息，并得到该文件的标识。

2. fclose: 

3. man fopen

   ```
   FILE *fopen(const char *path, const char *mode);
   ```

   + 指针类型：FILE *

   + **返回值做判断**：在代码中对返回值进行判断

     ```
     if ( (fp = fopen("/tmp/file1", "r")) == NULL)	/*绝对路径*/
     {
         printf("error open file /tmp/file1!\n");
         exit(1);
     }
     ```

#### mode

+ "a" :   只能在文件末尾追加数据,如果文件不存在则创建
+ “a+”:  允许读和追加数据,如果文件不存在则创建
+ "w":   只写,如果文件不存在则创建,如果文件已存在则把文件长度截断(Truncate)为0字节
  再重新写,也就是替换掉原来的文件内容
+ "r":  只读,文件必须已存在

#### 路径的介绍

1. Shell 提示符显示当前目录

   ```
   ~$		//当前工作目录是主目录
   /etc$	//当前工作目录是 /etc
   ```

2. 绝对路径：不同进程下的工作目录

   ```
   fp = fopen("/tmp/file1", "w")
   ```

3. 相对路径：

   + 相对路径是相对于当前工作目录(Current Working Directory)的路径
   + 每个进程都有自己的当前工作目录
   + Shell进程的当前工作目录可以用pwd 命令查看

   ```
   fp = fopen("file.a", "r"); //在当前工作目录下打开文件
   fp = fopen("../a.out", "r"); //只读打开当前工作目录下上一层目录下的文件
   fp = fopen("Desktop/file3", "w");	//当前工作目录下的子目录Desktop
   ```

### stdin/stdout/stderr

1. 终端操作：人机交互的设备，此时的I/O是对设备的操作。

   + 设备和文件占时不做区分

2. I/O设备的操作，printf 和scanf 不用打开就可以操作设备

   + c程序启动是会自动把终端设备打开三次,
   + 分别赋给三个FILE *指针stdin 、stdout和stderr ，
   + 这三个文件指针是libc 中定义的全局变量,

3. 函数的操作

   + printf：向stdout中写；

   + scanf：从stdin中读

   + stderr：打印标准错误，所以fopen的标准错误代码

     ```
     if ( (fp = fopen("/tmp/file1", "r")) == NULL)	/*绝对路径*/
     {
         printf("error open file /tmp/file1!\n");
         exit(1);
     }
     ```

### errno / perror

1. errno 

   + 很多系统函数在错误返回时将错误原因记录在libc 定义的全局变量errno 中
   + 每个错误原因对因一个错误码。
   + 所有错误码都是正整数。

2. perror

   + 对错误码errno的整数进行解读：解释成字符串再打印
   + 可以添加附加信息：方便定位错误

   ```
   int main(void)
   {
       FILE *fp = fopen("abcde", "r");
       if (fp == NULL) {
           perror("Open file abcde");	// 添加的额外信息Open file abcde：
           exit(1);
   	}
   	return 0;
   }
   ```

3. strerror

   + strerror 函数可以根据错误号返回错误原因字符串。
   + 以后学线程库时我们会看到,有些函数的错误码并不保存在errno 中,而是通过返回值返回。就不能调用perror打印错误原因了，这时strerror就需要使用strerror

   ```
   fputs(strerror(n), stderr);
   ```

### 以字节为单位的I/O函数

+ [ CSlib/fgetc.c ](htpps://github.com/quronghui/LinuxC.git)

1. fgetc(stdin)

   + 从指定的文件中读一个字节
   + fgetc 读到文件末尾时返回EOF ，只是用这个返回值表示已读到文件末尾,并不
     是说每个文件末尾都有一个字节是EOF (根据上面的分析,EOF并不是一个字节)。

2. getchar 从标准输入读一个字节

   + 调用getchar() 相当于调用fgetc(stdin)

   ```
   #include <stdio.h>
   int fgetc(FILE *stream);
   int getchar(void);
   返回值:成功返回读到的字节,出错或者读到文件末尾时返回EOF
   ```

3. fputs 向指定的文件写一个字节

   + 每调用一次fputc ,读写位置向后移动一个字节,因此可以连续多次调用fputc 函数依次写入多个字节

4. putchar(c) 向标准输出写入一个字节

   + 调用putchar，相当于调用fputc( c, stdout )

5. 从终端输入时有两种方法表示文件结束

   + 直接输入 ctrl + D

   + 利用Shell 的Heredoc语法

     + <<END 表示从下一行开始是标准输入,直到某一行开头出现END时结束。
     + << 后面的结束符可以任意指定,不一定得是END ,只要和输入的内容能区分开就行。

     ```
     $ ./a.out <<END
     > hello
     > hey
     > END
     hello
     hey
     ```

### 操作读写位置的函数

1. 三个函数

   ```
   #include <stdio.h>
   int fseek(FILE *stream, long offset, int whence);	//返回值:成功返回0,出错返回-1并设置errno
   long ftell(FILE *stream);	//返回值:成功返回当前读写位置,出错返回-1并设置errno
   void rewind(FILE *stream);	//把读写位置移到文件开头
   ```

2. fseek(FILE *stream, long offset, int whence)

   + offset ：可正可负
     + 负值表示向前(向文件开头的方向)移动,正值表示向后(向文件末尾的方向)移动,
     + 如果向前移动的字节数超过了文件开头则出错返回
     + 如果向后移动的字节数超过了文件末尾,再次写入时将增大文件尺寸,,从原来的文件末尾到fseek 移动之后的读写位置之间的字节都是0.
   + whence ：何时
     + SEEK_SET：从文件开头移动offset个字节
     + SEEK_CUR（current）从当前位置移动offset个字节
     + SEEK_END 从文件末尾移动offset个字节

### 以字符串位单位的I/O函数

1. fgets : 从指定的文件中读一行字符到调用者提供的缓冲区中供的缓冲区中。

   ```
   char *fgets(char *s, int size, FILE *stream); // s--指向buffer;size--读取长度；stream--原始文件
   ```

   + 该函数从stream 所指的文件中读取以'\n'结尾的一行(包括'\n' 在内)存到缓冲区s中
     + 如果文件中的一行太长,fgets 从文件中读了size-1个字符还没有读到'\n' 
     + 则将size-1个字符和‘\0’添加到buffer，剩下的下一次调用
   + 并且在该行末尾添加一个'\0' ，组成完整的字符串。

2. fgets 对于 '\n' 和 '\0'

   + 对于fgets 来说,'\n'是一个特别的字符,而'\0' 并无任何特别之处
   + 如果读到'\0' 就当作普通字符读入。
   + fgets 只适合读文本文件而不适合读二进制文件,

3. fputs : 向指定的文件写入一个字符串,puts向标准输出写入一个字符串。

   ```
   int fputs(const char *s, FILE *stream);
   int puts(const char *s);
   ```

   + 缓冲区s中保存的是以'\0' 结尾的字符串，fputs 将该字符串写入文件stream，但并不写入结尾的'\0'；
   + fputs 并不关心的字符串中的'\n' 字符,字符串中可以有'\n'也可没有'\n'

4. puts将字符串s写到标准输出(不包括结尾的'\0' ),然后自动写一个'\n' 到标准输出。

### 以记录为单位的I/O文件

+ [/CSlib/fread_and_fwrite/](https://github.com/quronghui/LinuxC.git)

1. fread / fwrite

   + 用于读写记录，这里的记录是指一串固定长度的字节,比如一个int、一个结构体或者一个定长数组。

   ```
   size_t fread(void *ptr, size_t size, size_t nmemb, FILE *stream);
   size_t fwrite(const void *ptr, size_t size, size_t nmemb, FILE
   *stream);
   返回值:读或写的记录数,成功时返回的记录数等于nmemb,出错或读到文件末尾时返回
   的记录数小于nmemb,也可能返回0
   ```

   + 该程序生成的recfile 文件是二进制文件而非文本文件,因为其中不仅保存着字符型数据,还保存着整型数据24和28((在od命令的输出中以八进制显示为030和034)

     {% asset_img fread.png %}

2. 注意,直接在文件中读写结构体的程序是不可移植的

   + 结果输出不一定相同
   + 因为不同平台的大小端可能不同(因而对整型数据的存储方式不同)
   + ,结构体的填充方式也可能不同(因而同一个结构体所占的字节数可能不同）

### 格式化的I/O函数

+ 格式化的I/O函数：以特定的格式进行输入和输出
+ printf  and scanf
+ [/IO/print/print.c](https://github.com/quronghui/LinuxC.git)

#### printf

+ 格式化打印到标准输出

1. 关于printf的函数：很多种分类

   {% asset_img print.png %}

2. printf 转换说明的可选项

   + “%#x ” ：指定输出类型是0x 十六进制

     + “ %#X ” : 输出大写字符

   + “-%10d-”： 长度为10，格式化后的内容居左,右边可以留空格。

   + “ %* . *d ”：打印输出的%6.4---长度位6，精度位4

   + “ %hhd ” ：对于整型参数可以指定字长,hh、h 、l 、ll 分别表示char 、short 、long、long long 的字长

   + “ %p ” :  打印main函数的首地址

   + “%f ”:   double型参数格式化，精度=小数点后6位

   + “ %e/E ” : 取double型参数格式化为，转化为指数模式

     {% asset_img printf_e.png %}

   + " %g/G " : 精度指有效数字，默认是6位有效数字，多余的就抹去

   + “%%” ： 格式化输出一个 %

3. printf并不知道实际参数的类型，只能按转换说明指出的参数类型从栈帧上取参数，

4. 所以如果实际参数和转换说明的类型不符,结果可能会有些意外。

#### scanf

1. scanf 从标准输入读字符,按格式化字符串format中的转换说明解释这些字符
   + 转换后赋给后面的参数,后面的参数都是传出参数,因此必须传地址而不能传值。
   + scanf 用输入的字符去匹配，格式化字符串中的字符和转换说明
     + 如果成功匹配一个转换说明,就给一个参数赋值
     + 或者如果遇到和格式化字符串不匹配的地方就停止。

2. scanf的转换字符还得注意一点
   + 对于整型参数可以指定字长,有hh 、h、l、ll(也可以写成一个L),含义和printf相
     同。
   + 但l和L还有一层含义,当转换字符是e、f、g时,
   + 表示赋值参数的类型是float *而非double *这一点跟printf不同,这时前面加上l或L表示double *或long double *型。
3. scanf 字符转换
   + scanf(%d, &i);	// 传的是地址，不能传值
   + “%d”：匹配十进制整数(开头可以有负号),赋值参数的类型是int * 。
   + “% i ”:  匹配整数(开头可以有负号),赋值参数的类型是int * 
     + 以0x或0X开头，则匹配十六进制整数
     + 以0开头则匹配八进制整数
   + “%o , %u, %x”:  匹配无符号八进制、十进制、十六进制整数，赋值参数类型是usigned int *
   + " %c " : 匹配一串字符,字符的个数由宽度指定,缺省宽度是1,赋值参数的类型char *
     + 末尾不会添加'\0' 。
     + 如果输入字符的开头有空白字符,这些空白字符并不被忽略,而是保存到参数中,
     + 要想跳过开头的空白字符,可以在格式化字符串中用一个空格去匹配。
   + "%s":  匹配一串非空白字符
     + 从输入字符中的第一个非空白字符开始匹配到下一个空白字符之前,或者匹配到指定的宽度,赋值参数的类型是char *,
     + 莫为自动添加‘\0’
   + "%e, %f, %g" : 匹配浮点数(开头可以有负号),赋值参数的类型是float *
     + 可以指定double *或long double *的字长。

### C标准库的I/O缓存

1. 用户程序调用C标准I/O库函数读写文件或设备，

   + 库函数要通过系统调用把读写请求传给内核
   + 由内核驱动磁盘或设备完成I/O操作
     + 内核写回设备的操作是Flush操作；
     + 库函数是fflush
     + fclose函数在关闭文件之前也会做Flush操作。

2. 分配一个I/O缓冲区以加速读写操作

   {% asset_img fflush.png %}

3. 缓冲区分为三类

   {% asset_img cash.png %}

   + printf 标准的输出，分配的是行缓冲；
     + 每次遇到 \n ；换行符，便进行flush操作；
     + 写回内核，输入到设备

## 数值字符串转换函数

1. 将一串字符中能识别成某种进制的数，转换为int or double

   ```
   #include <stdlib.h>
   int atoi(const char *nptr);	//  把一个字符串开头可以识别成十进制整数的部分转换成int 型,
   double atof(const char *nptr); // atof 把一个字符串开头可以识别成浮点数的部分转换成double型
   返回值:转换结果
   ```

   + 开头没有可识别的进制数，则返回0

2. strtol and strtod 

   + 能控制识别的进制数（8,10,16）
   + 能区分返回值error and 0

   ```
   long int strtol(const char *nptr, char **endptr, int base);
   double strtod(const char *nptr, char **endptr);
   返回值:转换结果,出错时设置errno
   ```

## 分配内存函数

1. 在堆空间分配内存的函数

   {% asset_img malloc.png %}

2. calloc

   + 分配nmemb 个元素的内存空间,每个元素占size 字节
   + calloc负责把这块内存空间用字节0填充,而malloc 并不负责把分配的内存空间清零。

3. realloc

   + 候用malloc 或calloc分配的内存空间使用了一段时间之后需要改变它的大小
   + 把原内存空间的指针ptr传给realloc,通过参数size 指定新的大小(字节数)
   + realloc返回新内存空间的首地址,并释放原内存空间。

## 综合练习

### 日志文件中添加记录

1. 获取当前的系统时间需要调用time(2)函数,返回的结果是一个time_t 类型；
2. 其实就是一个大整数，其值表示从UTC(Coordinated Universal Time)时间1970年1月1日00:00:00(称为UNIX系统的Epoch时间)到当前时刻的秒数。
3. 然后调用localtime(3)将time_t所表示的UTC时间转换为本地时间(我们是+8区,比UTC多8个小时)并转成struct tm 类型
4. 该类型的各数据成员分别表示年月日时分秒
5. 调用sleep(3) 函数可以指定程序睡眠多少秒。

### INI and XML files

1. INI文件：是Initialization File的缩写，即初始化文件，系统[配置文件](https://baike.baidu.com/item/%E9%85%8D%E7%BD%AE%E6%96%87%E4%BB%B6)所采用的存储格式

   + 文件扩展名：配置文件 . ini
   + 格式：由节，键，值组成
     + 节： [ section ]
     + 键 = 值 ：name = value
   + 注释：注解使用分号表示（;）。在分号后面的文字，直到该行结尾都全部为注解。

   ```
   example：
   	; exp ini file
       [port]
       portname=COM4
       port=4
   ```

2. XML文件：同样是一个配置文件的格式

3. 两者区别

   +  xml,对于描述复杂的数据结构非常的方便，缺点相对ini使用麻烦一点。
     + 而且因为它有比较严格的格式审查机制，容错性也不是特别好,在手写时容易出现错误。
     + 抛开配置的功能，作为存储传输数据的手段，xml还有个缺点就是它的处理和存储的效率非常低下，解析速度慢，占用更多的存储空间。
   + INI ：通常用于对软件的参数进行配置和记录。
     + 优点是使用方便，嵌入程序也容易，几个接口就够了，很容易掌握。
     + 配置文件更小巧，手工配置也更容易。
     + 缺点是它的结构只有2层，对于复杂类型数据描绘就显得比较无力了。
     + 另外ini文件有64kb的大小限制。

4. 转换ini 为xml

   {% asset_img ini.png %}

   {% asset_img xml.png %}