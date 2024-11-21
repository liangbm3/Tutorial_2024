/**********************************************************************
 * FileName: data_client.cpp
 * Author: @Ethan-Zhengsy
 * Version: 1.0.0
 * Date: 2024.11.19
 * Description: 建立一个客户端 Client，实现操作数据发送
                服务名称    /send_data
                发送消息类型    client_server::Data
 * Function List: 
        1. main : 主函数，建立一个Client,发送数据
**********************************************************************/

#include "client_server/Data.h"
#include <ros/ros.h>

int main(int argc, char **argv) {
    ros::init(argc, argv, "data_client");///客户端节点初始化

    ros::NodeHandle node;///创建节点句柄

    ros::service::waitForService("/send_data");///发现服务端
    ros::ServiceClient data_client = node.serviceClient<client_server::Data>("/send_data");///创建客户端

    client_server::Data srv;///初始化客户端数据
    int num1, num2;
    std::cin >> num1 >> num2;
    srv.request.a = num1;
    srv.request.b = num2;

    ROS_INFO("Call service to send data: a = %d    b = %d", srv.request.a, srv.request.b);///请求服务调用
    if (data_client.call(srv)) {
        ROS_INFO("Sum: %d", srv.response.sum);
        ROS_INFO("Product: %d", srv.response.product);
        ROS_INFO("Equal: %s", srv.response.equal.c_str());
    } else {
        ROS_ERROR("Failed to call service send_data");
    }
    return 0;
}
