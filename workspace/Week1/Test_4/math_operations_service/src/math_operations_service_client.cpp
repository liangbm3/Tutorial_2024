#include <ros/ros.h>
#include <math_operations_service/MathOperations.h> // 引入自定义服务消息头文件

int main(int argc, char **argv) {
    // 检查命令行参数数量
    if (argc!= 3) {
        ROS_INFO("Usage: math_operations_service_client <num1> <num2>");
        return 1; // 返回错误
    }

    ros::init(argc, argv, "math_operations_service_client"); // 初始化节点
    ros::NodeHandle n; // 创建节点句柄

    // 创建服务客户端，连接到 "math_operations" 服务
    ros::ServiceClient client = n.serviceClient<math_operations_service::MathOperations>("math_operations");
    math_operations_service::MathOperations srv; // 创建服务请求对象
    srv.request.num1 = atoll(argv[1]); // 将第一个参数转为整数并赋值
    srv.request.num2 = atoll(argv[2]); // 将第二个参数转为整数并赋值

    // 调用服务并检查是否成功
    if (client.call(srv)) {
        ROS_INFO("Sum: %ld, Product: %ld, Are equal: %s", srv.response.sum, srv.response.product,
                 srv.response.are_equal? "True" : "False");
    } else {
        ROS_ERROR("Failed to call service math_operations"); // 打印错误信息
        return 1; // 返回错误
    }

    return 0; // 返回成功
}