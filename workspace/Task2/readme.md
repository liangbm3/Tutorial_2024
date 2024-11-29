# Task2

- Author： @skoyhs
- Date： 2024.11.27
- Abstract：第二周任务实现内容
- Version: 1.0.0
- Remind: 非必要文件已经忽略了，具体可见`.gitignore`文件

## 任务一：my_example_app

***注：*** 实现内容放在`my_example_app`文件夹中

### 实现思路：

首先要明白`int my_example_app_main(int argc, char *argv[])`中的 `argc` 和 `argv` 的含义：

`argc`：是终端命令行中输入参数的个数。

`argv`：是终端命令行中的参数数组。

所以我们可以通过`argv`来获得参数，从而判断程序应该执行的功能。

### 实现过程：

1. 在`examples`文件夹中创建`my_example_app`程序，添加`CMakeLists.txt`、`Kconfig`、`my_example_app`三个文件。

2. 编写程序：

   关键代码展示：

   ```c++
   //我在实现的过程中发现我的程序无法通过ctrl+c的方式终止时间输出，所以我添加了一个信号捕捉的功能，当我输入ctrl+c时，程序会接收到SIGINT的信号，然后控制running赋值为0，终止时间输出.
   void handle_signal(int sig){
   running = 0;
   }
   signal(SIGINT,handle_signal);
   
   //处理命令time 
   if (strcmp(argv[1], "time") == 0) {
           PX4_INFO("Starting time print every second...");
           time_t start_time=time(NULL);//获取程序开始执行的时间
           double seconds=0;
           while (running) {
               time_t now = time(NULL);//获取当前时间
               seconds =(float)difftime(now,start_time);//计算时间差值
               PX4_INFO("Elapsed time: %.2f seconds",seconds);
               sleep(1);  // 每秒钟打印一次时间
           }
       }
   //处理命令count
   else if (strcmp(argv[1], "count") == 0) {
           //判断指令输入是否正确
           if (argc != 4) {
               PX4_ERR("Usage: my_example_app count a b");
               return -1;
           }
   
           // 将参数a和b转换为整数
           int a = atoi(argv[2]);
           int b = atoi(argv[3]);
           int sum = a + b;
           PX4_INFO("The sum of %d and %d is: %d", a, b, sum);
       }
   ```

   3. 修改`CMakeLists.txt`和`Kconfig`

      ```cmake
      px4_add_module(
      	MODULE examples__my_example_app_
      	MAIN my_example_app
      	STACK_MAIN 2000
      	SRCS
      		my_example_app.cpp
      	DEPENDS
      	)
      ```

      ```cmake
      menuconfig EXAMPLES_MY_EXAMPLE_APP
              bool "my_example_app"
      	default n
      	---help---
      	        Enable support for my_example_app
      
      ```

      

### 程序执行结果：

![](https://raw.githubusercontent.com/skoyhs/Tutorial_2024/refs/heads/main/workspace/Task2/images/Screenshot%20from%202024-11-27%2008-36-33.png)

### 任务完成情况：

**已完成：**

1. 在控制台输入` my_example_app time` 时，控制台隔 1s打印程序启动的时间。
2. 在控制台输入` my_example_app count a b` 时，计算并打印a+b的结果。

**未完成：**

无

## 任务二：实现四旋翼无人机绕四个定点飞行

***注：*** 实现内容放在`offboard_takeoff`文件夹中

### 实现思路：

我这里采用的是offboard模式+ros功能包的实现方法。

### 实现过程：

1. 创建`offboard_control`功能包，添加`src`、`include`文件夹

2. 在`src`文件夹中添加`offboard_control.cpp`文件

   关键代码如下：

   ```c++
   //创建目标点，这里我定义的一个函数来创建目标点
   geometry_msgs::PoseStamped create_target(double x, double y, double z) {
       geometry_msgs::PoseStamped target;
       target.pose.position.x = x;
       target.pose.position.y = y;
       target.pose.position.z = z;
       target.pose.orientation.w = 1.0;  // 默认无旋转（保持水平）
       return target;
   }
   geometry_msgs::PoseStamped target1 = create_target(0, 0, 2);   // 起点
   geometry_msgs::PoseStamped target2 = create_target(50, 0, 2);   // 第二个点
   geometry_msgs::PoseStamped target3 = create_target(50, 50, 2);   // 第三个点
   geometry_msgs::PoseStamped target4 = create_target(0, 50, 2);   // 第四个点
   
   // 初始化变量，标记当前目标点
   //通过current_target来实现目标点的转移
   geometry_msgs::PoseStamped current_target = target1;
   int target_index = 0;
    
   //获取飞行器的当前位置信息
   geometry_msgs::PoseStamped current_pos;
    void pos_cb(const geometry_msgs::PoseStamped::ConstPtr& msg){
       current_pos=*msg;
    }
   
   //绕点飞行部分
   while (ros::ok()) {
   
           // 计算当前位置和目标点之间的距离
           double dx = current_pos.pose.position.x - current_target.pose.position.x;
           double dy = current_pos.pose.position.y - current_target.pose.position.y;
           double dz = current_pos.pose.position.z - current_target.pose.position.z;
           double distance = sqrt(dx * dx + dy * dy + dz * dz);
   
           // 如果接近目标点，切换到下一个目标点
           //TAGET_RADIUS是我定义的目标半径，表示接近目标的容许误差
           if (distance < TARGET_RADIUS) {
               target_index = (target_index + 1) % 4;  // 循环访问目标点
               switch (target_index) {
                   case 0: current_target = target1; break;
                   case 1: current_target = target2; break;
                   case 2: current_target = target3; break;
                   case 3: current_target = target4; break;
               }
               ROS_INFO("Moving to target %d", target_index + 1);
           }
   
           // 发布目标位置
           local_pos_pub.publish(current_target);
   
           // 持续更新
           ros::spinOnce();
           rate.sleep();
       }
   
   ```

   3. 修改`CMakeLists.txt`

      ```cmake
      add_executable(offboard_control src/offboard_control.cpp)
      target_link_libraries(offboard_control ${catkin_LIBRARIES}) 
      ```

###  仿真结果：

![](https://raw.githubusercontent.com/skoyhs/Tutorial_2024/refs/heads/main/workspace/Task2/images/Screenshot%20from%202024-11-27%2016-51-25.png)

### 任务完成情况：

**已完成：**

实现四旋翼无人机绕四个定点飞行

**未完成：**

无

## 附加任务：解决仿真中四旋翼朝向问题

***注：*** 实现内容放在`offboard_takeoff_quaternion`文件夹中

### 实现思路：

作者在写报告的时候还没有完全明白四元数与欧拉角，但是由于这个任务中，我们只需要在二维平面绕z轴进行旋转，所以俯仰和滚转我们不用考虑，只需要考虑偏航即可。

### 实现过程：

在上述代码中添加：

```c++
// 计算目标位置与当前位置之间的朝向，返回四元数
geometry_msgs::Quaternion calculate_orientation(double x, double y) {
    // atan2 是一个数学函数，它根据点 (x, y) 计算出其相对于原点的角度，这里是围绕Z轴的旋转
    double yaw = atan2(y, x);  
    //创建一个四元数对象
    tf::Quaternion quat;
    ////setRPY()是一个欧拉角旋转函数，他采用固定轴的旋转方式，先绕定轴x旋转（横滚），然后再绕定轴y（俯仰），最后绕定轴z（偏航），这里是围绕z轴的旋转，所以x,y轴都置为0即可
    quat.setRPY(0, 0, yaw);
    //将四元数转换为geometry_msgs的格式
    geometry_msgs::Quaternion orientation_msg;
    tf::quaternionTFToMsg(quat, orientation_msg);
    return orientation_msg;
}

  // 计算目标点的朝向（绕Z轴）
  //将目标点的x,y轴与当前所在位置的x,y轴进行朝向的计算
  geometry_msgs::Quaternion target_orientation = calculate_orientation(current_target.pose.position.x -      current_pos.pose.position.x, current_target.pose.position.y - current_pos.pose.position.y);
 
  // 设置目标的姿态（目标位置 + 朝向）
  current_target.pose.orientation = target_orientation;
```

### 仿真结果：

![](https://raw.githubusercontent.com/skoyhs/Tutorial_2024/refs/heads/main/workspace/Task2/images/Screenshot%20from%202024-11-27%2015-42-08.png)

![](https://raw.githubusercontent.com/skoyhs/Tutorial_2024/refs/heads/main/workspace/Task2/images/Screenshot%20from%202024-11-27%2015-42-08.png)

### 任务完成情况：

**已完成：**

解决仿真中四旋翼朝向问题

**未完成：**

作者能力有限，光研究朝向问题就花了太多时间，头发都掉了一点（还是数学基础差了一点），所以其他方式实现就没有研究了(可能后面有时间会思考一下，先提交作业要紧)

