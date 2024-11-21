#include<ros/ros.h>
#include<std_msgs/String.h>
#include<ssr_pkg/Carry.h>

//定义回调函数chao_callback，接受参数msg
void chao_callback(ssr_pkg::Carry msg)
{
    //打印消息，ROS——WARN和ROS——INFO在这里单纯区分颜色
    ROS_WARN("%ld 届",msg.year);
    ROS_WARN(msg.grade.c_str());
    ROS_INFO(msg.data.c_str());
    ROS_INFO("%d 这个数怎么样",msg.random_int);

}

int main(int argc, char *argv[])
{
    setlocale(LC_ALL,"");
    //初始化ROS节点
    ros::init(argc, argv, "ma_node");

    ros::NodeHandle nh;
    //创建订阅者，订阅名为My_Topic的topic，回调函数为chao_callback，以处理接受的消息
    ros::Subscriber sub =nh.subscribe("My_Topic", 3, chao_callback);
    
    //循环等待回调函数，ros::ok()检查节点是否正常工作，如果检测到错误或者关闭，则返回false
    while (ros::ok())
    {
        //保证节点正常工作，避免消息阻塞
        ros::spinOnce();
    }
    
    
    return 0;
}