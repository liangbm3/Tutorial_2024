# 第二周任务说明

---
- Author: 郑思扬
- Reviced: 郑思扬
- Date: 2024-11-29
- Version: 1.0.0
- Abstract: 空队第二周任务说明

---
## 安装opencv
1. 从官网上下载 **opencv源码**，我选择的是opencv4.5.5 source  
2. 安装依赖项  
```
$ sudo apt-get install build-essential libgtk2.0-dev libjpeg-dev  libtiff5-dev libopenexr-dev libtbb-dev
$ sudo apt-get install libavcodec-dev libavformat-dev libswscale-dev libgtk-3-dev libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev pkg-config
```
3. 安装opencv  
将opencv压缩包解压至 **home 目录**下
```
$ unzip opencv-4.5.5.zip
```  
&emsp;&emsp;创建 **build 文件夹**，进行 cmake 分析
```
$ cd opencv-4.5.5/
$ mkdir build
$ cd build
$ cmake ..
```
&emsp;&emsp;用 make 进行编译
```
$ sudo make -j4
```
&emsp;&emsp;编译过程可能耗时较长  
&emsp;&emsp;等待编译完成后进行安装
```
$ sudo make install
```
4. 配置环境变量
&emsp;&emsp;首先找到 **opencv4.pc** 的位置，例如我的就在 /usr/lib/x86_64-linux-gnu/pkgconfig/
```
$ locate opencv4.pc
```
&emsp;&emsp;然后将其改名为 **opencv.pc**
```
$ sudo mv opencv4.pc opencv.pc
```
&emsp;&emsp;修改 **/etc/ld.so.conf文件**
```
$ sudo gedit /etc/ld.so.conf
```
&emsp;&emsp;加入你的 opencv 路径
```
include /usr/lib/x86_64-linux-gnu
```
&emsp;&emsp;输入命令使得conf生效
```
$ sudo ldconfig
```
&emsp;&emsp;修改 **bash.bashrc文件**
```
$ sudo gedit /etc/bash.bashrc 
```
&emsp;&emsp;在末尾加入
```
PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export PKG_CONFIG_PATH
```
&emsp;&emsp;然后source使得bash生效
```
$ source /etc/bash.bashrc
```
&emsp;&emsp;最后验证是否安装配置成功
```
$ pkg-config opencv --modversion
```
&emsp;&emsp;若显示版本号则安装成功

---
## 任务一
#### 代码内容说明
> - Functions:   
>   &emsp;利用 OpenCV 对任意一张图片进行 灰度化、高斯模糊、边缘检测、膨胀、腐蚀 等基础处理操作。
> - Depend Libraries:  
>   &emsp;依赖 - opencv  
>   &emsp;依赖 - numpy
#### 代码
- [image_processing.py](./Week2Task1/image_processing.py)
```python
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

#保存处理过后的图片
cv2.imwrite('gray.jpg', gray)
cv2.imwrite('blurred.jpg', blurred)
cv2.imwrite('edges.jpg', edges)
cv2.imwrite('dilated.jpg', dilated)
cv2.imwrite('eroded.jpg', eroded)
```
#### 运行过程
&emsp;在程序所在的文件夹下打开终端  
&emsp;运行程序
```
$ python3 image_processing.py
```
即可查看到[处理结果](./Week2Task1)
- 灰度化
![灰度化](./Week2Task1/gray.jpg)
- 高斯模糊
![高斯模糊](./Week2Task1/blurred.jpg)
- 边缘检测
![边缘检测](./Week2Task1/edges.jpg)
- 膨胀
![膨胀](./Week2Task1/dilated.jpg)
- 腐蚀
![腐蚀](./Week2Task1/eroded.jpg)

---
## 任务二
#### 代码内容说明
> - Functions:   
>   &emsp;利用opencv已有的库实现人脸识别。
> - Depend Libraries:  
>   &emsp;依赖 - opencv
#### 代码
- [face_recognition.py](./Week2Task2/face_recognition.py)
```python
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
```
#### 运行过程
&emsp;在项目文件夹下打开终端，运行指令
```
$ python3 face_recognition.py
```
&emsp;即可看到[处理结果](./Week2Task2/output_image.jpg)
![处理结果](./Week2Task2/output_image.jpg)

---
## 配置yolov5
1. 从 **anaconda官网** 下载anaconda
2. 打开 **anaconda prompt**，cd到目标文件夹，创建 **python环境** 并激活
```
conda create -n pytorch_dl python=3.12
conda activate pytorch_dl
```
3. 配置pytorch  
确定**系统配置，包括操作系统、Python版本、CUDA版本**（如果有NVIDIA GPU）  
在pytorch官网上找到对应的安装指令并粘贴到 conda 中执行  
验证安装是否成功
```
python -c "import torch; print(torch.__version__)"
```
&emsp;&emsp;若显示 pytorch 版本则安装成功
4. 配置 yolov5  
将 yolov5的 **github 仓库**克隆到虚拟环境的文件夹中  
在 **anaconda prompt** 中cd到 yolov5的文件夹下
安装 yolov5 的依赖(可以换源下载)
```
pip install -r requirements.txt
```
&emsp;&emsp;到这里环境配置完成

---
## 任务三
#### 任务内容说明
> - Functions:   
>   &emsp;使用预训练权重yolov5s检测图片。
> - Depend Libraries:  
>   &emsp;依赖 - yolov5  
>   &emsp;依赖 - detect.py
#### 运行过程
&emsp;打开 **anaconda的虚拟环境**  
&emsp;cd到python解释器所在的文件夹,我的是
```
D:
cd D:\UserDFile\Pycharm\pytorch_dl
```
&emsp;然后激活 **python环境**
```
conda activate D:\UserDFile\Pycharm\pytorch_dl
```
&emsp;然后cd到包含[待处理图片](./Week2Task3/street.jpg)的文件夹，例如
```
cd D:\UserDFile\GithubFileClone\Tutorial_2024\workspace\Week2\Week2Task3
```
&emsp;运行指令
```
python D:/UserDFile/Pycharm/pytorch_dl/yolov5/yolov5/detect.py --weights yolov5s.pt --img 640 --conf 0.25 --source D:/UserDFile/GithubFileClone/Tutorial_2024/workspace/Week2/Week2Task3/street.jpg
```
&emsp;其中 D:/UserDFile/Pycharm/pytorch_dl/yolov5/yolov5/detect.py 换为你的 detect.py路径  
&emsp;D:/UserDFile/GithubFileClone/Tutorial_2024/workspace/Week2/Week2Task3/street.jpg 换位你的图片路径
&emsp;然后便可按提示在 yolov5\runs\detect\exp 中查看到[识别结果](./Week2Task3/street_recognition.jpg)
![识别结果](./Week2Task3/street_recognition.jpg)

---
## 附加任务
### 解释 opencv 函数接口实现原理
+ **imread ('path/to/image.jpg')**: 这个函数读取文件系统中指定路径的图像文件，并将其作为NumPy数组加载到内存中。图像数据通常以BGR（蓝、绿、红）的顺序存储，这是OpenCV处理图像的默认格式。如果图像文件不存在或者路径错误，函数会返回None。
+ ****cvtColor(src, code)**: 这个函数将图像从一个颜色空间转换到另一个颜色空间。在这个例子中，src是原始图像，code指定了转换的类型，这里是cv2.COLOR_BGR2GRAY，意味着将图像从BGR（OpenCV默认的颜色顺序）转换为灰度图像。转换过程涉及到对每个像素的BGR值进行加权求和，以计算出灰度值。
+ ****GaussianBlur(src, ksize, sigmaX)**: 这个函数应用高斯模糊来减少图像噪声和细节,通过与高斯核的卷积来平滑图像。src是输入图像。ksize是高斯核的大小，它必须是正数和奇数。sigmaX是高斯分布的标准差(高斯核在X方向上的标准差)，如果设置为0，OpenCV会根据ksize自动计算。高斯核中的每个值都是根据高斯概率密度函数计算的，核中的值与图像逐点相乘后求和，得到模糊后的像素值。
+ **Canny(image, threshold1, threshold2)**: 这个函数用于进行边缘检测，它使用Canny算法。image是输入的灰度图像，threshold1和threshold2是用于确定强边缘和弱边缘的阈值。Canny边缘检测算法包括几个步骤：首先使用高斯滤波器平滑图像以减少噪声，然后计算图像的梯度幅度和方向，接着非极大值抑制用于确保检测到的边缘是连续的，最后通过双阈值检测确定强边缘和弱边缘。
+ **dilate(src, kernel, iterations)**: 这个函数用于图像膨胀。src是输入图像，kernel是结构元素,定义了膨胀的形状和大小（在这个例子中没有指定，所以使用默认的3x3矩形结构元素），iterations是膨胀操作的次数。膨胀操作通过增加图像中的亮区域来强化图像中的白色区域（前景），通过将结构元素滑过图像，并在结构元素的每个位置将结构元素与图像的局部区域进行逻辑或操作来实现的。
+ **erode(src, kernel, iterations)**：这个函数用于图像腐蚀，与膨胀操作相反，它通过减少图像中的亮区域来强化图像中的黑色区域（背景）。src是输入图像，kernel和iterations的解释与dilate函数相同。腐蚀是通过将结构元素滑过图像，并在结构元素的每个位置，将结构元素与图像的局部区域进行逻辑与操作来实现的。
+ **imshow(winname, mat)**: 这个函数创建一个窗口，并在窗口中显示mat图像。如果窗口不存在，则创建它；如果窗口已存在，则将其带到前台。
+ **waitKey(delay)**: 这个函数等待指定的毫秒数，或者直到有按键按下。delay参数指定了等待的毫秒数。如果delay为0，函数会无限期等待用户的按键输入。如果delay为正数，函数等待指定的毫秒数，如果期间有按键按下，则返回按键的ASCII码，否则返回0。
+ **destroyAllWindows()**: 这个函数关闭所有由OpenCV创建的窗口。
+ **imwrite(filename, img)**: 这个函数将img图像保存到文件系统中的filename指定的路径。它支持多种图像格式，包括JPEG、PNG、BMP等。图像数据从NumPy数组转换为指定格式的文件。
+ **CascadeClassifier('path/to/cascade.xml')**: 这个函数加载一个预训练的级联分类器，用于对象检测。在这个例子中，它加载了一个Haar特征的级联分类器，专门用于人脸检测。haarcascade_frontalface_default.xml是OpenCV提供的预训练模型文件。
+ **face_cascade.detectMultiScale(image, scaleFactor, minNeighbors, minSize, maxSize)**: 这个函数用于在图像中检测对象。image是输入的灰度图像，scaleFactor是图像尺寸在每次图像缩放时乘以的因子，minNeighbors是每个候选矩形应该保留的邻近数目的最小值，minSize和maxSize分别是可以检测到的对象的最小尺寸和最大尺寸。这个函数会返回一个包含检测到的对象的矩形列表。
+ **rectangle(img, (x, y), (x+w, y+h), (255, 0, 0), thickness)**: 这个函数在图像上绘制一个矩形。img是输入图像，(x, y)是矩形的左上角坐标，(x+w, y+h)是矩形的右下角坐标，(255, 0, 0)是矩形的颜色（这里是蓝色），thickness 是矩形线条的厚度。
### yolov5 的视频流识别
#### 任务内容说明
> - Functions:   
>   &emsp;使用预训练权重yolov5s检测视频流。
> - Depend Libraries:  
>   &emsp;依赖 - yolov5  
>   &emsp;依赖 - detect.py
#### 运行过程
&emsp;打开 **anaconda的虚拟环境**  
&emsp;cd到python解释器所在的文件夹,我的是
```
D:
cd D:\UserDFile\Pycharm\pytorch_dl
```
&emsp;然后激活 **python环境**
```
conda activate D:\UserDFile\Pycharm\pytorch_dl
```
&emsp;运行指令
```
python D:/UserDFile/Pycharm/pytorch_dl/yolov5/yolov5/detect.py --weights D:/UserDFile/Pycharm/pytorch_dl/yolov5/yolov5/yolov5s.pt --source 0
```
&emsp;即可从弹窗中看到识别效果
&emsp;在命令行窗口中输入 ctrl+C 即可结束
### 附加任务
#### 任务内容说明
> - Functions:   
>   &emsp;使用预训练权重yolov5s检测视频流。
> - Depend Libraries:  
>   &emsp;依赖 - opencv
#### 代码
- [camera_publisher.py](./camera_publisher_subscriber/camera_publisher.py)
```python
#!/usr/bin/env python

import rospy
import cv2
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import sys

def main():
    # 初始化 ROS 节点
    rospy.init_node('opencv_camera_publisher', anonymous=True)

    # 设置发布话题
    image_pub = rospy.Publisher('/camera/image_raw', Image, queue_size=10)

    # 创建 CvBridge 对象
    bridge = CvBridge()

    # 打开摄像头
    cap = cv2.VideoCapture(0)  # 0 表示默认摄像头

    if not cap.isOpened():
        print("Error: Could not open video stream.")
        sys.exit()

    rate = rospy.Rate(10)  # 设置发布频率 10Hz

    while not rospy.is_shutdown():
        # 从摄像头读取图像
        ret, frame = cap.read()

        if not ret:
            print("Error: Failed to capture image.")
            break

        # 将 OpenCV 图像转换为 ROS 图像消息
        try:
            ros_image = bridge.cv2_to_imgmsg(frame, "bgr8")
        except Exception as e:
            print(e)
            continue

        # 发布图像消息
        image_pub.publish(ros_image)

        # 显示图像
        cv2.imshow("Camera", frame)

        # 按下 'q' 键退出
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

        rate.sleep()

    # 释放摄像头并关闭所有窗口
    cap.release()
    cv2.destroyAllWindows()

if __name__ == '__main__':
    main()
```
- [camera_subscriber.py](./camera_publisher_subscriber/camera_subscriber.py)
```python
#!/usr/bin/env python

import rospy
import cv2
from sensor_msgs.msg import Image
from cv_bridge import CvBridge

# 全局变量，用于存储CvBridge实例
bridge = CvBridge()

def image_callback(msg):
    try:
        # 将ROS图像消息转换为OpenCV图像
        cv_image = bridge.imgmsg_to_cv2(msg, desired_encoding='bgr8')
    except CvBridgeError as e:
        print(e)
        return

    # 将BGR图像转换为灰度图像
    gray_image = cv2.cvtColor(cv_image, cv2.COLOR_BGR2GRAY)

    # 显示灰度图像
    cv2.imshow("Gray Image", gray_image)
    cv2.waitKey(1)  # 等待1毫秒，以便屏幕更新

    # 当按下'q'键时，退出显示
    if cv2.waitKey(1) & 0xFF == ord('q'):
        cv2.destroyAllWindows()

def main():
    # 初始化ROS节点
    rospy.init_node('opencv_image_listener', anonymous=True)
    
    # 订阅图像话题
    rospy.Subscriber("/camera/image_raw", Image, image_callback)
    
    # 保持Python脚本运行，直到被终止
    rospy.spin()

if __name__ == '__main__':
    main()
```
#### 编译过程
&emsp;首先在虚拟机设置中将可移动设备->摄像头设置为连接（与主机断开）  
&emsp;安装摄像头驱动
```
$ sudo apt install v4l-utils
```
&emsp;然后设置权限，并重启虚拟机
```
$ sudo usermod -a -G video $(whoami)
```
&emsp;检测摄像头
```
$ v4l2-ctl --list-devices
```
&emsp;在 ROS 工作区创建新的 package
```
$ catkin_create_pkg camera_publisher_subscriber roscpp rospy std_msgs geometry_msgs turtlesim
```
&emsp;将 camera_publisher.py 和 camera_subscriber.py 粘贴到src文件夹中
&emsp;更改 package.xml, 加入
```
<exec_depend>sensor_msgs</exec_depend>
<exec_depend>cv_bridge</exec_depend>
```
&emsp;更改 CMakeLists.txt
&emsp;在 find_package 中加入 cv_bridge
&emsp;在 install 前加入
```
catkin_install_python(PROGRAMS
  src/camera_publisher.py
  src/camera_subscriber.py
  DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
```
&emsp;**回到工作空间根目录**，尝试编译
```
$ source devel/setup.bash
$ catkin_make
```
#### 运行过程
&emsp;先运行一个 ros master, ctrl + alt + t 打开一个新终端
```
$ roscore
```
&emsp;在工作区 catkin_ws 下打开终端  
&emsp;先设置**环境变量**
```
$ source devel/setup.bash
```
&emsp;然后运行camera_subscriber.py
```
$ rosrun camera_publisher_subscriber camera_subscriber.py
```
&emsp;在工作区 catkin_ws 下打开终端  
&emsp;先设置**环境变量**
```
$ source devel/setup.bash
```
&emsp;然后运行camera_publisher.py
```
$ rosrun camera_publisher_subscriber camera_publisher.py
```
&emsp;即可看到运行结果