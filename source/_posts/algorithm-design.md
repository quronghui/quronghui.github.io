---
layout: post
title: algorithm_design
date: 2019-05-25 10:57:45
categories: 
- [data_struct_algorithm]
tags: algorithm
---

# algorithm design

+ 算法的实现转为算法的设计；递归和循环实现算法

| 算法       | 适用场合                                                     |
| ---------- | ------------------------------------------------------------ |
| 排序和查找 | 二分查找，归并排序，快速排序                                 |
| 回溯法     | 二维数组上搜索路径，回溯法通过递归实现（当限定不能递归时，用栈模拟） |
| 动态规划   | 求某个问题最优解，(1)该问题可以分为多个子问题；(2)子问题的最优解组合成该问题的最优解<br />自上而下进行分析，(3)子问题存在重叠现象；通过循环的方式避免重复计算 |
| 贪婪算法   | 在动态规划思路之后，提示某一个特殊选择后，得到最优解         |
| 位运算     | 数字的二进制形式对0/1的操作，有与、或、异或、左移和右移      |

## 递归和循环

1. 递归的实现：通过调用函数自身
   + 每一次函数的调用，需要在内存栈中分配空间用以保存参数，返回地址和临时变量；
   + 每次往栈中压入数据和读取数据都需要时间；
2. 应用动态规划解决的问题：递归分析，循环实现
   + 可以使用递归的思路分析问题；
   + 从下而上通过循环实现代码；
3. 递归引起的问题：
   + 调用栈溢出，每个进程的栈容量优先。

### 应用一：[面试题10：斐波那契数列，青蛙跳台阶](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/09_recursion_and_loop/fibonacci.c)

### 应用二: [面试题60：n个骰子的点数的概率](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/09_recursion_and_loop/dicesProbability.c)

### 应用三: [面试题61：扑克牌的顺子判断](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/09_recursion_and_loop/continueCard.c)



## [排序和查找](https://luckywater.top/2019/05/22/Sort-ways/)

| 查找排序算法           | 适用场合                                                     |
| ---------------------- | ------------------------------------------------------------ |
| 二分查找算法           | 在排序数组中（部分排序）：查找一个数字或者某个数字出现的次数 |
| 哈希表<br />二叉排序树 | 考察重点在数据结构，不是算法                                 |
| 快速排序               | 最后得到的就是两个已排序的数组，加一个枢纽元                 |

1. [二分查找法的实现](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/10_find_and_sort/binary_search.c)
2. [quick_sort算法的实现](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/10_find_and_sort/quick_sort.c)

### 		应用一：[面试题11：旋转数组的最小数字](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/10_find_and_sort/rotating_array.c)

### 应用二: 归并排序 [ 面试题51：数组中的逆序对](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/10_find_and_sort/inversePair_mergeSort.c)



## 二分查找

### 应用一: [二分查找 -- 面试题53（一）：数字在排序数组中出现的次数](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/10_find_and_sort/numberOfK_InSortArray.c)

### 应用二: [二分查找 --  面试题53（二）：0到n-1中缺失的数字数](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/10_find_and_sort/missingNumber_increasingArray.c)

### 应用三: [二分查找 -- 面试题53（三）：数组中数值和下标相等的元素](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/10_find_and_sort/value_incArray.c)

## 回溯算法

1. 回溯算法的定义：蛮力法的升级版

   - 它从解决问题的**每一步**的所有可能进行尝试，选择一个可行的方案，一步步的得到最终的约束条件

2. 适用的题目：

   - 路径的选择，或者是背包问题；
   - 二维矩阵上路劲的查找问题
   - 

3. 解题的方法：

   - 回溯法属于递归的性质，通过栈进行实现；

   - 每一步的选择，对下一步将产生影响；如果一直没有找到路径，就回溯到上一个节点，从新选择路劲尝试；

     ### 应用一 :[面试题12：矩阵中的路径](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/11_backtracking/matrix_path.c)

     ### 应用二: [ 面试题13：机器人的运动范围](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/11_backtracking/moving_count.c)

## 动态规划贪婪算法

+ 动态规划：需要O(n^2)的时间和O(n) 空间；
+ 贪婪算法：需要O(1)的时间和空间

### 动态规划类求解

1. 动态规划的三个特点：
   + 求某个问题最优解：该问题可以分为多个子问题；
   + 子问题的最优解组合成该问题的最优解
   + 子问题存在重叠现象；通过循环的方式避免重复计算
   + 自上而下进行分析问题，从下往上解决问题；
2. 动态规划从下往上解决问题，中间数据怎么存储
   + 中间数据通过一维 / 二维 数组 进行存储；

### 贪婪算法

1. 贪婪算法特点

   + 希望在动态规划中的，每一个局部都是最优的；
   + 然后组合起来才是最优的解；

2. gcc 编译时：需要链接数学库

   ```
   Greedy_maxProduct:	Greedy_maxProduct.o 
   	$(CC) $^ -o $@ -lm						// 在链接成目标文件时，加上动态链接库函数 -lm
   ```

   ### 动态规划应用一: [ 面试题14: 剪绳子 :给你一根长度为n绳子，请把绳子剪成m段](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/12_DynamicProgramming_GreedyAlogithm/Dynamic_maxProduct.c)

   ### 动态规划应用二: [面试题47：礼物的最大价值. 题目：在一个m×n的棋盘的每一格都放有一个礼物，每个礼物都有一定的价值（价值大于0）](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/12_DynamicProgramming_GreedyAlogithm/get_MaxValue_inMatrix.c)
   
   ### 动态规划应用三: [面试题48：最长不含重复字符的子字符串.  扩展: 将这个长的字符串打印出来?](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/12_DynamicProgramming_GreedyAlogithm/longSubstring_withoutDup.c)
   
   ### 贪婪算法应用一：[面试题14: 剪绳子 :给你一根长度为n绳子，请把绳子剪成m段](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/12_DynamicProgramming_GreedyAlogithm/Greedy_maxProduct.c)

## 位运算

### 概念

1. 了解进制的概念：

   + 几进制：在一系列递增数中，一位能表示的最大值 < "几"进制
   + 比如：时分秒的六十进制

2. 位运算：

   + 与，或，异或，左移和右移
   + 按位进行

3. 右移：针对符号位时

   + 正数：符号位为0；右移n位时，补n个0；
   + 负数：符号位为1；右移n位时，补n个1；

   ```
   n = n >> 1; 	// 不能只写 n >> 1
   ```

### 应用一： [面试题15: 计算一个整数转换为二进制后，1的个数](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/13_bit_opreation/one_count.c)

### 应用二： [面试题56（一）：数组中只出现一次的两个数字.题目：一个整型数组里除了两个数字之外，其他的数字都出现了两次。](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/13_bit_opreation/findNumsOnce.c)

### 应用三： [面试题56（一）：数组中只出现一次的两个数字. 题目：在一个数组中除了一个数字只出现一次之外，其他数字都出现了三次。](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/13_bit_opreation/findAppearOnce.c)

## 分治算法

1. 分治算法：

   {% asset_img divide.png %}

   + 至少含有两次递归才算是分治算法

2. 分治算法

   + 最大子序列；
   + 线性时间树遍历方法；
   + 归并和快排；

3. 非分治算法：只使用一次递归

   + dijkstra 算法









## 随机化算法

1. 定义：
   + 在算法期间，随机数至少有一次用于决策。
   + 该算法的运行时间不仅依赖与特定的输入，还依赖于所发生的随机数

## 贪婪算法其余的知识点

1. 最小化处理

   - 平均完成时间最小化：先处理需要时间更短的作业；
   - 最后完成时间最小化：进行大小搭配，组合

2. huffman 算法

   - 用于文件压缩：字符是不同频率出现，文件压缩才是可能的；

   - Huffman 算法：

     1）将树组合成森林；

     2）一棵树的权中等于他的树叶的频率之和；

     3）选择权值最小的两棵树，进行merge；

     4）两棵老树成为新树的左右儿子；

     5）新树的权总是那些老树权值和；

   {% asset_img huffman.png %}

3. 集装箱处理问题

   - 联机装箱：必须把每一件物品放入一个箱子后才处理下一件物品；
   - 脱机处理：将所有输入数据全部读入后才进行处理

4. 联机处理：

   - 下项适合算法：检查箱子空余空间是否还能装下刚刚处理的物品，不能就创建新空间；

   - 首次适合算法：

     1）一次扫描箱子，需要O（N）；

     2）把新的一项物品放入足够能放入的第一个箱子中；

     3）只有放不下时才创建新空间

5. 脱机处理

   - 将所有物品信息全部排序后，在进行处理‘
   - 首次适合递减算法和最佳适合递减算法