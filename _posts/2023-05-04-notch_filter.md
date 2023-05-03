---
title: "影像處理小白（四）：利用頻域圖像消除週期性雜訊"
date: 2023-05-04 01:30:00 +0800

tags: 
  - Python
  - OpenCV
  - image processing
  - DFT
  - noise reduction
  - frequency domain
  - notch filter

categories: [Python, 影像處理]

math: true

img_path: ../../assets/img/posts/convert_image_to_frequency_domain
---

這是學校選修課的功課紀錄，同步發布於 [該課程 Blogger](https://yzucs362hw.blogspot.com/2023/05/s1091444-4.html) <br>

## 功課要求

圖片似乎受到某種頻域雜訊干擾，撰寫一個程式嘗試復原此圖像。

![受干擾的圖片](https://github.com/titaliu1224/Image-Processing/blob/main/assignment4/image4.png?raw=true){: w="500", h="500"}

## 成果
![復原圖像過程](https://github.com/titaliu1224/Image-Processing/blob/main/assignment4/result.png?raw=true){: w="650", h="650"}
_程式完成後的執行結果_

## 開發環境

| OS         | Editor             | Language      | OpenCV       |
|------------|--------------------|---------------|--------------|
| Windows 10 | Visual Studio Code | Python 3.9.16 | OpenCV 4.5.4 |

## 實作
> [本次程式碼](https://github.com/titaliu1224/Image-Processing/blob/main/assignment4/main.py)

使用的 libraries 如下：

```py
import cv2
import matplotlib.pyplot as plt
import numpy as np
```

### 1/ 使用 DFT 取得頻域圖像與頻譜圖

這裡可以去看 [影像處理小白（三）：使用 DFT 將影像轉換至頻域](/posts/convert_image_to_frequency_domain/) ，步驟都一樣。

### 2/ 用滑鼠點選 notch points

notch point 通常用來消除圖像上的特定頻率，這裡我們透過觀察，可以發現頻譜圖上有六個週期性出現的亮點，所以來進行手動選取。<br>
建立一個 function 將點擊處的值設為 0:

```py
def add_notch_point(event, x, y, flags, img):
    # if button is clicked, mark the point
    if event == cv2.EVENT_LBUTTONDOWN:
        print("added nothch point at: ", x, y)
        # draw a circle
        cv2.circle(img, (x, y), 20, 0, -1)
```

使用 `cv2.setMouseCallback()` 建立一個可供點擊的視窗：
```py
# mouse click to find notch points
notch_points_img = np.ones(magnitude.shape, dtype=np.uint8)
cv2.namedWindow('Frequency Domain Image')
cv2.setMouseCallback('Frequency Domain Image', add_notch_point, notch_points_img)
cv2.imshow('Frequency Domain Image', magnitude)
cv2.waitKey(0)
```

在這裡就能知道當時有平移 DFT 圖像的好處了，可以很快的發現哪些亮點是週期性的重複出現。

### 3/ 平移得到的 notch points 圖像

剛才我們都是看著平移過的頻譜圖進行點擊，但原先的 DFT 結果並非這樣，所以我們要反向的把 notch points 圖像給平移回來。

```py
# swap notch points to match dft_A
tmp = np.copy(notch_points_img[0:cy, 0:cx])
notch_points_img[0:cy, 0:cx] = notch_points_img[cy:dft_A.shape[0], cx:dft_A.shape[1]]
notch_points_img[cy:dft_A.shape[0], cx:dft_A.shape[1]] = tmp
tmp = np.copy(notch_points_img[0:cy, cx:dft_A.shape[1]])
notch_points_img[0:cy, cx:dft_A.shape[1]] = notch_points_img[cy:dft_A.shape[0], 0:cx]
notch_points_img[cy:dft_A.shape[0], 0:cx] = tmp
```

### 4/ 套用 notch filter

將原本的 DFT 圖像的兩個通道和平移過的 notch filter 相乘，消除滑鼠點過的黑點部分，週期性雜訊就會被去除掉。

```py
# apply notch filter
planes[0] = planes[0] * notch_points_img
planes[1] = planes[1] * notch_points_img
dftB = cv2.merge(planes)
```

### 5/ 反向 DFT



### 6/ 還原圖片

最後使用 DFT 得出的 `dft_A` 來還原圖片，使用 `cv2.idft()` 做反向的傅立葉轉換， `cv2.split()` 與 `cv2.magnitude()` 取得轉換後的影像， normalize 後就能以 unsigned 8 bits 的方式輸出灰階影像。

```py
# get inverse dft
cv2.idft(dft_A, dft_A)
cv2.split(dft_A, planes)
# get inverse image
inverse_img = cv2.magnitude(planes[0], planes[1])
# normalize to 0~255
cv2.normalize(inverse_img, inverse_img, 0, 255, cv2.NORM_MINMAX)
# convert to 8 bit unsigned integer
inverse_img = inverse_img.astype(np.uint8)
# show inverse image
plt.subplot(2, 2, 4)
plt.imshow(inverse_img, cmap='gray')
plt.title("Inverse Image")
plt.axis("off")

plt.show()
```

## 總結

DFT 能將影像從時域轉至頻域，可以用來找出影像中週期性出現的雜訊。

## 參考資料

- [【沒錢ps,我用OpenCV!】Day 14 - 進階修圖1，運用 OpenCV 顯示圖片直方圖、分離與合併RGB通道 show histogram, split, merge RGB channel](https://ithelp.ithome.com.tw/articles/10244284)
- [Opencv 例程講解7 ---- DFT圖像傅立葉變換](https://www.twblogs.net/a/5b83abae2b71777a2efcdd07)
- [圖解傅立葉分析](https://hackmd.io/@sysprog/fourier-transform?utm_source=pocket_saves)
