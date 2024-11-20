cmake_minimum_required(VERSION 3.5.0)
project(fibonacci VERSION 0.1.0 LANGUAGES C CXX)


include_directories(${PROJECT_SOURCE_DIR}/include)

add_library(Fibonacci STATIC src/Fibonacci.cpp)


add_executable(fibonacci demo/main.cpp)
target_link_libraries(fibonacci PRIVATE Fibonacci)

include(CTest)
enable_testing()

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
