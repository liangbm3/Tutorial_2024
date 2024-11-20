#include<ros/ros.h>
#include<simple_message/RandomData.h>

void randomDataCallback(const simple_message::RandomData::ConstPtr&msg){
    ROS_INFO("Received: num1 = %d, num2 = %d, message = %s", msg->num1,msg->num2,msg->info.c_str());

}
int main(int argc,char**argv){
    ros::init(argc,argv,"random_data_subscriber");
    ros::NodeHandle nh;

    ros::Subscriber sub=nh.subscribe("random_data",10,randomDataCallback);
    ros::spin();

    return 0;
}