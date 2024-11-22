#include <ros/ros.h>
#include "learning_topic/data.h"

int main(int argc, char **argv)
{
    // ROS节点初始化
    ros::init(argc, argv, "data_publisher");

    // 创建节点句柄
    ros::NodeHandle n;

    // 创建一个Publisher，发布名为/data_info的topic，消息类型为learning_topic::data，队列长度10
    ros::Publisher data_info_pub = n.advertise<learning_topic::data>("/data_info", 10);

    // 设置循环的频率
    ros::Rate loop_rate(1);
    int s=442;
    int count = (33*count+s)%100;
    while (ros::ok())
    {

	 count = (33*count+s)%100;    
        // 初始化learning_topic::data类型的消息
    	learning_topic::data data_msg;
		data_msg.data=count;

        // 发布消息
		data_info_pub.publish(data_msg);

       	ROS_INFO("Publisher data Info: %d",data_msg.data=count); 

        // 按照循环频率延时
        loop_rate.sleep();
    }

    return 0;
}

