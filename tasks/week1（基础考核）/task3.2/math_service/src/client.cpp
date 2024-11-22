#include "ros/ros.h"
#include "math_service/MathOps.h"

int main(int argc, char **argv)
{
  ros::init(argc, argv, "math_client");

  // 检查命令行参数
  if (argc != 3)
  {
    ROS_INFO("usage: math_client X Y");
    return 1;
  }

  ros::NodeHandle n;
  // 创建服务客户端
  ros::ServiceClient client = n.serviceClient<math_service::MathOps>("math_ops");
 
  //创建一个服务请求对象，从命令行参数中读取两个整数赋值
  math_service::MathOps srv;
  srv.request.a = atoll(argv[1]);
  srv.request.b = atoll(argv[2]);

  //调用服务，打印结果
  if (client.call(srv))
  {
    ROS_INFO("Sum: %f, Product: %f, Equal: %d", (double)srv.response.sum, (double)srv.response.product, (int)srv.response.equal);
  }
  else
  {
    ROS_ERROR("Failed to call service math_ops");
    return 1;
  }
  

  return 0;
}
