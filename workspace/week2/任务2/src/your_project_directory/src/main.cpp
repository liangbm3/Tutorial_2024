#include <ros/ros.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/SetMode.h>
#include <geometry_msgs/PoseStamped.h>
#include <cmath>
#include <vector>
#include <geometry_msgs/Point.h>

// ROS节点句柄
ros::NodeHandle nh;

// 发布目标位置
ros::Publisher local_pos_pub = nh.advertise<geometry_msgs::PoseStamped>(
    "mavros/setpoint_position/local", 10);

// 服务客户端，用于设置模式和解锁
ros::ServiceClient arming_client = nh.serviceClient<mavros_msgs::CommandBool>(
    "mavros/cmd/arming");

ros::ServiceClient set_mode_client = nh.serviceClient<mavros_msgs::SetMode>(
    "mavros/set_mode");

// 发送目标位置
void send_target_pose(const geometry_msgs::Point& target) {
    geometry_msgs::PoseStamped target_pose;
    target_pose.header.stamp = ros::Time::now();
    target_pose.header.frame_id = "map";
    target_pose.pose.position = target;
    target_pose.pose.orientation.w = 1.0;
    local_pos_pub.publish(target_pose);
}

// 设置为OFFBOARD模式并解锁
bool arm_and_set_offboard() {
    mavros_msgs::SetMode offb_set_mode;
    offb_set_mode.request.custom_mode = "OFFBOARD";

    if (!set_mode_client.call(offb_set_mode) ||!offb_set_mode.response.mode_sent) {
        ROS_ERROR("Failed to set OFFBOARD mode");
        return false;
    }

    mavros_msgs::CommandBool arm_cmd;
    arm_cmd.request.value = true;

    if (!arming_client.call(arm_cmd) ||!arm_cmd.response.success) {
        ROS_ERROR("Failed to arm vehicle");
        return false;
    }

    return true;
}

// 起飞逻辑
void takeoff() {
    for (double z = 0.0; z <= 10.0; z += 1.0) {
        geometry_msgs::Point point;
        point.x = 0.0;
        point.y = 0.0;
        point.z = z;
        send_target_pose(point);
        ros::Duration(1.0).sleep();
    }
}

// 降落逻辑
void land() {
    for (double z = 10.0; z >= 0.0; z -= 1.0) {
        geometry_msgs::Point point;
        point.x = 0.0;
        point.y = 0.0;
        point.z = z;
        send_target_pose(point);
        ros::Duration(1.0).sleep();
    }
}

int main(int argc, char **argv) {
    ros::init(argc, argv, "gazebo_quadrotor_controller");

    // 等待服务可用
    ros::service::waitForService("mavros/cmd/arming");
    ros::service::waitForService("mavros/set_mode");

    // 尝试设置为OFFBOARD模式并解锁
    if (!arm_and_set_offboard()) {
        return -1;
    }

    // 定义航点（使用逐个元素构造方式初始化）
    std::vector<geometry_msgs::Point> waypoints;

    geometry_msgs::Point point1;
    point1.x = 0.0;
    point1.y = 0.0;
    point1.z = 10.0;
    waypoints.push_back(point1);

    geometry_msgs::Point point2;
    point2.x = 10.0;
    point2.y = 0.0;
    point2.z = 10.0;
    waypoints.push_back(point2);

    geometry_msgs::Point point3;
    point3.x = 10.0;
    point3.y = 10.0;
    point3.z = 10.0;
    waypoints.push_back(point3);

    geometry_msgs::Point point4;
    point4.x = 0.0;
    point4.y = 10.0;
    point4.z = 10.0;
    waypoints.push_back(point4);

    // 起飞
    takeoff();

    // 飞行到每个航点
    for (size_t i = 0; i < waypoints.size(); ++i) {
        send_target_pose(waypoints[i]);
        ros::Duration(5.0).sleep(); // 假设飞行到每个航点需要5秒
    }

    // 降落
    land();

    return 0;
}