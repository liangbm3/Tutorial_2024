/**********************************************************************
 * FileName: data_server.cpp
 * Author: @Ethan-Zhengsy
 * Version: 1.0.0
 * Date: 2024.11.19
 * Description: 建立一个服务端 Server，实现操作数据接收和处理，并发送结果
                服务名称    /send_data
                发送消息类型    client_server::Data
 * Function List: 
        1. main : 主函数，建立一个Server,接收数据并发送处理结果
        2. dataCallback： 回调函数
**********************************************************************/

#include "client_server/Data.h"
#include <ros/ros.h>

/**
 * @brief 回调函数
 * @param req 接收请求
 * @param res 发送结果
 * 
 * @return 返回说明
*        -<em>false</em> fail
*        -<em>true</em> succeed
*/
bool dataCallback(client_server::Data::Request &req, client_server::Data::Response &res) {
    ROS_INFO("Data: a: %d   b: %d", req.a, req.b);
    res.sum = req.a + req.b;///a与b的和
    res.product = req.a * req.b;///a与b的积
    if (req.a == req.b) {
        res.equal = "True";
    } else {
        res.equal = "False";
    }///a与b是否相等
    return true;
}

int main(int argc, char **argv) {
    ros::init(argc, argv, "data_server");///服务端节点初始化
    
    ros::NodeHandle node;///创建节点句柄

    ros::ServiceServer data_server = node.advertiseService("/send_data", dataCallback);///反馈处理结果
    
    ROS_INFO("Ready to compute data.");
    ros::spin();
    return 0;
}