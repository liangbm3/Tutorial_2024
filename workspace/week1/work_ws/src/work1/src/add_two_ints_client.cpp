#include "ros/ros.h"
#include "work1/AddTwoInts.h"

int main(int argc, char **argv)
{
  ros::init(argc, argv, "add_two_ints_client");
  ros::NodeHandle n;

  ros::ServiceClient client = n.serviceClient<work1::AddTwoInts>("add_two_ints");
  work1::AddTwoInts srv;
  srv.request.a = 2;
  srv.request.b = 3;

  if (client.call(srv))
  {
    ROS_INFO("Sum: %ld", (long int)srv.response.sum);
    ROS_INFO("Product: %ld", (long int)srv.response.product);
    ROS_INFO("Equal: %d", srv.response.isEqual);
  }
  else
  {
    ROS_ERROR("Failed to call service add_two_ints");
    return 1;
  }

  return 0;
}