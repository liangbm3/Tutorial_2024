
#include <ros/ros.h>
#include <mavros/mavros.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/Vector3.h>
#include <geometry_msgs/TwistStamped.h>
#include <mavros_msgs/CommandBool.h>
#include<mavros_msgs/SetMode.h>
#define TARGET_RADIUS 0.5  // 目标半径，表示接近目标时的容许误差


 geometry_msgs::PoseStamped current_pos;
 void pos_cb(const geometry_msgs::PoseStamped::ConstPtr& msg){
    current_pos=*msg;
 }


// 设置四个目标点的坐标，假设飞行器以(0, 0)为起点
geometry_msgs::PoseStamped create_target(double x, double y, double z) {
    geometry_msgs::PoseStamped target;
    target.pose.position.x = x;
    target.pose.position.y = y;
    target.pose.position.z = z;
    target.pose.orientation.w = 1.0;  // 默认无旋转（保持水平）
    return target;
}

int main(int argc, char **argv) {
    ros::init(argc, argv, "quad_path_flight");
    ros::NodeHandle nh;

    ros::Subscriber pos_sub = nh.subscribe("/mavros/local_position/pose", 10, pos_cb);
    ros::Publisher local_pos_pub = nh.advertise<geometry_msgs::PoseStamped>("/mavros/setpoint_position/local", 10);
    ros::ServiceClient arming_client = nh.serviceClient<mavros_msgs::CommandBool>("/mavros/cmd/arming");
    ros::ServiceClient set_mode_client = nh.serviceClient<mavros_msgs::SetMode>("/mavros/set_mode");

    ros::Rate rate(20.0);  // 发布频率 20 Hz
    
   
    // 创建目标点
    geometry_msgs::PoseStamped target1 = create_target(0, 0, 2);   // 起点
    geometry_msgs::PoseStamped target2 = create_target(50, 0, 2);   // 第二个点
    geometry_msgs::PoseStamped target3 = create_target(50, 50, 2);   // 第三个点
    geometry_msgs::PoseStamped target4 = create_target(0, 50, 2);   // 第四个点

    // 初始化变量，标记当前目标点
    geometry_msgs::PoseStamped current_target = target1;
    int target_index = 0;
    
    for(int i = 100; ros::ok() && i > 0; --i){
        local_pos_pub.publish(current_target);
        ros::spinOnce();
        rate.sleep();
    }
    // 飞行器进入 Offboard 模式
    mavros_msgs::SetMode offb_set_mode;
    offb_set_mode.request.custom_mode = "OFFBOARD";
    if (set_mode_client.call(offb_set_mode) && offb_set_mode.response.mode_sent) {
        ROS_INFO("Offboard mode enabled");
    } else {
        ROS_ERROR("Failed to set Offboard mode");
        return 1;
    }

    // 解锁飞行器
    mavros_msgs::CommandBool arm_cmd;
    arm_cmd.request.value = true;
    if (arming_client.call(arm_cmd) && arm_cmd.response.success) {
        ROS_INFO("Vehicle armed");
    } else {
        ROS_ERROR("Failed to arm vehicle");
        return 1;
    }

    while (ros::ok()) {

        // 计算当前位置和目标点之间的距离
        double dx = current_pos.pose.position.x - current_target.pose.position.x;
        double dy = current_pos.pose.position.y - current_target.pose.position.y;
        double dz = current_pos.pose.position.z - current_target.pose.position.z;
        double distance = sqrt(dx * dx + dy * dy + dz * dz);

        // 如果接近目标点，切换到下一个目标点
        if (distance < TARGET_RADIUS) {
            target_index = (target_index + 1) % 4;  // 循环访问目标点
            switch (target_index) {
                case 0: current_target = target1; break;
                case 1: current_target = target2; break;
                case 2: current_target = target3; break;
                case 3: current_target = target4; break;
            }
            ROS_INFO("Moving to target %d", target_index + 1);
        }

        // 发布目标位置
        local_pos_pub.publish(current_target);

        // 持续更新
        ros::spinOnce();
        rate.sleep();
    }

    return 0;
}

