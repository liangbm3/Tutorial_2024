# **week1**

## **1. 斐波那契数列**
- 请打开`Fibonacci`文件夹查看
### **1.1 代码**

```
#include<iostream>
using namespace std;

int Fibonacci(int n)
{
    if(n==1)
    {
        return 1;
    }
    if(n==2)
    {
        return 1;
    }
    return Fibonacci(n - 1) + Fibonacci(n - 2);
}

int main(){
    int n;
    cout << "n = ";
    cin >> n;
    cout << Fibonacci(n) << endl;
    return 0;
}
```

### **1.2 vscode编译截图**
![Fibonacci](image/Fibonacci.png)


### **1.3 `cmake` 和 `makefile` 编译此c++程序**
#### **1.3.1 `CMakeList.txt`**
```
# 设置最低 CMake 版本
cmake_minimum_required(VERSION 3.10)

# 定义项目名称
project(Fibonacci)

# 设置 C++ 标准
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# 添加可执行文件
add_executable(Fibonacci Fibonacci.cpp)
```
#### **1.3.2 `Makefile`**
```
BUILD_DIR = build

all: $(BUILD_DIR)/Fibonacci

$(BUILD_DIR)/Fibonacci: Fibonacci.cpp
	mkdir -p $(BUILD_DIR)
	cd $(BUILD_DIR) && cmake ..
	cd $(BUILD_DIR) && make

clean:
	rm -rf $(BUILD_DIR)
```

## **2. Linux Shell**
- 请打开`Linus Shell`文件夹查看
### **2.1 创建`books.txt`**
![books.txt](image/books.txt.png)
### **2.2 创建`book.sh`脚本**
```
#!/bin/bash

BOOKS_FILE="books.txt"

usage() {
    echo "Usage:"
    echo " book.sh  -->  列出所有书籍记录"
    echo " book.sh -a  -->  添加书"
    echo " book.sh -d  -->  删除书"
    echo " book.sh -s  -->  查找对应书号的书籍信息"
}

if [ ! -f "$BOOKS_FILE" ];
then
    echo "错误：文件 $BOOKS_FILE 不存在！"
    exit 1
fi

if [ "$1" == "" ]
then 
    cat "$BOOKS_FILE"
elif [ "$1" == "-a" ]
then
    if [ -z "$2" ]
    then 
        echo "错误：没有正确输入要添加的书籍信息"
        usage
        exit 1
    fi
    IFS=":" read -r book_id title author category <<< "$2"
    if grep -q "^$book_id:" "$BOOKS_FILE"
    then
        echo "书号 $book_id 已存在"
        grep "^$book_id:" "$BOOKS_FILE"
    else
        echo "$2" >> "$BOOKS_FILE"
    fi
elif [ "$1" == "-d" ]
then
    if [ -z "$2" ]
    then 
        echo "错误：没有正确输入书号"
        usage
        exit 1
    elif grep -q "^$2:" "$BOOKS_FILE"
    then
        echo "确认删除书号为 $2 的书籍信息吗？ (y/n)"
        read -r confirm
        if [ "$confirm" == y ]
        then
            grep -v "^$2:" "$BOOKS_FILE" > tmpfile && mv tmpfile "$BOOKS_FILE"
        fi
    fi
elif [ "$1" == "-s" ]
then
    if [ -z "$2" ]
    then
        echo "错误：没有正确输入书号"
        usage
        exit 1
    elif grep -r "^$2:" "$BOOKS_FILE"
    then
        grep "^$2:" "$COOKS_FILE"
    else
        echo "找不到书号 $2 的信息"
    fi
else
    usage
    exit 1
fi
```
#### 2.2.1 列出所有书籍记录：输入`book.sh`
![book.sh2.2.1](image/book.sh2.2.1.png)
#### 2.2.2 添加书：输入`book.sh -a 2006:人工智能导论:刘八:计算机科学`
![book.sh2.2.2](image/book.sh2.2.2.png)
#### 2.2.3 删除书：输入`book.sh -d 2001`
- 输入 n
- 输入 y
![[book.sh2.2.3.png]]
#### 2.2.4 查找书：输入`book.sh -s 2001`
![book.sh2.2.4](image/book.sh2.2.4.png)
#### 2.2.5 不按规定输入时
![book.sh2.2.5](image/book.sh2.2.5.png)

## **3. ROS通信机制**
- 请打开`ROS_ws`文件夹查看
### **3.1 ROS成功安装**
![roscore](image/roscore.png)
### **3.1 `Publisher`和`Subscriber`**
先在`ROS_ws`中创建一个包`package_pub_sub`
#### 3.1.1执行截图
  ![rosrun_package_pub_sub](image/rosrun_package_pub_sub.png)

#### 3.1.2 代码思路

- 创建`randomdata.msg`
```
int32 id
float64 value
string timestamp
```
- `Publisher.cpp`
```
#include<ros/ros.h>

#include<package_pub_sub/randomdata.h>

#include<cstdlib>

#include<ctime>

  

int main(int argc, char** argv){

  

    //节点初始化

    ros::init(argc, argv, "random_publisher");

    //创建节点句柄

    ros::NodeHandle nh;

  

    //创建一个publisher，发布名为"random_topic"的topic，消息类型为package_pub_sub::randomdata，队列长度为10

    ros::Publisher pub = nh.advertise<package_pub_sub::randomdata>("random_topic", 10);

    //设置循环频率

    ros::Rate loop_rate(1);

  

    srand(time(0));

    while(ros::ok())

    {

        //初始化package_pub_sub::randomdata类型的消息

        package_pub_sub::randomdata msg;

        msg.id = rand() % 100;

        msg.value = static_cast<double>(rand()) / RAND_MAX;

        msg.timestamp = std::to_string(ros::Time::now().toSec());

        //发布消息

        pub.publish(msg);

        ROS_INFO("Published: ID=%d, Value=%.2f, Timestamp=%s", msg.id, msg.value, msg.timestamp.c_str());

        //按照循环频率等待下一次循环

        loop_rate.sleep();

    }

    return 0;

}
```

- `Subscriber.cpp`
```
#include<ros/ros.h>

#include<package_pub_sub/randomdata.h>

  

//接收到订阅的消息后，会进入消息回调函数

void callback(const package_pub_sub::randomdata::ConstPtr& msg){

    //打印接收到的消息

    ROS_INFO("Received: ID=%d, Value=%.2f, Timestamp=%s", msg->id, msg->value, msg->timestamp.c_str());

}

  

int main(int argc, char**argv){

    //初始化ROS节点

    ros::init(argc, argv, "random_subscriber");

    //创建节点句柄

    ros::NodeHandle nh;

  

    //创建订阅者，订阅名为"random_topic"的topic，消息类型为package_pub_sub::randomdata，队列长度为10

    ros::Subscriber sub = nh.subscribe("random_topic", 10, callback);

  

    //循环等待回调函数

    ros::spin();

    return 0;

}
```

#### 3.2.3 在CMakelists.txt 和 package.xml 中添加
- `CMakelists.txt`
```
find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  message_generation
)

add_message_files( FILES randomdata.msg )

generate_messages( 
	DEPENDENCIES std_msgs ) 

catkin_package( 
	CATKIN_DEPENDS roscpp std_msgs message_runtime )

add_executable(Publisher msg/Publisher.cpp) target_link_libraries(Publisher ${catkin_LIBRARIES}) 

add_executable(Subscriber msg/Subscriber.cpp) target_link_libraries(Subscriber ${catkin_LIBRARIES}) 
```
- `package.xml`
```
<build_depend>message_generation</build_depend>
<exec_depend>message_runtime</exec_depend>
```


### **3.3 `server`和`client`**
- 之前提交的那次一直编译不成功应该是我在创建包的时候没有执行一次`catkin_make`，其他步骤都和之前一致，然后就catkin_make成功了，好神~奇~
#### 3.3.1 运行截图

![rosrun_service_pkg](image/rosrun_service_pkg.png)
#### 3.3.2 代码思路
先在`ROS_ws`中创建一个包`service_pkg`
- `TwoNumbers.srv`
```
int32 a
int32 b
---
int32 sum
int32 product
bool is_equal

```
- `service_server.cpp`
```
#include <ros/ros.h>

#include <service_pkg/TwoNumbers.h>

  

bool handle_request(service_pkg::TwoNumbers::Request &req,

                    service_pkg::TwoNumbers::Response &res)

{

    //定义三种运算

    res.sum = req.a + req.b;

    res.product = req.a * req.b;

    res.is_equal = (req.a == req.b);

    //打印三种运算结果

    ROS_INFO("Received: a=%d, b=%d | Sum=%d, Product=%d, Equal=%s",

             req.a, req.b, res.sum, res.product, res.is_equal ? "True" : "False");

    //如果成功调用，则返回true

    return true;

}

  

int main(int argc, char **argv)

{

    //初始化ROS节点

    ros::init(argc, argv, "number_service");

    //创建节点句柄

    ros::NodeHandle nh;

  

    //创建一个服务，名为"two_numbers"，回调函数为handle_request

    ros::ServiceServer server = nh.advertiseService("two_numbers", handle_request);

    //打印日志：表示服务已启动

    ROS_INFO("Service ready.");

    //循环等待

    ros::spin();

    return 0;

}
```
- `service_client.cpp`
```
#include <ros/ros.h>

#include <service_pkg/TwoNumbers.h>

  

int main(int argc, char **argv)

{

    //初始化客户端节点

    ros::init(argc, argv, "number_client");

    //创建节点句柄

    ros::NodeHandle nh;

  

    //创建一个服务客户端，连接名为“two_numbers”的服务，客户端与服务器之间的交互类型为“service_pkg::TwoNumbers”

    ros::ServiceClient client = nh.serviceClient<service_pkg::TwoNumbers>("two_numbers");

    //声明服务请求消息

    service_pkg::TwoNumbers srv;

    srv.request.a = 5;

    srv.request.b = 10;

  

    //调用服务，等待服务端返回结果

    if (client.call(srv))

    {

        ROS_INFO("Response: Sum=%d, Product=%d, Equal=%s",

                 srv.response.sum, srv.response.product, srv.response.is_equal ? "True" : "False");

    }

    else

    {

        //调用失败打印错误

        ROS_ERROR("Failed to call service.");

    }

    return 0;

}
```

#### 3.3.3 CMakelists.txt 和 package.xml 的添加
- `CMakelists.txt`
```
find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  message_generation
)

add_service_files( FILES TwoNumbers.srv )

generate_messages( 
	DEPENDENCIES std_msgs ) 

catkin_package( 
	CATKIN_DEPENDS roscpp std_msgs message_runtime )

add_executable(service_server src/service_server.cpp) target_link_libraries(service_server ${catkin_LIBRARIES}) add_dependencies(service_server ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS}) 

add_executable(service_client src/service_client.cpp) target_link_libraries(service_client ${catkin_LIBRARIES}) add_dependencies(service_client ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

```

- `package.xml`
```
<build_depend>message_generation</build_depend>
<exec_depend>message_runtime</exec_depend>

```
