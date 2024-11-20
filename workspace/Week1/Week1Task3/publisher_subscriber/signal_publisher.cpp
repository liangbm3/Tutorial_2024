/**********************************************************************
 * FileName: signal_publisher.cpp
 * Author: @Ethan-Zhengsy
 * Version: 1.0.0
 * Date: 2024.11.19
 * Description: 建立一个信息发布节点 Publisher，实现自定义随机数据发送
                发布消息题目    /signal_info
                发布消息类型    publisher_subscriber::Signal_send
 * Function List: 
        1. main : 主函数，建立一个publisher,发送自定义随机数据
**********************************************************************/

#include "publisher_subscriber/Signal_send.h"
#include <ros/ros.h>

int main(int argc, char **argv) {
    ros::init(argc, argv, "signal_publisher");///发布节点初始化

    ros::NodeHandle node;///创建节点句柄

    ros::Publisher signal_info_pub = node.advertise<publisher_subscriber::Signal_send>("/signal_info", 10);///创建publisher, 队列长度为10
    
    ros::Rate loop_rate(10);///设置循环频率
    int count = 0;
    while (ros::ok()) {
        publisher_subscriber::Signal_send signal_send_msg;//初始化消息类型
        signal_send_msg.number = static_cast<int>(rand()%10);
        signal_send_msg.text = "Random Data";
        
        signal_info_pub.publish(signal_send_msg);///发布消息
        ROS_INFO("Publish Signal Info: number:%d    text:%s", signal_send_msg.number, signal_send_msg.text.c_str());
        
        ros::spinOnce();
		loop_rate.sleep();///按照循环频率延时
    }
    return 0;
}


