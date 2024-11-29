import cv2

# 读取图片
image = cv2.imread('image.png')

# 灰度化
gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# 高斯模糊
blurred_image = cv2.GaussianBlur(image, (5, 5), 0)

# 边缘检测
edges = cv2.Canny(image, 100, 200)

# 膨胀操作
kernel = cv2.getStructuringElement(cv2.MORPH_RECT, (3, 3))
dilated_image = cv2.dilate(image, kernel, iterations = 1)

# 腐蚀操作
eroded_image = cv2.erode(image, kernel, iterations = 1)

# 显示结果
cv2.imshow('Original Image', image)
cv2.imshow('Gray Image', gray_image)
cv2.imshow('Blurred Image', blurred_image)
cv2.imshow('Edges', edges)
cv2.imshow('Dilated Image', dilated_image)
cv2.imshow('Eroded Image', eroded_image)
cv2.waitKey(0)
cv2.destroyAllWindows()