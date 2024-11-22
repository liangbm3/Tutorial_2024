#include "ros/ros.h"
#include "math_service/MathOps.h"

//计算函数
bool handle_math_ops(math_service::MathOps::Request &req,
                     math_service::MathOps::Response &res)
{
  res.sum = req.a + req.b;
  res.product = req.a * req.b;
  res.equal = (req.a == req.b);
  return true;
}

int main(int argc, char **argv)
{
  ros::init(argc, argv, "math_server");
  ros::NodeHandle n;

//初始化服务端
  ros::ServiceServer service = n.advertiseService("math_ops", handle_math_ops);
  ROS_INFO("Ready to perform math operations.");
//进入ROS的主循环，等待并处理服务请求
  ros::spin();

  return 0;
}
