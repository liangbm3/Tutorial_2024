
# Week1
全部完成
## 斐波那契数列
### 一、前期准备

#### 1、vscode下载

在官网下载，并安装相关插件，包括c/c++，cmake，cmake tools，Markdown All in One，Markdown Preview Enhanced。

#### 2、学习cmake与makefile

以`helloworld.cpp`程序为例，参考博客文章完成学习

##### 参考文章
`https://blog.csdn.net/m0_55127902/article/details/135677412?ops_request_misc=%257B%2522request%255Fid%2522%253A%2522331801E7-165D-403A-999D-E72FFCE1E0AA%2522%252C%2522scm%2522%253A%252220140713.130102334..%2522%257D&request_id=331801E7-165D-403A-999D-E72FFCE1E0AA&biz_id=0&utm_medium=distribute.pc_search_result.none-task-blog-2~all~sobaiduend~default-1-135677412-null-null.142^v100^pc_search_result_base2&utm_term=ubuntu%20vscode%20cmake&spm=1018.2226.3001.4187`

### 二、程序编写

该程序使用递归方法,在给定一个整数 `n`，计算并返回斐波那契数列的第`n` 项。

#### 1、工作原理

程序采用以下递归逻辑：
- 如果 `n = 0`，结果为 `0`。
- 如果 `n = 1`，结果为 `1`。
- 如果 `n > 1`，结果为前两个斐波那契数之和，即 `(n-1)` 和 `(n-2)` 的和。

#### 2.代码解释

##### `solution` 函数

```cpp
int solution(int i)
{
    if(i == 0) return 0; 
    if(i == 1) return 1;
    //特例特判：初始的i=0，i=1，分别对应0和1
    return solution(i-1) + solution(i-2);
    //递归至i-1和i-2，直至i=0或i=1
}
```

##### `main` 函数

```cpp
int main()
{
    int n;
    cin>>n;//输入n
    int sum;
    sum=solution(n);
    cout<<sum<<endl;//输出结果
    return 0;
}
```
### 三、编译

##### 1、在vscode中使用Ctrl+P打开命令面板，输入camke:q，选择快速入门。
##### 2、输入项目名称，选择创建C++项目，选择创建可执行文件
##### 3、在终端输入以下命令编译项目并运行可执行文件

```
cd build
cmake ..
make 
./Hello
```
### 四、执行结果
![alt text](<Screenshot from 2024-11-22 11-57-55.png>)

## Linux shell


### 一、前期准备

#### 扩展下载

在`vscode`中下载`Bash IDE`和`ShellCheck`扩展

### 二、程序编写

#### 1、实现逻辑

传入参数，对参数进行判断，并进行相应操作

#### 2、代码

```shell
#!/bin/bash

if [ $# -eq 0 ];then #如果没有参数传入，则列出所有图书
    cat books.txt
fi

operation=$1
shift

if [ "$operation" = "-a" ];then
    new_book_info=$*
    new_book_number=$(echo $new_book_info | cut -d: -f1)
    #获得new_book_info并从中提取出new_bokk_number
    if grep -q "^$new_book_number:" books.txt;then #添加书籍
        echo "The book has existed and its info is as followed:"
        grep "^$new_book_number:" books.txt
    else
        echo $new_book_info >> books.txt
        echo "The book is added successfully."
    fi
elif [ "$operation" = "-d" ];then #删除书籍
    book_to_delete_number=$*
    if grep -q "^$book_to_delete_number:" books.txt;then
        echo "Are you sure to DELETE it?(y/n)"
        read confirmation #寻求确定
        if [ "$confirmation" = "y" ] || [ "$confirmation" = "yes" ] || [ "$confirmation" = "Y" ];then
            sed -i "/^$book_to_delete_number:/d" books.txt
            echo "It was deleted seccessfully."
        else
            echo "The delete operation was stoped."
        fi
    else 
        echo "The book does not exist and delete operation fails."
    fi
elif [ "$operation" = "-s" ];then #搜索
    book_to_search_number=$*
    if grep -q "^$book_to_search_number:" books.txt;then
        echo "The book exists and its info is as followed."
        grep "^$book_to_search_number:" books.txt
    else
        echo "The book does not exist." 
    fi
elif [ "$operation" != "" ];then #不合法的输入时，提示该脚本的规范输入
    echo "Your operation is wrong and the right one is as followed"
    echo "book.sh,which means listing all info of books"
    echo "book.sh -a [new_book_number:new_book_name:new_book_author:new_book_type],which means adding "
    echo "book.sh -d [book_to_delete_number],which means deleting the info of the book"
    echo "book.sh -d [book_to_search_number],which means searching the info of the book"
fi
#写代码的时候，linux还没下中文，所以回应都是蹩脚的英文，应该没关系吧
```
###### 本质上就是对传入的参数进行判断

#### 3、执行结果

![alt text](<Screenshot from 2024-11-22 14-06-35.png>)

## ROS简单话题通信和自定义消息

### 一、前期准备

#### 1、ROS安装
#### 2、工作区构建
##### 参考文章
`https://liangbm3.top/2024/11/02/ros1%E5%9F%BA%E7%A1%80%E4%B8%8E%E5%B8%B8%E7%94%A8%E5%91%BD%E4%BB%A4/#5-1-%E5%B0%8F%E6%B5%B7%E9%BE%9F`

### 二、程序编写

#### 0、模仿操作
##### 参考文章
`https://liangbm3.top/2024/11/02/ros1%E5%9F%BA%E7%A1%80%E4%B8%8E%E5%B8%B8%E7%94%A8%E5%91%BD%E4%BB%A4/#5-1-%E5%B0%8F%E6%B5%B7%E9%BE%9F`

#### 1、功能包构建和编译

#### 2、创建自定义消息类型

##### 创建消息文件 
在`pub_sub_pkg`下，新建`msg`文件夹。在其中创建`RandomNumber.msg`
```
int32 number1
int32 number2
```
##### 修改 `package.xml`
在`packsge.xml`中添加以下内容
```
<build_depend>message_generation</build_depend>
<exec_depend>message_runtime</exec_depend>
```

##### 修改`CMakeLists.txt`
对照
```
find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
  message_generation
)

add_message_files(
  FILES
  RandomNumber.msg
)

generate_messages(
  DEPENDENCIES
  std_msgs
)
```

##### `catkin_make`编译

#### 3、Publisher的编写

##### 代码
```cpp
#include <ros/ros.h>
#include <pub_sub_pkg/RandomNumber.h>
#include <cstdlib>  // for rand()
#include <ctime>    // for time()

int main(int argc, char** argv) {
    ros::init(argc, argv, "random_number_publisher");
    ros::NodeHandle nh;

    // 创建一个发布者，发布到 "random_number" 主题
    ros::Publisher random_pub = nh.advertise<pub_sub_pkg::RandomNumber>("random_number", 10);

    // 初始化随机数生成器
    std::srand(static_cast<unsigned int>(std::time(0)));

    // 设置循环频率
    ros::Rate loop_rate(1);  // 每秒发布一次

    while (ros::ok()) {
        // 创建一个消息并设置随机数
        //std_msgs::Int32 msg;
        //msg.data = std::rand() % 100;  // 生成 0 到 99 的随机数
        pub_sub_pkg::RandomNumber msg;
        msg.number1 = std::rand() % 100;
        msg.number2 = std::rand() % 100;
        // 发布消息
        random_pub.publish(msg);
        ROS_INFO("Published random number: %d %d", msg.number1, msg.number2);

        // 休眠直到下一个循环
        ros::spinOnce();
        loop_rate.sleep();
    }

    return 0;
}
```

##### 修改`CMakeLists.txt`
##### `catkin_make`编译

#### 4、subscriber的编写

##### 代码
```cpp
#include <ros/ros.h>
#include <pub_sub_pkg/RandomNumber.h>

void randomNumberCallback(const pub_sub_pkg::RandomNumber::ConstPtr& msg) {
    ROS_INFO("Received: num1 = %d, num2 = %d", msg->number1, msg->number2);
}
int main(int argc, char** argv) {
    ros::init(argc, argv, "random_number_subscriber");
    ros::NodeHandle nh;

    // 创建一个订阅者，订阅 "random_number" 主题
    ros::Subscriber sub = nh.subscribe("random_number", 10, randomNumberCallback);

    // 循环等待回调
    ros::spin();

    return 0;
}
```
##### 修改`CMakeLists.txt`
##### `catkin_make`编译

#### 5、运行

##### 启动ROS核心
```roscore```

##### 启动发布节点
```
rosrun pub_sub_pkg random_number_publisher
```

##### 启动订阅节点
```
rosrun pub_sub_pkg random_number_subscriber
```
### 三、执行结果
![alt text](<Screenshot from 2024-11-22 15-07-51.png>)
![alt text](<Screenshot from 2024-11-22 15-08-22.png>)

## ROS简单服务通信

### 二、程序编写

#### 0、模仿操作
##### 参考文章
`https://liangbm3.top/2024/11/02/ros1%E5%9F%BA%E7%A1%80%E4%B8%8E%E5%B8%B8%E7%94%A8%E5%91%BD%E4%BB%A4/#5-1-%E5%B0%8F%E6%B5%B7%E9%BE%9F`

#### 1、创建功能包
在`src`文件夹下执行
```
catkin_create_pkg math_operations_service std_msgs rospy roscpp message_generation
```
第二个为功能包名称，其后为依赖的库和工具

#### 2、创建自定义服务消息
在功能包中新建`srv`文件夹，添加`MathOperations.srv`文件,内容：
```
int64 num1
int64 num2
---
int64 sum
int64 product
bool are_equal
```
上面是请求的数据，下面是响应的数据

#### 3、修改`CMakeLists.txt`和`Package.xml`
确保`CMakeLists.txt`有以下内容
```cmake
#所需ROS组件包
find_package(catkin REQUIRED COMPONENTS
  rospy
  std_msgs
  message_generation
)

#指定了自定义服务消息文件
add_service_files(
  FILES
  MathOperations.srv
)

#根据依赖生成消息相关的代码
generate_messages(
  DEPENDENCIES
  std_msgs
)
```
确保`Package.xml`有以下内容
```
#与自定义消息类型相关
<build_depend>message_generation</build_depend>
<exec_depend>message_runtime</exec_depend>
```

#### 1、创建服务端
在math_operations_service/src目录下创建一个名为math_operations_service_server.cpp的文件，其代码内容如下：
```cpp
#include <ros/ros.h>
#include <math_operations_service/MathOperations.h> // 引入自定义服务消息头文件

// 处理数学运算请求的回调函数
bool handle_math_operations(math_operations_service::MathOperations::Request &req,
                            math_operations_service::MathOperations::Response &res) {
    // 计算两数之和
    res.sum = req.num1 + req.num2;
    // 计算两数之积
    res.product = req.num1 * req.num2;
    // 判断两数是否相等
    res.are_equal = (req.num1 == req.num2);
    ROS_INFO("Request: num1=%ld, num2=%ld; Sending back response: sum=%ld, product=%ld, are_equal=%s",
             req.num1, req.num2, res.sum, res.product, res.are_equal? "True" : "False");
    return true; // 返回成功
}

int main(int argc, char **argv) {
    ros::init(argc, argv, "math_operations_service_server"); // 初始化节点
    ros::NodeHandle n; // 创建节点句柄

    // 创建服务，注册到名为 "math_operations" 的服务上
    ros::ServiceServer service = n.advertiseService("math_operations", handle_math_operations);
    ROS_INFO("Ready to perform math operations."); // 打印日志信息
    ros::spin(); // 进入循环，等待服务请求

    return 0; // 返回成功
}
```
##### 修改`CMakeLists.txt`
```cmake
#指定生成的可执行文件及其源文件
add_executable(math_operations_service_server src/math_operations_service_server.cpp)
#链接所需的ROS库
target_link_libraries(math_operations_service_server ${catkin_LIBRARIES})
#与自定义消息有关
add_dependencies(math_operations_service_server math_operations_service_generate_messages_cpp)
```
##### 编译

#### 2、创建客户端

同理，在math_operations_service/src目录下创建一个名为math_operations_service_client.cpp的文件
```cpp
#include <ros/ros.h>
#include <math_operations_service/MathOperations.h> // 引入自定义服务消息头文件

int main(int argc, char **argv) {
    // 检查命令行参数数量
    if (argc!= 3) {
        ROS_INFO("Usage: math_operations_service_client <num1> <num2>");
        return 1; // 返回错误
    }

    ros::init(argc, argv, "math_operations_service_client"); // 初始化节点
    ros::NodeHandle n; // 创建节点句柄

    // 创建服务客户端，连接到 "math_operations" 服务
    ros::ServiceClient client = n.serviceClient<math_operations_service::MathOperations>("math_operations");
    math_operations_service::MathOperations srv; // 创建服务请求对象
    srv.request.num1 = atoll(argv[1]); // 将第一个参数转为整数并赋值
    srv.request.num2 = atoll(argv[2]); // 将第二个参数转为整数并赋值

    // 调用服务并检查是否成功
    if (client.call(srv)) {
        ROS_INFO("Sum: %ld, Product: %ld, Are equal: %s", srv.response.sum, srv.response.product,
                 srv.response.are_equal? "True" : "False");
    } else {
        ROS_ERROR("Failed to call service math_operations"); // 打印错误信息
        return 1; // 返回错误
    }

    return 0; // 返回成功
}
```

##### 修改`CMakeLists`
同理
```cmake
add_executable(math_operations_service_client src/math_operations_service_client.cpp)
target_link_libraries(math_operations_service_client ${catkin_LIBRARIES})
add_dependencies(math_operations_service_client math_operations_service_generate_messages_cpp)
```

##### 编译

### 三、运行

#### 1、启动ROS核心，服务器节点，客户端节点
```
rosrun math_operations_service math_operations_service_server
```
```
rosrun math_operations_service math_operations_service_client <num1> <num2>
```

#### 2、结果
![alt text](<Screenshot from 2024-11-22 16-47-35.png>)