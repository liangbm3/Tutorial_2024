#include <ros/ros.h>
#include <pub_sub_pkg/RandomNumber.h>
#include <cstdlib>  // for rand()
#include <ctime>    // for time()

int main(int argc, char** argv) {
    ros::init(argc, argv, "random_number_publisher");
    ros::NodeHandle nh;

    // 创建一个发布者，发布到 "random_number" 主题
    ros::Publisher random_pub = nh.advertise<pub_sub_pkg::RandomNumber>("random_number", 10);

    // 初始化随机数生成器
    std::srand(static_cast<unsigned int>(std::time(0)));

    // 设置循环频率
    ros::Rate loop_rate(1);  // 每秒发布一次

    while (ros::ok()) {
        // 创建一个消息并设置随机数
        //std_msgs::Int32 msg;
        //msg.data = std::rand() % 100;  // 生成 0 到 99 的随机数
        pub_sub_pkg::RandomNumber msg;
        msg.number1 = std::rand() % 100;
        msg.number2 = std::rand() % 100;
        // 发布消息
        random_pub.publish(msg);
        ROS_INFO("Published random number: %d %d", msg.number1, msg.number2);

        // 休眠直到下一个循环
        ros::spinOnce();
        loop_rate.sleep();
    }

    return 0;
}