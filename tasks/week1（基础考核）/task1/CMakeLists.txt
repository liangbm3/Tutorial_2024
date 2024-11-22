# 制定cmake最低版本
cmake_minimum_required(VERSION 3.10)

# 设置工程名称
project(MyCppProject)

message("test")

# 指定语言版本
set(CMAKE_CXX_STANDARD 11)
# 创建可执行文件
add_executable(Fibonacci main.cpp)
