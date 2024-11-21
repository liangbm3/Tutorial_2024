#include<ros/ros.h>
#include<std_msgs/String.h>
#include<ssr_pkg/Carry.h>

//主函数，argc和argv用于接收命令行参数
int main(int argc, char  *argv[])
{
    //初始化ROS节点，名字为chao_node
    ros::init(argc,argv, "chao_node");
    //提示指令的开始
    printf("开始\n");
    
    //创建节点句柄，句柄有类似管家的作用，作为系统通信接口
    ros::NodeHandle nh;
    
    //创建publisher，话题名为My_Topic，消息类型为ssr_pkg::Carry
    ros::Publisher pub = nh.advertise<ssr_pkg::Carry>("My_Topic",3);

    //设置循环频率，频率高了也没用（
    ros::Rate loop_rate(10);

    //循环发布自定义消息
    while (ros::ok())
    {
        printf("你是谁，随便说一个数\n") ;
        ssr_pkg::Carry msg;
        msg.year =2024;
        msg.grade ="大一";
        msg.data = "张三";
        //发布随机数
        msg.random_int = rand() % 100;
        pub.publish(msg);
        loop_rate.sleep();
    }
    
    return 0;
}