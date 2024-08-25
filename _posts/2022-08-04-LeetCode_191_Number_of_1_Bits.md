---
title: "LeetCode: 191. Number of 1 Bits"
date: 2022-08-04 09:24:00 +0800

tags: 
    - leetcode
    - bit manipulation
    - java

categories: [LeetCode, Easy]

media_subpath: ../../assets/img/posts/191_Number_of_1_Bits
---

剛開始學 Java，當然是要來寫 easy 題啊！

> [題目本人點我](https://leetcode.com/problems/number-of-1-bits/)
> <br>
> [本題 github](https://github.com/titaliu1224/LeetCode/blob/main/easy/191-Number%20of%201%20Bits)

## 題目概述

輸入：一個正整數 <br>
輸出：該正整數在二進位下有多少個1 <br>

注意：因為 Java 沒有 unsigned integer，所以過大的數會以 2's complement 的形式 overflow。

## 我的做法1

一開始我想起資訊概論教的短除法方法：除以2，記下餘數。<br>
但是一碰到負數就沒轍了，因為我的迴圈只設計給正數使用。<br>
這個方法如果在有 unsigned integer 的語言中應該能行，可惜身為 java 必須改道QQ。

```java
// ans 為 1 的數量，n 為輸入的數字
int ans = 0;
while(n > 0){
    ans = ans + ( n % 2 );
    n /= 2;
}
```
## 我的做法2

既然不能用數學的方法做，只好從 bit 的方向下手。<br>

我的想法是：先取最右邊的 bit，再將 n 向右 shift 一位，並用迴圈重複這個流程。<br>
但還是沒辦法用 `n % 2` 來取得最右邊的 bit，所以使用一個我稱它為 "mask" 的方法： `n & 1` 。
1. 利用和1做 bitwise and 來保留最右 bit 的值
2. 再使用 `n >>> 1` 做 logical shift 來完成右移一位的動作

這裡有個小細節：不能使用 `n >> 1` 進行 arithmetic shift，這樣如果最右 bit 是1，它將會回到最左邊重新循環，導致數量計算錯誤。<br><br>

這裡先放上成績單：
![grade](grade.webp)

完整 code:

```java
public class Solution {
    // you need to treat n as an unsigned value
    public int hammingWeight(int n) {
        int ans = 0;
        while(n != 0){
            ans = ans + ( n & 1 );
            n = n >>> 1;
        }
        
        return ans;
    }
}
```

## 結語
這種 bit manipulation 的題目需要一點資訊概論基礎，意外的考驗基本功。<br>
題外話，這是我目前寫過成績最好的題目了，好快樂～
