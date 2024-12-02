# Task3

- Author： @skoyhs
- Date： 2024.12.2
- Abstract：第三周任务实现内容
- Version: 1.0.0
- Remind: 非必要文件已经忽略了，具体可见`.gitignore`文件

## 任务：实现仿真多无人机飞行

***注：*** 实现内容放在`multi_offboard_takeoff`文件夹中

### 实现思路：

多无人机飞行，这里肯定采用`roslaunch`方式来启动，然后无人机控制模式选择`offboard`模式，需要做的就是编写一个ros功能包实现对无人机的控制。我这里实现的是三架无人机以四边形轨迹飞行。

### 实现过程：

1. 在工作区的`src`目录下，创建一个`multi_offboard_takeoff`的功能包：

   ```bash
   catkin_create_pkg multi_offboard_takeoff rospy roscpp mavros
   ```

2. 在功能包的`src`目录下，创建一个`multi_offboard_takeoff.cpp`文件：

   **关键代码：**整体的代码思路还是和上周任务基本一样，通过订阅无人机位置信息判断是否到达目标点，到达后再更改下一个目标点并发布信息，控制无人机的飞行轨迹。

   ```c++
   //这里我实现了三个回调函数，保证能够订阅到三个无人机的位置信息
   geometry_msgs::PoseStamped current_pos_0;
    void pos_cb_0(const geometry_msgs::PoseStamped::ConstPtr& msg){
       current_pos_0=*msg;
    }
    geometry_msgs::PoseStamped current_pos_1;
    void pos_cb_1(const geometry_msgs::PoseStamped::ConstPtr& msg){
       current_pos_1=*msg;
    }
    geometry_msgs::PoseStamped current_pos_2;
    void pos_cb_2(const geometry_msgs::PoseStamped::ConstPtr& msg){
       current_pos_2=*msg;
    }
   
   //
   ```

   

