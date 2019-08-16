---
layout: post
title: String
date: 2019-06-26 22:03:07
categories: 
- [data struct]
tags: [string]
---

# 数据结构--字符串

## 字符串相关知识

1. 字符串赋值给数组

   - 字符串结尾影藏 '\0';

   - 字符串赋值给数组：**数组**要分配内存空间存储

     ```
     char str[100] = "fdslajfk";		// 数组的内从空间可以使动态分配,或者直接分配一个足够大的空间就行
     ```

   - 字符串赋值给指针：指针**指向**字符串地址，不分配内存空间

2. 网络编程中，URL参数含有 #，空格，则不能正常访问

   - 将特殊字符进行替换
   - 替换规则 ： % + ASCII(十六进制表示)

4. **字符串表示一个大数的方式：**
   
   - 将大数转化为一个字符串: 
   
     ```
     char string[50];
     int number = 21345;
     sprintf(string, %d, number);  // 将大数number, 转化为字符串后, 保存在string中
     ```
   
5. **字符串赋值和指针的关系**

   + (1) 同一个字符赋值给两个指针；这两个指针保存的地址是一样的，所以改变其中一个的值，另外一个也会变

   + (2) 打印字符的首地址: 通过 %p的形式;

     ```
         char name = 'a';
         char *str = &name;
         char *pbeg = &name;
     
         printf("str adress is %p value is %c:\n", str, *str);
         printf("pbeg adress is %p value is %c:\n",pbeg, *pbeg);
     
         char temp = 'b' ;
         *str = temp;		// 注意，这里赋值的是值；不能是地址
     
         printf("str adress is %p value is %c:\n", str, *str);
         printf("pbeg adress is %p value is %c:\n",pbeg, *pbeg);
     ```

     ```
     str adress is 0x7ffda0eefe36 value is a:
     pbeg adress is 0x7ffda0eefe36 value is a:
     str adress is 0x7ffda0eefe36 value is b:
     pbeg adress is 0x7ffda0eefe36 value is b:
     ```

6. 字符串的动态空间申请

   ```
   char *number = malloc(strlen(str) + 1); //字符串不使用sizeof()
   ```

   

## 字符串的相关笔试题目

1. 应用一：[面试题5：**替换**字符串中的空格 (通过特殊字符替换字符串中的 "#", " ")](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/05_String/string_replace.c)

2. 应用二：[面试题17：打印1到最大的**n位数**(n==2 打印1-99)](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/05_String/print_oneToMaxBit_number.c)

### 应用三：[面试题19：正则表达式匹配](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/05_String/match_string.c)

1. 根据题目的要求：举例子后找出规律；

### 应用四：[面试题20：表示数值的字符串。判断字符串，是不是数值](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/05_String/represent_number_string.c)

### 应用五：[面试题38：字符串的排列 。题目：输入一个字符串，打印出该字符串中字符的所有排列](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/05_String/permutation_ofStrings.c)

1. 字符串的排列：

   ​        a. 将字符串分为两部分：第一个字符，后面的所有字符；

   ​        b. 通过第一个字符和后面的字符一一交换；然后固定第一个字符；（全排列的首字母）

   ​        c. 然后将后面的字符：再次分为两部分，递归过程a,b;

   ​        d. 直到后面的字符为 '\0' 打印

2. 字符串的组合：

### 应用六: [面试题58（一）：翻转单词顺序.  题目：输入一个英文句子，翻转句子中单词的顺序，但单词内字符的顺序不变。](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/05_String/reverseSentence.c)

### 应用七: [面试题58（二）：左旋转字符串.  题目：字符串的左旋转操作是把字符串前面的若干个字符转移到字符串的尾部。](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/05_String/leftRotateString.c)



### 应用一：[题目：字符串转换到int类型，使用atoi函数可以轻松完成类型转换](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/05_String/Atio.c)

### 应用二：[ 题目：Int型整数，转化为字符串](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/05_String/Itoa.c)