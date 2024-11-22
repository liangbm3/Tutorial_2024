#include <ros/ros.h>
#include <package_ser_cli/TwoNumbers.h>

int main(int argc, char **argv)
{
    ros::init(argc, argv, "number_client");
    ros::NodeHandle nh;

    ros::ServiceClient client = nh.serviceClient<package_ser_cli::TwoNumbers>("two_numbers");
    package_ser_cli::TwoNumbers srv;
    srv.request.a = 5;
    srv.request.b = 10;

    if (client.call(srv))
    {
        ROS_INFO("Response: Sum=%d, Product=%d, Equal=%s",
                 srv.response.sum, srv.response.product, srv.response.is_equal ? "True" : "False");
    }
    else
    {
        ROS_ERROR("Failed to call service.");
    }
    return 0;
}
