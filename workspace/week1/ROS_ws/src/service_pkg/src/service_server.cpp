#include <ros/ros.h>
#include <service_pkg/TwoNumbers.h>

bool handle_request(service_pkg::TwoNumbers::Request &req,
                    service_pkg::TwoNumbers::Response &res)
{
    //定义三种运算
    res.sum = req.a + req.b;
    res.product = req.a * req.b;
    res.is_equal = (req.a == req.b);
    //打印三种运算结果
    ROS_INFO("Received: a=%d, b=%d | Sum=%d, Product=%d, Equal=%s",
             req.a, req.b, res.sum, res.product, res.is_equal ? "True" : "False");
    //如果成功调用，则返回true
    return true;
}

int main(int argc, char **argv)
{
    //初始化ROS节点
    ros::init(argc, argv, "number_service");
    //创建节点句柄
    ros::NodeHandle nh;

    //创建一个服务，名为"two_numbers"，回调函数为handle_request
    ros::ServiceServer server = nh.advertiseService("two_numbers", handle_request);
    //打印日志：表示服务已启动
    ROS_INFO("Service ready.");
    //循环等待
    ros::spin();
    return 0;
}
