#include<opencv2/opencv.hpp>
#include<iostream>

using namespace std;

int main(){
    //读取图片
    std::string image_path = "test1.jpg";

    int op = 0;
    cout << "请输入操作类型：1.读取图片 2.灰度化 3.高斯模糊 4.边缘检测 5.膨胀 6.腐蚀"<< endl;
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