---
layout: post
title: Windows SDK 
date: 2019-02-28 09:31:12
categories: Windows SDK
tags: 
 - windows
 - SDK
---

# Windows SDK 

+ [参考的csdn上相关的知识](https://blog.csdn.net/hyman_c/article/details/53057037)
+ 了解一些关于SDK开发的一些相关的知识

## Windows程序分类

1. Windows控制台程序

   + C语言编写第一个“hello world”时，当时的程序就是控制台程序。
   + 他的本质是DOS程序，没有自己的窗口，
   + 你看到的输出Hello world的窗口是程序本身借用了操作系统的DOS窗口

2. windows窗口程序

   ```
   int APIENTRY wWinMain(_In_ HINSTANCE hInstance,
                        _In_opt_ HINSTANCE hPrevInstance,
                        _In_ LPWSTR    lpCmdLine,
                        _In_ int       nCmdShow)
    {...}
    // APIENTRY wWinMain windos窗口程序的入口
   ```

3. 动态链接库dll

   ```
   BOOL APIENTRY DllMain( HMODULE hModule,
                          DWORD  ul_reason_for_call,
                          LPVOID lpReserved
   					 )
   {...}
   ```

4. Visual studio 下的工具

   + 所在目录：C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin
   + 1). 编译器 CL.exe ：将源代码翻译成目标代码。
   + 2). 连接器 LINK.exe : 将目标代码、库连接生成最终文件。
   + 3). 资源编译器RC.exe : 将资源编译，最终通过连接器存入最终文件

5. Visual studio 下的 lib 库

   + Kernel32. dll : 提供了线程、进程、内存管理等核心的API
   + user32.dll : 提供了窗口、消息等API
   + gdi32.dll : 提供了绘图的API