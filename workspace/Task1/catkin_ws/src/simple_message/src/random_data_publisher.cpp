#include<ros/ros.h>
#include<simple_message/RandomData.h>
#include<cstdlib>
#include<ctime>

int main(int argc,char**argv){
    ros::init(argc,argv,"random_data_publisher");
    ros::NodeHandle nh;

    //创建一个发布者
    ros::Publisher random_pub = nh.advertise<simple_message::RandomData>("random_data",10);

    //初始化随机数生成器
    std::srand(static_cast<unsigned int>(std::time(0)));

    //设置循环频率
    ros::Rate loop_rate(1);

    while(ros::ok()){
        simple_message::RandomData msg;
        msg.num1=std::rand()%100;
        msg.num2=std::rand()%100;
        msg.info="Random data generated";
        //发布消息
        random_pub.publish(msg);
        ROS_INFO("Published: num1 = %d, num2 = %d ,message = %s", msg.num1,msg.num2,msg.info.c_str());

        //休眠直到下一个循环
        ros::spinOnce();
        loop_rate.sleep();

    }
    return 0;
}