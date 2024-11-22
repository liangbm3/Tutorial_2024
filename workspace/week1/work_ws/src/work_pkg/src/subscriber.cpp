#include "ros/ros.h"
#include "work_pkg/CustomMsg.h"

void myCallback(const work_pkg::CustomMsg::ConstPtr& msg)
{
  ROS_INFO("I heard: [%d, %f, %s]", msg->id, msg->value, msg->name.c_str());
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "subscriber");
  ros::NodeHandle n;
  ros::Subscriber my_sub = n.subscribe("my_topic", 1000, myCallback);
  ros::spin();
  return 0;
}