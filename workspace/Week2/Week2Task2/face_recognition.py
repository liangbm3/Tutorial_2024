#-----------------------------------------------------------------------
# FileName：face_recognition.py
# Author: @Ethan-Zhengsy
# Version: 1.0.0
# Date: 2024.11.29
#-----------------------------------------------------------------------
# Discription: 利用 OpenCV 已有的库实现人脸识别 
# Function List: 
#       1. imread:      读取图片（内部的参数为图片所在的路径
#       2. cvtColor:    转变图片的颜色，这里选择灰色做灰化
#       3. CascadeClassifier:  级联分类器
#       4. detectMultiScale:   检测函数
#       5. rectangle:   绘制矩形
#       6. imshow:      显示图片处理结果
#       7. faceDetect:  封装人脸检测函数
#       8. waitkey:     等待特定键盘输入
#       9. destroyAllWindows:  释放内存
#       10.imwrite:     保存图片
#------------------------------------------------------------------------

import cv2

def faceDetect():
    #转换为灰度图
    gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    # 加载预训练的人脸检测模型
    face_cascade = cv2.CascadeClassifier('/home/ethan/opencv-4.5.5/data/haarcascades/haarcascade_frontalface_default.xml')
    # 检测人脸
    faces = face_cascade.detectMultiScale(gray, scaleFactor=1.1, minNeighbors=5, minSize=(300, 300), maxSize = (800, 800))
    # 绘制矩形框
    for (x, y, w, h) in faces:
        cv2.rectangle(img, (x, y), (x+w, y+h), (255, 0, 0), 2)
    # 显示结果
    cv2.imshow('Face Detection', img)

# 加载图像
img = cv2.imread('/mnt/hgfs/Ubuntu-20.04.6-sharefiles/UbuntuOpencvFile/Week2Task2/微信图片_20241128190549.jpg')

#检测函数
faceDetect()

#等待
while True:
    if ord('q') == cv2.waitKey(0):
        break

#释放内存
cv2.destroyAllWindows()

# 保存结果图像
success = cv2.imwrite('output_image.jpg', img)
if not success:
    print("Failed to save the image.")