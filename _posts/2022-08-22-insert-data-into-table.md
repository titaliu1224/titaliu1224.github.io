---
title: "在 MySQL 中的 table 插入資料（Lv. 2）"
date: 2022-08-22 04:04:00 +0800

tags: 
    - database
    - mysql
    - web

categories: [資料庫學習日誌]

media_subpath: ../../assets/img/posts/
---

[上一次](/posts/create-tables/)介紹了特殊的 key 和 VARCHAR 這個資料結構，並用其建立了 table，這次將來插入資料。

## 資料表操作 Lv. 1.5

### 選擇要插入的欄位
- 指令：`INSERT INTO <table> (<column 1>, <column 2>, ...) VALUE (<data 1>), (<data 2>), (<data 3>);`
- 注意事項：若什麼都不指定，就必須[填寫所有欄位](/posts/create_a_new_table_in_MySQL/#一次插入多筆資料)

```sql
MySQL[computers]> INSERT INTO objects (type, brand, model)
    -> VALUE ('2', 'logitech', 'G502'),
    -> ('3', 'corsair', 'MK.2'),
    -> ('1', 'ASUS', 'VG247Q1A');
```

### 顯示 table 建構資訊
- 指令：`SHOW CREATE TABLE <table>\G`
- 注意事項
  - 將顯示 table 未填資料時的預設內容
  - key 將在最後顯示
  - 最後的 `ENGINE` 是 table 採用的儲存引擎型態，InnoDB 是一種交易安全表，有一支持一些加密動作
  - `CHARSET` 是預設字元集，utf8 可以解析英文以外的語言，例如中文
  - 在調整過一些預設職之後，使用此指令可以檢視結果

```sql
MySQL[computers]> SHOW CREATE TABLE objects \G
*************************** 1. row ***************************
       Table: objects
Create Table: CREATE TABLE `objects` (
  `object_id` int NOT NULL AUTO_INCREMENT,
  `type` int DEFAULT NULL,
  `brand` varchar(20) DEFAULT NULL,
  `model` varchar(20) DEFAULT NULL,
  `description` text,
  PRIMARY KEY (`object_id`),
  UNIQUE KEY `model` (`model`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
1 row in set (0.00 sec)
```

再來我建立了幾個 table 練練手，各位也能自己試試看：
1. 用戶email與名字
2. type_id，對應鍵盤、滑鼠、螢幕等

## 總結
以下是建構 tables 應該考慮的點
1. 可以用多個 table 來存放不同的物品，並使用 key 來連接，如此便能減少錯誤並提升統一性
2. 一個欄位可以有很多種不同的屬性



