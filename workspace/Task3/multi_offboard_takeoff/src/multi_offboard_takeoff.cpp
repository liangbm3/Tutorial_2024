
#include <ros/ros.h>
#include <mavros/mavros.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/Vector3.h>
#include <geometry_msgs/TwistStamped.h>
#include <mavros_msgs/CommandBool.h>
#include<mavros_msgs/SetMode.h>
#define TARGET_RADIUS 0.5  // 目标半径，表示接近目标时的容许误差


 geometry_msgs::PoseStamped current_pos_0;
 void pos_cb_0(const geometry_msgs::PoseStamped::ConstPtr& msg){
    current_pos_0=*msg;
 }

 geometry_msgs::PoseStamped current_pos_1;
 void pos_cb_1(const geometry_msgs::PoseStamped::ConstPtr& msg){
    current_pos_1=*msg;
 }

 geometry_msgs::PoseStamped current_pos_2;
 void pos_cb_2(const geometry_msgs::PoseStamped::ConstPtr& msg){
    current_pos_2=*msg;
 }



// 设置四个目标点的坐标
geometry_msgs::PoseStamped create_target(double x, double y, double z) {
    geometry_msgs::PoseStamped target;
    target.pose.position.x = x;
    target.pose.position.y = y;
    target.pose.position.z = z;
    target.pose.orientation.w = 1.0;  // 默认无旋转（保持水平）
    return target;
}

int main(int argc, char **argv) {
    ros::init(argc, argv, "multi_offboard_takeoff");
    //第一架无人机uav0
    ros::NodeHandle nh0;
    ros::Subscriber pos_sub0 = nh0.subscribe("uav0/mavros/local_position/pose", 10, pos_cb_0);
    ros::Publisher local_pos_pub0 = nh0.advertise<geometry_msgs::PoseStamped>("uav0/mavros/setpoint_position/local", 10);
    ros::ServiceClient arming_client0 = nh0.serviceClient<mavros_msgs::CommandBool>("uav0/mavros/cmd/arming");
    ros::ServiceClient set_mode_client0 = nh0.serviceClient<mavros_msgs::SetMode>("uav0/mavros/set_mode");

    //第二架无人机uav1
   ros::NodeHandle nh1;
    ros::Subscriber pos_sub1 = nh1.subscribe("uav1/mavros/local_position/pose", 10, pos_cb_1);
    ros::Publisher local_pos_pub1 = nh1.advertise<geometry_msgs::PoseStamped>("uav1/mavros/setpoint_position/local", 10);
    ros::ServiceClient arming_client1 = nh1.serviceClient<mavros_msgs::CommandBool>("uav1/mavros/cmd/arming");
    ros::ServiceClient set_mode_client1 = nh1.serviceClient<mavros_msgs::SetMode>("uav1/mavros/set_mode");
    
   //第三架无人机uav2
   ros::NodeHandle nh2;
    ros::Subscriber pos_sub2 = nh2.subscribe("uav2/mavros/local_position/pose", 10, pos_cb_2);
    ros::Publisher local_pos_pub2 = nh2.advertise<geometry_msgs::PoseStamped>("uav2/mavros/setpoint_position/local", 10);
    ros::ServiceClient arming_client2 = nh2.serviceClient<mavros_msgs::CommandBool>("uav2/mavros/cmd/arming");
    ros::ServiceClient set_mode_client2 = nh2.serviceClient<mavros_msgs::SetMode>("uav2/mavros/set_mode");

    ros::Rate rate(20.0);  // 发布频率 20 Hz
    // 创建目标点
    geometry_msgs::PoseStamped target1_0 = create_target(0, 0, 2);   // 起点
    geometry_msgs::PoseStamped target2_0 = create_target(50, 0, 2);   // 第二个点
    geometry_msgs::PoseStamped target3_0 = create_target(50, 50, 2);   // 第三个点
    geometry_msgs::PoseStamped target4_0 = create_target(0, 50, 2);   // 第四个点
    
     geometry_msgs::PoseStamped target1_1 = create_target(1, 0, 2);   // 起点
    geometry_msgs::PoseStamped target2_1 = create_target(51, 0, 2);   // 第二个点
    geometry_msgs::PoseStamped target3_1 = create_target(51, 50, 2);   // 第三个点
    geometry_msgs::PoseStamped target4_1 = create_target(0, 50, 2);   // 第四个点

     geometry_msgs::PoseStamped target1_2 = create_target(0, 1, 2);   // 起点
    geometry_msgs::PoseStamped target2_2 = create_target(50, 1, 2);   // 第二个点
    geometry_msgs::PoseStamped target3_2 = create_target(50, 51, 2);   // 第三个点
    geometry_msgs::PoseStamped target4_2 = create_target(0, 51, 2);   // 第四个点

    // 初始化变量，标记当前目标点
    geometry_msgs::PoseStamped current_target_0 = target1_0;
    geometry_msgs::PoseStamped current_target_1 = target1_1;
    geometry_msgs::PoseStamped current_target_2 = target1_2;
    int target_index = 0;
    
    for(int i = 100; ros::ok() && i > 0; --i){
        local_pos_pub0.publish(current_target_0);
        local_pos_pub1.publish(current_target_1);
        local_pos_pub2.publish(current_target_2);
        ros::spinOnce();
        rate.sleep();
    }
    // 飞行器进入 Offboard 模式
    mavros_msgs::SetMode offb_set_mode;
    offb_set_mode.request.custom_mode = "OFFBOARD";
    if (set_mode_client0.call(offb_set_mode) &&
                set_mode_client1.call(offb_set_mode) &&
                set_mode_client2.call(offb_set_mode) &&
                offb_set_mode.response.mode_sent) {
        ROS_INFO("Offboard mode enabled");
    } else {
        ROS_ERROR("Failed to set Offboard mode");
        return 1;
    }

    // 解锁飞行器
    mavros_msgs::CommandBool arm_cmd;
    arm_cmd.request.value = true;
    if (arming_client0.call(arm_cmd) &&
                    arming_client1.call(arm_cmd) &&
                    arming_client2.call(arm_cmd) &&
                    arm_cmd.response.success) {
        ROS_INFO("Vehicle armed");
    } else {
        ROS_ERROR("Failed to arm vehicle");
        return 1;
    }

    while (ros::ok()) {

        // 计算当前位置和目标点之间的距离
        double dx_0 = current_pos_0.pose.position.x - current_target_0.pose.position.x;
        double dy_0 = current_pos_0.pose.position.y - current_target_0.pose.position.y;
        double dz_0 = current_pos_0.pose.position.z - current_target_0.pose.position.z;
        double distance_0 = sqrt(dx_0 * dx_0 + dy_0 * dy_0 + dz_0 * dz_0);

           double dx_1 = current_pos_1.pose.position.x - current_target_1.pose.position.x;
        double dy_1 = current_pos_1.pose.position.y - current_target_1.pose.position.y;
        double dz_1 = current_pos_1.pose.position.z - current_target_1.pose.position.z;
        double distance_1 = sqrt(dx_1 * dx_1 + dy_1 * dy_1 + dz_1 * dz_1);

           double dx_2 = current_pos_2.pose.position.x - current_target_2.pose.position.x;
        double dy_2 = current_pos_2.pose.position.y - current_target_2.pose.position.y;
        double dz_2 = current_pos_2.pose.position.z - current_target_2.pose.position.z;
        double distance_2 = sqrt(dx_2 * dx_2 + dy_2 * dy_2 + dz_2 * dz_2);
        // 如果接近目标点，切换到下一个目标点
        if (distance_0 < TARGET_RADIUS&&distance_1 < TARGET_RADIUS&&distance_2 < TARGET_RADIUS) {
            target_index = (target_index + 1) % 4;  // 循环访问目标点
            switch (target_index) {
                case 0: current_target_0 = target1_0; current_target_1 = target1_1;current_target_2 = target1_2;break;
                case 1: current_target_0 = target2_0;  current_target_1 = target2_1; current_target_2 = target2_2;break;
                case 2: current_target_0 = target3_0;current_target_1 = target3_1;current_target_2 = target3_2; break;
                case 3: current_target_0 = target4_0;current_target_1 = target4_1;current_target_2 = target4_2; break;
            }
            ROS_INFO("Moving to target %d", target_index + 1);
        }

        // 发布目标位置
        local_pos_pub0.publish(current_target_0);
         local_pos_pub1.publish(current_target_1);
          local_pos_pub2.publish(current_target_2);
        // 持续更新
        ros::spinOnce();
        rate.sleep();
    }

    return 0;
}

