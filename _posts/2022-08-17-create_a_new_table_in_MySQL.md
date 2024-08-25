---
title: "在 MySQL 資料庫中新建一個 Table"
date: 2022-08-17 03:22:00 +0800

tags: 
    - database
    - mysql
    - web

categories: [資料庫學習日誌]

media_subpath: ../../assets/img/posts/
---
本系列將以流水帳形式記錄我用到的指令和走過的軌跡，順便當小鐵人賽XD <br>
我將會以一個純資料庫新手的角度說說我學到的東西，若有錯誤歡迎指正。以下是我使用的工具：

| OS         | MySQL server version |
|------------|----------------------|
| Windows 10 | 8.0.30               |

## 事前準備
1. 已建立好非 root 帳號
2. 使用該帳號登入用戶端文字介面mysql，指令：`mysql -u <user> -p`
3. 我使用指令 `prompt MySQL [\d]>\_` 將我的命令輸入提示更改成 `MySQL [test]> `，其中 `\d` 為[預設資料庫](/posts/create_a_new_table_in_MySQL/#設定預設資料庫使不用每次都打上資料庫名稱)，`\_` 為空格，以下示範：
```
mysql> prompt MySQL [\d]>\_
PROMPT set to 'MySQL [\d]>\_'
MySQL [(none)]> 
```

## 資料庫操作 Lv. 1

### 查詢伺服器中的 database 們
- 指令：`SHOW DATABESES;`
- 注意事項
  - 是 databas**es**，不是 database
  - 每句句尾都要加上分號

```
MySQL [(none)]>  show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| sakila             |
| sys                |
| world              |
+--------------------+
7 rows in set (0.00 sec)
```

## SQL 指令 Lv. 1: 建立資料庫與資料表

### 建立一個 database
- 指令： `CREATE DATABASE <name>;`
- 注意事項：資料庫名稱通常是小寫

```
MySQL [(none)]> create database test;
Query OK, 1 row affected (0.01 sec)
```

### 建立一個 table
- 指令：`CREATE TABLE <database.table> (<欄位> <型別>, <欄位2> <型別2>, ...);`
- 注意事項：[關於型別可以看這裡](https://dev.mysql.com/doc/refman/8.0/en/integer-types.html)

```
MySQL [(none)]> create table test.books (book_id INT, title TEXT, status INT);
Query OK, 0 rows affected (0.02 sec)
```

### 查看 database 中的 tables
- 指令：`SHOW TABLES FROM <database>;`
- 注意事項：無
- 小心得：一個資料庫就像是一份 Google Sheet，裡面可以建立多個資料表，像是資料庫中的 table 一樣，而這一整個 server 就是包含多個 Google sheet 的資料夾（不說 Excel 是因為我沒用過 Excel，誰叫它要錢~）

```
MySQL [(none)]> show tables from test;
+----------------+
| Tables_in_test |
+----------------+
| books          |
+----------------+
```

### 設定預設資料庫使不用每次都打上資料庫名稱
- 指令：`USE <database>;`
- 注意事項：若在 prompt 中有使用 `\d` 的話，這時 prompt 會產生變化

```
MySQL [(none)]> use test
Database changed
MySQL [test]> 
```

如此一來便不需打上 table 名稱了：
```
MySQL [test]> show tables;
+----------------+
| Tables_in_test |
+----------------+
| books          |
+----------------+
1 row in set (0.00 sec)
```

### 查看 tables 中的資料
- 指令：`DESCIRBE <table>;`
- 注意事項：我們還未放入任何資料

```
MySQL [test]> describe books;
+---------+------+------+-----+---------+-------+
| Field   | Type | Null | Key | Default | Extra |
+---------+------+------+-----+---------+-------+
| book_id | int  | YES  |     | NULL    |       |
| title   | text | YES  |     | NULL    |       |
| status  | int  | YES  |     | NULL    |       |
+---------+------+------+-----+---------+-------+
3 rows in set (0.00 sec)
```

## SQL Lv. 2: 插入與處理資料

### 在 talbe 中插入資料
- 指令：`INSERT INTO <table> VALUES(<data1>, <data2>, <data3>);`
- 注意事項
  - 大小寫與空格不影響指令的執行
  - 須按照創建時的欄位順序填寫值

```
MySQL [test]> insert into books VALUES(100, 'Heart of Darkness', 0);
Query OK, 1 row affected (0.01 sec)
```

### 一次插入多筆資料
- 指令：`INSERT INTO <table> VALUES(<data1>, <data2>, <data3>), (<data4>, <data5>, <data6>);`
- 注意事項：無

```
MySQL [test]> insert into books VALUES(101, 'Hello World is a mysterious spell', 1), (102, 'Mozambique Here', 0);
Query OK, 1 row affected (0.00 sec)
```


### 查看 table 中的資料
- 指令：`SELECT * FROM <table>;`
- 注意事項
  - `*` 表示「全部、所有」，[關於正則表達式](https://docs.microsoft.com/zh-tw/sql/ssms/scripting/search-text-with-regular-expressions?view=sql-server-ver16)
  - - 將 `*` 改成欄位名稱即可顯示特定欄位

```
MySQL [test]> SELECT * FROM books;
+---------+-----------------------------------+--------+
| book_id | title                             | status |
+---------+-----------------------------------+--------+
|     100 | Heart of Darkness                 |      0 |
|     101 | Hello World is a Mysterious Spell |      1 |
|     102 | Mozambique Here                   |      0 |
+---------+-----------------------------------+--------+
3 rows in set (0.00 sec)
```

### 篩選資料
- 指令：`SELECT * FROM <table> WHERE <條件式>;`
- 注意事項
  - 是 `=` 不是 `==`，[關於比較運算子](https://docs.microsoft.com/zh-tw/sql/t-sql/language-elements/comparison-operators-transact-sql?view=sql-server-ver16)
  - 假設這裡的 status 代表剩餘庫存與否

```
MySQL [test]> SELECT * FROM books WHERE status = 1;
+---------+-----------------------------------+--------+
| book_id | title                             | status |
+---------+-----------------------------------+--------+
|     101 | Hello World is a Mysterious Spell |      1 |
+---------+-----------------------------------+--------+
1 row in set (0.00 sec)
```

### 以卡片方式顯示資料
- 指令：句尾不使用 `;` 而是 `\G`
- 注意事項
  - 此方法當表格過長導致換行或排版跑掉時很好用
  - 若是小寫的 `\g`，行為會和 `;` 一樣

```
MySQL [test]> SELECT * FROM books WHERE status = 0 \G
*************************** 1. row ***************************
book_id: 100
  title: Heart of Darkness
 status: 0
*************************** 2. row ***************************
book_id: 102
  title: Mozambique Here
 status: 0
2 rows in set (0.00 sec)
```

### 修改資料
- 指令：`UPDATE <table> SET <資料名稱> = <值> WHERE <條件式>;`
- 注意事項：無

```
MySQL [test]> UPDATE books SET title = 'A Server Made of Potato' WHERE book_id = 102;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0
```

### 一次修改兩筆資料
- 指令：`UPDATE <table> SET <資料名稱> = <值>, <資料名稱2> = <值2> WHERE <條件式>;`
- 注意事項：以空格隔開要修改的值

```
MySQL [test]> UPDATE books SET title = 'The Secret of Hello World', status = 0 WHERE book_id
= 101;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MySQL [test]> SELECT * FROM books;
+---------+---------------------------+--------+
| book_id | title                     | status |
+---------+---------------------------+--------+
|     100 | Heart of Darkness         |      0 |
|     101 | The Secret of Hello World |      0 |
|     102 | A Server Made of Potato   |      1 |
+---------+---------------------------+--------+
3 rows in set (0.00 sec)
```

### Character
- 指令：`CHAR(<SIZE>)`
- 注意事項：使用字元集來限制字串長度，使資料用起來更有效率，當資料一多的時候會顯示出差異
  
```
MySQL [test]> CREATE TABLE status_names (status_id INT, status_name CHAR(8));
Query OK, 0 rows affected (0.01 sec)
```

這裡順便插入資料使我們可以對照 `books`{: .filepath} 中的 `status`{: .filepath} 是什麼意思：
```
MySQL [test]> INSERT INTO status_names VALUES(0, 'Incative'), (1, 'Active');
Query OK, 2 rows affected (0.00 sec)
Records: 2  Duplicates: 0  Warnings: 0

MySQL [test]> SELECT * FROM status_names;
+-----------+-------------+
| status_id | status_name |
+-----------+-------------+
|         0 | Incative    |
|         1 | Active      |
+-----------+-------------+
2 rows in set (0.00 sec)
```

### 結合兩個 table
- 指令： `<table1> JOIN <table2>`
- 注意事項
  - 不用 `*` 來挑選欄位是因為會出現一些不需要的欄位（如：status, status_id）
  - 使用 `JOIN` 就能一次選擇兩種 table 中的欄位
  - 在打上分號前不論怎麼換行都沒關係
  - 會在 `books`{: .filepath} 中使用 `status = 0 or 1` 是因為這樣可以讓資料比較簡潔也避免出錯（例如打錯英文字）
  - 若兩個 table 有一樣名字的欄位，必須寫成 `<database1>.<table> JOIN <database2>.<table>`

```
MySQL [test]> SELECT book_id, title, status_name
    -> FROM books JOIN status_names
    -> WHERE status = status_id;
+---------+---------------------------+-------------+
| book_id | title                     | status_name |
+---------+---------------------------+-------------+
|     100 | Heart of Darkness         | Incative    |
|     101 | The Secret of Hello World | Incative    |
|     102 | A Server Made of Potato   | Active      |
+---------+---------------------------+-------------+
3 rows in set (0.00 sec)
```

## 恭喜完成
現在就去建立自己的表格吧！<br>
1. 請輸入 `quit` 登出後重新登入一次
2. 請試著建立以下2個 tables
3. 請試著使用 `relatoinship`{: .filepath} 篩選出關係為 Friend 的人並顯示
   
```
+---------+------------+--------------+----------------------+-------------+
| name    | phone_work | phone_mobile | email                | relation_id |
+---------+------------+--------------+----------------------+-------------+
| Tita    | 0227858593 | 0965789597   | tita@gmail.com       |           1 |
| Richard | 0356459812 | 0955558623   | rrrrichard@hello.com |           2 |
| Benny   | 055432124  | 0964487598   | bbb@yeah.com         |           2 |
| Jenny   | 0667841325 | 0954123465   | jennychen@mail.com   |           3 |
| Ikea    | 024128869  | 0922245678   | IkeaIsIkea@ikea.com  |           1 |
+---------+------------+--------------+----------------------+-------------+

+-------------+--------------+
| relation_id | relationship |
+-------------+--------------+
|           1 | Family       |
|           2 | Friend       |
|           3 | Colleague    |
+-------------+--------------+

```

### Reference
_本篇內容皆來自 [MySQL 與 MariaDB 學習手冊](https://www.gotop.com.tw/books/bookdetails.aspx?types=a&bn=A440)_
