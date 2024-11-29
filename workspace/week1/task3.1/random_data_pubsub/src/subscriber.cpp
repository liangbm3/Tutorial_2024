#include "ros/ros.h"
#include "random_data_pubsub/RandomData.h"

void chatterCallback(const random_data_pubsub::RandomData::ConstPtr& msg) {
  ROS_INFO("I heard: [%.2f, %s]", msg->data, msg->message.c_str());
}

int main(int argc, char **argv) {
  ros::init(argc, argv, "subscriber_node");
  ros::NodeHandle n;

  ros::Subscriber sub = n.subscribe("random_data_topic", 1000, chatterCallback);

  ros::spin();

  return 0;
}
