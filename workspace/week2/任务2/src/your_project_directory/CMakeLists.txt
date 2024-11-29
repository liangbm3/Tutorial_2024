cmake_minimum_required(VERSION 3.0.2)
project(your_project_directory)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  geometry_msgs
  mavros_msgs 
  
)

catkin_package()

include_directories(
  ${catkin_INCLUDE_DIRS}
)

add_executable(your_project_directory_node src/main.cpp)

target_link_libraries(your_project_directory_node
  ${catkin_LIBRARIES}
)
add_dependencies(your_project_directory_node ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})