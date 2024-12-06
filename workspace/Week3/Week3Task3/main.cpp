#include "parser.h"
#include <urdf/model.h>
#include <string>
#include <sensor_msgs/JointState.h>
#include <tf/transform_broadcaster.h>
#include <geometry_msgs/Point.h>
#include <ros/ros.h>
#include <random>
#include <iomanip>
#include <std_msgs/String.h>
using namespace std;

float yaw = 0.0;
SVector3 velocity={0, 0, 0};  //速度向量

// 假设手势识别结果是一个字符串消息
void gestureCallback(const std_msgs::String::ConstPtr& msg) {
    ROS_INFO("Received gesture: %s", msg->data.c_str());
    // 根据接收到的手势指令控制小车
    // 这里需要根据手势识别结果来设置小车的速度和方向
    // 例如：
    if (msg->data == "forward") {
        // 小车前进
        velocity = {0.1, 0, 0};
    } else if (msg->data == "backward") {
        // 小车后退
        velocity = {-0.1, 0, 0};
    } else if (msg->data == "left") {
        // 小车左转
        yaw -= 0.1;
    } else if (msg->data == "right") {
        // 小车右转
        yaw += 0.1;
    } else if (msg->data == "stop") {
        // 小车停止
        velocity = {0, 0, 0};
    }
}

int main(int argc, char** argv) {
    ros::init(argc, argv, "state_publisher");
    ros::NodeHandle n;
	little_car car;//初始化控制对象  小车
    car.joint_pub = n.advertise<sensor_msgs::JointState>("joint_states", 1);
	car.pos_pub = n.advertise<geometry_msgs::Point>("car_position",1); //小车的位置消息发布
	
	//添加一个Subscriber，从手势识别Publisher处订阅指令
    ros::Subscriber gesture_sub = n.subscribe<std_msgs::String>("gesture_topic", 1, gestureCallback);


    ros::Rate loop_rate(60);
	// SVector3 velocity={0, 0, 0};  //速度向量
	car.set_noise_level(0);		   //设置噪声等级
	// float yaw = 0.0;
    while (ros::ok()) {
	//	yaw += 0.01;
		car.set_velocity(velocity);//设置小车速度
    	car.set_yaw(yaw); 		   //修改小车的方向
        car.update_();//小车状态更新
		loop_rate.sleep();
    }


    return 0;
}