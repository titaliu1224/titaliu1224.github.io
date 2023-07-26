---
title: "影像處理小白（六）：Run-Length Encoding 壓縮圖片"
date: 2023-06-08 22:24:00 +0800

tags: 
  - Python
  - OpenCV
  - image processing
  - RLE
  - compression

categories: [Python, 影像處理]

math: true

img_path: ../../assets/img/posts/convert_image_to_frequency_domain
---

這是學校選修課的功課紀錄，同步發布於 [該課程 Blogger](https://yzucs362hw.blogspot.com/2023/06/s1091444-6.html) <br>

## 功課要求

附件中為三張利用將晶片高度以色彩視覺化後的圖片。 
請設計一個基於Run-Length 的壓縮法方，對圖檔作無失真壓縮後儲存成新檔案。 
 
部落格上應敘述你的壓縮方法，提供壓縮檔之格式，並計算三張圖的平均壓縮率
(compression ratio)。

![要壓縮的圖片]([https://github.com/titaliu1224/Image-Processing/blob/main/Assignment6/result.png](https://github.com/titaliu1224/Image-Processing/blob/main/Assignment6/result.png?raw=true)){: w="650", h="650"}

## 成果
![python 跑完後的 cmd 輸出]([https://github.com/titaliu1224/Image-Processing/blob/main/Assignment6/result2.png](https://github.com/titaliu1224/Image-Processing/blob/main/Assignment6/result2.png?raw=true)){: w="500", h="500"}
_得到檔案的壓縮率與平均壓縮率_

## 開發環境

| OS         | Editor             | Language      | OpenCV       |
|------------|--------------------|---------------|--------------|
| Windows 10 | Visual Studio Code | Python 3.9.16 | OpenCV 4.5.4 |

## 實作
> [本次程式碼](https://github.com/titaliu1224/Image-Processing/blob/main/assignment6/main.py)

使用的 libraries 如下：

```py
import cv2, os
import matplotlib.pyplot as plt
import numpy as np
```

### 1/ 利用迴圈讀入三張圖片

建立一個儲存三張圖片路徑的 list ，使用迴圈讀入圖片並送至 `compress(original_img, compress_file)` 進行壓縮，取得壓縮率並儲存在 `compress_ratio[i]` 中。 <br>


```py
def main():
    img_path = ["img1.bmp", "img2.bmp", "img3.bmp"]
    compress_path = ["img1.dat", "img2.dat", "img3.dat"]
    # 跑過三張圖片
    compress_ratio = [0, 0, 0]
    print("| Image Name | Original Size  | Compress Size  | Compression Ratio |")
    print("| ---------- | -------------- | -------------- | ----------------- |")
    for i in range(0, len(img_path)):
