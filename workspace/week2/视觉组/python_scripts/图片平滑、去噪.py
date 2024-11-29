import cv2
import numpy as np
import matplotlib.pyplot as plt

# 图像读取
img = cv2.imread('data/opencv/noise.jpg')

# 图像平滑
# ## 均值滤波cv2.blur(输入图像, 卷积核的大小)
# ## 高斯滤波cv2.GaussianBlur(输入图像, 卷积核的大小, 水平方向的高斯核标准偏差, 垂直方向的高斯核标准偏差, 边界的填充类型)
# ## 中值滤波cv2.medianBlur(输入图像, 卷积核的大小)
blur1 = cv2.blur(img, (5, 5))   # 均值滤波
blur2 = cv2.GaussianBlur(img, (5, 5), 1)    # 高斯滤波
blur3 = cv2.medianBlur(img, 5)  # 中值滤波

# 图像显示
# ## plt.figure创建了一个图形窗口，大小为10x5英寸，分辨率为100（DPI）
# ## 使用plt.subplot(nrows, ncols, index)来创建子图
# ## plt.subplot(141)表示创建一个1行4列的子图网格，并激活第一个子图
# ## 分别显示原始图像和三种滤波后的图像
# ## plt.imshow用于显示图像，plt.title用于设置子图的标题
# ## plt.xticks([])和plt.yticks([])用于移除x轴和y轴的刻度标签

plt.figure(figsize=(10, 5), dpi=100)
plt.rcParams['axes.unicode_minus'] = False     # 确保在图中显示负号时不会出现方块或乱码

plt.subplot(141), plt.imshow(img), plt.title("Original")
plt.xticks([]), plt.yticks([])
plt.subplot(142), plt.imshow(blur1), plt.title("Mean Filtering")
plt.xticks([]), plt.yticks([])
plt.subplot(143), plt.imshow(blur2), plt.title("Gauss Filtering")
plt.xticks([]), plt.yticks([])
plt.subplot(144), plt.imshow(blur3), plt.title("Median Filtering")
plt.xticks([]), plt.yticks([])

plt.savefig('./runs/opencv/denoise_image.png')
plt.show()

