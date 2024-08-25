---
title: "在 MySQL 中建立 table （小進階）"
date: 2022-08-22 04:04:00 +0800

tags: 
    - database
    - mysql
    - web

categories: [資料庫學習日誌]

media_subpath: ../../assets/img/posts/
---

[上次](/posts/create_a_new_table_in_MySQL/)我們學會如何建立資料庫與資料表並插入一些資料，這次將更深入了解資料表如何操作。

## 規劃資料架構的基本要素

在建立 table 前建議先規劃這些；
1. 資料庫有幾個資料表、分別要叫什麼名字
2. 每個資料表要有多少欄位和欄位的名稱
3. 每個欄位要儲存[什麼型態的資料](https://www.w3schools.com/mysql/mysql_datatypes.asp)

## 資料庫操作 Lv. 1.5
### 刪除資料庫

- 指令：`DROP DATABASE <database>`
- 注意事項：我將會以電腦周邊當作要儲存的資料

```
MySQL[(none)]> CREATE DATABASE computers;
Query OK, 1 row affected (0.03 sec)

MySQL[(none)]> DROP DATABASE computers;
Query OK, 0 rows affected (0.01 sec)
```

## 資料表操作 Lv 1 - 建立 table

首先創立一個資料表，我將會一一解釋其中內容。

``` sql
MySQL[computers]> CREATE TABLE objects (
    -> object_id INT AUTO_INCREMENT,
    -> type INT,
    -> brand VARCHAR(20),
    -> model VARCHAR(20) UNIQUE,
    -> description TEXT,
    -> PRIMARY KEY (object_id)
    -> );
Query OK, 0 rows affected (0.03 sec)
```

使用 `DESCRIBE <table>` 來查看 table:

```
MySQL[computers]> DESCRIBE objects;
+-------------+-------------+------+-----+---------+----------------+
| Field       | Type        | Null | Key | Default | Extra          |
+-------------+-------------+------+-----+---------+----------------+
| object_id   | int         | NO   | PRI | NULL    | auto_increment |
| type        | int         | YES  |     | NULL    |                |
| brand       | varchar(20) | YES  |     | NULL    |                |
| model       | varchar(20) | YES  | UNI | NULL    |                |
| description | text        | YES  |     | NULL    |                |
+-------------+-------------+------+-----+---------+----------------+
5 rows in set (0.00 sec)
```

### Object_id

`object_id` 將作為主要鍵值欄位，所以有關鍵字 `PRIMARY KEY` 。<br>
我想就是之後要搜尋特定物品時將使用這個 id 做連結的意思吧。<br>

而 `AUTO_INCREMENT` 則是代表這個區塊的值要自動遞增，預設起始值為1。

> 可以在這裡看 [W3School 的 PRIMARY KEY 教學](https://www.w3schools.com/mysql/mysql_primarykey.asp)

### type

這裡將儲存此物品的種類，如螢幕、鍵盤、滑鼠等，以 INT 表示，方便輸入也預防打錯。

### brand

這將儲存品牌的名字。<br>
VARCHAR 和 CHAR 不同的地方是，當使用 CHAR(10) 只有輸入 hi 兩個字時，CHAR 將會自動補上8個字來填滿設定的 CHAR(10)。<br>
但 VARCHAR 將不會以空格填滿，而是只使用2個字的空間（2 bytes）來儲存資料。

另外還有 NCHAR 和 NVARCHAR，他們將以 unicode 編碼，每個字元占用2 bytes，雖花了更多空間，但如此便能儲存中文、日文、韓文等非英文資料。

> 參考資料：[[iT鐵人賽Day6]SQL Server 資料型態 char varchar nchar nvarchar](https://ithelp.ithome.com.tw/articles/10213922)

### model 

將儲存該物品的型號。<br>
`UNIQUE` 將會確保該欄的每一個值都不會重複，而前面提過的 `PRIMARY KEY` 自帶 UNIQUE 的屬性。

### description

將填寫物品的詳細資料，使用 `TEXT` 就不怕字數上限的問題，他的行為就好像 C++ 中的 string 一樣，會隨著使用者輸入的資料長度變化它所需的儲存空間。

### DESCRIPTION <table>

- 在使用 `DESCRIPTION <table>` 後，第三欄（Null）表示是否允許值為NULL。
- 第四欄（key）將會顯示該欄位是否有索引存在，將以簡寫表示，如：
  - `PRI` 是 `PRIMARY KEY`
  - `UNI` 是 `UNIQUE`
- 第五欄（Default） 表示該欄是否有預設資料值，但我們在建立時沒有指定預設資料所以這裡為 NULL。
- 最後一欄（Extra）會記錄欄位的額外資訊。

## 資料表操作 Lv. 1.2 - 修改 table

雖然前面有提到我們應該要設計好 table 再來建立，但 MySQL 仍有一些方法可以修正打錯的資料。<br>
小提示，要修改就要趁早，不然 data 輸入後再修改可能會造成很多麻煩。

### 增加一個欄位

- 指令：`ALTER TABLE <table> ADD <column_name> <data_type>`
- 注意事項：將會新增為最後一個欄位

```sql
MySQL[computers]> ALTER TABLE objects
    -> ADD color VARCHAR(10);
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0
```

### 刪除一個欄位

- 指令：`ALTER TABLE <table> DROP <column_name>`
- 注意事項：無

```sql
MySQL[computers]> ALTER TABLE objects
    -> DROP color;
Query OK, 0 rows affected (0.01 sec)
Records: 0  Duplicates: 0  Warnings: 0
```

### 修改欄位的資料型態

- 指令：`ALTER TABLE <table> MODIFY <column_name> <data_type>`
- 注意事項：只能修改資料型態，不能修改欄位名。

```sql
MySQL[computers]> ALTER TABLE objects
    -> MODIFY color INT;
Query OK, 0 rows affected (0.06 sec)
Records: 0  Duplicates: 0  Warnings: 0
```

### 其他修改方式

可以使用 [`DROP 指令`](#資料庫操作-lv-15)刪除整個資料庫，再使用 [`CREATE 指令`](#資料表操作-lv-1---建立-table) 來重新建立一次資料庫，以修改打錯的名字或多筆資料。<br>
而途中可以使用方向鍵上鍵來快速輸入以前輸入的資料。

## 恭喜完成

這篇比較短，只建立好一個 table，下篇就來插入資料囉

### Reference

_本篇內容皆來自 [MySQL 與 MariaDB 學習手冊](https://www.gotop.com.tw/books/bookdetails.aspx?types=a&bn=A440) 與 [W3School](https://www.w3schools.com/mysql/default.asp)_

