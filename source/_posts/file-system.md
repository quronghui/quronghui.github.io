---
layout: post
title: file_system
date: 2019-04-18 14:42:46
categories: 
- [LinuxC]
- [file_system]
tags: file_system
---

# file_system

{% asset_img ext2.png %}

## ext2 文件系统

### 磁盘分区划分

1. 磁盘分区

   + 格式化工具：mkfs 对每个分区进行格式化
   + 目的：格式化为某种文件系统，才能存储文件
   + 格式化过程：在磁盘写一些管理存储布局的信息。

2. 文件系统

   + 文件系统中存储的最小单位是块(Block)；

   + Block size

     ```
     $ mke2fs -b 1024 / 2048 / 4096	//指定块的大小
     // 32位的每一页大小是4kb
     ```

### ext2文件系统

1. 总体布局

   {% asset_img ext2_block.png %}

+ Boot block :

  + size : 1 kb
  + 启动块是由PC标准规定的,用来存储磁盘分区信息和启动信息,任何文件系统都不能使用启动块。

+ ext2 文件系统：整个分区划成若干个同样大小的块组(Block Group)

  + super block ：

    + 功能：描述整个分区的文件系统信息,例如块大小、文件系统版本号、上次mount 的时间
    + 损坏：损坏就会丢失整个分区的数据，所以超级块在每个块组的开头都有一份拷贝。

  +  Grope Descriptor Table

    + 功能：由很多块组描述符组成,
    + 块组描述符：存储一个块组的描述信息，一旦块组描述符意外损坏就会丢失整个块组的数据

  + Block Bitmap

    + size : one block
    + 功能：块位图就是用来描述整个块组中哪些块已用哪些块空闲的,它本身占一个块,
      + 1  表示占用；
      + 0 表示空闲

    ```
    $ df	// 用df命令统计整个磁盘的已用空间,直接查看block bitmap
    $ du 	//用du 命令查看一个较大目录的已用空间就非常慢,要搜遍整个目录的所有文件。
    ```

  + inode bitmap

    + size : one block
    + 功能：中每个bit表示一个inode是否空闲可用。

  + inode table

    + 功能：存储文件的描述信息

      ```
      $ ls -l 	// 文件信息都保存在iNode中
      ```

    + 构成：每个文件都有一个inode；

      + 个块组中的所有inode组成了inode表。

    + size：一个块组有多少个8KB就分配多少个inode。

      + 也可以近似认为数据块有多少个8KB就分配多少个inode,

  + data block

    + 目录：该目录下的所有文件名和目录名存储在数据块中
      + 注意文件名保存在它所在目录的数据块中
      + :目录也是一种文件,是一种特殊类型的文件。
    + 设备文件：FIFO和socket等特殊文件没有数据块,设备文件的主设备号和次设备号保存在inode中。

### 查看指令

1. home 目录下 

   ```
   $ ls -l		// 为什么各目录的大小都是4096的整数倍
   ```

2. zero 字符设备文件

   ```
   $ ls -l /dev	// 
   ```

   {% asset_img ls_dev.png %}

   + xconsole 文件的类型是p(表示pipe)
     + 是一个FIFO文件,是一块内核缓冲区的标识,
     + 不在磁盘上保存数据,因此没有数据块,文件大小是0。
   + zero 文件的类型是c，表示字符型设备文件
     + 它代表内核中的一个设备驱动程序,也没有数据块,原本应该写文件大小的地方写了1, 5 这两个数字,表示主设备号和次设备号
     + 访问该文件时,内核根据设备号找到相应的驱动程序

3. ln 符号链接

   ```
   $ touch hello	// touch 文件权限 666
   $ ln -s ./hello halo	// 符号链接halo 指向hello；halo文件保存./hello路进名
   $ ls -l
   ```

4. ln 硬链接

   ```
   $ ln ./hello hello2
   $ ls -l
   ```

   + hello2和hello 除了文件名不一样之外,别的属性都一模一样

   + 硬链接数：ls -l 第二栏的数字

     + 表示一个文件在文件系统中有几个名字
     + hello 和hello2是同一个文件在文件系统中的两个名字

   + 硬链接数也保存在inode中

     ```
     $ mkdir a	// creat a file
     $ mkdir a/b	// 在目录a 创建 b file
     $ ls -ld a	// 硬链接数 是3
     $ ls -la a
     $ ls -la a/b
     ```

5. 目录的硬链接

   + 目录的硬链接只能通过 a/b  这种方式创建
   + 用ln命令可以创建目录的符号链接,但不能创建目录的硬链接。

## 文件系统的实例

### 格式化分区

1. 创建一个1MB文件，并清零

   ```
   $ dd if=/dev/zero of=fs count=256 bs=4k
   ```

   + dd 命令可以把一个文件的一部分拷贝成另一个文件。
   + 到/dev/zero 是一个特殊的设备文件,它没有磁盘数据块,对它进行读操作传给设备号为1, 5的驱动程序.
   + if和of 参数表示输入文件和输出文件,count 和bs 参数表示拷贝多少次,每次拷多少字节。

2. 格式化并清零

   ```
   $ mke2fs fs		// 格式化文件
   $ dumpe2fs fs	// 查看这个分区的超级块和块组描述符表中的信息
   $ od -tx1 -Ax fs	// 二进制文件的查看
   ```

3. mount 挂载

   ```
   $ sudo mount -o loop fs /mnt
   $ cd /mnt/
   $ ls -la
   ```

   + 会出现三个目录
     + “.”表示当前目录,  “..”表示上一级目录,
     + lost+found 目录由e2fsck工具使用,如果在检查磁盘时发现错误,就把有错误的块挂在这个目录下
   + sudo unmount /mnt  ：取消挂载

4. debugfs  工具

   ```
   $ debugfs fs	// 它提供一个命令行界面,可以对文件系统做各种操作
   $ debugfs: help	//
   $ debugfs: quit
   ```

   + 例如查看信息、恢复数据、修正文件系统中的错误。

## 数据块寻址

1. 数据块　通过inode中的索引项Blocks[0-14]

   + 索引项一共有15个,从Blocks[0] 到Blocks[14] ,每个索引项占4字节。
   + 索引项Blocks[12] 所指向的块并非数据块,而是称为间接寻址块(Indirect Block)

   {% asset_img inode.png  %}

2. 访问文件中的任意数据

   + 只需要两次读盘操作,一次读inode(也就是读索引项)一次读数据块。

3. 而访问大文件中的数据

   + 则需要最多五次读盘操作:inode、一级间接寻址块、二级间接寻址块、三级间接寻址块、数据块

## 文件和目标操作的系统文件

### 系统函数

1. stat
   + stat(2)函数读取文件的inode
   + 然后把inode中的各种文件属性填入一个struct stat 结构体传出给调用者。
2. access 函数
   + access(2) 函数检查执行当前进程的用户是否有权限访问某个文件
   + access函数取出文件inode中的st_mode 字段,比较一下访问权限，0/-1
3. chmod(2) 和fchmod(2) 函数
   + 改变文件的访问权限,也就是修改inode中的st_mode字段
4. utime(2) 函数
   + 改变文件的访问时间和修改时间,
5. link(2)函数
   + 创建硬链接,其原理是在目录的数据块中添加一条新记录,其中的inode号字段和原文件相同。
   + symlink(2) 函数创建一个符号链接,这需要创建一个新的inode,其中st_mode字段的文件类型是符号链接
6. unlink(2) 函数删除一个链接。
7. rename(2) 函数
   + 改变文件名,需要修改目录数据块中的文件名记录,

## VFS (Virtual Filesystem)

### 目录树

1. 不同的磁盘分区、光盘或其它存储设备都有不同的文件系统格式,然而这些文件系统都可以mount 到某个目录下。
   + 用ls命令看起来是一样的,读写操作用起来也都是一样的
2. VFS
   + Linux 内核在各种不同的文件系统格式之上做了一个抽象层；
   + 使得文件、目录、读写访问等概念成为抽象层的概念
   + 因此各种文件系统看起来用起来都一样,这个抽象层称为虚拟文件系统

### 内核数据结构

1. 每个进程的process control block 
   + 保存着一份文件描述符
   + 已打开的文件在内核中用file 结构体表示,文件描述符表中的指针指向 file struct
2. file struct
   + 维护File Status Flag(file 结构体的成员f_flags)
   + 和当前读写位置(file 结构体的成员f_pos )
   + f_count：表示引用计数(Reference Count)
     + 例如有fd1和fd2 都引用同一个file 结构体，要close（d1）,close(d2)；
     + 才会释放file struct
3. file_operation
   + 每个file 结构体都指向一个file_operations 结构体,,这个结构体的成员都是函数指针
   + 指向实现各种文件操作的内核函数。
4. dentry
   + 每个file 结构体都有一个指向dentry结构体的指针,“dentry”是directory entry(目录项)的缩写
   + 为了减少读盘次数,内核缓存了目录的树状结构,称为dentry cache
5. inode
   + 每个dentry结构体都有一个指针指向inode 结构体。
   + inode 结构体保存着从磁盘inode读上来的信息。
6. super_block
   + inode 结构体有一个指向super_block结构体的指针
   + super_block结构体保存着从磁盘分区的超级块读上来的信息,

### dup and dup2 函数

1. dup 和dup2 都可用来复制一个现存的文件描述符,使两个文件描述符指向同一个file 结构体。

2. dup2

   ```
   int dup(int oldfd);
   int dup2(int oldfd, int newfd);
   ```

   