---
title: "客製化 PowerShell！讓終端變得好看又好用"
date: 2025-06-21 23:41:00 +0800

tags:
  - powershell
  - customize
  - command line

categories: [工作環境設定]

media_subpath: ../../assets/img/posts/customize_your_powershell
---

~~眾所周知~~我是一個 PowerShell 愛好者（兼各種更換配色主題愛好者），如果可以不用 GUI 就不用，所以把愛用的環境打扮漂亮對我來說非常重要。  
這裡就來聊聊我一直沒有想過要分享出來的 terminal 美化之術（主要也是因為網路上太多人分享過了），安裝一些主題和插件讓使用 command line 的每一天都快快樂樂。   
本文適合有稍微使用過 command line 的用戶。   

材料準備：
- Windows 10/11（但本文以 Win 11 為主）
- Windows Terminal（Win 11 應有內建，Win 10 用戶請自行下載）

## 1/ 安裝 PowerShell Core 7

要安裝一些好用的插件的話就必須要有 PowerShell 7，其他版本的都不在本文的討論範圍內。  
現在打開 Windows Terminal 中的 PowerShell，輸入指令 `$PSVersionTable` 並按下 Enter，查看 `PSVersion` 那一欄是 5 開頭還是 7 開頭？  

如果沒有自己下載過，通常 Windows 內建的都是 PowerShell 5，可以直接輸入以下指令，或是到 [微軟官網](https://learn.microsoft.com/zh-tw/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.5) 看更詳細的資訊。

```shell
winget install --id Microsoft.PowerShell --source winget
```

---

## 2/ 使用 Oh-My-Posh 和 Posh-Git 進化 Terminal

Oh My Posh 可以大幅美化 PowerShell，幫它上色、加圖標，程式碼都需要 highlight 了，沒道理 terminal 不用！  
除了上色之外，它還提供顯示指令完成的時間點、當前的 Git 狀態等，當然也支援自訂主題。  

![terminal theme example](terminal_pic_example.png){:w: "200"}
_其中一種主題範例_

### 2.1/ 安裝 Nerd Font

由於 Oh-My-Posh 使用到多種特殊符號，例如上圖中 git branch 的符號，所以需要特別的字體 "Nerd Font" 來支援顯示。  
安裝可以前往 [nerdfonts.com](https://www.nerdfonts.com/font-downloads) 選自己喜歡的字體下載。  

下載完成後，解壓縮選擇喜歡的樣式點兩下打開檔案，把它安裝到你的電腦裡，就完成啦。  
順帶一提，我喜歡 mono（等寬）的字體，這樣才有在 coding 的感覺。  

安裝好後，重啟 Windows Terminal，點擊上方的下拉選單，側邊欄點擊 PowerShell 7 的設定檔，點擊 Appearance。  
在 Font face 欄位選擇剛剛安裝的字體，就完成設定了。

### 2.2/ 安裝 Oh-My-Posh

打開 PowerShell 7，輸入以下指令，安裝 Oh-My-Posh：

```shell
winget install JanDeDobbeleer.OhMyPosh -s winget
```

安裝完成後，我們打開 `$profile` （不知道怎麼打開的話輸入：`notepad $profile`）新增一行來讓每次打開 PowerShell 時都可以自動初始化：

```shell
oh-my-posh init pwsh | Invoke-Expression
```

### 2.3/ 安裝 Posh-Git

Posh-Git 用來提供當前 repo 的狀態給 PowerShell（例如 branch、commit、stash 的狀態），也支援 git 指令的 auto-complete。    
輸入以下指令安裝：

```shell
PowerShellGet\Install-Module posh-git -Scope CurrentUser -Force
```

裝完後一樣在 `$profile` 中加入這行初始化：

```shell
Import-Module posh-git
```

### 2.4/ 選主題囉

現在按下 `ctrl+s` 儲存 `$profile` 中的改動，然後重新開一個 PowerShell 7，確認剛剛做的設定都有正常套用。
然後輸入指令來看目前可以套用的主題，如果有小地方不喜歡的話也可以自己進行修改，建議 `cd` 到有 git 的資料夾，可以看到主題顯示 git 資訊時的樣式：

```shell
Get-PoshThemes
```

選好之後，把剛剛 `$profile` 中的 init oh-my-posh 的指令改成這樣， `negligible` 改成你選的主題的名稱並重啟，往後就能使用同一種主題了：

```shell
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\negligible.omp.json" | Invoke-Expression
```

---

## 3/ Terminal-Icons 讓資料結構變得更 Fancy

平常 `ls` 指令打下去後就是一連串文字，不光是醜，也有點難以辨識。   
Terminal-icons 可以解決這個問題，會根據不同的副檔名加上 icon。    

![Terminal-Icon Example](terminal_icon_example.webp)
_使用 terminal-icon 讓 ls 的結果更好看_

安裝方法也很簡單，輸入這個指令安裝：

```shell
Install-Module -Name Terminal-Icons -Repository PSGallery -Force
```

然後一樣把 init 的指令丟到 `$profile` 裡面：

```shell
Import-Module -Name Terminal-Icons
```

重啟 PowerShell 後的 `ls` 應該都會漂漂亮亮了。    

---

## 4/ 善用 Alias 模擬 Linux 指令環境

PowerShell 中的指令主要是 `cmdlet`，長得像是 `Get-Command` 或是 `Set-Location`，如果是習慣使用 Linux 指令的玩家可能會有不好的遊戲體驗。    
（謎之音：你怎麼不買 Macbook）    
（另一個在哭的謎之音：公司不提供嗚嗚）    

因為從上大學開始使用的幾乎都是 Windows 筆電所以沒有多少可以分享，而且像 `ls` 、 `mkdir` 這種常用的指令也能夠順利在 PowerShell 中運行。    
不過可以推薦一個好用指令 `open` ，在 Linux 中可以開啟類似檔案總管的 GUI，有的時候還是挺方便。    
這個指令在 PowerShell 中叫做 `Invoke-Item` ，在 `$profile` 中加入 alias 就可以使用：

```shell
Set-Alias -Name open -Value Invoke-Item
```
---

## 總結

本篇的分享就到這裡，因為大多是下載、設定的內容，也就沒有多少個人經驗可以分享。    
不過這些設定完成後，就可以嘗試像我一樣愛上 command line 了吧！    

在這些基本的設定完成後，也推薦各位根據實際應用情況下載其他好用的小工具，例如 docker 相關啦、call API 相關啦、WebSocket 監聽相關啦的工具，PowerShell 7 的社群力量非常強大。    
而且 Windows Terminal 的原生設定也有一些可玩的地方。    

另外另外，Windows 11 從版本 24H2 後開始支援 `sudo` 指令！！    
（還沒 update 都給我去 update！）    
如果是 Windows 10 玩家可以去下載 [gsudo](https://github.com/gerardog/gsudo)，往後即便突然需要權限，也不需要按右鍵點選「以管理員身份執行」。    

在設定過程中有遇到什麼瓶頸或是好玩的看法都可以底下留言討論，就算沒有也可以給我一個表情符號讓我知道對你有幫助~    

