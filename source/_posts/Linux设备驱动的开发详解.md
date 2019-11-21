---

layout: post
title: Linux设备驱动的开发详解
date: 2019-08-24 19:48:34
categories: [driver]
tags: [platfrom]
---

# Linux设备驱动的开发详解

1. 如何学习驱动
   + 驱动的框架 和 代码框架
2. [硬盘镜像下载]( https://pan.baidu.com/s/1huaRl8S) m6a1
3. globalmem、globalfifo等代码目录
   + /home/baohua/develop/training/kernel/drivers
4. [其他相关参考](https://mp.weixin.qq.com/s?__biz=MzAwMDUwNDgxOA==&mid=214353671&idx=1&sn=50d4b64d9a2d7368c99b0e372428c37c&chksm=13d5819a24a2088ca362f1d8b8e66d1e7ceba8ec81a92ce4da4bddbbda1e8fe741c774445c07&mpshare=1&scene=1&srcid=0824KL4iF6nTJfzW12VWBkdW&sharer_sharetime=1566651975360&sharer_shareid=39fc8872838381471f750b646fdbf5e4#rd)

## 设备驱动的概念

1. 设备驱动的作用?

   + 对设备驱动最通俗的解释就是“驱使硬件设备行动”。
   + 驱动与底层硬件直接打交道, 按照硬件设备的具体工作方式,读写设备的寄存器,完成设备的轮询、中断处理、DMA 通信,进行物理内存向虚拟内存的映射等,
   + 最终让 通信设备能收发数据, 让显示设备能显示文字和画面, 让存储设备能记录文件和数据。
2. 设备驱动的分类和特点
   + 驱动的对象: 存储器 + 外设 (包括CPU内部)
3. **Linux 三大设备驱动?**
   + 字符设备: 必须以**串行数据依次**访问的设备
     + 触摸屏, 磁带驱动, 鼠标
   + 块设备: 可以按照**任意顺序**进行访问, 以块为单位(512bytes)访问
     + 硬盘, emmc
   + 网络设备: 面向数据包的接受和发送设计, 并不倾向于文件系统的节点;
     + 使用套接字编程

### 无OS的设备驱动

1. 无操作系统的设备驱动

   + 单任务框架
   + 通过一个无限循环 + 中断检测 / 轮询检测完成 ( 有相应的代码框架)
   + 连接 应用程序 和硬件的桥梁
   + 驱动程序, 需要由**应用软件**直接完成

2. 无操作系统的串口驱动

   {% asset_img no_os_driver.png %}

### 有OS的设备驱动

1. 有OS的设备驱动

   + 需要将驱动融入进内核;
   + 驱动: 操作系统和硬件的桥梁
   + 应用程序只与OS的API打交道

   {% asset_img os_driver.png %}

2. OS 给设备驱动带来了哪些麻烦?

   + 操作系统通过给驱动制造麻烦, 来达到给上层应用提供**便利**的目的
   + 麻烦: 需要按照OS的框架编写驱动代码; 还需要挂载到OS上; 实现驱动和内核接口的代码

### Linux 设备驱动和软硬件的关系

1. Linux对字符和块设备的处理

   +　将其映射为文件和目录;
   +　应用程序通过调用OS的API调用字符设备和块设备

2. 应用程序如何使用硬件设备?

   + 直接使用Linux api进行编程
     + open(), write(), read(), close()
   + 使用C库函数调用Linux的API, 便于代码移植
     + fopen(), fwrite()

   {% asset_img linux_driver.png %}

3. LED驱动
   
   + GPIO寄存器 :控制寄存器和数据寄存器

## 驱动设计的硬件基础

### 处理器

1. 通用处理器
   + 冯·诺依曼结构 : 程序指令存储地址和数据存储地址指向同一个存储器的不同物理位置
   + 哈佛结构: 程序指令和数据分开存储,指令和数据可以有不同的数据宽度
     + 哈佛结构还采用了独立的程序总线和数据总线
   + 指令集划分: RISC 和CISC
2. 数字信号处理器
   + 数字信号处理器(DSP)针对通信、图像、语音和视频处理等领域的算法而设计。
   + 相关矩阵运算等算法中的大量重复乘法。

### 存储器

{% asset_img store.jpg %}

### [总线SerialBus](https://luckywater.top/2019/07/29/SerialBus/)

## Linux 内核及内核编译

### 内核目录的分析

1. **linux 内核目录**
   
   +  arch :包含和硬件体系结构相关的代码,每种平台占一个相应的目录
+ drivers : 设 备 驱 动 程 序, 每 个 不 同 的 驱 动 占 用 一 个 子 目 录
  
2. 内核中目录的总结

   + 内核: drivers 与arch 的软件架构分离, 驱动不包含板级信息, 让驱动跨平台;
   + 内核通用部分和具体硬件剥离

3. **Linux内核的五部分, 之间的依赖关系**

   {% asset_img linux_kernel.png %}

### 内核的编译和加载

1. 内核配置的三个部分

   + Makefile
   + Kconfig: 用户进行配置选择;
   + 配置工具: 命令解释器和配置用的用户界面

   ```
   make menuconfig
   ```

2. 目标代码是否编译的选项

   ```
   obj - y += foo.c	// 将函数编译进内核; 内核编译
   obj - m += foo.c	// 将函数编译成 .ko文件; 模块编译
   obj - n += foo.c	//  函数不变异
   ```

### Linux代码的编译风格

1. GNU C 预定义两个标识符保存: 当前函数名字

   ```
   __func__  
   __PRETTY_FUNCTION__ ;
   $ printf("this funcation name is : %s\n",__func__  );  // 可以代替函数的名字, 打印出来
   ```

2. 宏定义: do{} while(0) 用法

   ```
   #def ine SAFE_FREE(p) do{ free(p); p = NULL;} while(0)
   ```

3. goto 跳转到错误代码

4. arm Linux 工具链

   ```
   arm-linux-gnueabihf-gcc; // 工具链
   armcc 										// 进行编译
   objdump;							// 反汇编
   ```

5. Linux 下串口工具

   ```
   minicom	// 设置其波特率
   ```

## Linux 内核模块的编写

1. 如何将驱动包含入内核中?

   + obj - y : 直接编译进内核
     + 缺点: 造成内核模块太大
   + obj - m : 编译成.ko模块, 
     + 需要的时候, 动态加载到内核; 

2. 驱动代码的编写(按照内核框架) -- >  编译成模块 -- > 加载到内核中 -- > 卸载模块  

   ```
   $ insmod  hello.ko  // 模块加载函数 , 只加载hello.ko模块;
   $ modprobe  -r hello.ko	// 模块加载函数,  将加载hello.ko 依赖的所有模块;
   
   $ rmmod hello.ko		// 模块卸载函数 , 只卸载hello.ko模块;
   
   $ lsmod 				// 查询模块之间的依赖关系;  == cat /proc/modules
   $modinfo hello.ko	// 得到模块相关参数信息
   ```

3. Linux内核中的**打印函数**

   ```
   printk(KERN_INFO "hello world\n");		// 使用printk进行打印
   ```

4. 相关的信息, 通过查看内核日志得到内核输出

   ```
   $ vim  /var/log/messages
   ```

### Linux内核模块程序结构

1. 模块**加载**函数:

   ```
   static int __int initialization_funcation(void)		// __init : 模块加载函数的声明
   {
   }
   module_init(initialization_funcation);					// 模块函数通过这样的方式进行指定; 使用这个函数的方法
   ```

2. 模块**卸载**函数

   ```
   static int __exit  cleanup_funcation(void)		// __exit : 模块卸载函数的声明
   {
   }
   module_init(cleanup_funcation);					// 模块函数通过这样的方式进行指定; 使用这个函数的方法
   ```

3. **模块的参数**

   ```
   module_param(参数名, 参数类型, 参数读写权限);		// 定义一个模块参数声明
   ```

   + 在/sys 目录下, 查看模块参数

4. 导出符号

   + linux的 /proc/kallsyms 文件对应着内核符号表

   ```
   EXPORT_SYMBOL(符号名)
   EXPORT_SYMBOL_GPL(符号名)
   ```

5. 模块的声明和描述

   + 表明模块的作者, 版本号, 设备号, **模块支持的所有设备**

   ```
   MODULE_DEVICE_TABLE(table_info)		//对于支持USB, PCI的设备:  表示模块支持的设备
   ```

## Linux文件系统和设备文件

1. linux : 一切都是文件 -- 设备即文件;

2. 设备驱动是如何被访问的?

   - 通过与文件操作相关的**系统调用或C库函数**(本质也是系统调用)被访问
   - 设备驱动结构: 为了迎合应用程序而设计的API;

3. 文件的属性

   + 文件打开的标志 : 

   + 文件的权限 : 分三类用户

     ```
     mode + umask  : 一起决定文件的权限
     umask: 只影响 r w x 
     ```

   + Linux 文件的权限通过5个数字表示

     ```
     { [用户ID](0/1) ;  [组ID](0/1); [读权限](3bit的八进制数);  [写权限]; [执行权限]}
     1 0 705;  用户组权限; 文件所有者rwx; 文件组0; 其他用户rx;
     ```

### 系统调用和C库函数的文件操作

| 区别           | 系统调用                     | C库函数调用                           |
| -------------- | ---------------------------- | ------------------------------------- |
| 文件操作函数   | 全是 int型                   | 存在不同的类型                        |
| 文件的打开标志 | O_EDONLY (以大写O开头)       | r / w / a(追加)                       |
| 文件的权限     | S_IRUSR(以S_I开头)           |                                       |
| 操作的数据类型 | int                          | 字符和字符串                          |
| 推荐使用       |                              | 便于移植                              |
| 与驱动关系     | 应用程序 -- 系统调用 -- 驱动 | 应用程序 -- C库 -- 系统调用 -- 驱动   |
|                |                              | C库函数使用时, 内部包含了系统调用函数 |

1. 系统调用: 文件操作

   ```
   int	create(const char *filename,  mode_t mode);		// 创建, 由mode + umask决定权限; 
   int	open(const char *filename,  int flag, mode_t mode);		// 打开文件,  存在打开标志和打开权限;  返回 int fd;
   int read(int fd, const void *buf, size_t length);			// 读buf; 返回实际读出来的字节数	
   int write(int fd, const void *buf, size_t length);			// 写buf; 返回实际写入的字节数	
   int close(int fd);																		//  关闭;
   int lseek (int fd, offset_t offset, int whence);			// 文件读写时的相对位置;  offset,偏移量, 可取负值; whence: 相对位置
   ```

2. **C库函数的文件操作**

   + 推荐使用库函数进行操作, 方便移植;  
   + 实现字符流的操作;

   ```
   FILE *fopen(const char *path,  const char *mode);	// 文件打开, mode为打开标志
   int close (File *stream);	
   ```

   + 读写: 以字符 和 字符串为单位进行读写; **可以实现从流中读取n个字段**

     ```
      int fgetc(FILE *stream);
      char *fgets(char *s, int size, FILE *stream);			// 类型比较特殊, 为char*
     int fputc(int c, FILE *stream);
     int fputs(const char *s, FILE *stream);
     
     int fprintf(FILE *stream, const char *format, ...);	// 用法不太会
     int fscanf(FILE *stream, const char *format, ...);	
     
     size_t fread(void *ptr, size_t size, size_t nmemb, FILE *stream);
     size_t fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream);
     ```

   + 定位功能

     ```
     int fseek(FILE *stream, long offset, int whence);
     int fgetpos(FILE *stream, fpos_t *pos);
     int fsetpos(FILE *stream, const fpos_t *pos);
     ```

### linux文件系统

#### linxu 文件系统目录结构

1. /proc 目录
   + 进行以及内核信息(包括PCU, 硬盘, 内存信息)存放的位置;
   + **伪**文件系统, 存在与内存之中
   + 包含进程和线程的相关信息
2. /var
   + /var/log 存放系统日志
3. **/sys**
   + 内核支持的**文件系统**映射到此目录上;
   + linux设备驱动模型中的总线, 设备, 驱动; 在sysfs文件系统中找到对应的节点;

#### 虚拟文件系统和设备驱动的关系

{% asset_img vfs_driver.png %}

### 结构体 : file and inode

| 设备驱动的两个模块 | 包含内容                                                | 目录查看      |
| ------------------ | ------------------------------------------------------- | ------------- |
| file               | private data                                            |               |
| inode              | i_cdev : 记录设备号 (32bit) ;  主(12bit)次设备号(20bit) | /proc/devices |
|                    | 块设备 : block_device ; 字符设备: i_cdev                |               |

1. struct file

   + 在内核打开文件时创建, 并传递给在文件上进行操作的任何函数, 在文件的所有实例关闭后, 释放这个结构体;
   +  命名: file or filp(file pointer)
   + **private data: ** 私有数据在设备驱动中广泛使用;

2. struct inode : 元数据

   +  **Linux 管理文件的最基本单位**
   + 文件系统连接子目录的桥梁

3. inode 中的设备号的获取

   ```
   unsigned int iminor(struct inode *innode);		// 主设备号的获取;  minor -- 表示位数较少
   unsigned int imajor(struct inode *innode);		// 次设备号的获取; major --  位数较多
   ```

### devfs and udev

| devfs                  | udev                               |
| ---------------------- | ---------------------------------- |
| 设备文件系统           | 用户空间设备管理                   |
| 策略包含在内核中(受限) | 策略: 处于用户空间; 内核只提供机制 |

1. 模型抽象

   + devfs : 内核不仅要提供恋爱的机制, 还需要规定和谁恋爱
   + udev: 内核只提供恋爱的机制, 和谁谈恋爱由用户决定

2. udev的工作原理

   + 利用设备加入和移除时**内核所通过netlink套接字, 发出的热插拔式事件uevent**来工作;

3. udev 如何处理设备的热插拔和冷插拔?

   

   | 热插拔                                                 | 冷插拔                                             |
   | ------------------------------------------------------ | -------------------------------------------------- |
   | udev 已经启动, 才插入设备                              | udev还未启动                                       |
   | 设备信息由内核, 通过netlink套接字发送, 叫做**uevent**; | 内核提供的sysfs下面的uevent节点, 给该节点写一个add |
   | udev从内核收到的信息来进行创建设备文件节点;            | 导致内核**重新发送**netlink; udev启动后就可以处理  |

### sysfs文件系统

1. sysfs文件系统的特点

   + 虚拟文件系统;
   + 将连接在系统上的**设备和总线**组织成为一个分级的文件
   + 目录: 来源于bus_type  ; device   ;  device_driver
   + 文件: 来源于具体的attribute

   ```
   $ dump		//打印出总线, 设备和驱动信息;
   ```

2. /sys/bus/pci

   + 在划分出drivers 和devices目录

3. Linux内核中描述**总线, 设备, 驱动**的三个结构体

   + bus_type  ; device   ;  device_driver
   + 模型抽象:  红尘中的男女+月老
     + **设备和驱动分开注册;  **
     + bus_type: match()进行匹配, 匹配成功后, xxx_driver的probe()被执行

4. attribute属性文件

   + 伴随着show()和store()函数, 分别用于读写该attribute对应的sysfs文件

## 字符设备驱动

1. Linux字符设备驱动的关键数据结构
   + cdev: 设备号的注册注销
   + file_operations结构体:  文件操作具体功能函数
2. globalmem 虚拟字符设备驱动的编写方法
   + 读写函数, seek()函数和I/O控制函数;
   + 私有数据的作用;

### Linux字符设备驱动

```
struct cdev{
	struct file_operations	*ops	;	//文件操作的结构体
	dev_t	dev;										// 设备号
};
```

1. cdev结构体的操作函数

   + **__init ：标志模块的加载**
   + **__exit：标识模块的卸载**

   ```
   void cdev_init( struct cdev *cdev, struct file_operations *ops );	// 初始化cdev成员, 建立cdev和file_operations之间连接
   struct cdev *cdev_alloc(void);									// 动态申请cdev的内存
   int cdev_add(struct cdev *, dev_t , unsigned );		// 字符设备的注册
   void cdev_del(struct cdev *);										//  字符设备的注销
   ```

2. cdev分配和释放设备号

   ```
   (1)在cdev_add()之前, 先调用函数, 向系统申请设备号;
   		register_chrdev_region();	// 申请自己知道的设备号
   		alloc_chrdev_region();			// 设备号未知,动态申请
   (2) 在cdev_del()之后, 调用函数
   		unregister_chrdev_region(); 		//释放设备号
   ```

3. file_operations文件操作结构体

   + 使用的是**函数指针**

   + 三个操作

     ```
     ssize_t xxx_read();		// 用户空间和内核之间的读写; copy_to_user()
     ssize_t xxx_write();	// copy_from_user
     ssize_t xxx_ioctl();
     ```

   + 用户空间 -- 内核空间  的读写

     +  **access_ok();			// 检测用户控件缓存区的合法性, 才能进行读写;**
     
     ```
      copy_to_user();	// 内核空间到用户空间缓存区的复制
      copy_from_user();	//用户空间到内核空间的复制
     
     ```

### globalmem()虚拟设备驱动

1. globalmem字符设备驱动会分配一片大小为GLOABLEMEM_SIZE(4KB)的**内存空间**

   + **mem[]数组空间：与用户空间进行数据交换**

   + **虚拟字符设备：不仅有cdev ,也有了内存空间、**

   + **私有数据：使得驱动改动小量代码，实现多个设备的支持**

     ```
     container_of()	;		// 通过结构体成员的指针找到对应结构体的指针
     ```

2. globalmem()的结构体

   ```
   struct globalmem_dev{
   	struct cdev cdev;
   	unsigned char mem[GLOABLEMEM_SIZE];
   }
   ```

3. globalmem中模块的加载和释放函数

   + 和linux设备驱动中的一样

4. globalmem文件的操作

   + 使得设备结构体中的mem[]数组 -- > 用户控件交互数据

   ```
   static ssizet_t globalmeme_read();			//读数据
   static ssizet_t globalmeme_write();			// 写数据
   static ssizet_t globalmeme_llseek();		// 数据偏移
   static ssizet_t globalmeme_ioctl();			// I / O控制函数
   ```

5. 私有数据的使用

   ```
   int global_open();		// 进行私有数据的设置
   {
   	file->private_data	=	globalmem_devp;		// 私有数据先设置, 后使用;
   }
   ```

   + 使用私有数据后, 就可以实现同时包含多个设备; 但是只使用一套文件操作函数;

6. globalmem模块的查看

   ```
   $ cat /proc/devices		// 查看字符设备的驱动
   $  mknod /dev/globalmem  c 230 0 	//创建设备节点;  主设备号 和次设备号;
   ```


## Linux设备驱动中的并发控制

1. linux设备驱动中必须解决的一个问题?
   + 多个进程对共享资源的并发访问, 并发的访问会导致竞态;
2. 两组概念
   + 并发和竞态
   + 自旋锁和互斥体

### 设备驱动中的并发

1. 并发和竞态的概念?
   + 并发: 多个执行单元同时, 并行被执行;
   + 竞态: 并发的执行单元对共享资源的访问, 导致了竞态的发生;
2. linux驱动中竞态问题的产生原因?
   + 多处理器SMP的多个CPU
   + 单CPU的进程抢 
   + 中断发生(默认不进行中断嵌套)

### 解决并发和竞态

1. Linux中为何会存在编译乱序?
   + **编译器**的行为: 对内存访问时, 为了**提高**cache的**命中率**和CPU的Load/Store单元的工作效率;
   + 再发开编译器优化时, 汇编代码并没有严格按照代码的逻辑顺序;
2. Linux中执行乱序?
   + **处理器运行的行为**: CPU执行的时候是乱序执行的, 但是这一个乱序对于单核的程序是**不可见**的, 当碰到**依赖点**(需要后面指令结果)时会**等待**;
3. 解决互斥的方法?
   + 中断屏蔽(中断屏蔽指令): 很少单独使用
   +  原子操作: 只能针对整数进行;
   + 自旋锁和互斥体: 应用的最广泛;

### 自旋锁和互斥体 

| 区别        | 自旋锁                        | 互斥体                                     |
| ----------- | ----------------------------- | ------------------------------------------ |
| 锁被占用时  | 自旋等待的时间                | 上下文切换的时间                           |
| 阻塞/非阻塞 | 非阻塞访问的内存区            | **进程级:** 多个进程对资源的互斥; 阻塞访问 |
| 应用        | 访问时间较短;中断和软中断情况 | 访问时间较长, 存在**上下文切换;**          |

### gobalmem增加并发

1. gobalmem 只能使用互斥体, 不能使用自旋锁

   ```
   copy_from_user()
   copy_to_user()
   ```

   + 导致阻塞的函数存在, 只能使用互斥体;	

## Linux设备驱动中阻塞和非阻塞I/O

| 实现         | 阻塞                         | 非阻塞                    |
| ------------ | ---------------------------- | ------------------------- |
| 方法         | **等待队列**中进行进程的唤醒 | 轮训函数实现              |
| 实现函数     | sleep_on(); wake_up()        | poll(); select(); epoll() |
| 虚拟字符设备 | globalfifo()                 |                           |

1. 非阻塞方式中的poll函数?
   + 设别驱动中的poll()函数不会阻塞;
   + 但是与  poll(); select(); epoll()相关的系统调用会阻塞的等待至少一个文件描述集合可访问或超时;

## Linux设备驱动中的异步通知与异步IO

### 异步通知

1. 设备驱动: 异步通知的概念

   + 一旦设备**就绪**, 则**主动通知**应用程序, 这样应用程序就不用查询设备的状态; 
   + 机制: 信号驱动的异步I/O;
   + 信号: 在**软件层**次上对中断机制的模拟, 信号是异步的;
     + 一个**进程**收到一个**信号**, 与**处理器**收到一个**中断请求**可以说是一样的; 

2. 进程能捕获的SIGIO信号?

   + 除了SIGSTOP和SIGKILL两个信号外, 进程能够忽略或捕获其他的全部信号;

3. **设备驱动与用户程序之间的异步通知**

   + 用户空间: 设置文件的拥有者(设置进程) , FASYNC标志(检查信号的变更), 捕获信号
   + 内核空间: 响应文件的拥有者,  FASYNC标志的设置, 资源可获得时**释放信号**

   {% asset_img signal_async.png %}

4. 在globalfifo驱动中增加异步通知

   ```
   用户空间
   	fcntl();	设置文件的拥有者, 设置FASYNC变更机制
   	signal();	捕获信号
   设备驱动: 
   int fasync_helper();	 // 处理FASYNC标志变更的函数;
   void kill_fasync();			// 释放信号量;
   ```

### Linux的异步IO

1. Linux常用的输入/输出模型

   + 同步IO(Synchronization): 当请求发出之后, 应用程序就会**阻塞**, 直到请求满足为止;
   + **AIO**异步IO(Asynchronous ): 应用程序发起IO请求后, 直接执行, 并不等待IO结束
     + 过一段时间查询之前的IO请求完成的情况;
     + IO请求完成后会自动调用与IO完成绑定的**回调函数**;

   {% asset_img asynchronous_io.png %}

### glibc 提供一个不依赖于内核完成的AIO

1. glibc中包括的函数

   ```
   aio_read();
   aio_write();
   aio_error();	//确定请求状态;
   aio_return();	//异步IO需要调用该函数, 实现返回值的读取;
   ```

2. 本质: 借用了多线程模型,新的AIO线程与发起AIO的线程通过pthread_cond_signal(), 实现线程间的同步

### 内核空间实现AIO

1. libaio实现异步AIO的优点?

   + AIO可以**一次性**发出大量的read/write调用, 并且通过通用层的**IO调度**获取更好的性能;
   + 用户程序可以减少过多的同步负载(多线程同步)

2. 内核空间实现的机制

   ```
   io_submit();		//AIO的请求都用io_submit进行下发;
   gcc aior.c -o aior -laio;	// 加上laio的库进行编译
   ```

3. AIO与设备驱动

   + 用户空间调用io_submit()后, 生成一个iocb结构
   + 内核对应生成与之对应的: kiocb结构;

## 中断和时钟

1. Linux中断中引入顶半部和底半部分离的机制?
   + ISR的执行并不存在于进程的上下文切换中, 要求ISR要尽可能短;
2. 底半部执行的方法?

### 中断的分类

1. 根据中断的来源?
   + 内部中断: 来自于CPU内部(软件中断指令, 溢出, 出发错误);
     + OS从用户态切换到内核态: 借助cpu内部的软件中断
   + 外部中断: 来自于CPU的外设请求;
2. 中断是否可屏蔽?
   + 内部中断: 不能屏蔽
   + 外部中断: 可屏蔽
3. 中断入口的跳转方法不同?
   + 向量中断: CPU为不同的中断分配不同的中断号, 当检测到某个中断到来后, 自动跳转到对应中断号的地址执行;
     + 不同的中断号有不同的**入口地址** 
   + 非向量中断:  多个中断共享一个中断入口地址, 在软件内部判断中断号
4. 嵌入式系统和 X86中的中断? 
   + PIC(program interrupt control): 可编程中断控制器;
   + MASK寄存器:  中断屏蔽;  PEND寄存器: 中断使能;
5. ARM多处理器常用的中断?
   + GIC(Generic interrupt control): 通用中断控制器
   + 支持三种中断
     + SGI(software generated interrupt): 软件产生的中断, 用于多核间通信;
     + PPI(private peripheral interrupt): 某个CPU的私有的外设中断, 只能发给特定的CPU
     + SPI(Shared peripheral interrupt): 共享外设中断; 中断从CPU0产生, 将中断设定到CPUi上;

### Linux 中断编程

1. 中断申请

   ```
   request_irq();  free_irq();		// 内核提供的函数
   devm_request_irq();				// devm开头的API申请的是内核"managed"资源, 一般不需要显示释放
   ```

2. 中断屏蔽和使能

   ```
   void disable_irq(int irq);		// 等待目前的中断处理完成;
   void disable_irq_nosync(int irq);	// 立即返回;
   void enable_irq(int irq);			// 中断使能
   
   #define_local_irq_save(flags);		// 禁止所有中断, 保存状态到flag中    #define_local_irq_restore(flags)
   void local_irq_disable(void);		// 禁止所有中断, 且不保存状态				# void local_irq_enable(void)
   ```

3. **底半步机制实现**

   + tasklet

     + 执行上下文方法: 是软中断, 执行时机通常是**中断顶部返回**

     + ```
       tasklet_schedule();	// 进行调度
       ```

   + 工作队列

     + 执行上下文方法: 内核线程, 可以进行调度和睡眠;

     + ```
       INIT_WORK();				//将工作队列和处理函数绑定
       schedule_work();		// 工作队列的调度
       ```

     + cmwq(Concurrency-managed woekqueues): cmwq维护了工作队列的线程池, 以提高并发性

   + 软中断

     + 和tasklet一样运行与中断上下文, 属于原子上下文的一种, 不允许睡眠

### 内核定时器

1. 软件意义上的定时器: 

   + 最终依赖于**硬件定时器**实现, 在内核时钟中断发生后检测各**定时器是否到期**, 到期后的定时器处理函数将作为**软中断**在底半部执行;

2. Linux内核中提供**一组函数和数据结构**来完成定时处罚工作或者完成某周期性的事务;

   ```
   time_list()；	  // 定时器的结构体，设置到期时间 
   ```

3. 定时器的到期时间

   ```
   jiffies + Hz;		// jiffies 表示定时时间; Hz  表示1s; 
   ```

4. **内核中的延时**

   + 忙等待: ndelay(), mdelay() 配合硬件上短延时;
   + 睡眠等待: msleep()对应于时间精度要求不高的延时;

## 内存与I/O访问

1. 内存空间和I/O空间的访问
   + I/O空间: 通过两个指令-- in/out
   + 内存空间: 地址和指针;

### MMU

1. MMU: 内存管理单元, 实现虚拟地址和物理地址的快速转换;

   + TLB: MMU的核心部件, 他缓存少量的虚拟地址与物理地址的转换关系, 式转换表cache;

   + TTW(translation table walk): 转换漫游表
     + 当TLB中没有缓冲对应的地址转换关系时, 需要通过内存中的转换表访问得到VA-PA的对应关系
     + TTW成功后, 将结果添加到TLB中

2. Linux中与硬件无关的四级页表目录

   + PGD, PUD, PMD, PTE

### Linux内存管理

1. 分为用户空间(0-3G)和内存空间(3G-4G)

   + 每个进程的**用户空间**是完全独立, 互不干涉的, 用户进程各自有不同的页表.
   + 内存空间: 有内核负责映射, 不会跟着进程改变, 是固定的;内核空间的虚拟地址到物理地址的映射被所有进程共享;

2. 内核地址空间, 由低地址 -- 高地址

   {% asset_img kernel_memory.png %}

3. 内存存取

   + 用户空间动态分配内存

     ```
     malloc(), free(); 		// 内存申请和释放
     malloc() 实现的机制:  通过brk() 和 mmap()两个系统调用从内核申请内存
     ```

   + 内核空间动态分配内存

     | kmalloc()    | __get_free_pages() | vmalloc()      |
     | ------------ | ------------------ | -------------- |
     | 阻塞等待;    | 非阻塞             |                |
     | 分配页的大小 | 2^n页进行分配      |                |
     | 物理空间连续 | 物理空间连续       | 物理空间不连续 |

### DMA (Direct memory Access)编程

1. DMA属于内核空间的一块区域, 16MB以下的空间;

2. DMA造成**Cache缓存一致性问题**?

   + Cache:  被作用于CPU对内存的缓存, 提高TLB的命中率, 从而避免CPU每次都必须要与相对慢速的内存交互数据来提高数据的访问速率;
   + DMA: 作为**内存**与**外设**之间传输数据的方式, 不需要cpu的参与;
   + 缓存一致性问题:  当DMA内存地址和Cache内存地址访问有**重叠**, 经过DMA操作后数据发生改变, 而CPU并不知道, 认为Cache中的数据就是内存中的数据, 当使用Cache映射内存时, 用的任然是陈旧的数据. 

   ```
   dma_alloc_coherent();	// 对于DMA缓冲, 使用其申请空间
   ```

3. 驱动中出现缓存一致性问题

   + Cache与内存不一致错误, 导致驱动无法正常运行;

4. DMA的三个概念

   + 基于DMA硬件使用的是总线地址, 而非物理地址

   | 总线地址                   | 物理地址                | 虚拟地址        |
   | -------------------------- | ----------------------- | --------------- |
   | 从设备的角度看到的内存地址 | 从CPU,MMU看到的内存地址 | CPU核看到的地址 |
   | 通过总线: 连接芯片         | VA---PA的映射机制       |                 |

## Linux设备驱动的软件架构思想

1. 软件架构思想:

   + 将设备端的信息从驱动中分离出来
   + 设备 和 驱动分离的思想
     + cdev  和 file_operation : 进行分离

2. Linux设备和驱动挂载到同一种总线上?

   + 对于PCI, USB, IIC, SPI 等总线, 其设备和驱动直接按照对应的总线框架编写驱动
   + 对于独立的外设: Linux使用一种虚拟总线platform;

3. platform虚拟总线

   + bus_type:  结构体中的match() 函数匹配设备和驱动;
   + platform_device: 设备注册
   + platform_driver:  驱动注册,  结构体中的probe()函数用于绑定驱动和总线

4. **如何将globalfifo字符设备, 驱动挂载到platform虚拟总线上?**

   1. 将globalfifo移植为platform驱动;
   2. 在板文件中添加globalfifo这个platform_device

5. **设备驱动分层思想**

   {% asset_img core_driver.png %}

6. 实例: SPI中实现主机驱动和外设驱动分离的思想?

# Linux块设备和网络设备

## Linux 字符设备, 块设备, 网络设备驱动的区别

| 区别         | 字符设备                  | 块设备                       |
| ------------ | ------------------------- | ---------------------------- |
| 数据传输单位 | 字节为单位                | 块为单位 --  block(512bytes) |
| 有无缓冲区   | 无须缓冲且直接读写        | 有I/O缓冲                    |
| 访问顺序     | 顺序读写                  | 随机读写, 读取不同的扇区     |
| 设备         | 鼠标, 键盘...(大多数设备) | 存储设备                     |
| Linux目录    | /dev  一切皆文件          | /dev  一切皆文件             |

## 块设备驱动的结构体

1. block_device_operations 文件操作结构体
   + 类似于file_operations;
   + 但是没有读写相关的函数, 只有打开, 释放, 控制 函数
2. gendisk 磁盘设备结构体
   + 使用gendisk(通用磁盘)结构体表示一个独立的磁盘设备(或分区)

### 块设备的I/O操作

1. bio, request, request_queue 结构体

   + bio: (block IO), 对应上层传递给块层的I/O请求;

   {% asset_img block_io.jpg %}

2. 块设备的I/O操作中:

   + 贯穿始终的就是"**请求**";
   + 块设备的I/O操作会排队和整合;

3. **I/O调度算法, 为了完成请求的合并.**

   + 一个请求: 可以包含多个I/O

     | I/O调度器             | 作用                                                         |
     | --------------------- | ------------------------------------------------------------ |
     | Noop                  | 实现简单的FIFO队列, 进行基本的**合并**, 适合基于flash存储器  |
     | Anticipatory (预期的) | 推迟I/O请求, 等待更多I/O请求, 进行排序                       |
     | Deadline              | 将每次请求延迟降到最低, 使用轮训调度器; 适用于读取较多的环境 |
     | CFQ                   | 为所有任务分配均匀的I/O带宽                                  |

### 块设备驱动的任务

1. 驱动的任务是处理请求, 队请求的排队和整合由I/O调度算法解决;
2. **块设备驱动的核心**
   + 请求处理函数: 需要请求队列的支持, 实现块设备的随机访问
   + 制造请求: 设备本身支持正真的随机访问

## Linux网络设备驱动

1. 网络设备驱动的作用?
   + 完成用户数据包在**网络媒介上**发送和接受的设备, 他将上层协议传递下来的数据包以特定的媒介访问控制方式进行**发送**, 并将接收到的数据包**传递**给上层协议
   + **数据包**向下为发送, 向上为传递

### 网络设备驱动的四层结构

1. Linux层次化设计的作用?

   + 实现了对上层协议接口的统一
   + 硬件驱动对下层多样化硬件设备的可适应性;

   {% asset_img netdev.jpg %}

2. 四层结构的作用?

   | 四层结构       | 作用                                                         | 特殊数据结构        |
   | -------------- | ------------------------------------------------------------ | ------------------- |
   | 网络协议接口层 | 通过**两个函数**实现数据的接受和发送                         | sk_buffer  (socket) |
   | 网络设备接口层 | 为万千设备**定义**统一, 抽象的数据结构体 net_device          | net_device          |
   | 设备驱动功能层 | **填充**net_device具体成员, **注册**net_device实现**操作函数与内核**的挂接 |                     |
   | 网络设备和媒介 | 完成数据包接受和发送的**物理实体**                           | 网络适配器          |

### sk_buffer 结构体

1. sk_buffer 的作用?

   + 用于Linux网络子系统各层之间传递数据, 是所有数据流动的**载体**

2. struct sk_buffer

   + head 和 end: 指向缓冲区的头部和尾部
   + data 和 tail : 指向数据的头部和尾部

   {% asset_img socket_buffer.jpg %}

3. Linux套接字缓冲区支持分配, 释放, 变更的**函数**

   + Linux内核中使用的函数

     ```
     struct sk_buffer *alloc_skb();							// 分配一个套接字缓冲区和数据缓冲区
     void	kfree_skb(struct sk_buffer *skb);	//释放一个套接字缓冲区和数据缓冲区
     unsigned char *skb_put();							// 在缓冲区尾部添加数据
     ```

   + 设备驱动中使用的函数

     ```
     struct sk_buffer *dev_alloc_skb();							// 分配一个套接字缓冲区和数据缓冲区
     void	dev_kfree_skb(struct sk_buffer *skb);	//释放一个套接字缓冲区和数据缓冲区
     unsigned char *skb_push();							// 在缓冲区尾部添加数据
     ```

### net_device结构体

1. net_device的作用?
   + 包含网络设备的属性和操作函数;
   + open() , ioctl()
2. 设备驱动中的数据包接收?
   + 网络设备驱动: 以**中断**方式接收数据包
   + poll_controller(): 采用轮询方式;
   + NAPI(new API):
     + 接收中断来临 -- 关闭接收中断 -- 以轮询方式接受所有数据包直到为空 -- 开启接收中断 ....

### 网络设备驱动的注册与注销

1. 使用的函数

   ```
   register_netdev()	;	// 网络设备的注册函数
   register_netdev()	;	// 网络设备的注销函数
   ```

### 网络设备

1. 网络设备的初始化

   + 探测网络设备是否存在, 存在则检测设备所用的硬件资源
   + 软件接口: 分配net_device结构体对其数据和函数指正成员赋值
   + 获得设备的私有信息指针并初始化各成员的值;

2. 网络设备的打开和释放

   {% asset_img net_device_open_realease.png %}

3. 数据发送流程

   {% asset_img data_transform.png %}

4. 数据接受流程

   + 主要有**中断**引发设备的中断处理函数;

   {% asset_img data_receive.png %}

5. 网络连接状态

   + 网络适配器硬件电路可以检测链路上是否有载波;
   + 载波反映了网络的连接是否正常;

### DM9000网卡设备驱动

1. DM9000一般挂在外面的内存总线上;      

# I2C、SPI、USB驱动

1. Linux的理念

   + 将主机端驱动和外设端分离，通过一个核心层将某种总线的协议进行抽象；

   {% asset_img iic_struct.jpg %}

2. **热插拔能力的总线**

   + I2C和SPI不具备热插拔能力，所有会有板级信息的描述；
   + USB和PCI总线，具有热插拔能力，没有板级信息的描述；当存在USB设备插入后，linux子系统会自动探测；

## Linux I2C驱动

### I2C驱动体系结构由三部分组成

+ ```
  tree /sys/bus/i2c/		// 在sysfs文件系统下，查看i2c设备
  ```

1. I2C核心 ：

   + 是I2C总线驱动和设备驱动**中间枢纽**，提供注册和注销方法，实现I2C的**通信**（Algorithm);
   + 它以通用的、与平台无关的接口，实现I2C中设备与**I2C适配器**(adapter)的沟通；

2. I2C总线驱动

   + 对I2C硬件体系结构中**适配器**端的**实现**

   + I2C总线驱动**填充**：i2c_adapter和i2c_algorithm结构体

     ```
     （1）struct  	i2c_adapter 	and 	i2c_algorithm
     （2）控制i2c_adapter产生通信信号的函数
     ```

3. I2C设备驱动（客户驱动）

   + 对I2C硬件提示西结构中设备端的实现；
   + I2C设备驱动**填充**：i2c_driver和i2c_client结构体；

### I2C四个结构体的关系

1. 适配器和通信

   

   | 结构体关系 | i2c_adapter                         | i2c_algorithm                                                |
   | ---------- | ----------------------------------- | ------------------------------------------------------------ |
   | 各自作用   | 对应物理上的一个适配器              | 对应一套通信方法                                             |
   | 函数       |                                     | master_xfer()产生I2c访问周期需要的信号，<br />以i2c_msg为单位 |
   | **关系**   | 适配器需要i2c_algorithm产生通信时序 |                                                              |

2. 驱动和客户端

   

   | 结构体关系 | i2c_driver                            | i2c_client                  |
   | ---------- | ------------------------------------- | --------------------------- |
   | 各自作用   | 对应一套驱动方法                      | 对应真实的物理设备          |
   | 函数       | probe(), remove(), supend(), resume() | BSP板级信息：i2c_board_info |
   | **关系**   | 一个驱动支持多个物理设备；一对多      |                             |

3. 适配器和客户端

   + 一个适配器：可以被多个client依附；

### 总线如何实现设备和驱动的绑定

1. i2c_bus的函数match()函数检测到device和device_driver匹配时，就会调用driver里的probe()函数，完成初始化适配器硬件，申请适配器需要的内存，时钟，中断等资源，最终完成适配器的注册；

## USB驱动

### USB驱动框架：分主机侧和设备侧

1. USB主机侧角度

   

   | USB主机侧的模块       | 作用                               | 结构体             |
   | --------------------- | ---------------------------------- | ------------------ |
   | USB主机控制器驱动程序 | 控制插入其中的USB设备              | usb_hcd; hc_driver |
   | USB设备驱动程序       | 控制设备如何作为从设备与主机通信； | usb_driver         |

   + USB核心（API）：通过定义一些数据结构和宏，功能函数；向上提供接口，向下提供编程框架；维护USB设备通信；

2. USB从机角度

   + UDC设备控制器：关心底层的硬件操作；
   + Funcation驱动：利用通用的API，通过usb_request与底层UDC驱动交互；

​	{% asset_img usb_bus.jpg %}

 	3. USB设备逻辑包含
     + 设备、配置、接口、端点四个层次
     + 每个设备提供不同级别的配置信息，不同配置体现不同的功能；
     + 一个配置由多个接口组成；
     + 一个接口由多个端点组成；

### URB 中断的生命周期

1. 通常包含创建，初始化，提交和被USB核心级USB主机传递，完成后回调函数被调用的过程；

# ARM Linux 设备树

1. 板级代码信息的描述

   + 对于内核来说，板级代码信息的描述是不需要存在的

   ```
   arch/arm/plat-xxx;		// 这两个目录下存在着描述信息
   arch/arm/mach-xxx;
   platform_device, i2c_board_info, spi_board_info
   ```

2. 设备树的特点

   + 描述**硬件**的数据结构
   + 设备树被命名：节点（可包含子节点）和属性（名称和值）
   + 设备树可以将硬件的细节直接传递给Linux，无需在内核中进行大量的冗余编程；

3. 通过设备树**替代**用于注册的板级代码，驱动也以新的方式与.dts中定义的设备节点进行匹配；

## 设备树的传递和展开

+ Bootloader 在启动时，会将设备树.dtb的入口地址传递给内核，内核会将其进行展开出linux内核中的platform_device,i2c_client, spi_device等设备
+ 设备用到的内存，IRQ等资源，也被传递给了内核，内核会将这些资源绑定给展开的相应设备；

## 设备树的组成和结构

| 结构描述                  | 描述                                                         |
| ------------------------- | ------------------------------------------------------------ |
| DTS                       | 文件.dts是一位种**ASCII**文本格式的设备树描述;<br />.dtsi：dts中的公共部分，类似于.h文件；(.dts包含.dtsi) |
| DTC(device tree compiler) | 是一个工具，将 .dts(ascii文本)  -- 编译为 -- dtb(二进制文件) |
| DTB(device tree binary)   | 是.dts被DTC工具编译后的二进制格式的设备树描述                |
| 绑定(Binding)             | 对于设备树中的节点和属性，如何描述设备的硬件细节，需要.txt文档 |
| Bootloader                | Uboot运行 fdt addr命令设置 **.dtb**的地址                    |

# Linux内核移植

1. 移植Linux到全新的SMP Soc上需要底层硬件提供
   + 定时器节拍
   + 中断控制器
   + SMP启动
   + GPIO
   + 时钟
   + pinctrl (pin control)
2. 这些底层功能被封装好后，其他设备驱动只能调用内核提供的通用API
   + 这些API底层：填充内核规定好的**回调函数**

# [调试工具](https://luckywater.top/2019/03/04/LinuxCGdb/)

