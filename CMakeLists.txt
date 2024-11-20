# 设置最低 CMake 版本
cmake_minimum_required(VERSION 3.10)

# 定义项目名称
project(Fibonacci)

# 设置 C++ 标准
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# 添加可执行文件
add_executable(Fibonacci Fibonacci.cpp)

