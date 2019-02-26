---
layout: post
title: Math-matric
date: 2018-02-18 21:50:35
categories: Math
tags: matric
---

- 邮箱： hustmath2018@163.com -- math2018
- [typora使用操作](https://blog.csdn.net/WeiDelight/article/details/81011921)

# 矩阵论 

- 考试内容

  {% asset_img matric1.jpg %}

## Schedule

|  Dateline  |  start time   | end time | Learning |
| :--------: | :-----------: | :------: | :------: |
| 2018/12/4  |     20:00     |  20:40   |          |
| 2018/12/10 |     20:00     |  10:00   |          |
| 2018/12/12 |     15:10     |          |          |
| 2018/12/13 | 14：35-17: 10 |  19:20-  |          |
| 2018/12/15 |    15：00     |          |          |



## 线性空间

1. 条件：V是一非空集，F是数域，V中元满足向量的一些性质（数乘，交换和结合）；

2. 结论：V为F上的线性空间(或向量空间),记为V(F);

   1. 空间V中的元称为向量；

   2. 若

      ![line1](/home/quronghui/_posts/%7B%7B%20site.url%20%7D%7D/assets/math/line1.png)

   3. 性质：零元是唯一的

3. 线性相关：集合中某一元素可由其他元素组线性表示。

4. 线性无关定义：

   1. 当 m >2 时；线性无关的条件是，向量组a_i中没有一个元素，可以由其他元素线性表示
      1. 单个非零向量组是线性无关；
      2. 在空间V中若能找到 n 个线性无关的向量组成dimV = n; 

5. 基（基底）的概念

   1. ![line3](/home/quronghui/_posts/%7B%7B%20site.url%20%7D%7D/assets/math/line3.png)
   2. 基：最大线性无关向量的集合。

6. 如何求多项式P(t)，在基B={a_i}下，的坐标x={x_i}

   1. 坐标：其实就是 A x = b中，向量x的解
   2. 求解：（1）构造增广矩阵，进行初等行变换化简；（2）行元素对应相等进行求解
   3. ![line4](/home/quronghui/_posts/%7B%7B%20site.url%20%7D%7D/assets/math/line4.png)
   4. ![base](/home/quronghui/_posts/%7B%7B%20site.url%20%7D%7D/assets/math/base.png)

7. **基变换矩阵**

   1. 空间 V 中的两个基B1 和 B2，存在一个变换矩阵P(ij)，使得B2中的每一个元素，可以通过B1和矩阵P(ij)的某一列相乘得到：

      ![line5](/home/quronghui/_posts/%7B%7B%20site.url%20%7D%7D/assets/math/line5.png)

   2. 求解技巧：

      - 通过逆矩阵：求解的坐标是n*m维，选用增广矩阵构造 单位矩阵 E，进行初等行变换；

8. **坐标变换矩阵**

   1. 由基变换引出的概念：求同一个坐标下，不同基对应的元素求解；

   2. 根据对应关系求解就行：向量 X = 基 B * 坐标 P；

   3. 这样，在根据基变换矩阵便可以求出关系式

      ![conversion_of_coordinates](/home/quronghui/_posts/%7B%7B%20site.url%20%7D%7D/assets/math/conversion_of_coordinates.png)

   4. 当基为标准基：单位矩阵时；任何其他基，相同坐标下的向量都为零矩阵

9. 子空间

   1. 线性空间V本身及由V的零元构成的零空间(记为{0}，都是V的子空间，称它们为平凡子空间。
   2. 张成子空间：span

10. 子空间W的交；子空间W的和 ----维度

    1. 对于维度：先求W的和，再用公式求W交

       ![space](/home/quronghui/_posts/%7B%7B%20site.url%20%7D%7D/assets/math/space.png)

    2. 子空间满足维 dim 的性质，维度就是不能线性表示的，元素的个数。

    3. 子空间的交，和满足的维度dim 

       ![and](/home/quronghui/_posts/%7B%7B%20site.url%20%7D%7D/assets/math/and.png)

11. 子空间W的交；子空间W的和 ----基

    1. 对于基：先求W交的基，在求W和的基；

    2. 对于：W的交求基

       存在一组不全为0的K，使得 V * K =0；最大线性无关向量的集合。

       ![line6](/home/quronghui/_posts/%7B%7B%20site.url%20%7D%7D/assets/math/line6.png)

    3. 对于：W的和求基

12. 直和：强调的是和空间的元素：唯一分解为两个子空间（各出一个元素）的和

    1. 直和：会考证明题——根据性质进行判断

    ![direct_sum](/home/quronghui/_posts/%7B%7B%20site.url%20%7D%7D/assets/math/direct_sum.png)

<<<<<<< HEAD
    2. 直和的性质：
       1. W的交为零空间；
       2. dim( W1 + W2) = dim(W1) + dim(W2) 

#        3. 直接证明组成的：W(1)+W(2)---线性无关

2. 直和的性质：
   1. W的交为零空间；
   2. dim( W1 + W2) = dim(W1) + dim(W2) 

> > > > > > > refs/remotes/origin/master