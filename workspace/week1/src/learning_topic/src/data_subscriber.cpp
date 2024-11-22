
#include <ros/ros.h>
#include "learning_topic/data.h"

// 接收到订阅的消息后，会进入消息回调函数
void dataInfoCallback(const learning_topic::data::ConstPtr& msg)
{
    // 将接收到的消息打印出来
    ROS_INFO("Subcribe data Info: random data:%d",msg->data );
}

int main(int argc, char **argv)
{
    // 初始化ROS节点
    ros::init(argc, argv, "data_subscriber");

    // 创建节点句柄
    ros::NodeHandle n;

    // 创建一个Subscriber，订阅名为/person_info的topic，注册回调函数personInfoCallback
    ros::Subscriber data_info_sub = n.subscribe("/data_info", 10, dataInfoCallback);

    // 循环等待回调函数
    ros::spin();

    return 0;
}

