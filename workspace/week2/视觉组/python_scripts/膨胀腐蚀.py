import cv2
import numpy as np
import matplotlib.pyplot as plt

# 图像读取
img_org = cv2.imread('data/opencv/example_org.jpg')
img_noise = cv2.imread('data/opencv/example_noise.jpg')

# 创建核结构np.ones(shape,dtpye=None,order='C)
kernel = np.ones((10, 10), np.uint8)  # 10*10的全1矩阵

# 形态学处理
erosion_img = cv2.erode(img_org, kernel)  # 腐蚀  (输入图像, kernel, 迭代次数iteration)
dilate_img = cv2.dilate(img_org, kernel)  # 膨胀
# (输入图像,操作类型,kernel核大小)

# 图像显示
# matplotlib.pyplot.figure(画像编号或名称, figsize画像的宽和高, dpi像素数, facecolor背景颜色, edgecolor边框颜色, frameon是否绘制画像, FigureClas选用的自定义Figure, clear是否清除原有画像)
plt.figure(figsize=(10,6), dpi=100)
plt.rcParams['axes.unicode_minus'] = False

plt.subplot(121), plt.imshow(img_org), plt.title("Original")
plt.xticks([]), plt.yticks([])  # 不显示坐标轴
plt.subplot(122), plt.imshow(erosion_img), plt.title("Erosion")
plt.xticks([]), plt.yticks([])

plt.savefig('./runs/opencv/derodila_image.png')
plt.show()

