---
layout: post
title: socket
date: 2019-05-08 15:44:22
categories:
tags:
---

# Socket

+ socket：IP地址 + TCP/UDP 端口号  ----- 唯一标识网络通讯中的一个进程
+ socket pair ：建立连接的两个进程各自有一个socket来标识，两个socket连接
+ socket API ：TCP/IP协议设计的应用层编程接口。 unix 网络编程
+ 介绍TCP协议的函数接口
+ 最后简要介绍UDP协议和UNIX Domain Socket （套接字）的函数接口。

## Introduction

### 网络字节序

1. 多字节数据

   + 多字节数据：看成一个整体，也就是数据流；
   + 数据流：在内存、磁盘文件存储的时候都是存在顺序的，顺序分为大端和小端；
   + 网络数据流的**地址**：先发出的数据是低地址，后发出的数据是高地址。

2. TCP/IP协议网络数据流

   + 应采用大端字节序，即低地址 高字节。

     + 低地址：数据在内存中的存储地址是由低到高的
     + 高字节：字节在进制数表示时的位置

   + 主机和网络字节序

     + 考虑发送和接收数据方：大端、小端字节序-----需要统一

   + 库函数

     + 网络字节序和主机字节序的转换。

     ```
     $ uint32_t htonl(uint32_t hostlong);
     // h表示host,n表示network,to表示转换方向；l表示32位长整数,s表示16位短整数。
     ```

     + 如果主机是小端字节序,这些函数将参数做相应的大小端转换然后返回,
     + 如果主机是大端字节序,这些函数不做转换,将参数原封不动地返回。

### socket地址的数据类型

1. socket API

   + 是一层抽象的网络编程接口，适用于各种底层网络协议：IPv4、IPv6，UNIX Domain Socket。
   + 然而,各种网络协议的地址格式并不相同

2. socket 地址结构体

   ```
   $ #include <sys/socket.h >	//介绍程序中用到的socket API函数
   $ #include <netinet/in.h> 	// IPv4和IPv6的地址格式定义
   $ sockaddr_in 结构体		// 表示IPV4的地址，,包括16位端口号和32位IP地址
   $ sockaddr_in6 结构体		// 表示IPv6地址包括16位端口号、128位IP地址
   ```

   + 各种socket地址结构体的开头都是相同的；
   + 前16位表示整个结构体的长度；
   + 后16位表示地址类型
     + IPv4 -- AF_INET、IPv6 -- AF_INET6；Unix Domain Socket -- AF_UNIX
   + socket API可以接受各种类型的sockaddr结构体指针做参数
     + 参数都用struct sockaddr *类型强制转换一下
     + bind、accept、connect等函数

3. IPV4 的socket网络编程

   + sockaddr_in中的成员struct in_addr sin_addr表示32位的IP地址。

   + 我们通常用点分十进制的**字符串**表示IP地址

   + 字符串(10进制) 转 in_addr (十六进制)的函数:

     {% asset_img in_addr.png %}

     + 其中inet_pton和inet_ntop不仅可以转换IPv4的in_addr,还可以转换IPv6的in6_addr
     + 函数的接口是void *addrptr。

## 基于TCP协议的网络程序

1. client to server

   {% asset_img tcp_client_server.png %}

   + 函数操作过程中：没有数据到达时，进行阻塞等待

2. 关闭连接

   + 调用close()：任何一方调用close()后,连接的两个传输方向都关闭,不能再发送数据了。
   + 调用shutdown()：如果一方调用shutdown()则连接处于半关闭状态,仍可接收对方发来的数据。

3. 学习socket API时要注意应用程序和TCP协议层是如何交互的:

   + 调用connect()会发出SYN段 
   + 如read()返回0就表明收到了FIN段

### TCP 网络程序 

+ [socket / server.c](https://github.com/quronghui/LinuxC.git)

#### server

+ 完成server的全过程

1. socket()函数

   + socket()打开一个网络通讯端口，成功返回的文件描述符
   + 网络通讯端口：就像是一个文件一样，有了文件描述符，便能对一个文件进行读写操作

2. bind()函数

   + 服务器程序：需要调用bind绑定一个固定的网络地址和端口号，为了方便客户端的连接
     + 内核分配的话：每次都会发生改变

   ```
   int bind(int sockfd, const struct sockaddr *myaddr, socklen_t
   addrlen);
   ```

   + bind()的作用是将参数sockfd和myaddr绑定在一起,使sockfd这个用于网络通讯的文件描述符监听myaddr所描述的地址和端口号。
   + struct sockaddr *是一个通用指针类型，myaddr参数实际上可以接受多种协议的sockaddr结构体
   + myaddr 初始化之后，才能用bind()函数

3. 网络地址

   + IPV4 或者是IPV6
   + INADDR_ANY 参数目前还不知道哪里找到的；
     + 表示本地的任意IP地址,

4. 两个文件描述符

   + accept()的参数listenfd是先前的监听文件描述符；
   + 而accept()的返回值是另外一个文件描述符connfd，之后与客户端之间就通过这个connfd通讯
     + 之后与客户端之间就通过这个connfd通讯,
     + 再次回到循环开头listenfd仍然用作accept的参数

### client

1. connect()

   + connect和bind的参数形式一致
   + 区别在于bind的参数是自己的地址
   + 而connect的参数是对方的地址。

2. 运行

   ```
   $ ./server	// 启动server
   $ netstat  -apn|grep 8000 	// 得到此时开启的tcp的源地址和端口号
   $ ./client	advvv	// 启动客户端
   ```

3. socket文件描述符

   + 一个socket文件描述符对应一个socket pair
   + ,也就是源地址:源端口号和目的地址:目的端口号,也对应一个TCP连接。

   {% asset_img socket_fd.png %}