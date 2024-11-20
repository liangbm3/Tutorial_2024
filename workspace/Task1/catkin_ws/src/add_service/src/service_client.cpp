#include<ros/ros.h>
#include<add_service/AddTwoInt.h>

int main(int argc,char **argv){
     // 检查命令行参数数量
    if (argc != 3) {
        ROS_INFO("Usage: add_service_client <num1> <num2>");
        return 1; // 返回错误
    }
//初始化节点
    ros::init(argc,argv,"service_client");
    ros::NodeHandle n;

    //创建客户端—
    ros::ServiceClient client =n.serviceClient<add_service::AddTwoInt>("add_two_int");
    add_service::AddTwoInt srv;
    srv.request.a=atoll(argv[1]);
    srv.request.b=atoll(argv[2]);
    if(client.call(srv)){
        ROS_INFO("Sum: %ld, Product: %ld, Equal: %s",srv.response.sum,srv.response.product,srv.response.equal.c_str());
    }
    else{
        ROS_ERROR("Failed to call service add_two_int");
        return 1;
    }
return 0;
    
}