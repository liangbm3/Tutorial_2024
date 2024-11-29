#-----------------------------------------------------------------------
# FileName：image_processing.py
# Author: @Ethan-Zhengsy
# Version: 1.0.0
# Date: 2024.11.29
#-----------------------------------------------------------------------
# Discription: 利用 OpenCV 对任意一张图片进行 
#               灰度化、高斯模糊、边缘检测、膨胀、腐蚀 等基础处理操作。
# Function List: 
#       1. imread:      读取图片（内部的参数为图片所在的路径
#       2. cvtColor:    转变图片的颜色，这里选择灰色做灰化
#       3. blurred :    高斯模糊
#       4. Canny:       检测图片的边缘
#       5. dilate:      对图片做膨胀处理
#       6. erode:       对图片做腐蚀处理
#       7. imshow：     显示图片
#       8. waitkey:     等待特定键盘输入
#       9. destroyAllWindows:  释放内存
#       10.imwrite:     保存图片
#------------------------------------------------------------------------

import cv2
import numpy as np

# 读取图片
image = cv2.imread('/mnt/hgfs/Ubuntu-20.04.6-sharefiles/UbuntuOpencvFile/Week2Task1/IMG_20230831_120526.jpg')

# 灰度化
gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# 高斯模糊
blurred = cv2.GaussianBlur(gray, (5, 5), 0)

# 边缘检测
edges = cv2.Canny(blurred, 100, 200)

# 膨胀
dilated = cv2.dilate(edges, None, iterations=1)

# 腐蚀
eroded = cv2.erode(dilated, None, iterations=1)

# 显示图片
cv2.imshow('Original', image)
cv2.imshow('Gray', gray)
cv2.imshow('Blurred', blurred)
cv2.imshow('Edges', edges)
cv2.imshow('Dilated', dilated)
cv2.imshow('Eroded', eroded)

# 等待按键后关闭所有窗口
cv2.waitKey(0)
cv2.destroyAllWindows()

cv2.imwrite('gray.jpg', gray)
cv2.imwrite('blurred.jpg', blurred)
cv2.imwrite('edges.jpg', edges)
cv2.imwrite('dilated.jpg', dilated)
cv2.imwrite('eroded.jpg', eroded)
