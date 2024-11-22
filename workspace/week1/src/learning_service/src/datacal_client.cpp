#include <ros/ros.h>
#include "learning_service/datacal.h"

int main(int argc, char** argv)
{
    // 初始化ROS节点
	ros::init(argc, argv, "datacal_client");

    // 创建节点句柄
	ros::NodeHandle node;

    // 发现/spawn服务后，创建一个服务客户端，连接名为/spawn的service
	ros::service::waitForService("/show_datacal");	
	ros::ServiceClient datacal_client = node.serviceClient<learning_service::datacal>("/show_datacal");
        int a=1;
       ros::Rate loop_rate(1);
       while (ros::ok())
    {
       
    // 初始化learning_service::data的请求数据
	learning_service::datacal srv;
	a++;
	srv.request.num1 = a%6;
	srv.request.num2  = 3;
	

    // 请求服务调用
	ROS_INFO("Call service to show result[num1:%d, num2:%d]", 
			 srv.request.num1, srv.request.num2);

	datacal_client.call(srv);

	// 显示服务调用结果
	ROS_INFO("Show person result : %s", srv.response.result.c_str());
        
        }
	return 0;
};


