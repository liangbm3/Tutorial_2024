#include "ros/ros.h"
#include "random_data_pubsub/RandomData.h"

int main(int argc, char **argv) {
  ros::init(argc, argv, "publisher_node");
  ros::NodeHandle n;

  ros::Publisher pub = n.advertise<random_data_pubsub::RandomData>("random_data_topic", 1000);

  ros::Rate loop_rate(10); // 10Hz

  while (ros::ok()) {
    random_data_pubsub::RandomData msg;
    msg.data = rand() % 100; // 生成0-99之间的随机整数
    msg.message = "Random Data";

    ROS_INFO("Publishing: %f, %s", msg.data, msg.message.c_str());

    pub.publish(msg);

    ros::spinOnce();
    loop_rate.sleep();
  }

  return 0;
}
