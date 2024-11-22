#include <ros/ros.h>
#include <package_ser_cli/TwoNumbers.h>

bool handle_request(package_ser_cli::TwoNumbers::Request &req,
                    package_ser_cli::TwoNumbers::Response &res)
{
    res.sum = req.a + req.b;
    res.product = req.a * req.b;
    res.is_equal = (req.a == req.b);
    ROS_INFO("Received: a=%d, b=%d | Sum=%d, Product=%d, Equal=%s",
             req.a, req.b, res.sum, res.product, res.is_equal ? "True" : "False");
    return true;
}

int main(int argc, char **argv)
{
    ros::init(argc, argv, "number_service");
    ros::NodeHandle nh;

    ros::ServiceServer server = nh.advertiseService("two_numbers", handle_request);
    ROS_INFO("Service ready.");
    ros::spin();
    return 0;
}
