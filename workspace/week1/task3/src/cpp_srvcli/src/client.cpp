#include "rclcpp/rclcpp.hpp"
#include "my_interfaces/srv/two_ints.hpp"
#include <chrono>
#include <cstdlib>
#include <memory>
#include <iostream>

using namespace std::chrono_literals;

int main(int argc, char **argv) {
    rclcpp::init(argc, argv);

    if (argc != 3) {
        RCLCPP_INFO(rclcpp::get_logger("rclcpp"), "usage: operator_two_ints_client X Y");
        return 1;
    }

    std::shared_ptr<rclcpp::Node> node = rclcpp::Node::make_shared("operator_two_ints_client");
    rclcpp::Client<my_interfaces::srv::TwoInts>::SharedPtr client =
        node->create_client<my_interfaces::srv::TwoInts>("two_ints");

    auto request = std::make_shared<my_interfaces::srv::TwoInts::Request>();
    request->a = atoll(argv[1]);
    request->b = atoll(argv[2]);

    while (!client->wait_for_service(1s)) {
        if (!rclcpp::ok()) {
            RCLCPP_ERROR(rclcpp::get_logger("rclcpp"), "Interrupted while waiting for the service. Exiting.");
            return 0;
        }
        RCLCPP_INFO(rclcpp::get_logger("rclcpp"), "service not available, waiting again...");
    }

    auto result = client->async_send_request(request);
    // Wait for the result.
    if (rclcpp::spin_until_future_complete(node, result) == rclcpp::FutureReturnCode::SUCCESS) {
        // RCLCPP_INFO(rclcpp::get_logger("rclcpp"), "Received"); 
    } else {
        RCLCPP_ERROR(rclcpp::get_logger("rclcpp"), "Failed to call service");
    }
    auto ans = result.get();
    RCLCPP_INFO(rclcpp::get_logger("rclcpp"), "Sum: %ld, Prod: %ld, Diff: %d", ans->sum, ans->prod, (ans -> dif == 0) ? 0 : 1);
    rclcpp::shutdown();
    return 0;
}
