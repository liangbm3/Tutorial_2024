#include "ros/ros.h"
#include "simple_service_communication/Service.h"

bool calculate(simple_service_communication::Service::Request &req,
               simple_service_communication::Service::Response &res) {
    // 设置本地语言环境，防止输出中文乱码
    setlocale(LC_ALL, "");
    // 打印接收到的数字
    ROS_INFO("接收到的数字: a = %d, b = %d", req.a, req.b);
    res.sum = req.a + req.b;
    res.product = req.a * req.b;
    res.equal = req.a == req.b;
    return true;
}

int main(int argc, char **argv) {
    ros::init(argc, argv, "service_server");
    ros::NodeHandle nh;
    //链接客户端
    ros::ServiceServer service = nh.advertiseService("calculate_service", calculate);
    
    ros::spin();
    
    return 0;
}