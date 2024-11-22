#include <ros/ros.h>
#include <pub_sub_pkg/RandomNumber.h>

void randomNumberCallback(const pub_sub_pkg::RandomNumber::ConstPtr& msg) {
    ROS_INFO("Received: num1 = %d, num2 = %d", msg->number1, msg->number2);
}
int main(int argc, char** argv) {
    ros::init(argc, argv, "random_number_subscriber");
    ros::NodeHandle nh;

    // 创建一个订阅者，订阅 "random_number" 主题
    ros::Subscriber sub = nh.subscribe("random_number", 10, randomNumberCallback);

    // 循环等待回调
    ros::spin();

    return 0;
}