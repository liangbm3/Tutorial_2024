#指定所需的最低 CMake 版本
cmake_minimum_required (VERSION 3.10)

#定义项目名称和语言
project(Week1Task1 LANGUAGES CXX)

#设置C++标准
set(CMAKE_CXX_STANDARD 11)
set(CMAKW_CXX_STANDARD_REQUIRED True)

#添加可执行文件及其源文件
add_executable(fibonacci fibonacci.cpp)
