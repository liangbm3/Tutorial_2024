import cv2
import numpy as np
import matplotlib.pyplot as plt

# 图像读取
img = cv2.imread('data/opencv/luna.jpg')

# Canny边缘检测：去除噪声(高斯滤波)-计算图像梯度(Sobel滤波器)-非极大值抑制-滞后阈值(2个)
lowThreshold = 1
max_lowThreshold = 80
canny = cv2.Canny(img, lowThreshold, max_lowThreshold)

# 图像展示
plt.figure(figsize=(8, 5), dpi=100)
plt.rcParams['axes.unicode_minus'] = False
plt.subplot(121), plt.imshow(img, cmap=plt.cm.gray), plt.title("Original")
plt.xticks([]), plt.yticks([])
plt.subplot(122), plt.imshow(canny, cmap=plt.cm.gray), plt.title("Edge Detection")
plt.xticks([]), plt.yticks([])

plt.savefig('./runs/opencv/detect_image.png')
plt.show()

