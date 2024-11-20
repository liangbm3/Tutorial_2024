# 第一周任务说明

---
- Author: 郑思扬
- Reviced: 郑思扬
- Date: 2024-11-20
- Version: 1.0.0
- Abstract: 空队第一周任务说明

- *Note: 需要编写的代码部分已全部完成，但所有的编译和运行部分不包含在提交的代码中，需要按文中编译运行步骤运行*
---
## 任务一

#### 代码内容说明
> - Functions: 
>     输入一个整数 n,计算并返回**斐波那契数列**的第 n 项
> - Depend Libraries:
>     依赖 - C++标准库

#### 代码
- [fibonacci.cpp](./Week1Task1/fibonacci.cpp)
```C++
#include <iostream>

/**
 * @brief 斐波那契数列递归函数
 * @param n 斐波那契数列项数
 * 
 * @return 返回数列的值
 */
int getFibonacci(int n) {
    if (n == 0) return 0;	///递归终点 F(0) = 0
    else if (n == 1) return 1;	///递归终点 F(1) = 1
    else {
        /**
         * 斐波那契数列递归式
         * F(n) = F(n - 1) + F(n - 2)
        */
        return getFibonacci(n - 1) + getFibonacci(n - 2);
    }
}

int main() {
    int n;  ///斐波那契数列项数
    std::cin >> n;  
    std::cout << getFibonacci(n) << std::endl;
    return 0;
}

- [CMakeLists.txt](./Week1Task1/CMakeLists.txt)
```cmake
#指定所需的最低 CMake 版本
cmake_minimum_required (VERSION 3.10)

#定义项目名称和语言
project(Week1Task1 LANGUAGES CXX)

#设置C++标准
set(CMAKE_CXX_STANDARD 11)
set(CMAKW_CXX_STANDARD_REQUIRED True)

#添加可执行文件及其源文件
add_executable(fibonacci fibonacci.cpp)
```
#### 编译过程

  为了使项目更简洁有条理，先在项目文件夹中建立 **build 文件夹**
  并进入文件夹
```
$ mkdir build
$ cd build
```

  然后执行 cmake 指令
```
$ cmake ..
```
  等待cmake完成, 执行make指令
```
$ make
```
  执行完成后会生成**目标文件 fibonacci.exe**

#### 测试程序
  尝试运行 fibonacci.exe :
```
$ ./fibonacci
```
  然后输入数据n, 按回车可得输出[结果](./Photo/1.1%20任务一运行结果.png)

## 任务二

#### 代码内容说明
>  - Functions: 
>     一个名称为 **book.sh的脚本**，该脚本实现以下功能：
>         1. 当输入 book.sh 时，
>             + 列出文件中所有书籍的记录内容。
>         2. 当输入 book.sh -a 2001:Python编程:张三:计算机科学 时，
>             + 首先判断 2001 书号记录是否存在，
>                 + 如果不存在，则将该信息写入文件；
>                 + 如果存在，则给出提示，并输出文件中书号为 2001 的该行信息。
>         3. 当输入 book.sh -d 2001 时，
>             + 首先判断 2001 书号记录是否存在，
>                 + 如果不存在，则给出提示；
>                 + 如果存在，则提示用户确认是否要删除记录。
>                     + 若用户输入 y 或 yes，则删除文件中书号为 2001 的该行信息；
>                     + 若用户输入 n 或 no，则不做删除操作。
>         4. 当输入 book.sh -s 2001 时，
>             + 首先判断 2001 书号记录是否存在，
>                 + 如果不存在，给出提示；
>                 + 如果存在，则输出文件中书号为 2001 的该行信息。
>         5. 当用户输入的选项不正确时，
>             + 给出错误提示，并显示脚本的使用方法。

#### 代码
- [文本文件book.txt](./Week1Task2/books.txt)
```
2001:Python编程:张三:计算机科学
2002:现代文学概论:李四:文学
2003:数据结构与算法:王五:计算机科学
2004:高等数学:赵六:数学
2005:世界历史:孙七:历史
```

- [脚本文件book.sh](./Week1Task2/book.sh)
```shell
#!/bin/bash

# 定义书籍信息文件
BOOK_FILE="books.txt"

# 检查文件是否存在
if [ ! -f "$BOOK_FILE" ]; then
    echo "书籍信息文件不存在。"
    exit 1
fi

# @brief 列出所有书籍记录
listBooks() {
    echo "文件中所有书籍的记录内容："
    cat "$BOOK_FILE"
}

# @brief 添加书籍记录
addBook() {
    local book_info="$1"
    local book_id=$(echo "$book_info" | cut -d':' -f1)
    if grep -q "^$book_id:" "$BOOK_FILE"; then
        echo "书号为 $book_id 的记录已存在。"
        grep "^$book_id:" "$BOOK_FILE"
    else
        echo "$book_info" >> "$BOOK_FILE"
        echo "书号为 $book_id 的记录已添加。"
    fi
}

# @brief 删除书籍记录
deleteBook() {
    local book_id="$1"
    if grep -q "^$book_id:" "$BOOK_FILE"; then
        echo "书号为 $book_id 的记录存在。"
        read -p "是否要删除记录？(y/n): " confirm
        if [[ "$confirm" == "y" || "$confirm" == "yes" ]]; then
            sed -i "/^$book_id:/d" "$BOOK_FILE"
            echo "书号为 $book_id 的记录已被删除。"
        else
            echo "操作已取消。"
        fi
    else
        echo "书号为 $book_id 的记录不存在。"
    fi
}

# @brief 搜索书籍记录
searchBook() {
    local book_id="$1"
    if grep -q "^$book_id:" "$BOOK_FILE"; then
        grep "^$book_id:" "$BOOK_FILE"
    else
        echo "书号为 $book_id 的记录不存在。"
    fi
}

# 主函数
main() {
    if [ $# -eq 0 ]; then
        listBooks
    elif [ "$1" == "-a" ] && [ $# -eq 2 ]; then
        addBook "$2"
    elif [ "$1" == "-d" ] && [ $# -eq 2 ]; then
        deleteBook "$2"
    elif [ "$1" == "-s" ] && [ $# -eq 2 ]; then
        searchBook "$2"
    else
        echo "错误：不正确的参数。"
        echo "使用方法："
        echo "  $0                 列出所有书籍记录"
        echo "  $0 -a <book_info>  添加书籍记录，格式：书号:书名:作者:类别"
        echo "  $0 -d <book_id>    删除书号为 <book_id> 的记录"
        echo "  $0 -s <book_id>    搜索书号为 <book_id> 的记录"
    fi
}

# 执行主函数
main "$@"
```
#### 运行过程

  确保脚本和文档**在同一文件夹下**,并在 Linux 系统中给予执行权限
```
$ chmod +x book.sh
```
  然后可以通过以下程序[运行](./Photo/2.1%20任务二运行结果.png)
  再次点开 book.txt 可以[查看修改后的文档](./Photo/2.2%20任务二运行结果.png)
```
./book.sh                          # 列出所有书籍记录
./book.sh -a 2006:新书名:新作者:    # 新类别添加书籍记录
./book.sh -d 2001                  # 删除书籍记录
./book.sh -s 2001                  # 搜索书籍记录
```

## 任务三
### 工作空间配置
  首先**创建工作空间**
```
$ mkdir -p ~/catkin_ws/src
$ cd ~/catkin_ws/src
$ catkin_init_workspace
```
  尝试编译工作空间
```
$ cd ~/catkin_ws/
$ catkin_make
```
  添加 **install 文件夹**
```
$ catkin_make install
```
  设置并检查环境变量
```
$ source devel/setup.bash
$ echo $ROS_PACKAGE_PATH
```

### 问题一
#### 代码内容说明
> - Functions: 
>     包含一个**信息发布节点 Publisher**，和一个**信息订阅节点 Subscriber**的**package**。
>     信息发布节点产生随机数据并发布自己创建的自定义消息类型，信息订阅节点订阅话题并将数据输出到终端。
> - Depend Libraries:
>     依赖 - ros库
#### 代码
- [signal_send.msg](./Week1Task3/publisher_subscriber/Signal_send.msg)
```
int8 number
string text
```
- [signal_publisher.cpp](./Week1Task3/publisher_subscriber/signal_publisher.cpp)
```C++
#include "publisher_subscriber/Signal_send.h"
#include <ros/ros.h>

int main(int argc, char **argv) {
    ros::init(argc, argv, "signal_publisher");///发布节点初始化

    ros::NodeHandle node;///创建节点句柄

    ros::Publisher signal_info_pub = node.advertise<publisher_subscriber::Signal_send>("/signal_info", 10);///创建publisher, 队列长度为10
    
    ros::Rate loop_rate(10);///设置循环频率
    int count = 0;
    while (ros::ok()) {
        publisher_subscriber::Signal_send signal_send_msg;//初始化消息类型
        signal_send_msg.number = static_cast<int>(rand()%10);
        signal_send_msg.text = "Random Data";
        
        signal_info_pub.publish(signal_send_msg);///发布消息
        ROS_INFO("Publish Signal Info: number:%d    text:%s", signal_send_msg.number, signal_send_msg.text.c_str());
        
        ros::spinOnce();
		loop_rate.sleep();///按照循环频率延时
    }
    return 0;
}
```
- [signal_subscriber.cpp](./Week1Task3/publisher_subscriber/signal_subscriber.cpp)
```C++
#include "publisher_subscriber/Signal_send.h"
#include <ros/ros.h>

/**
 * @brief 回调函数
 * @param signal_received_msg 接收数据的指针
 * 
 * @return void
 */
void signalInfoCallback(const publisher_subscriber::Signal_send::ConstPtr& signal_received_msg) {
    ROS_INFO("Subscribe Signal Info: number:%d    text:%s", signal_received_msg->number, signal_received_msg->text.c_str());
}
int main(int argc, char **argv) {
    ros::init(argc, argv, "signal_subscriber");///信息接收节点初始化

    ros::NodeHandle node;///创建节点句柄

    ros::Subscriber signal_info_sub = node.subscribe("/signal_info", 10, signalInfoCallback);///创建subscriber, 队列长度为10
    
    ros::spin();///循环等待回调函数
    return 0;
}
```
#### 编译过程
  先**创建一个 package**
```
$ cd ~/catkin_ws/src
$ catkin_create_pkg publisher_subscriber roscpp rospy std_msgs geometry_msgs turtlesim
```
  在 package 下创建一个名为 **msg 的文件夹**，和**Signal_send.msg 文件**
```
$ mkdir msg
$ cd ~/publisher_subscriber/msg
$ touch Signal_send.msg
```
  将 Signal_send.msg 代码粘贴进来
  回到 publisher_subscriber 下，修改 **package.xml 文件**,加入（66行后）
```xml
  <build_depend>message_generation</build_depend>
  <exec_depend>message_runtime</exec_depend>
```
  修改 **CMakeList.txt**
  添加（15行后）
```cmake
  message_generation
```
  加入(77行后)
```cmake
add_message_files(FILES Signal_send.msg)
generate_messages(DEPENDENCIES std_msgs)
```
  去掉 CATKIN_DEPENDS （114行）的注释(#)，添加
```
message_runtime
```
**回到工作空间根目录**，尝试编译
```
$ source devel/setup.bash
$ catkin_make
```
然后进入src文件夹，将 signal_publisher.cpp 和 signal_subscriber.cpp 粘贴进来
再次修改**CMakeLists.txt**, 加入（158行后）
```cmake
add_executable(signal_publisher src/signal_publisher.cpp)
target_link_libraries(signal_publisher ${catkin_LIBRARIES})
add_dependencies(signal_publisher ${PROJECT_NAME}_generate_message_cpp)

add_executable(signal_subscriber src/signal_subscriber.cpp)
target_link_libraries(signal_subscriber ${catkin_LIBRARIES})
add_dependencies(signal_subscriber ${PROJECT_NAME}_generate_message_cpp)
```
**回到工作空间根目录**，尝试编译
```
$ source devel/setup.bash
$ catkin_make
```
#### 运行过程
  先运行一个 ros master, ctrl + alt + t 打开一个新终端
```
$ roscore
```
  在工作区 catkin_ws 下打开终端
  先设置**环境变量**
```
$ source devel/setup.bash
```
  然后运行 subscriber
```
$ rosrun publisher_subscriber signal_subscriber
```
  在工作区 catkin_ws 下打开终端
  先设置**环境变量**
```
$ source devel/setup.bash
```
  最后运行 publisher
```
$ rosrun publisher_subscriber signal_publisher
```
  [即可看到数据传输](./Photo/3.1%20任务三运行结果.png)

### 问题二
#### 代码内容说明
> - Functions: 
>    包含一个**服务端Server**和一个**客户端client**的一个 **package**。客户端向服务端发送两个数字，服务端接收这两个数字并返回它们的和、乘积、是否相等(True or False)
> - Depend Libraries:
>   依赖 - ros库
#### 代码
- [Data.srv](./Week1Task3/client_server/Data.srv)
```
int8 a
int8 b
---
int8 sum
int8 product
string equal
```
- [data_client.cpp](./Week1Task3/client_server/data_client.cpp)
```C++
#include "client_server/Data.h"
#include <ros/ros.h>

int main(int argc, char **argv) {
    ros::init(argc, argv, "data_client");///客户端节点初始化

    ros::NodeHandle node;///创建节点句柄

    ros::service::waitForService("/send_data");///发现服务端
    ros::ServiceClient data_client = node.serviceClient<client_server::Data>("/send_data");///创建客户端

    client_server::Data srv;///初始化客户端数据
    int num1, num2;
    std::cin >> num1 >> num2;
    srv.request.a = num1;
    srv.request.b = num2;

    ROS_INFO("Call service to send data: a = %d    b = %d", srv.request.a, srv.request.b);///请求服务调用
    if (data_client.call(srv)) {
        ROS_INFO("Sum: %d", srv.response.sum);
        ROS_INFO("Product: %d", srv.response.product);
        ROS_INFO("Equal: %s", srv.response.equal.c_str());
    } else {
        ROS_ERROR("Failed to call service send_data");
    }
    return 0;
}
```
- [data_server.cpp](./Week1Task3/client_server/data_server.cpp)
```C++
#include "client_server/Data.h"
#include <ros/ros.h>

/**
 * @brief 回调函数
 * @param req 接收请求
 * @param res 发送结果
 * 
 * @return 返回说明
*        -<em>false</em> fail
*        -<em>true</em> succeed
*/
bool dataCallback(client_server::Data::Request &req, client_server::Data::Response &res) {
    ROS_INFO("Data: a: %d   b: %d", req.a, req.b);
    res.sum = req.a + req.b;///a与b的和
    res.product = req.a * req.b;///a与b的积
    if (req.a == req.b) {
        res.equal = "True";
    } else {
        res.equal = "False";
    }///a与b是否相等
    return true;
}

int main(int argc, char **argv) {
    ros::init(argc, argv, "data_server");///服务端节点初始化
    
    ros::NodeHandle node;///创建节点句柄

    ros::ServiceServer data_server = node.advertiseService("/send_data", dataCallback);///反馈处理结果
    
    ROS_INFO("Ready to compute data.");
    ros::spin();
    return 0;
}
```
#### 编译过程
  先创建一个 **package**
```
$ cd ~/catkin_ws/src
$ catkin_create_pkg client_server roscpp rospy std_msgs geometry_msgs turtlesim
```
  在 package 下创建一个名为 **srv 的文件夹**，和 **Data.srv 文件**
```
$ mkdir srv
$ cd ~/client_server/srv
$ touch Data.srv
```
  将 Data.srv 代码粘贴进来
  回到 client_server 下，修改 **package.xml** 文件,加入（66行后）
```xml
  <build_depend>message_generation</build_depend>
  <exec_depend>message_runtime</exec_depend>
```
  修改 **CMakeList.txt**
  添加（15行后）
```cmake
  message_generation
```
  加入(77行后)
```cmake
add_message_files(FILES Data.srv)
generate_messages(DEPENDENCIES std_msgs)
```
  去掉 CATKIN_DEPENDS （114行）的注释(#)，添加
```
message_runtime
```
回到工作空间根目录，尝试编译
```
$ source devel/setup.bash
$ catkin_make
```
然后进入src文件夹，将 **data_client.cpp** 和 **data_server.cpp** 粘贴进来
再次修改**CMakeLists.txt**, 加入（158行后）
```cmake
add_executable(data_client src/data_client.cpp)
target_link_libraries(data_client ${catkin_LIBRARIES})
add_dependencies(data_client ${PROJECT_NAME}_generate_message_cpp)

add_executable(data_server src/data_server.cpp)
target_link_libraries(data_server ${catkin_LIBRARIES})
add_dependencies(data_server ${PROJECT_NAME}_generate_message_cpp)
```
**回到工作空间根目录**，尝试编译
```
$ source devel/setup.bash
$ catkin_make
```

#### 执行过程
  先运行一个 ros master, ctrl + alt + t 打开一个新终端
```
$ roscore
```
  在工作区 catkin_ws 下打开终端
  先设置**环境变量**
```
$ source devel/setup.bash
```
  然后运行server
```
$ rosrun client_server data_server
```
  在工作区 catkin_ws 下打开另一个终端
  先设置**环境变量**
```
$ source devel/setup.bash
```
  最后运行client
```
$ rosrun client_server data_client
```
  然后输入两个数字，按enter查看[运行结果](./Photo/3.2%20任务三运行结果.png)