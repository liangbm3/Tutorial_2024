#include "ros/ros.h"
#include "simple_service_communication/Service.h"

int main(int argc, char **argv) {
    //初始化ROS节点
    ros::init(argc, argv, "service_client");
    //创建句柄
    ros::NodeHandle nh;
    //创建客户端
    ros::ServiceClient client = nh.serviceClient<simple_service_communication::Service>("calculate_service");
    simple_service_communication::Service srv;
    srv.request.a = 5;
    srv.request.b = 10;
    
    if (client.call(srv)) {
        //设置本地语言环境，防止输出中文乱码
        setlocale(LC_ALL, "");
        //打印接收到的数据，发出提示
        ROS_INFO("和: %d", srv.response.sum);
        ROS_INFO("积: %d", srv.response.product);
        ROS_INFO("是否相等: %s", srv.response.equal ? "True" : "False");
    } else {
        ROS_ERROR("Failed to call service calculate_service");
        return 1;
    }
    
    return 0;
}