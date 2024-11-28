#include "parser.h"
#include <urdf/model.h>
#include <string>
#include <sensor_msgs/JointState.h>
#include <tf/transform_broadcaster.h>
#include <geometry_msgs/Point.h>
#include <ros/ros.h>
#include <random>
#include <iomanip>
#include "car_turn/yaw_v.h"
#include <cmath>
#include <math.h>

#define PI acos(-1)

using namespace std;

SVector3 velocity = {0, 0, 0};  // 速度向量
float yaw = 0.0;
float v_x = 0, v_y = 0, v_z = 0;

// 订阅回调函数
void callback(const car_turn::yaw_v::ConstPtr& msg) {
    ROS_INFO("Received yaw and velocity data");
    yaw = msg->yaw;
    v_x = msg->v_x;
    v_y = msg->v_y;
    v_z = msg->v_z;
}

int main(int argc, char** argv) {
    ros::init(argc, argv, "state_publisher");
    ros::NodeHandle n;

    // 初始化小车控制对象
    little_car car;
    car.joint_pub = n.advertise<sensor_msgs::JointState>("joint_states", 1);
    car.pos_pub = n.advertise<geometry_msgs::Point>("car_position", 1); // 小车位置发布

    // 订阅车体转动信息
    ros::Subscriber sub_turn = n.subscribe<car_turn::yaw_v>("turn", 1, callback);

    // 定义发布速率
    ros::Rate loop_rate(60);

    while (ros::ok()) {
        // 更新小车方向和速度
        car.set_yaw(yaw);
        velocity = {v_x, v_y, 0};
        car.set_velocity(velocity); // 设置小车速度

        // 更新小车状态
        car.update_();

        // 处理消息
        ros::spinOnce();
        loop_rate.sleep();
    }

    return 0;
}
