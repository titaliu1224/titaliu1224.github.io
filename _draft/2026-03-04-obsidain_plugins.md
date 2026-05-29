---
title: "五個一定要嘗試的 Obsidian 插件"
date: 2025-07-27 17:04:00 +0800

tags:
  - taking notes
  - obsidian
  - customize

categories: [日常碎碎唸]

media_subpath: ../../assets/img/posts/zettelkasten_with_obsidian
---

原本是想要分享我的 Obsidian 筆記心法，寫著寫著就想著「那來介紹一下 Obsidian」好了。  
但是說到介紹 Obsidian，就不得不提那強大的插件與社群！  
於是本文就來分享我每天都在使用的 Obsidian 插件和一點使用心得。  

## 什麼是 Obsidian？

Obsidian 是一個開源的筆記軟體，主要使用 markdown 來寫筆記（markdown 是我的愛），同時能在 pdf 和 html 等資料格式中轉換（用來匯出給他人看），並且適配各種其他的筆記軟體。  
同時，Obsidian 也是基於 local 儲存，完全不怕被第三方平台綁架或是資安等問題。  
使用 Google Drive、iCloud 或是 Github 來備份或是自架一個 NAS 等等也是完全沒有問題。  
如果想要有更好的同步體驗，也可以花錢用 Obsidian 的 Sync 功能，可以有最好的多裝置編輯體驗。  

### Obsidian 和其他筆記軟體有什麼不同？

Obsidian 最大的特點是「雙向連結」和「視覺化關聯圖」。  
透過筆記之間的連結可以將相關的筆記相連在一起，日後要查閱筆記時可以像是聯想一般，同時翻閱所有相關的知識。  
例如我想到有一個關於 CSS 語法的筆記，我可以搜尋「前端」筆記 -> 連結到 CSS 筆記 -> 連結到我想找的 CSS 語法筆記。  

而這些連結最後會織成一片大型關聯圖，在這張圖中可以找到你常用的知識種類，並且抓到一些筆記孤兒來歸檔。  
有點像是在看我這個人的腦袋結構一樣，非常有趣。  

以我自己為例，筆記最大的兩個熱點便是「工作」和「資工」，其中這兩個群集之間有幾篇同時涵蓋兩個領域的筆記將他們相連。  

![利用 Obsidian 製作的卡片盒筆記 graph view](/graph_view.webp)
_我的 Obsidian Graph View，可以看到每個筆記之間的連結_


## Plugins 推薦

Obsidian 的插件分為官方的 Core Plugins 和社群提供的 Community Plugins。  
Core Plugins 雖然數量少，但品質穩定，不需要記憶一大堆的指令、快捷鍵，小卻好用。  
Community Plugins 則是百花齊放，常常能挖到寶。  

### Templates

顧名思義，他是寫筆記時的樣板，讓你的每篇筆記可以有一些預設的樣式或欄位。  

以我的 template 為例，我將不同的知識來源分成不同的 template，裡面含有不同的 MOC 和欄位。  
例如 book template 中包含封面、作者，people template 包含該人物屬於的組織、團隊。  
（至於為什麼有一個類別是 People，那是因為我想追蹤近期和哪個同事合作或是持續閱讀了某個人的文章）  
![template 適合把筆記做分類](/my_template.webp)
_我的 Templates_

### Paste URL into Selection

厭倦在貼上連結時打一堆複雜的 `[]()` 了嗎？  
下載這個插件後，先複製要貼上的連結，回到 Obsidian 後把想要當 link text 的文字框起來，直接 `ctrl + v` 就完成了貼上，再也不用打一堆括號啦！

![Paste URL into selection 是非常適合懶人的 plugin](https://user-images.githubusercontent.com/4748206/98997874-ed55fb80-253d-11eb-9121-709a316a4d1e.gif)
_插件的效果展示_

### Clear Unused Images

我在寫筆記時常需要貼上一些截圖，貼完後常覺得不滿意，又刪掉重新截圖一次。  
但是要我找到已經 import 到 Obsidian vault 的圖片然後刪除實在是非常麻煩，不刪除的話又很佔空間。  
於是這個插件提供指令，一鍵刪除所有沒被引用到的圖片與檔案。  

![這個 plugin 對於喜歡截圖貼上的人很有幫助](/clear_image.webp)
_刪除檔案的 log_

### Dataview

Dataview 是一個可以用類似 SQL 的語法來查詢筆記的插件。  
我的使用場景是列出所有有引用該筆記的筆記，對於統整型的 MOC 很有幫助。  
（註：MOC 是 Map of Content 的縮寫，是一種將筆記做分類的筆記）  

這個功能有點像 Notion 的 database，但自訂性更高。  
且得意於 Obsidian 的雙向連結特性，我們又有更多的手段可以分類與統整筆記了。

![Dataview 是一個類似 SQL 的語法，整理筆記神器](/dataview.webp)
_我在 Web MOC 中 Query 他底下的子 MOC 和有連結此 MOC 的相關筆記_


### Excalidraw / Tldraw

不可能現在還在使用 Mermaid 或是 drawio 畫流程圖吧！  
作為一個工程師，一定有需要畫架構圖、流程圖等需求，如果這時需要跳到其他工具繪圖，除了感受差之外，又很難跟現有的筆記系統結合。  
這時候一個白板繪圖工具就很重要了，但取決於每個人的使用場景，需要自行評估要使用哪一個。  

- Excalidraw: 強大的繪圖插件，和 Obdisidian 的深度整合，可以在白板中插入筆記的雙向連結，適合複雜的筆記需求。
- Tldraw: 輕量的繪圖工具，介面簡潔好上手，載入速度也快，適合簡單畫圖。

![Tldraw 是一個輕量的繪圖工具讓人在 Obsidian 中簡單繪圖](/tldraw.webp)
_Tldraw 的使用介面，具備基礎白板功能，簡單好看_
