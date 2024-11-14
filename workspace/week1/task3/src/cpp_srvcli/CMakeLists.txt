cmake_minimum_required(VERSION 3.5)
project(cpp_srvcli)

find_package(ament_cmake REQUIRED)
find_package(rclcpp REQUIRED)
find_package(my_interfaces REQUIRED)

add_executable(server src/service.cpp)
ament_target_dependencies(server
rclcpp my_interfaces)

add_executable(client src/client.cpp)
ament_target_dependencies(client
rclcpp my_interfaces)

install(TARGETS
  server
  client
  DESTINATION lib/${PROJECT_NAME})

ament_package()
