#include<ros/ros.h>
#include<package_pub_sub/randomdata.h>
#include<cstdlib>
#include<ctime>

int main(int argc, char** argv){

    //节点初始化
    ros::init(argc, argv, "random_publisher");
    //创建节点句柄
    ros::NodeHandle nh;

    //创建一个publisher，发布名为"random_topic"的topic，消息类型为package_pub_sub::randomdata，队列长度为10
    ros::Publisher pub = nh.advertise<package_pub_sub::randomdata>("random_topic", 10);
    //设置循环频率
    ros::Rate loop_rate(1);

    srand(time(0));
    while(ros::ok())
    {
        //初始化package_pub_sub::randomdata类型的消息
        package_pub_sub::randomdata msg;
        msg.id = rand() % 100;
        msg.value = static_cast<double>(rand()) / RAND_MAX;
        msg.timestamp = std::to_string(ros::Time::now().toSec());
        //发布消息
        pub.publish(msg);
        ROS_INFO("Published: ID=%d, Value=%.2f, Timestamp=%s", msg.id, msg.value, msg.timestamp.c_str());
        //按照循环频率等待下一次循环
        loop_rate.sleep();
    }
    return 0;
}
