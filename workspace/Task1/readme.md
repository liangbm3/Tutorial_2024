# Task1

- 作者： 孙凯
- 时间： 2024.11.20
- 概述：第一周任务实现内容

## 任务一 ：斐波那契数列

### 实现思路：

根据任务提示中所给出的算法实现方法，我这里选择的是滚动数组法，采用动态规划的思想。

在这个迭代实现中，使用了两个变量 prev2 和 prev1 分别存储前两个 Fibonacci 数字 F(n-2) 和 F(n-1)。通过更新这两个变量，逐步计算 Fibonacci 数列的每一项，直到计算出 F(n)。
初始时，prev2 = 0（F(0)），prev1 = 1（F(1)）。从 i = 2 开始，逐步计算 Fibonacci 数列的每一项：result = prev1 + prev2（即 F(i) = F(i-1) + F(i-2)），更新 prev2 为 prev1，并更新 prev1 为 result。通过这种方式，最终 result 就保存了 F(n)。

***算法复杂度 :***

时间复杂度：O(n)

空间复杂度： O(1)

***滚动数组法：***

是动态规划中常用的空间优化算法，可以优化算法使用的空间，在一些情况下甚至可以降低时间复杂度。

### 算法实现流程

1. 建立一个项目Fibonacci，然后创建`demo`, `include`, `src`三个文件夹。（`demo`是存放项目`main`源文件，`include`是存放项目头文件， `src`是存放要编译的源文件）

2. 在`demo`, `include`, `src`中依次添加`main.cpp` `Fibonacci.h` `Fibonacci.cpp`三个文件, 接口如下:

   ```C++
   int Fibonacci(int n);
   ```

3. 编写CMakeLists.txt: 

   ```cmake
   include_directories(${PROJECT_SOURCE_DIR}/include)#添加头文件路径
   
   add_library(Fibonacci STATIC src/Fibonacci.cpp)#添加静态库
   
   add_executable(fibonacci demo/main.cpp)#创建可执行文件
   target_link_libraries(fibonacci PRIVATE Fibonacci)#链接静态库
   ```

4. 打开终端，开始编译：

   ```bash
   $ cmake .
   $ make
   $ ./fibonacci
   ```

### 算法执行结果：

![](/home/sk/Tutorial_2024/workspace/Task1/image/Screenshot from 2024-11-20 09-02-21.png)

### 任务完成情况：

**已完成：**

1. 算法C++代码实现
2. 通过终端调用Cmake和make进行编译

**未完成：**

无

## 任务二：Linux Shell

### 实现思路：

根据任务内容，需要我实现的是显示书籍记录、添加书籍、删除书籍和查询书籍四种基本功能，并且需要添加应有的报错信息。

我将代码分为四个模块：

```bash
#检查文件是否存在
...........
-----------------
#显示脚本使用方式
usage()
...........
-----------------
#判断功能输入
#没有参数,显示所有书籍记录
if [ $# -eq 0 ]; then
...........
#参数 -a 添加书籍 
if [ "$1" == "-a" ]; then
#检查书号是否存在
if ! grep -q "^$BOOK_ID:" "$BOOK_FILE"; then
...........
#参数 -d 删除书籍
if [ "$1" == "-d" ]; then
#检查书号是否存在
if ! grep -q "^$BOOK_ID:" "$BOOK_FILE"; then
...........
#参数 -s 查询书籍
if [ "$1" == "-s" ]; then
#检查书号是否存在
if ! grep -q "^$BOOK_ID:" "$BOOK_FILE"; then
...........
-----------------
#没有匹配到任何有效的选项，显示使用方法
usage
-----------------
```

### 实现流程：

1. 导入`books.txt`并用变量BOOK_FILE代替他，然后利用`! -f "$BOOK_FILE"`来判断文件路径是否存在。

   ```bash
   BOOK_FILE="books.txt"
   # 检查文件是否存在
   if [ ! -f "$BOOK_FILE" ]; then
   ```

   

2. 定义函数`usage()`来显示使用方法

   ```bash
   usage() {
       echo "输入选项错误！"
       echo "使用方法:"
       echo "  $0                # 显示所有书籍记录"
       echo "  $0 -a 书号:书名:作者:类别  # 添加新的书籍记录"
       echo "  $0 -d 书号       # 删除指定书号的书籍记录"
       echo "  $0 -s 书号       # 查询指定书号的书籍记录"
       exit 1
   }
   ```

   

3. 功能输入判断： 通过不同的参数来判断指令功能，并在各个功能中添加书号不存在的检查和提示。

   ```bash
   #第二个参数$1不存在，则显示书籍记录
    $# -eq 0 
   #第二个参数$1为 -a ，则添加书籍
   "$1" == "-a"
   #第二个参数$1为 -d ，则删除书籍
   "$1" == "-d" 
   #第二个参数$1为 -s ，则查询书籍
   "$1" == "-s"
   ```

4. 输入选项不符合，则调用`usage`显示使用方法  

### 任务执行结果：

![](/home/sk/Tutorial_2024/workspace/Task1/image/Screenshot from 2024-11-17 14-35-45.png)

### 任务完成情况：

**已完成**：

1. `book.sh `功能实现
2. if 判断语句检测不同参数
3. 脚本正确处理用户输入的错误参数并给出提示。

**未完成**：

无

## 任务三：ROS通信机制

### 3.1 话题通信和自定义消息

### 实现思路：

1. 创建一个Publisher节点发布两个随机数据。
2. 创建一个Subscriber节点订阅该话题并打印接收到的数据。
3. 自定义一个消息类型，里面包含两个int类型和一个string类型的消息变量。

### 实现流程：

1. 创建一个`simple_ message`的功能包，命令行如下：

   ```shell
   $ catkin_create_pkg simple_message std_msgs rospy roscpp message_generation
   $ catkin_make
   $ source /devel/setup.bash
   ```

2. 自定义消息类型`RandomData.msg`,消息文件内容如下：

   ```shell
   int32 num1
   int32 num2
   string info
   ```

3. 修改`CMakeLists.txt`和`package.xml`

   ```cmake
   find_package(catkin REQUIRED COMPONENTS
     message_generation
     roscpp
     rospy
     std_msgs
   )
   add_message_files(
     FILES
     RandomData.msg
   )
   generate_messages(
     DEPENDENCIES
     std_msgs
   )
   ```

   ```xml
   <build_depend>message_generation</build_depend>
   <exec_depend>message_generation</exec_depend> <!--我这里还添加了message_generation的包运行依赖 -->
   <exec_depend>message_runtime</exec_depend>
   ```

   修改完以后，生成消息头文件

   ```shell
   $ catkin_make
   ```

4. 编写Publisher节点

   在`simple_message/src`中添加`random_data_publisher.cpp`

   ```C++
   //添加应有的头文件
   #include<ros/ros.h>
   #include<simple_message/RandomData.h>
   #include<cstdlib>
   #include<ctime>
   //初始化节点
   
   //创建一个发布者
       ros::Publisher random_pub = nh.advertise<simple_message::RandomData>("random_data",10);
   //初始化随机数生成器
       std::srand(static_cast<unsigned int>(std::time(0)));
   //设置循环频率
       ros::Rate loop_rate(1);
   while(ros::ok()){
   // 创建一个消息并设置随机数
   
   //发布消息
       
   //休眠到下一个循环
   }
   ```

   

5. 编写Subscriber节点

   在`simple_message/src`中添加`random_data_subscriber.cpp`

   ```c++
   void randomDataCallback(const simple_message::RandomData::ConstPtr&msg)//实现数据的输出
   int main(){
       //初始化节点
       
       //创建订阅者
   }
   ```

6. 修改`CMakeLists.txt`，添加可执行文件和链接库

7. 调用命令行生成可执行文件

   ```shell
   $ catkin_make
   ```

### 任务执行结果：

![](/home/sk/Tutorial_2024/workspace/Task1/image/Screenshot from 2024-11-20 10-30-27.png)

### 3.2 简单服务通信

### 任务思路

1. 创建一个服务消息类型，包含两个int64的请求数据类型， 两个int64和一个string类型的响应数据。
2. 创建一个服务端service server，接收两个数字并返回它们的和、乘积以及是否相等的结果。 
3. 创建一个客户端service client，向服务端请求两个数字并打印结果。

### 任务流程：

1. 创建一个add_service的功能包，命令行如下：

   ```shell
   $ catkin_create_pkg add_service std_msgs rospy roscpp message_generation
   $ catkin_make
   $ source /devel/setup.bash
   ```

2. 创建自定义的服务消息`AddTwoInt.srv`，内容如下：

   ```shell
   int64 a
   int64 b
   ---
   int64 sum
   int64 product
   string equal
   ```

3. 修改`CMakeLists.txt`和`package.xml`

   ```cmake
   find_package(catkin REQUIRED COMPONENTS
     message_generation
     roscpp
     rospy
     std_msgs
   )
   add_service_files(
     FILES
     AddTwoInt.srv
   )
    generate_messages(
     DEPENDENCIES
     std_msgs
   ) 
   ```

4. 创建服务端service_server

   在`add_service/src`中添加`service_server.cpp`

   ```c++
   //添加必要的头文件
   #include<ros/ros.h>
   #include<add_service/AddTwoInt.h>
   //处理计算的回调函数，负责计算加法，乘法和等于判断
   bool handle_add_two_int(add_service::AddTwoInt::Request &req,add_service::AddTwoInt::Response &res)
   //初始化服务端
   ```

5. 创建客户端service_client

   在`add_service/src`中添加`service_client.cpp`

   ```c++
   //添加必要的头文件
   #include<ros/ros.h>
   #include<add_service/AddTwoInt.h>
   //检查命令行参数变量，若是命令行错误则输出提示信息
   
   //初始化节点
   
   //创建客户端
   ```

6. 修改`CMakeLists.txt`，添加可执行文件和链接库

7. 调用命令行生成可执行文件

   ```shell
   $ catkin_make
   ```

### 任务执行结果：

![](/home/sk/Tutorial_2024/workspace/Task1/image/Screenshot from 2024-11-20 20-10-22.png)

### 任务完成情况：

**已完成：**

1. 信息发布节点产生随机数据并发布，要求使用自己创建的自定义消息类型，信息订阅节点订阅话题并将数据输出到终端。
2. 客户端向服务端发送两个数字，服务端接收这两个数字并返回它们的和、乘积、是否相等(True or False)。

**未完成：**

无

