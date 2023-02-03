---
title: "利用 Github Actions 自動連結其他 Blog 的最新貼文"
date: 2023-02-03 18:52:00 +0800

tags: 
    - Github
    - Github Actions
    - workflow
    - YAML
    - Ruby

math: true

categories: [日常碎碎唸]

img_path: ../../assets/img/posts/14_Longest_Common_Prefix
---

在上篇 [將其他 blog 的文章連結到 Jeykyll blog](/posts/link_to_other_blog) 使用了手動的方式下載 RSS 檔案，並在本地端執行完 `feeds.rb`{: .filepath} 後再 push 到 Github 上。 <br>
文末也提到我希望全自動執行這個動作，時隔半年，在各方取捨之下我終於做出了一個能符合我八成需求的 workflow 了。 <br>

> 由於我本人也不太會 Github Action 的撰寫，主要是用拼湊的完成這次的code。 <br>
> 所以這裡不會深入講解 workflow 中的語法。
{: .prompt-danger}