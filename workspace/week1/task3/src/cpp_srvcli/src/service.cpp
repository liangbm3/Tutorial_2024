#include "rclcpp/rclcpp.hpp"
#include "my_interfaces/srv/two_ints.hpp"
#include <memory>

void op(const std::shared_ptr<my_interfaces::srv::TwoInts::Request>  request,
        std::shared_ptr<my_interfaces::srv::TwoInts::Response> response) {
    response->sum = request->a + request->b;
    response->prod = request->a * request->b;
    response->dif = request->a - request->b;
    RCLCPP_INFO(rclcpp::get_logger("rclcpp"), "Incoming request\na: %ld" " b: %ld", request->a, request->b);
    RCLCPP_INFO(rclcpp::get_logger("rclcpp"), "sending back response: Sum: [%lld], Prod: [%lld], Diff: [%d]\n", 
        (long long)response->sum, (long long)response->prod, response->dif == 0 ? 0 : 1);
}

int main(int argc, char **argv) {
    rclcpp::init(argc, argv);

    std::shared_ptr<rclcpp::Node> node = rclcpp::Node::make_shared("service");

    rclcpp::Service<my_interfaces::srv::TwoInts>::SharedPtr service =
        node->create_service<my_interfaces::srv::TwoInts>("two_ints", &op);

    RCLCPP_INFO(rclcpp::get_logger("rclcpp"), "Ready to operate two ints.");

    rclcpp::spin(node);
    rclcpp::shutdown();
}
