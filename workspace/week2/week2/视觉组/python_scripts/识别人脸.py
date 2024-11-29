import cv2

# 加载预训练的人脸检测模型
face_cascade = cv2.CascadeClassifier(cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')

image = cv2.imread('data/opencv/friends.jpg')
gray_image = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

# 检测人脸
faces = face_cascade.detectMultiScale(gray_image, scaleFactor=1.1, minNeighbors=5, minSize=(30, 30))

# 绘制矩形框
for (x, y, w, h) in faces:
    cv2.rectangle(image, (x, y), (x+w, y+h), (255, 0, 0), 5)

cv2.imwrite("runs/opencv/friends.jpg",image)

cv2.imshow('Face Detection', image)
cv2.waitKey(0)
cv2.destroyAllWindows()