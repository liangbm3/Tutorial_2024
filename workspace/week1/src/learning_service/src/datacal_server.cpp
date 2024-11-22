#include <ros/ros.h>
#include "learning_service/datacal.h"

// service回调函数，输入参数req，输出参数res
bool datacalCallback(learning_service::datacal::Request  &req,
         			learning_service::datacal::Response &res)
{
    // 显示请求数据
    ROS_INFO("request: num1:%d  num2:%d", req.num1, req.num2);
    ROS_INFO("result: sum:%d  product:%d  isequal:%d", req.num1+req.num2, req.num1*req.num2, req.num1==req.num2);

	// 设置反馈数据
    res.result = "OK";

    return true;
}

int main(int argc, char **argv)
{
    // ROS节点初始化
    ros::init(argc, argv, "datacal_server");

    // 创建节点句柄
    ros::NodeHandle n;

    // 创建一个名为/show_datacal的server，注册回调函数datacalCallback
    ros::ServiceServer datacal_service = n.advertiseService("/show_datacal", datacalCallback);

    // 循环等待回调函数
    ROS_INFO("Ready to show calculation result.");
    ros::spin();

    return 0;
}



