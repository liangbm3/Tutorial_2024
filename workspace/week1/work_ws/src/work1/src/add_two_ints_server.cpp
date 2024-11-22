#include "ros/ros.h"
#include "work1/AddTwoInts.h"

bool add(work1::AddTwoInts::Request  &req,
         work1::AddTwoInts::Response &res)
{
  res.sum = req.a + req.b;
  res.product = req.a * req.b;
  res.isEqual = req.a == req.b;
  ROS_INFO("request: x=%ld, y=%ld", (long int)req.a, (long int)req.b);
  ROS_INFO("sending back response: [%ld, %ld, %d]", (long int)res.sum, (long int)res.product, res.isEqual);
  return true;
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "add_two_ints_server");
  ros::NodeHandle n;

  ros::ServiceServer service = n.advertiseService("add_two_ints", add);
  ROS_INFO("Ready to add two ints.");
  ros::spin();

  return 0;
}