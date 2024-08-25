---
title: "將其他 blog 的文章連結到 Jeykyll blog"
date: 2022-08-18 09:44 +0800

tags: 
    - jekyll
    - ruby
    - rss
    - html
    - web

categories: [日常碎碎唸]

media_subpath: ../../assets/img/posts/
---

一直都很想要把 medium 的一些舊文章和朋友的文章引用進自己的 blog，這樣就能在我沒有更新的時候這裡也能有新文章出現，~~也就是說我要偷懶的意思~~。<br>
本篇將會示範如何在我的 Jekyll 網站中增加一個頁面來顯示其他網站的文章，可能內容和你的主題會有出入，請依照你的狀況做改變。<br>

> 本篇內容是「手動」下載 RSS 檔案和「手動」 deploy Github page ，如對自動化此流程感興趣請參照 [利用 Github Actions 自動連結其他 Blog 的最新貼文](/posts/automatic_link_to_other_blog/)

## 事前準備
1. 擁有一個 Jeykyll 網站，並下載了 Ruby
2. 擁有一個 Github，並下載了 Git
3. 找到一個感興趣的網站的 RSS Feed 並下載到電腦中，例如[我的這個 blog](https://titaliu1224.github.io/feed.xml)
   - 什麼是 Feed? Feed 是 Web2.0 的產物，它會顯示一個網站中最近的幾篇文章的概述，好讓人可以整合在一個地方（如 RSS 閱讀器）閱讀各平台的最新資訊。

## 步驟1: 下載 Jekyll feed importer
1. 首先，下載4個 gem 套件：
   1. feed-normalizer: `gem install feed-normalizer`
   2. yaml: `gem install yaml -v 0.1.0`
   3. to_slug: `gem install to_slug`
   4. sanitize: `gem install sanitize`
2. 下載[Jekyll feed importer](https://github.com/MattKevan/Jekyll-feed-importer) 的 `feeds.rb`{: .filepath} 並將其放入網站資料夾中
3. 點開檔案，設定 `feed_file` 作為你 feed 檔案將會在的位置和 `output_location` 作為輸出的 markdown 檔案將去的位置。以下為 feed_file 設定：
   1. 請先下載你想要匯入的 feed 檔
   2. 請建立一個 yaml 檔，名字隨意
   3. 依照以下格式一一填上你的 feed 的檔名
   ```yml
    - name: Tita's Medium
        feed: ./_friends_link/TitaLiu.xml
    ```
4. 因為當輸入的文章標題為全中文時會無法順利顯示檔名，所以我自己加了一個變數 `count` 在每形成一個檔案時 += 1，使每一個檔案都有一個流水號，這個 code 有點難貼上，麻煩各位依照迴圈的邏輯自己加上去
5. 執行 `ruby feed.rb`，你的目的地 `output_location`{: .filepath} 中應該會出現很多 markdown 檔案，格式為；

``` md
---
title: "碎碎念隨筆（十）：如何在 VSCode 中使用 PowerShell Core 7?"
date: 2022-04-18 19:22:47 +0000
dateadded: 2022-08-19 00:31:33 +0800
description: ""
link: "https://medium.com/@TitaLiu/%E7%A2%8E%E7%A2%8E%E5%BF%B5%E9%9A%A8%E7%AD%86-%E5%8D%81-%E5%A6%82%E4%BD%95%E5%9C%A8-vscode-%E4%B8%AD%E4%BD%BF%E7%94%A8-powershell-core-7-3a5d7533b4e4?source=rss-1f0703e3e84b------2"
category:
---
```

## 步驟2: 修改 config.yml
前往你的 `_config.yml`{: .filepath} 找到 `collections:` ，並新增一項 `friends_link`，像這樣：

```yml
collections:
  friends_link:
    people: true
```

## 步驟3: 複製檔案到 local 端
1. 新增 `friends.md`{: .filepath} 到資料夾 `_tabs`{: .filepath}
2. 複製其他 `_tabs`{: .filepath} 中的內容，並更改 `title` 和 `layout`
    ```md
---
layout: friends
title: Friends
icon: fas fa-user
order: 6
---
    ```
3. 前往你的主題的 `github > _layouts`{: .filepath}，複製你想呈現的頁面的 html 檔，檔名通常會和你 `_tabs`{: .filepath} 中其他檔案的 `layout` 的值相同，例如我的是 `archives.html`{: .pathfile}
4. 修改 html 檔，將原本的 `site.posts` 改成 `site.friends_link` （即步驟2中設定的 `collections` ）
5. Jekyll collection 預設使用 `date` 由舊到新排序，但我希望新的是第一個，修改了一下（請自行補上 `%` ，我直接打出來會出錯）：

    ```
    { assign sorted = site.friends_link | reverse }
    { for post in sorted }
        ...other code
    { endfor }
    ```
   
6. 理論上他要運作得很完美了！
（我是隔一天才打這篇文章的，若有缺漏可以告訴我，感謝！）

## 結語
目前為止應該都能用手動方式跑出朋友的文章了！ <br>
我原本想要研究使用 github workflow 下載文章並執行 `feedds.rb`{: .filepath}，可惜在下載 Medium 的 feed 時出了一點小狀況，而且要利用 workflow 來執行檔案實在有點複雜，只能再研究看看了。
