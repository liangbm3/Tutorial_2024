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