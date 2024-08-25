---
title: "在 .NET Web API 中，使用 JSON 傳遞簡單型態的參數"
date: 2024-04-17 12:53:00 +0800

tags: 
  - web
  - dotnet
  - api
  - backend

categories: [web 網頁開發]

media_subpath: ../../assets/img/posts/christmas_project
---

在使用 .NET 作為後端 server end point 時， web API 有時需要接收從前端傳過來的資料。  
然而，平時在傳遞物件時都沒有問題，當接收的參數為單個字串或是單個整數時，反而怎麼樣都接收不到，是哪裡寫錯了嗎？只有自定義的物件可以作為 API 參數嗎？  

## 問題描述

這次的專案使用 Vue.ts 和 .NET 8 作為前後端。  
在 .NET 中，Controller 有一支 API end point， function 名為 `DeleteInfo(int id)` 。  
他會接收一個整數 id 作為參數，並將其傳入另一個 function 做處理，並回傳一個成功與否的字串給前端。  

```cs
[HttpPost]
public string DeleteInfo(int id) {
    Console.WriteLine("Id： " + id);
    return _infoRepo.DeleteInfo(id);
}
```

完成後，透過 Swagger 直接打 API 得到了滿意的結果。  

於是我們便興高采烈的去前端把他們串接起來，並傳入了參數（例如：`15`）。  
回到後端的 console 發現了一個 output: `Id： 0` ，顯然是沒有傳遞成功。  

```ts
const api = axios.create({
    baseURL: import.meta.env.VITE_API,
})
export const deleteData = async (dataId: number): Promise<string> => (await api.put('/data/delete', dataId)).data

```

## .NET 的參數傳遞規則

導致這個錯誤的不是因為參數型態、不是前端寫得不好，而是因為不了解 .NET Core 原生的預設參數傳遞機制。  
[微軟官方文件](https://learn.microsoft.com/zh-tw/aspnet/web-api/overview/formats-and-model-binding/parameter-binding-in-aspnet-web-api)是如此描述的：

> 如果參數是「簡單」類型，Web API 會嘗試從 URI 取得值。 簡單型別包括 .NET 基本類型 (int、 bool、 double等) ，加上 TimeSpan、 DateTime、 Guid、 decimal和 string， 以及 具有可從字串轉換之類型轉換器的任何類型。 (稍後的型別轉換器的詳細資訊。)

或是切換到英文版的文件：

> If the parameter is a "simple" type, Web API tries to get the value from the URI. Simple types include the .NET primitive types (int, bool, double, and so forth), plus TimeSpan, DateTime, Guid, decimal, and string, plus any type with a type converter that can convert from a string. (More about type converters later.)

也就是說，字串、整數、布林等平時常見的資料型態，都不是透過 JSON (body) 的方式傳輸，而是透過 URI。

### 什麼是 URI 參數傳遞？

他是把參數拼在 URL 裡面直接做傳遞，例如：

```
api/deleteinfo?id=15
```

然而，在本次專案中，我們希望透過 body 方式傳輸。

## 指定使用 Body 方傳遞參數

這裡就關係到兩個部分，分別是前端要把參數用正確的方式傳輸，還有後端用正確的方接收。  

### 後端

後端的處理相對直覺和簡單，在參數前面加上 `[FromBody]` 屬性即可。  

```cs
[HttpPost]
public string DeleteInfo([FromBody]int id) {
    Console.WriteLine("Id： " + id);
    return _infoRepo.DeleteInfo(id);
}
```

### 前端

前端預設也是使用 URI 傳送，所以必須在 request 的 Header 中註明 Content-Type 為 `application/json`。  
在這份專案中，我希望所有的 API 都透過 body 方式傳輸，所以直接在宣告 axios 的地方定義 Header：

```ts
const api = axios.create({
    headers: {
        'Content-Type': 'application/json'
    }
})
```

如此便完成了前後端的設定，現在再從前端打一次 API 測試看看吧！  

## 後記

這個 bug 一開始遇到的時候非常難解，在網路上爬了好久才終於翻到有人在討論這個問題。  
希望這一篇能被 Google Search Console 納入索引，讓更多後端小白解決問題。

## 參考資料

- [【WebApi系列】详解WebApi如何传递参数](https://www.cnblogs.com/wangjiming/p/8378108.html)
- [C# Web Api Post method with simple type parameters](https://stackoverflow.com/questions/42436051/c-sharp-web-api-post-method-with-simple-type-parameters)
