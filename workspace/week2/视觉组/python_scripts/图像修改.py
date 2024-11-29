import cv2

image=cv2.imread("data/opencv/a.jpg")

# ===================================================

# ==================一些属性===========================
print(image.shape)  # 图像的形状(H行数,W列数,C):(960, 960, 3)
                    ## 如果是二值图像或者灰度图像，则仅返回行数和列数
print(image.size)   # 像素数目 H*W*C:2764800
print(image.dtype)  # 图像的数据类型:uint8
# ===================================================

# ====================颜色空间转换=====================
img=cv2.cvtColor(image,cv2.COLOR_BGR2GRAY)
cv2.imwrite("./runs/opencv/edit_image.jpg",img)
# 主要是RGB,BGR,GRAY,HSV,LAB,YCrCb
## cv2.COLOR_BGR2GRAY
## cv2.COLOR_HSV2BGR
## cv2.COLOR_GRAY2RGB
## cv2.COLOR_BGR2LAB
## cv2.COLOR_BGR2YCrCb
# ===================================================