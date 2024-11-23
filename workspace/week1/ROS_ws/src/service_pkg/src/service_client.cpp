#include <ros/ros.h>
#include <service_pkg/TwoNumbers.h>

int main(int argc, char **argv)
{
    //初始化客户端节点
    ros::init(argc, argv, "number_client");
    //创建节点句柄
    ros::NodeHandle nh;

    //创建一个服务客户端，连接名为“two_numbers”的服务，客户端与服务器之间的交互类型为“service_pkg::TwoNumbers”
    ros::ServiceClient client = nh.serviceClient<service_pkg::TwoNumbers>("two_numbers");
    //声明服务请求消息
    service_pkg::TwoNumbers srv;
    srv.request.a = 5;
    srv.request.b = 10;

    //调用服务，等待服务端返回结果
    if (client.call(srv))
    {
        ROS_INFO("Response: Sum=%d, Product=%d, Equal=%s",
                 srv.response.sum, srv.response.product, srv.response.is_equal ? "True" : "False");
    }
    else
    {
        //调用失败打印错误
        ROS_ERROR("Failed to call service.");
    }
    return 0;
}
