/**********************************************************************
 * FileName: signal_subscriber.cpp
 * Author: @Ethan-Zhengsy
 * Version: 1.0.0
 * Date: 2024.11.19
 * Description: 建立一个信息接收节点 Subscriber，实现数据接收
                接收消息题目    /signal_info
                接收消息类型    publisher_subscriber::Signal_send
 * Function List: 
        1. main : 主函数，建立一个subscriber,接收自定义随机数据
        2. signalInfoCallback: 回调函数
**********************************************************************/

#include "publisher_subscriber/Signal_send.h"
#include <ros/ros.h>

/**
 * @brief 回调函数
 * @param signal_received_msg 接收数据的指针
 * 
 * @return void
 */
void signalInfoCallback(const publisher_subscriber::Signal_send::ConstPtr& signal_received_msg) {
    ROS_INFO("Subscribe Signal Info: number:%d    text:%s", signal_received_msg->number, signal_received_msg->text.c_str());
}
int main(int argc, char **argv) {
    ros::init(argc, argv, "signal_subscriber");///信息接收节点初始化

    ros::NodeHandle node;///创建节点句柄

    ros::Subscriber signal_info_sub = node.subscribe("/signal_info", 10, signalInfoCallback);///创建subscriber, 队列长度为10
    
    ros::spin();///循环等待回调函数
    return 0;
}
