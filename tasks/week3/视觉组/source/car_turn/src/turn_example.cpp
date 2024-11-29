#include "ros/ros.h"
#include "car_turn/yaw_v.h"
#include <math.h>
#include <geometry_msgs/Point.h>
#define PI acos(-1)

float x, y, z;
float x_point = 0;
float y_point = 0;
int step = 0;  // 控制小车运动的步数

void callback(const geometry_msgs::Point::ConstPtr& msg)
{
    ROS_INFO("收到信息");
    x = msg->x;
    y = msg->y;
    z = msg->z;
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "turn_s");
    ros::NodeHandle node_handle;
    ros::Subscriber sub = node_handle.subscribe("car_position", 1, callback);
    ros::Publisher pub = node_handle.advertise<car_turn::yaw_v>("turn", 1);
    car_turn::yaw_v msg;
    ros::Rate rate(20);

    while (ros::ok())
    {
        // 根据step控制小车运动的方向
        switch (step)
        {
        case 0:  // 向前走2米
            y_point += 0.1;
            if (y_point >= 2)
            {
                y_point = 2;
                step = 1;  // 切换到下一个步骤
            }
            break;

        case 1:  // 向右走2米
            x_point += 0.1;
            if (x_point >= 2)
            {
                x_point = 2;
                step = 2;  // 切换到下一个步骤
            }
            break;

        case 2:  // 向后走2米
            y_point -= 0.1;
            if (y_point <= 0)
            {
                y_point = 0;
                step = 3;  // 切换到下一个步骤
            }
            break;

        case 3:  // 向左走2米
            x_point -= 0.1;
            if (x_point <= 0)
            {
                x_point = 0;
                step = 0;  // 重置为初始步骤，循环
            }
            break;
        }

        // 计算偏航角
        msg.yaw = atan2(y_point - y, x_point - x);  // 使用 atan2 确保方向正确

        // 计算速度
        msg.v_x = (x_point - x) * 0.05;
        msg.v_y = (y_point - y) * 0.05;
        msg.v_z = 0;

        pub.publish(msg);
        ros::spinOnce();
        rate.sleep();
    }

    return 0;
}
