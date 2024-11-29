author：@kanning666
# 1. 安装OpenCV
## **1.1 直接在软件源安装并且验证**
---
- **因为我week1安装的Ubuntu是20.04.6版本的，如果直接从源软件包下载OpenCV的话，他自动配备的OpenCV版本是4.2.0，会与教程中的Ubuntu18.04有点细微的差别，但大体是一样的**
### 1.1.1 安装OpenCV
```
# 安装 Python 3 接口
$ sudo apt install python3-opencv
```

```
# Python 3

$ python3
Python 3.6.4+ (default, Feb 12 2018, 08:25:03) 
[GCC 7.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> import cv2
>>> cv2.__version__
'3.2.0'
>>>
```
### 1.1.2 验证编译
- 把`CV_LOAD_IMAGE_COLOR`换成`IMREAD_COLOR`OpenCV4.x表达
```
#include <iostream>
// OpenCV library headers
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>

using namespace cv;
using std::cout;
using std::endl;

int main(int argc, char** argv) {
    if (argc != 2)
    {
        cout << " Usage: display_image ImageToLoadAndDisplay" << endl;
        return -1;
    }

    Mat image;
    // Use cv::IMREAD_COLOR instead of CV_LOAD_IMAGE_COLOR
    image = imread(argv[1], IMREAD_COLOR);  // Read the file

    if (!image.data) // Check for invalid input
    {
        cout << "Could not open or find the image" << endl;
        return -1;
    }

    namedWindow("Display window", WINDOW_AUTOSIZE); // Create a window for display.
    imshow("Display window", image); // Show our image inside it.

    waitKey(0); // Wait for a keystroke in the window
    return 0;
}

```
- 并且在***编译***时将`opencv` 变成 `opencv4`
```
$ g++ display_image.cpp -o display_image `pkg-config --cflags --libs opencv4`
```
- 查看图片
```
$ ./display_image <图片的路径>
```
[testpicture](image/testpicture.png)

# 2.学会使用opencv一些简单的基础功能

## **2.1 在Windows主机和Ubuntu虚拟机中设置共享文件夹**
- 目的为传输图片文件
1. 打开Ubuntu终端，创建挂载点
```
sudo mkdir -p /mnt/hgfs
```
2. 手动挂载文件夹,共享文件夹名称为`Ubuntu共享文件夹`
```
sudo vmhgfs-fuse .host:/Ubuntu共享文件夹 /mnt/hgfs -o allow_other
```
3. 检查挂载成功
```
ls /mnt/hgfs
```
[share](image/share.png)
4. 将共享文件夹中内容复制到要提交的存放图片的文件夹
```
sudo rsync -av /mnt/hgfs/test1.jpg /home/kanning/projects/Tutorial/workspace/week2/image/
```

## **2.2 编写代码**
打开`week2/foundation`文件夹，编写.cpp 文件
```
#include<opencv2/opencv.hpp>

#include<iostream>

  

int main(){

    //读取图片

    std::string image_path = "test1.jpg";

  

    int op = 0;

    cout << "请输入操作类型：1.读取图片 2.灰度化 3.高斯模糊 4.边缘检测 5.膨胀 6.腐蚀";

    cin >> op;

    //读取图片

    cv::Mat image = cv::imread(image_path);

    if(image.empty()){

        std::cerr << "图片加载失败！" << std::endl;

        return -1;

    }

  

    //灰度化

    cv::Mat gray;

    cv::cvtColor(image, gray, cv::COLOR_BGR2GRAY);

  

    //高斯模糊

    cv::Mat gaussianBlur;

    cv::GaussianBlur(gray, gaussianBlur, cv::Size(5, 5), 0);

  

    //边缘检测

    cv::Mat edges;

    cv::Canny(gaussianBlur, edges, 100, 200);

  

    //膨胀

    cv::Mat dilated;

    cv::Mat kernel = cv::getStructuringElement(cv::MORPH_RECT, cv::Size(5, 5));

    cv::dilate(edges, dilated, kernel);

  

    //腐蚀

    cv::Mat eroded;

    cv::erode(dilated, eroded, kernel);

  

    //显示结果

    switch(op){

        case 1:

            cv::imshow("Origunal", image);

            break;

        case 2:

            cv::imshow("Gray", gray);

            break;

        case 3:

            cv::imshow("Guassian Blur", gaussianBlur);

            break;

        case 4:

            cv::imshow("Edges", edges);

            break;

        case 5:

            cv::imshow("Dilated", dilated);

            break;

        case 6:

            cv::imshow("Eroded", eroded);

            break;

        default:

            std::cerr << "操作类型错误！" << std::endl;

            return -1;

    }

  

    //用户选择退出

    cv::waitKey(0);

    cv::destroyAllWindows();

  

    return 0;

}
```

再编写`Makefile`编译文件
```
# 定义编译器
CXX = g++

# 定义编译器选项
CXXFLAGS = -Wall -g `pkg-config --cflags opencv4`
LDFLAGS = `pkg-config --libs opencv4`

# 定义目标文件名
TARGET = foundation

# 定义源文件
SRC = foundation.cpp

# 默认规则
all: $(TARGET)

# 编译规则
$(TARGET): $(SRC)
        $(CXX) $(CXXFLAGS) -o $(TARGET) $(SRC) $(LDFLAGS)

# 清理规则
clean:
        rm -f $(TARGET)

```

在终端编译运行
```
$ make
$ ./foundation
```

1. 显示图片 [f1](image/f1.png)
2. 灰度化 [f2](image/f2.png)
3. 高斯模糊 [f3](image/f3.png)
4. 边缘检测 [f4](image/f4.png)
5. 膨胀 [f5](image/f5.png)
6. 腐蚀 [f6](image/f6.png)


# 3.学会运用人脸检测
请打开`face_detect`文件夹
## **3.1 代码示例**
```
#include<opencv2/opencv.hpp>
#include<opencv2/objdetect.hpp>
#include<opencv2/highgui.hpp>
#include<opencv2/imgproc.hpp>
#include<iostream>

using namespace std;

int main(){
    //加载人脸检测的Haar特征分类器
    cv::CascadeClassifier face_cascade;
    if(!face_cascade.load("/usr/share/opencv4/haarcascades/haarcascade_frontalface_default.xml")){
        cerr << "错误加载人脸检测的Haar特征分类器" << endl;
        return -1;
    }

    //读取图像
    cv::Mat img = cv::imread("/home/kanning/projects/Tutorial/workspace/week2/image/face_test.jpg");
    if(img.empty())
    {
        cerr << "读取图像失败！" << endl;
        return -1;
    }

    //灰度化
    cv::Mat gray;
    cv::cvtColor(img, gray, cv::COLOR_BGR2GRAY);
    cv::equalizeHist(gray, gray);

    //人脸检测
    vector<cv::Rect> faces;
    face_cascade.detectMultiScale(gray, faces);

    //在图像中绘制检测到的人脸
    for (size_t i = 0; i < faces.size();i++)
    {
        cv::rectangle(img, faces[i], cv::Scalar(255, 0, 0), 2);
    }

    //显示图像结果
    cv::imshow("result face detect", img);
    cv::waitKey(0);

    return 0;
}
```

## **3.2 MakeFile编译**
```
CXX=g++
CXXFLAGS=`pkg-config --cflags opencv4`
LDFLAGS=`pkg-config --libs opencv4`

TARGET = face_detect
SOURCES = face_detect.cpp

all: $(TARGET)

$(TARGET): $(SOURCES)
	$(CXX) $(CXXFLAGS) $(SOURCES) -o $(TARGET) $(LDFLAGS)

clean:
	rm -f $(TARGET)
```

## **3.3 结果示例**
[face_detect](image/face_detect.png)

# 4.配置Python并安装anaconda，管理环境
## **4.1 配置Python**
[python](image/python.png)
## **4.2 安装anaconda**
[anaconda](image/anaconda.png)
## **4.3 用anaconda管理环境**
### 4.3.1 创建虚拟环境
```
conda create -n py3.10 python=3.10
```
[python1](python1.png)
### 4.3.2 查看已安装的Python虚拟环境
```
conda env list
```
[python2](python2.png)
### 4.3.3 删除创建的虚拟环境
```
conda remove -n py3.10 --all
```
[python3](pyhton3.png)

# 5. yolov5
## **5.1 创建自己的环境**
```
conda create -n My_torch python=3.8
```
## **5.2 预权重模型**
在gitee上下载了个代码模型，进入我的环境`My_torch`，用vscode打开`detect.py`，在`/data/images`中放入自己拍摄的照片，运行，在`/runs`里面查看检测的图片
[test2](image/test2.jpg)


# **6. 对接口的理解**
1. **灰度化**
将彩色图像变成灰色图像，通过调整RGB的值来完成
2. **高斯模糊**
降低了图像的噪点，使图片变得有些模糊平滑
3. **边缘检测**
检测图像的线条，也就是边缘
4. **膨胀**
增大了图像的边缘，使线条变粗，或增大白色边界
5. **腐蚀**
比边缘检测线条粗糙了些，或者说去掉了一些噪点（？）