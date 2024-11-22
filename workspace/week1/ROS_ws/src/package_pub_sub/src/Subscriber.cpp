#include<ros/ros.h>
#include<package_pub_sub/randomdata.h>

//接收到订阅的消息后，会进入消息回调函数
void callback(const package_pub_sub::randomdata::ConstPtr& msg){
    //打印接收到的消息
    ROS_INFO("Received: ID=%d, Value=%.2f, Timestamp=%s", msg->id, msg->value, msg->timestamp.c_str());
}

int main(int argc, char**argv){
    //初始化ROS节点
    ros::init(argc, argv, "random_subscriber");
    //创建节点句柄
    ros::NodeHandle nh;

    //创建订阅者，订阅名为"random_topic"的topic，消息类型为package_pub_sub::randomdata，队列长度为10
    ros::Subscriber sub = nh.subscribe("random_topic", 10, callback);

    //循环等待回调函数
    ros::spin();
    
    return 0;
}