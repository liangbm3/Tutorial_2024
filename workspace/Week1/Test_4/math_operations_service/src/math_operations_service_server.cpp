#include <ros/ros.h>
#include <math_operations_service/MathOperations.h> // 引入自定义服务消息头文件

// 处理数学运算请求的回调函数
bool handle_math_operations(math_operations_service::MathOperations::Request &req,
math_operations_service::MathOperations::Response &res) {
    // 计算两数之和
    res.sum = req.num1 + req.num2;
    // 计算两数之积
    res.product = req.num1 * req.num2;
    // 判断两数是否相等
    res.are_equal = (req.num1 == req.num2);
    ROS_INFO("Request: num1=%ld, num2=%ld; Sending back response: sum=%ld, product=%ld, are_equal=%s",
             req.num1, req.num2, res.sum, res.product, res.are_equal? "True" : "False");
    return true; // 返回成功
}

int main(int argc, char **argv) {
    ros::init(argc, argv, "math_operations_service_server"); // 初始化节点
    ros::NodeHandle n; // 创建节点句柄

    // 创建服务，注册到名为 "math_operations" 的服务上
    ros::ServiceServer service = n.advertiseService("math_operations", handle_math_operations);
    ROS_INFO("Ready to perform math operations."); // 打印日志信息
    ros::spin(); // 进入循环，等待服务请求

    return 0; // 返回成功
}