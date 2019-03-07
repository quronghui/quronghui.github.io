---
layout: post
title: LinuxC Assert
date: 2019-03-07 10:19:07
categories: 
 - [LinuxC] 
 - [Emededded]
 - [Assert]
tags: [Linux, C]
---

# LinuxC Assert

## Assert Code 

1. Precondition : 代码的前提条件的测试；
2. Maintenance：代码主要功能函数的测试；
3. Postcondition：代码结果是否超过范围的测试
4. 测试函数：简单的代码方式测试，主要是测试条件/结果是否为真

## Shut Assert

1. 测试代码只在开发和调试时有用，如果已经发布(Release)的软件还要运行这些测试代码就会
   严重影响性能了。
2. 所以C语言规定,如果在包含assert.h 之前定义一个NDEBUG宏(表示NoDebug)
3. 就可以禁用assert.h中的assert宏定义，代码中的assert就不起任何作用了:

## Code

```
/*
*   折半查找
*   项目1介绍：
*        (1)折半查找的前提是数组已经排序好；
*       （2）提供assert代码测试的思想
*/
#define NDEBUG          /* 取消assert代码的相关测试 */
#include <stdio.h>
#include <assert.h>

#define LEN 8
int a[LEN] = {1, 3, 3, 3, 9, 5, 6, 7};

int is_sorted()
{
    int i, sorted = 1;
    for (i = 1; i < LEN; i++)
        sorted  = sorted && a[i-1] <= a[i];     /* 保证序列是一个排序好的 */
    return sorted;
}

int mustbe(int start, int end, int number)
{
    int i;
    for (i = 0; i < LEN; i++){
        if (i >= start && i <= end)
            continue;
        if (a[i] == number)
            return 0;
    }
    return 1;
}

int binarysearch(int number)
{
    int mid, start = 0, end = LEN - 1;

    assert(is_sorted());    /* Precondition 前提条件测试 */

    while(start <= end){
        assert(mustbe(start, end, number)); /* Maintenance 主要函数测试 */
        
        mid = (start + end) / 2;
        if(a[mid] < number)
            start = mid + 1;
        else if (a[mid] > number)
            end = mid - 1;
        else
            return mid;
    }
    assert(mustbe(start, end, number)); /* Postcondition 测试最终的结果*/
    return -1;    
}

int main(void)
{
    printf("where the element %d\n", binarysearch(3));
    return 0;
}
```

