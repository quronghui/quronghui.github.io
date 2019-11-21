---
layout: post
title: C++ Primer Plus
date: 2019-10-11 14:43:39
categories: [C++]
tags: [C++]
---

[TOC]



## C++ 的预备知识

### C vs C++

| 区别      | C                   | C++                                        |
| --------- | ------------------- | ------------------------------------------ |
| 组成      | 面向过程的C         | 面向过程的C ：数据+算法=程序               |
|           | 数据+算法=程序      | 面向对象的编程OOP：偏重于数据处理          |
|           |                     | 泛型编程：侧重于特定的数据类型；           |
| 源代码    | .c                  | .cpp                                       |
| 注释      | /* */               | //                                         |
| 头文件    | stdio : 标准的I / O | io + stream：I/O的输入输出流               |
|           | .h  （stdio.h）     | 去掉了.h，在前面加上c (cmath)              |
| 输入/输出 | scanf；printf       | cin ; count                                |
| 数组      | 数组                | vector（实现动态创建）  array （静态分配） |
| 字符串    | char str1[20];      | string str2;                               |
| strcut    | 定义和赋值          | 定义和赋值：可以省略struct                 |
| pointer   | int  *value;        | int*  value;  // *的位置不同；             |
|           |                     |                                            |

1. 面向对象的编程（OOP）

   + oop不像面向过程那样，试图使问题满足语言的过程性方法；oop试图让语言满足问题的要求；
   + oop程序设计方法首先设计**类**：将数据和方法合并为**类定义**；

2. 泛型编程：侧重于特定的数据类型

   + oop：是一个**管理**大项目的工具；
   + 泛型编程：提供了**执行**常见任务的工具（数据排序或合并链表）；

3. 源代码改错方法？

   + 应先改正第一个错误，如果在标识为有错误的那一行上找不到错误，请查看前一行；

   + ```
     cin.get();	 // 保证程序运行的界面不关闭，等待键盘键入一个enter；
     ```


### cin and cout

1. using namespace std 

   + 通过名称空间区分不同的版本；

   + 引用方式

     ```
     std::cout << "Hello, World!" << std::endl;		//endl  表示的是换行；
     ```

2. OOP对象之一：count / cin

   + count作为对象，我们不需要了解其内部情况，只需要知道它的接口，便能直接使用。

   + ```
     cout  <<  string;		// 将string插入到count接口中
     ```

   + {% asset_img count.png %}

## 数据

### 整形数据的表示

1. 整形数据的三种表示方式：

   + 第一位数字是1-9，则基数为10（十进制）
   + 第一位数字是0，第二位是1-7，则基数是8（八进制）
   + 前两位是0x或0X，则基数是16（十六进制）

2. 整形数据，在程序中修改类型的代码：

   ```
   #include <iostream>
   using namespace std;    // 省略using后，需要使用std::cout
   int main()
   {
       using namespace std;
       int chest = 42;     int waist = 42;     int inseam = 42；
       cout << "chest = " << chest << endl;     cout << hex;    //十六进制
       cout << "waist = " << waist << endl;     cout << oct;    //十进制
       cout << "inseam = " <<inseam << endl;
       return 0;
   }
   // chest = 42 // waist = 2a // inseam = 52
   ```

3. c++ 中OOP的成员函数

   ```
   cout.put();	// 类似于cout 输出；
   ```

4. 使用相同的符号进行多种操作叫做运算符重载。

### 字符串

1. 复合类型：基于整形和浮点类型创建的。

2. 数组：初始化和复制

3. 字符串：空字符'\0'，代表的是字符串的结尾

   ```
   char dog[8] = {'b', 'e', 'a', 'u', 'x', ' ', 'I', 'l'}	// not a string
   char cat[8] = {'b', 'e', 'a', 'u', 'x', ' ', 'I' , '\0'}	// is a string
   ```
   
4. string类型字符串和数组字符串的不同点

   ```
   // (1)string 类型的定义和复制
   // 数组不能直接复制，但是字符串可以直接复制
   // 字符串的长度 str1.size()
   void string_define_and_copy()
   {
       char charr1[20];
       char charr2[20] = "hello";
       string str1;
       string str2 = "world";  // 无需定义空间大小
   
       // 字符串的复制
       strcpy(charr1, charr2);
       cout << "charr1 is: " << charr1 << endl;
       str1 = str2;
       cout << "str1 is: " << str1 << endl;
       // 字符串的链接，字符串长度计算
       strcat(charr1, charr2);
       cout << "charr1 is: " << charr1 << " size = " << strlen(charr1)<< endl;
       str1 += str2;
       cout << "str1 is: " << str1  << " and size = " << str1.size() << endl;
   }
   
   // (2)string类型的字符串：读入一行
   void string_Input()
   {
       char charr1[20];
       string str1;
       cin.getline(charr1, 20);
       cout << "charr1 is: " << charr1  << " and size = " << strlen(charr1) << endl;
       getline(cin, str1); // 读入一行
       cout << "str1 is: " << str1 << " and size = " << str1.size() << endl;
   }
   ```

   

###  getline() and get() 读入一行字符串

| 区别         | cin.getline(string, size)                                    | cin.get(string, size)                                        |
| ------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| 特点         | 每次读取一行，通过换行符确定行尾；<br />在存储时，用'\0'代**替换**行符'\n' | 对于换行符**不进行读取**，而是放在stdin缓存队列中            |
| 连续的读入行 | cin.getline(string, size) 返回一个cin；<br />cin.getline(string, size).getline(); | cin.get():无参数，读取一个字符；<br />cin.get(string, size).get(); 将'\n'去除 |

1. 数字和字符串混合读入时的处理？

   + 读完数字后，使用cin.get() 将'\n'去除；

   + ```
     (cin >> year).get();    // 去除末尾的'\0'
     ```

2. cin 输入字符的时候：忽略空格和换行符；

   ```
   void Cin()
   {
       char ch;
       int count = 0;
       cin >> ch;  // 判断第一个字符是否为#
       while (ch != '#'){
           count << ch;
           ++count;    // 进行字符计数；忽略空格和换行；
           cin >> ch;  // 得到下一个字符
       }
       cout << endl << count << " characters read.\n";
   }
   ```
   
3. cin.get() :检查每个字符，包括空格、制表符（'\t'）和换行符('\n')；

   + cin.get(ch)：函数重载的OOP特性，输入一个参数
   + cin.get(name, ArSize)：输入一个数组名和数组大小

   ```
   void cin_get()
   {
       char ch;
       int count = 0;
       cin.get(ch);    // cin.get()是一个函数，所以ch此时传输的是地址
       while(ch != '#'){
           cout << ch;
           ++count;
           cin.get(ch);
       }
       cout << endl << count << "characters read.\n";
   }
   ```

4.  cin.eof / cin.fail 检测文件末尾标志EOF

   + // 对于EOF的标志：linux下是 ctrl+d

   ```
   void cin_eof()
   {
       char ch;
       int count;
       cin.get(ch);
       while (cin.fail() == false){    // cin.fail()==EOF，则返回true
           cout << ch;
           ++count;
           cin.get(ch);
       }
       cout << endl << count << " characters read.\n";
   }
   ```

5. cin.get（）和cin.get(ch) 之间的区别
   {% asset_img cin_get.png %}

6. getline：读取某一行

   ```
   void Getline()
   {
       const int ArSize = 10;
       char name[ArSize];
       char desert[ArSize];
       cin.getline(name, ArSize).getline(desert,ArSize);
       cout << "You input is: " << name << endl;
       cout << "You desert is: " << desert << endl;
   }
   void Get()
   {
       const int ArSize = 10;
       char name[ArSize];
       char desert[ArSize];
       cin.get(name,ArSize).get(); 	// 用于去除第一个字符串留在缓存中的'\n';
       cout << "You name is: " << name << endl;
       cin.get(desert,ArSize).get();
       cout << "You name is: " << desert << endl;
   }
   ```


### 结构体：实现多种数据的管理

1. struct 的定义和使用

   ```
   // 通过结构体：实现多个成员的管理
   struct inflatable{
       char name[20];
       float volume;
       double price;
   };
   int main()
   {
       // (1)struct inflatable 结构体的定义：可以省略struct
       inflatable guest = {"hello", 1.88, 3.33};
       cout << "guest: " << guest.name << " " << guest.volume << " " << guest.price << endl;
       // (2)结构体的复制
       inflatable  pre = guest;
       cout << "pre: " << pre.name << " " << pre.volume << " " << pre.price << endl;
       // (3) 结构数组： 定义和初始化
       inflatable array[2] = {
               {"Bambi", 0.5, 21.99},
               {"God", 200, 55.1}
       };
       cout << array[0].volume << " and " << array[1].price << endl;
       return 0;
   }
   ```

2. Union的使用：当一个商品的id有两种类型的选择时，可以使用Union

   ```
   struct widget {
       char name[20];
       int type;
       union id{		// 结构体中的联合体：id有两种属性的选择
           long id_num;
           char id_char[20];
       } id_val;
   };
   int main()
   {
       widget prize;
       prize.type = 1;
       if(prize.type == 1) {		//  验证不同的类型，存在不同的输出
           cout << "Enter id is long type : ";
           cin >> prize.id_val.id_num;
       }
       else {
           cout << "Enter id is char: ";
           cin >> prize.id_val.id_char;
       }
       return 0;
   }
   ```

3. enum 枚举类型：符号变量为整形（默认值是0,1...）

   ```
   // Enum 枚举类型的定义和声明
   void Enum()
   {
       // spectrum：枚举名；red...符号常量：对应0,1,2,3...整数
       enum spectrum{red, orange, yellow, green, blue, violet, indigo, ultraviolet };
       // 符号常量可以转化为整形，但是反之不成立
       spectrum band;  // 声明这种类型的变量band
       band = blue;    // 正确的赋值
       int value = blue;   // 符号常量可以转化为整形
   
       band = 2000;    // 错误：整形不能转化为符号常量
       band = red + orange; // 转换为0 + 1
   }
   // Enum 枚举类型的初始化
   void Enum_Init()
   {
       // 枚举类型的取值范围有要求
       enum bits {one = 1, two = 2, four = 4}; // 显示初始化
       bits myflags;
       myflags = bits(3);  // 成立的
       // 未初始化的第一个符号常量：默认为0；third = 101;
       enum bigstep{first, second = 100, third};
       // 符号常量可以同时表示一个值: zero=null=0;ze_one=1
       enum value{zero, null = 0, ze_one, ze_two=1};
   }
   ```

### 指针和存储空间

1. 面向对象编程与传统的过程性编程的区别？

   + OOP强调的是在运行阶段进行决策，并非编译阶段；

2. 指针的注意？

   + 指针不仅仅是指针（地址），而且还是指向特定类型的指针；
   + 指针在使用之前，一定要进行初始化；

   ```
       int *pt;
       pt = (int *)0xB8000000; // 将十六进制整数强制转化为int*的指针
   ```

3. new 和delete 成对出现？

   + new分配一个变量的空间

     ```
     // new 关键字：动态分配typeName类型空间
         typeName * pointer_name = new typeName;
         ...
         delete pointer_name;    // delete和new成对出现
     ```

   + new分配一个数组大小的空间

     ```
     // new 关键字：动态分配数组空间
         typeName * pointer_name = new typeName[num];
         ...
         delete [] pointer_name;    // delete和new成对出现
     ```

### 类型结合访问

```
#include <iostream>			// // 题目九：数组，指针，结构体同时结合，实现对结构体的访问；
using namespace std;
struct all{
    int year;
};
int main()
{
    all s01, s02, s03;  // c++定义结构体的时候可以省略struct
    s01.year = 1998;    // （1）使用句点访问；
    all* pa = &s02;     // （2）使用指针访问
    pa->year = 1999;
    all trio[3];        // （3）使用数组访问；
    trio[0].year = 2003;
    cout << "trio.year = " << trio->year << endl;   // 只代表首个数组元素吗？
    // (4)使用的是指针数组进行访问
    const all *arp[3] = {&s01, &s02, &s03}; // arp是一个常指针数组，每个数组元素都是常指针
    cout << "arp[1].year = " << arp[1]->year << endl;
    // (5) 指向指针的指针进行访问；
    const all **ppa = arp;
    // （6）使用auto进行推测ppb的类型
    auto ppb   = arp;
    cout << "(*ppa)->year = " << (*ppa)->year << endl;
    cout << "(*ppb)->year = " << (*(ppb + 1))->year << endl;
    return 0;
}
```

### 数组的替代品：数组（数据结构），vector  和  array（和数组不同，array是一个对象）

1. vector：是一种动态数组，允许在运行的时候创建数组的长度；

   + 可以再末尾附加新数据，或者在中间插入新数据；
   + vector：由new和delete进行管理内存，存储于堆区；

   ```
   #include <vector>
   vector<typeName>  vt[num];  // vd 是一个对象，num是数组的长度，可以是变量
   ```

2. array：定义的对象长度也是固定的，存储于栈区；

   + 同一类型的array对象：可以直接赋值；（数组不允许的）
   + 和vector不同的是：num是一个常量

   ```
   #include <array>
   array<typeName,  num> arr;		// num是一个常量；arr是一个对象；
   ```

3. 对于元素的访问：采用数组名（对象名）+ 下标

   ```
   {
       double a1[4] = {1.2, 2.4, 3.6, 4.8};    //（1）c/c++通用
       vector<double > a2(4);               // (2)C++98 STL
       a2[0] = 1.0/2.0; a2[1] = 1.0/3.0;       // vector的初始化和数组一样
       a2[2] = 1.0/4.0; a2[3] = 1.0/5.0;
       array<double , 4> a3 = {3.14, 2.72, 1.62, 1.41}; // (3) c++11允许的
       array<double , 4> a4;
       a4 = a3;         // 同一对象的array，允许直接复制
       return 0;
   }
   ```


## 循环和分支

### 基本循环

1. 赋值运算符：从右向左结合；

2. C++的表达式是值与运算符的结合，每个c++表达式都是有值的；

3. cout.setf()：实现bool判别

   ```
   题目一：通过设置cout.setf();实现false和true的输出
   int main()
   {
       int x = 10;
       cout.setf(ios_base::boolalpha); // a newer c++ feature
       cout << "The expression x <= 10: ";
       cout << (x <= 10) << endl;
       cout << "The expression x > 10: ";
       cout << (x > 10) << endl;
       return 0;
   }
   ```

4. ++i 前缀版的效率高于； i++后缀版；

### 基于while循环实现：

1. 通过while实现clock延时

   ```
   #include <iostream>
   #include <ctime>		// 头文件
   using namespace std;
   int main()
   {
       cout << "Enter the delay times, in seconds: ";
       float secs;
       cin >> secs;
       clock_t delay = secs * CLOCKS_PER_SEC;  // CLOCKS_PER_SEC 机器时间
       cout << "starting\a\n";     // \a是 转义字符 007，响铃符 BEL
       clock_t start = clock();    // 系统起始的时间
       while(clock() - start < delay)        ;
       cout << "done \a\n";
       return 0;
   }
   ```

### 基于范围的for循环

1. 基于范围的循环for，可以实现对数组元素的操作

   ```
   {
       vector<int > a1 = {1, 2, 3, 4};
       array<int, 4> a2 = {5, 6, 7, 8};
       for(int x : a1)     // (1)对数组元素的输出
           cout << x << " ";   // 1 2 3 4
       cout << endl;
       for(int &x :a1) {       // (2)对数组元素的操作
           x = x * 2;
           cout << x << " ";   // 2 4 6 8
       }
       return 0;
   }
   ```


### cctype字符函数库

1. 通过字符函数库：对输入的字符进行判断

   ```
   #include <cctype>
   ```

2. 具体的函数API，参照

   {% asset_img cctypes.png %}

### 文件的IO和文本的IO

| 区别           | 文本的IO              | 文件的IO                          |
| -------------- | --------------------- | --------------------------------- |
| 包含的头文件   | #include <iostream>   | #include <fstream>                |
| 头文件包含的类 | istream 和 ostream 类 | ifstream 和 ofstream              |
| 类定义的对象   | cin 和 cout           | 通过类进行定义 ：ifstream inFile; |

1. 文件的类如何与文件建立关联？

   ```
   ofstream outFile;
   outFIle.open("file.txt");		// 通过open建立联系
   ```

2. 通过ifstream 和 ofstream定义的对象？

   + 该对象和cin 和 cout使用的方法类似；

3. 文件打开是否成功的判断？

   ```
   #include <cstdlib>      // exit（）函数
   
   if(!inFile.is_open()) {   // file打开失败
           cout << "Could not open the file" << filename << endl;
           cout << "Program terminating.\n";
           exit(EXIT_FAILURE);
       }
   ```

4. 从文件中输入数据时，出现的错误的判断方式？【和cin.eof()是一样的用法】

   ```
       if(inFile.eof())   		 		// 错误原因：到达文件末尾
           cout << "End of file reached.\n";
       else if (inFile.fail())		 //错误原因：数据类型不匹配；
           cout << "Input Terminated by data mismatch.\n";
       else
           cout << "Input for unknown reason.\n";
   ```

5. [code比较](https://github.com/quronghui/c-add-prime-plus/blob/master/5_circle/7_fileIO.cpp)

## 函数

### 函数模块

1. 函数和二维数组

2. 函数和结构

   + 结构可以直接赋给另外一个结构；

3. 函数和string对象

   + 通过声明一个string对象数组，代替char类型的二维数组

   + ```
     string  str1[4];
     char str2[3][4];
     ```

4. [函数和array对象](https://github.com/quronghui/c-add-prime-plus/blob/master/7_funcation/1_funcation_array.cpp)

   + 通过array和string：声明一个字符串类型的数组

   + ```
     array < string , 4 >  str1 = {" {"Spring", "Summer", "Fall", "Winter"};"  }
     ```

5. [递归](https://github.com/quronghui/c-add-prime-plus/blob/master/7_funcation/2_recur.cpp)

   + 一层层的往下递归调用，然后在一层层的返回；

6. 函数指针

   + 区分函数的地址，还是函数的返回值

   + ```
     process( think );		// think 是一个函数名，在这里是函数的地址；
     process(think() );		// think() 代表的是函数的返回值；
     ```


### 内联函数

| 区别 | 常规函数               | 内联函数（c++）                  | 宏定义（c）        |
| ---- | ---------------------- | -------------------------------- | ------------------ |
| 用法 | 运行时候进行地址的跳转 | 编译阶段：与其他的程序代码“内联” | 编译阶段：进行替换 |
| 定义 |                        | 加关键字 inline                  | #define            |
| 区别 |                        | 使用参数传递形式                 | 使用参数替换       |

1. 内联函数使用条件？

   + 此函数执行时间短，且经常被使用；

   + ```
     inline double square(double x) { return x*x; }  // 函数的定义形式；
     ```

2. [内联函数和宏定义的区别点？](https://github.com/quronghui/c-add-prime-plus/blob/master/7_funcation/3_inline_funcation.cpp)

   + 变量是否加“（）”；
   + 对于（i++）的运算；

### 变量，引用，指针

| 区别 | 变量   | 引用                                                        | 指针              |
| ---- | ------ | ----------------------------------------------------------- | ----------------- |
| 定义 | int i; | int & alias = i;                                            | int *pointer = &i |
| 关系 |        | 等同于变量；地址相当于常指针；<br />int * const alias = &i; |                   |

1. 引用变量和一般变量的关系？

   + 引用变量：相当于一个别名，两个变量指向相同的内存单元和地址;

2. 引用和指针的区别？

   + int &rodent = rat;  // rodent的类型是int &, 即rodent是指向int型的引用

   + int *pointer ：将pointer声明为int *, 即指向int变量的指针

   + （1）指针：先声明，后赋值；引用--先赋值，后声明；

     （2）引用的地址：相当于const指针，只能与一个变量进行关联；

3. 引用和函数的用法？

   ```
   void swap_alias(int &a, int &b);    // 按照引用传递：标志为int &；
   void swap_pointer(int *p, int *q);  //按照指针传递：标志为int *；
   void swap_value(int c, int d);      // 按照值传递：改变不了原来的值；
   ```

4. [将引用用于结构？](https://github.com/quronghui/c-add-prime-plus/blob/master/7_funcation/4_2_alias_struct.cpp)

   + 将引用用于结构，有些类似于结构指针的用法；

### 对象，继承，引用

1. ostream 是基类，ofstream是派生类；

   + 派生类**继承**基类的方法，ofsteam类定义的对象可以使用基类的特性，如格式化方法：precision（）和setf()

   + 基类可以指向派生类的对象，无需强制转换；

     ```
     ostream &os;  // 基类定义的引用；
     ofstream fount;  // ofstream 类定义的对象；
     os既可以接收cout基类的对象，os也可以接收fount派生类的对象;
     ```

2. ostream 类中**格式化**的方法？（实现格式化输出）

   + 方法setf()：可以设置各种格式化的状态；

   + ```
     cout.setf(ios_base::fixed); // 将对象置于使用定点表示法的模式；
     cout.precision(2);      // 方法precision指定显示多少位小数；
     cout.setf(ios_base::showpoint); // 将对象置于显示小数点的模式，即使小数部分为零；
     ```

3. 需要使用引用？

   + 数据对象是**类**对象时；（c++新增这项特性的原因）

### 默认参数 与 函数重载

| 区别       | 默认参数                                                     | 函数重载                                   |                              |
| ---------- | ------------------------------------------------------------ | ------------------------------------------ | ---------------------------- |
| 有几个函数 | 1个                                                          | 多个重载函数                               | 1个                          |
| 使用条件   | 有参数传递时，覆盖默认值；<br />没有参数传递时，使用默认值； | 函数执行相同任务，<br />使用不同形式的数据 | 函数功能相同，数据类型不同； |



1. C++中的**默认参数**的使用？
   + 目的：有参数传递时，覆盖默认值；没有参数传递时，使用默认值；
   + 规则1：带参数列表的函数，必须从右向左添加默认值；int harpo（int n, int m=4, int j=5）
   + 规则2：实参传递的函数，实参按照从左到右依次赋值给形参，不能跳过中间的参数；
   2. [code](https://github.com/quronghui/c-add-prime-plus/blob/master/7_funcation/5_default_parameter.cpp)
2. 默认参数与函数重载的区别？
   + 默认参数：允许使用**不同数量的参数**调用同一个函数；
   + 函数重载（函数多态）：可以使用多个**同名**的函数；
3. 函数重载的要求？
   + 要求：函数类型相同（返回值类型相同），函数名相同，只是特征标不同；
   + 特征标：函数的参数列表
   + c++使用上下文来确定函数重载的版本；
4. 函数重载中的特征标又和特性？
   + 类型引用(int &i)和类型本身(int i)视为同一个特征标;
   + 非const变量赋值给const变量是允许的；反之则不行；
   + 特征标不同，但是函数类型不同（返回值类型不同），也不是函数重载；

### 函数模板

1. 函数模板的定义？

   + 使用泛型定义函数，也叫作通用编程；

   + 编译器按照模板创建相应的函数，并且用相应的Type(int/double)代替相应的类型名。

   + 按照引用的方式接收参数。

   + ```
     // 函数模板的定义：是一个整体，需要一起写
     template <typename AnyType>			// or <class AnyType>
     void Swap(AnyType &a, AnyType &b)
     ```

2. [函数模板使用代码？]()

3. 泛型编程？

   + typename类型就是所谓的泛型，代码在编译的时候，会将泛型定义的名称替换为实际的类型（int/double）；
   + 注意：并非所有的模板参数都必须是泛型；

4. 函数模板转化为具体化模板？

   + 函数模板：里面所有的变量的类型是泛型的typename，由编译器决定的；

   + 具体化模板：将typename定义为实际的类型；

   + ```
     // template模板函数的声明
     template <typename AnyType>
     void Swap(AnyType &a, AnyType &b);
     
     // 显示实例化：explicit instantiation // 函数参数的类型确定了
     template void Swap<char>(char &a, char &b);
     
     // 隐式实例化：
     
     // 显示具体化：explicit specialization; // 两个表示方式
     template <> void Swap<int >(int &a, int &b);
     template <> void Swap(int &a, int &b);
     ```


## 内存模型和名称空间

### 程序编译

1. 头文件的查找？

   + ".h"编译器会在当前工作目录或者源代码目录中查找；

   + <.h> 编译器会在标准位置进行查找；

2. 防止多个文件同时定义

   ```
   #ifndef XXX_H
   #define XXX_H
   ...
   #endif
   ```

### 内存中存储持续性，作用域和链接性

| 存储持续性 | 作用域scope         | 链接性 |
| ---------- | ------------------- | ------ |
|            | "::" 表示的是作用域 |        |

### 名称空间

1. [名称空间的定义？]()

   + 关键字：namespace可以创建名称空间的；
   + 名称空间可以是全局，也可以进行嵌套，但是不能位于代码块中（{ 代码块 }）；

2. using 声明和 using编译区别？

   +  using声明：using + 限定的名称组成；using声明作用--直接使用fetch替换Jill::fetch；// using声明：使得一个名称可用；

     ```
     using Jill::fetch;
     ```

   + using编译：using + namespace关键字 + 限定的名字组成；Jack里面所有的变量在使用的时候，不需要限定符Jack::， 直接就可以使用；

     ```
     using namespace Jack;		// 类似于using namespace std; 之后， 使cout；
     ```

3. using声明比使用using编译更加安全：

   + （1）using声明，导入的指定名称与局部名称发生冲突后，编译器将会发出指示；

   + （2）using编译导入所有名称，与局部变量发生冲突是，局部变量将会覆盖，而且不会发出警告；