---
layout: post
title: tree
date: 2019-05-17 15:24:33
categories:
- [data_struct_algorithm]
tags: [tree]
---

# Tree

1. 文件系统：三种访问结构；前中后序访问
2. 树的操作基本时间：O(logN)
3. 通过递归的方式实现树

## 树的实现

### 树的元素 -- 节点

1. 树中节点的关系

   1）n(1) --> n(2)：n(1) 是n(2)的祖先；

   2）n(1) != n(2);  n(1) 是n(2)的真祖先；

   3）parent 、child、sibling、leaf、grandparents、grandchild

2. 节点数的长度length：从1递增到n的

   1)节点深度depth：从root到n(i)的唯一路径长；root(depth) = 0

   2)节点的高度height：从n(i)到树叶leaf的最长路径; leaf(height) = 0

   3)一棵树的深度 = 高度

3. 树的一种表达方式

   ```
   struct treenode{
   	ElementType element;
   	struct treenode firstchild;	//第一个儿子节点
   	struct treenode nextsibling;	//下一个兄弟节点
   };
   ```

   {% asset_img firstchild.png %}

### 树的遍历

1. 遍历的顺序

   针对于父节点先处理还是后处理：

   1）先序遍历：先父节点，在左儿子节点，最后右儿子。

   + 打印出目录结构

   2）后序遍历：先左儿子节点，然后右儿子，在父节点。

   + 打印出每个文件占的块block大小（文件最小单位：**块**）


## 二叉树

+ 二叉树：是一棵树，每个节点的child，不能多于两个。

+ 平均深度的计算：

  1）平均二叉树：depth = O( sqrt(N) )

  2）二叉查找树：depth = O(logN)

### 二叉树实现

1. 二叉树的图形表示：圆圈加直线
2. 二叉树的每一次插入：
   + 调用malloc创建一个节点；
   + 调用free删除后被释放；
3.  Null 指针：
   + 每一棵N节点的二叉树，需要（N+1）个NULL指针
   + 每一个叶子节点：包含两个NULL指针

### 二叉树应用--表达式树

1. 编译器的设计领域，计算表达式的应用：

   + 中序遍历策略：中缀表达式；

   + 后序遍历策略：后缀表达式；

   + 前序遍历策略：前缀表达式；

2. 树定义：表达式

   + 操作数：叶子节点

   + 运算符：父节点

3. 构造表达式树：

   + 把后缀表达式 转化为中缀表达式，每一部分加上括号
   + 方法相反：操作数压栈，读操作数时弹出操作数；

   a.  用指针指向：每个操作数，以及每次运算得到的大操作数

   + 操作数的指针压栈，顺序是左child，右child；
   + 读到操作符时弹出操作数：每次弹出两个操作数；
     + 操作符做为父节点；
     + 先弹出的做为右child；后弹出的为左child
   + 将每次操作后得到的**大操作数**指针：压入栈中；
   + 最后有一个指针指向这个**树**：将指针压入栈中
   + 栈中只有一个指针

   {% asset_img expression.png %}

## 查找树 一 ： 二叉查找树ADT

1. 二叉查找树：

   1）每个节点：指定一个关键字值；

   2）关键字互异，没有重复值；

   3)  关键字：左子树的 < 小于X节点 < 右子树的

2. 二叉树的创建

   + 空间创建的时候：以节点数N来进行创建的。
   + 平均深度是O(logN)，不用担心栈空间用尽

3. 二叉树的删除：

   + 当被删除节点：包含两个child节点时；
   + 用该节点右子树的最小数据代替该节点的数据，并**递归的删除**那个节点；

4. 懒惰删除：

   + 当元素x的出现频率>1时，当删除x一次，只是频率减一，树不发生变化

### AVL 树：是带有平衡条件的二叉查找树

1. AVL树的平衡条件
   + 平衡条件1：每个节点的左右子树具有相同高度
   + 平衡条件2（最终）：一棵AVL树是其**每个节点**的左子树和右子树的高度最多差1的二叉查找树
2. AVL 特性破坏：插入新的节点后，破坏了原来的AVL树特性
   + 插入新的节点，破坏了AVL的深度，插入的节点会变大，导致不在同一层
   + 旋转：重新平衡插入后树的深度

#### 新的节点插入树的方式

1. 四中插入方式：

   {% asset_img insert_node.png %}

2. 单旋转

   + 元素插入是：左左插入和右右插入

3. 双旋转：

   + 元素插入是：左右插入和右左插入

#### 旋转

1. 单旋转发生的操作：

   + 插入节点n的：父节点p往上升一级，n的祖父节点g往下降一级；

   + p的另外一个孩子，高度不变，换到相反的一边

   + 形成新的AVL树；

2. 插入节点n和父节点p，祖父节点g 进行比较：

   1）n < p < g : 破坏AVL平衡的话，单旋转便能达到新的平衡；

   2）p < n < g : 破坏AVL平衡的话，双旋转才行；

   3）原先节点p 的另外一个孩子，调整到另外一边

   4）插入多个数据的时候：单双旋转都需要进行；

   5）旋转除了保证AVL高度平衡外；还需要满足二叉树关键字大小的特性

3. 双旋转发生的操作

   + 插入节点n的：父节点p往上升二级，到达n的祖祖父节点gg 的位置，往下降一级；
   + p节点的其他孩子：在左边child的就分配到左边（做另外节点的右child）；

### 伸展树

1. 伸展树的思想：
   + 当一个节点被访问后，节点就要经过一系列AVL树的旋转到达根节点。
   + 不需要考虑存储的花费
2. 一棵伸展树每次操作的摊还代价是：O(log N)
   + 进行M次操作的时间就是 O(M logN )

### 展开：

+ 类似于前面介绍的旋转的想法，旋转的实施上有了选择

1. 情形一：之字形 zig-zag
   + AVL那样的双旋转
2. 情形二：一字形 zig-zig

{% asset_img one_tree.png %}

## 查找树二：B-树

1. 阶为M的B-树具备下列的结构

   {% asset_img b_tree.png %}

   + 非root 和 非叶子节点：包含的儿子数 （M/2 -- M）
   + 所有节点的**高度**是一样的；
   + **所有的关键字**包含在叶子节点上；
   + 内部节点：只包含判断信息；

2. 内部节点：

   + 以圆圈作为边框，

   + 判断信息形式：( A : B ：C ...)
     + 具有的儿子数目：(  child < A ) and ( A < child < B ) and ( B < child < C ) ...
   + 判断信息的形式：( A: - )
     + 儿子数目：两个儿子，( child < A ) and ( A < child  )

3. 3 阶 B-树 : 2-3 B树

   + 非root 和 非叶子节点：包含的儿子数 （1 -- 3）

   {% asset_img 2_3.png %}

4. M=3阶 B树 插入新的关键字

   + 增加内部节点：其儿子数目在 （M/2 -- M）之间
   + 同一层调整不成功的话：增加树的深度（保证叶子节点在同一深度）

   {% asset_img change_b.png %}



## Difference

| tree                             | 作用                                                         | 时间复杂度 |
| -------------------------------- | ------------------------------------------------------------ | ---------- |
| 表达式树                         | 分析树--编译器中<br />分析树不是二叉树：表达式树的扩充       |            |
| 查找树一： -- 二叉查找树         | 递归实现查找                                                 | O(logN)    |
| AVL树-- 带有平衡条件的二叉查找树 | 要求每个节点的左右子树：height 差 < 1<br />插入关键字后：进行新的平衡--通过旋转 | O(logN)    |
| 伸展树--不带平衡条件的二叉查找树 | 节点的深度：不做限制<br />节点就要经过一系列AVL树的旋转到达根节点。 | O(M logN)  |
| 查找树二：B-树                   | 平衡M-路树，很好的匹配磁盘<br />平衡的条件：内部节点的儿子数 (M/2 -- M)； |            |
|                                  |                                                              |            |
| 平衡树方案                       | AVL 和 B-树                                                  |            |

# 树的实现

## 基础知识

1. 树的几种特例
   - 二叉搜索树：左边节点值 < root < 右边节点的值
   - 二叉堆：任意节点的关键字小于它所有后裔的关键字；
     - 完全二叉树的插入：从左边依次插入，所以不用考虑顺序；
   - 红黑树：红黑树是具有着色性质的二叉查找树；
2. 树实现的两种方法：递归和循环；
   + 由于递归在尾部的算法出现(尾部递归)，所以使用**迭代**更加有效.
   + **迭代**：递归是不停的调用自身，迭代是通过叠加旧值产生新值
3. 树的遍历：
   - 前序，中序，后序，层次遍历

### 二叉搜索树的知识

1. 二叉树中删除节点
   
   + 代码中没有给出，实现太过复杂
   
   + 情况1：删除没有孩子的节点；
     + 不存在重新建立连接的问题
   + 情况2：删除只有一个孩子的节点；
     + 把这个节点的：双亲和孩子连接就行，仍然保持二叉树的特性；
   + 情况3：删除有两个孩子的节点；
     + 不删除这个节点，删除其左子树中值最大的那个节点
   
2. 二叉搜索树的插入：

   + 默认没有重复的节点

3. **数组实现二叉搜索树**：

   + **最重要的条件**：数组元素的下标，应该和树中节点的位置对应
     + 对应关系：树的深度为 -- depth，树最多能存储 2^(depth + 1) - 1 个节点
     + 数组的空间大小至少是 2^(depth + 1) - 1 
   + **数组下标**
     + 数组下标：从0开始，所以我们假定0位置不存节点，从位置1开始存储；
     + 节点N的双亲节点 N/2；左孩子 2N；右孩子2N+1;

### 序列化和反序列化二叉树

1. 序列化：

   + 二叉树遍历为前序遍历序列，中序遍历序列；

2. 反序列化：

   + 由前序和中序 **序列**：反序列化二叉树；
   + 应用：面试题7

3. 前序和中序 的反序列化 -- **缺点**

   + 二叉树不能存在重复节点；
   + 需要将两个序列都读入后才能进行反序列化

4. 序列化规则：进行序列化和反序列化

   + 序列化：前序遍历后输出一个规则的字符串

     ```
     "[1,2,3,null,null,4,5]"
     ```

   + 反序列化：只根据前序遍历得到的序列构建二叉树；

## 构建二叉树 (用的同一个接口)

### 	应用一 ：[ 面试题 7 ：根据前序遍历和中序遍历，构建一颗二叉树 ](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/07_tree/construct_binary_tree.c)

### 应用：[]

### 应用二：[静态数组实现二叉搜索树，能实现节点的插入，搜索，前序遍历](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/07_tree/static_array_binary_tree.c)

### 应用三：[链式构建二叉搜索树,实现节点的插入，搜索，递归遍历](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/07_tree/link_binary_search_tree.c)

1. 这是C和指针上面的内容；实现节点插入，构建二叉搜索树
2. 应用二相当于数组的实现；应用三相当于链表的实现



## 找出中序遍历的下一个节点

### 	应用一：[面试题 8：找一颗二叉树中序遍历的下一个节点，节点有指向父结点的指针](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/07_tree/next_binary_tree_node.c)

1. 多了一个指针，指向父节点；

## 对称树判断

### 应用一:[ 面试题26：树的子结构   题目：输入两棵二叉树A和B，判断B是不是A的子结构](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/07_tree/Substructure_inTree.c)

1. 没有说明是二叉搜索树，因此是普通树，存在重复节点；

2. 树的值类型是double，判断相等的时候；

   ```
   -0.0000001 < (num1 - num2) < 0.0000001
   ```


### 应用二：[面试题27：二叉树的镜像  。题目： 请完成一个函数，输入一个二叉树，该函数输出它的镜像]( https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/07_tree/mirror_recursively_binatyTree.c)

1. 解题思路：
   + a.镜像的概念：从根节点开始，根节点含有左 or 右子树；交换左右子树；
   + b.判断条件：root->pLeft != NULL || root->pRight != NULL;

### 应用三：[面试题28：对称的二叉树。题目请实现一个函数，用来判断一棵二叉树是不是对称的。如果一棵二叉树和它的镜像一样，那么它是对称的](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/07_tree/is_Symmetrical.c)

 1. 如果是对称的树，树中的节点就存在重复，该树就不是二叉搜索树

 2. 解题思路：

    ```
    1. 思路一：
       a. 利用以前的代码：先将树A进行镜像，得到树B; mirror_recursively_binatyTree.c
       b. 然后判断 树A 和树 B 的结构是否一样 Substructure_inTree.c
       c. 也可以通过前序遍历得到两棵树的数组，比较数组是否相同；
     2. 思路二：
     a. 不用直接得到镜像的树B，假定一种遍历方式：先遍历root，然后遍历右子树，最后遍历左子书；
     b. 在遍历的时候，同时判断和 A树的关系
     c. 特殊情况
        Aroot 树为空 ，镜像树对应相等
        树中某一些节点为NULL，这时候镜像树是不对称的;
    ```


## 树和队列

+ 将两种ADT数据抽象类型融合在一起；

### 应用一：[面试题32（一）：不分行从上往下打印二叉树。 层级遍历二叉树](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/16_BinaryTreeAndQueue/BinaryTree_queue/printTree_fromTopToBottom.c)

1.  遇到的问题
   +  入队的节点是树的节点：这个可以通过改变Queue接口中的QUEUE_TYPE, 修改成BinaryTreeNode * 这样解决；
   + 但是入队后，队列执行一次后就判断为空: 我一开始写的queue.c有问题，queue->rear没有处理好；
2. 题目扩展
   + 广度优先遍历，或者是有向图，还是一棵树，都需要用到队列；

### 应用二：[面试题32（二）：分行从上到下打印二叉树。 每层打印之后换行](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/16_BinaryTreeAndQueue/BinaryTree_queue/printTreeLine.c)

1. 解题思路：

   + 和面试题32（一）是一样的思路；

   +  在打印换行的时候，需要知道每一层有多少个节点，需要两个变量进行表示；

## 树和栈

### 应用一：[面试题32（三）：之字形打印二叉树](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/16_BinaryTreeAndQueue/BinaryTree_stack/printZigzag.c)

1. 之字形打印的思路：通过画图能看出来
   + 通过栈实现：两个栈结构进行打印
   + 保存节点的顺序
     + 打印奇数层：左子节点 --> 右子节点
     + 打印偶数层：右子节点 --> 左子节点
   + 之字型打印：默认要分行
   + 把一个栈打印完了之后就可以分行，不用去记录每一层多少个

### 应用二：[面试题34：二叉树中和为某一值的路径. 题目：输入一棵二叉树和一个整数，打印出二叉树中结点值的和为输入整数的所有路径。](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/16_BinaryTreeAndQueue/BinaryTree_stack/findPth_binaryTree.c)

1. 解题思路

   ​        a. 路径：起始于根节点，结束于叶子节点；

   ​        b. 前序遍历：需要将路径中的节点进行入栈，作为路径的保存。

   ​        c. 节点遍历后，需要回溯到上一个节点；

2. 注意的是：打印条件-->

   ```
   if( currentSum == expectedSum && is_leaf(pRoot) )
   ```

   + 压入栈后的节点：如何顺序打印路径；
   + 方法：通过双栈模拟队列，实现栈的打印

## 二叉树后遍历的判断

### 应用一：[ 面试题33：二叉搜索树的后序遍历序列。输入一个整数数组，判断该数组是不是某二叉搜索树的后序遍历的结果](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/07_tree/verify_sequenceOfBST.c)

1.解题思路：

​        a.根据后序遍历中，root在最后一个，将序列分为两部分；

​        b.左半部分 < root < 右半部分 (当左半部分出现大于 root， 将后面的所有节点归于右半部分)

​        c.依次判断每一部分时候满足； （出现错误：右半部分出现了小于root的节点序列）

## 树和链表

### 应用一：[面试题36：二叉搜索树与双向链表.输入一棵二叉搜索树，将该二叉搜索树转换成一个排序的双向链表](https://github.com/quronghui/DataStructAndAlogrithmCode/blob/master/SwordOffer/16_BinaryTreeAndQueue/BinaryTree_doubleList/BinaryTree_Con_DoubleList.c)

1. 不能创建新的任何节点：意味着我们在遍历的时候，就需要对每一个节点进行转换（节点需要动态分配，指针初始化一个地址）
2. 转换为的转换为的链表是排序：选择中序遍历