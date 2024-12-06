#include <cstdio>
#include <iostream>
#include <string>
#include <stdexcept>
#include <ros/ros.h>
#include <std_msgs/String.h>
#include <opencv2/opencv.hpp>
#include <cv_bridge/cv_bridge.h>
#include <sensor_msgs/image_encodings.h>
#include <opencv2/opencv.hpp>
#include <nlohmann/json.hpp>

std::string detectGesture(const cv::Mat& frame) {
    // 创建一个临时文件名
    std::string tempImageFile = "/tmp/camera_frame.jpg";
    cv::imwrite(tempImageFile, frame); // 将图像保存到临时文件

    // 构建调用detect.py的命令
    std::string command = "python /home/ethan/yolov5/detect.py --weights /home/ethan/yolov5/weights/best.pt --source" + tempImageFile;

    // 使用popen执行命令并读取输出
    std::array<char, 128> buffer;
    std::string json_output;
    std::unique_ptr<FILE, decltype(&pclose)> pipe(popen(command.c_str(), "r"), pclose);
    if (!pipe) {
        throw std::runtime_error("popen() failed!");
    }
    while (fgets(buffer.data(), buffer.size(), pipe.get()) != nullptr) {
        json_output += buffer.data();
    }

    // 删除临时文件
    std::remove(tempImageFile.c_str());

    // 解析 JSON 输出
    nlohmann::json j = nlohmann::json::parse(json_output);
    std::string result;

    // 第一个检测到的对象的类别
    if (!j["detections"].is_null() && !j["detections"].empty()) {
        auto& detection = j["detections"][0];
        result = detection["class"].get<std::string>();
    }

    if (result.empty()) {
        throw std::runtime_error("No output from detect.py or no detections found");
    }

    return result;
}

void imageCallback(const sensor_msgs::ImageConstPtr& msg) {
    try {
        cv::Mat frame = cv_bridge::toCvShare(msg, sensor_msgs::image_encodings::BGR8)->image;
        // 调用YOLOv5进行手势识别
        std::string gesture = detectGesture(frame);
        std_msgs::String msg;
        msg.data = gesture;
        ros::NodeHandle nh;
        ros::Publisher gesture_pub = nh.advertise<std_msgs::String>("gesture_topic", 1);
        gesture_pub.publish(msg);
    } catch (const cv_bridge::Exception& e) {
        ROS_ERROR("Could not convert from '%s' to 'bgr8'.", msg->encoding.c_str());
    } catch (const std::runtime_error& e) {
        ROS_ERROR("Error during gesture detection: %s", e.what());
    }
}

int main(int argc, char** argv) {
    ros::init(argc, argv, "gesture_publisher");
    ros::NodeHandle nh;
    ros::Subscriber image_sub = nh.subscribe("/camera/image_raw", 10, imageCallback);
    ros::spin();
    return 0;
}