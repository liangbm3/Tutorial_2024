#include "ros/ros.h"
#include "std_msgs/String.h"
#include "work_pkg/CustomMsg.h"

int main(int argc, char **argv)
{
  ros::init(argc, argv, "publisher");
  ros::NodeHandle n;
  ros::Publisher my_pub = n.advertise<work_pkg::CustomMsg>("my_topic", 1000);
  ros::Rate loop_rate(10);

  while (ros::ok())
  {
    work_pkg::CustomMsg msg;
    msg.id = rand() % 1000;
    msg.value = static_cast<double>(rand()) / RAND_MAX;
    msg.name = "Random Value";
    my_pub.publish(msg);

    ros::spinOnce();
    loop_rate.sleep();
  }
  return 0;
}