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
   
   //初始化各个无人机，三架无人机操作相同，这里以uav0为例演示
   //订阅无人机位姿信息
    ros::NodeHandle nh0;
    ros::Subscriber pos_sub0 =  nh0.subscribe("uav0/mavros/local_position/pose", 10, pos_cb_0);
   //发布无人机位姿信息
    ros::Publisher local_pos_pub0 = nh0.advertise<geometry_msgs::PoseStamped>("uav0/mavros/setpoint_position/local", 10);
   //定义起飞服务客户端
    ros::ServiceClient arming_client0 = nh0.serviceClient<mavros_msgs::CommandBool>("uav0/mavros/cmd/arming");
   //定义设置模式服务客户端
    ros::ServiceClient set_mode_client0 = nh0.serviceClient<mavros_msgs::SetMode>("uav0/mavros/set_mode");
   
   //设置四个轨迹点，这里要根据multi_uav_mavros_sitl.launch的初始位置设置，当然也可以修改launch文件，自己设置
   // 创建目标点
       geometry_msgs::PoseStamped target1_0 = create_target(0, 0, 2);   // 起点
       geometry_msgs::PoseStamped target2_0 = create_target(50, 0, 2);   // 第二个点
       geometry_msgs::PoseStamped target3_0 = create_target(50, 50, 2);   // 第三个点
       geometry_msgs::PoseStamped target4_0 = create_target(0, 50, 2);   // 第四个点
   // 初始化变量，标记当前目标点
       geometry_msgs::PoseStamped current_target_0 = target1_0;
   
   //轨迹路线控制 
   // 计算当前位置和目标点之间的距离
           double dx_0 = current_pos_0.pose.position.x - current_target_0.pose.position.x;
           double dy_0 = current_pos_0.pose.position.y - current_target_0.pose.position.y;
           double dz_0 = current_pos_0.pose.position.z - current_target_0.pose.position.z;
           double distance_0 = sqrt(dx_0 * dx_0 + dy_0 * dy_0 + dz_0 * dz_0);
   // 如果接近目标点，切换到下一个目标点，这里设置了一个TARGET_RADIUS半径，用来判断无人机是否接近目标点
           if (distance_0 < TARGET_RADIUS&&distance_1 < TARGET_RADIUS&&distance_2 < TARGET_RADIUS) {
               target_index = (target_index + 1) % 4;  // 循环访问目标点
               switch (target_index) {
                   case 0: current_target_0 = target1_0; current_target_1 = target1_1;current_target_2 = target1_2;break;
                   case 1: current_target_0 = target2_0;  current_target_1 = target2_1; current_target_2 = target2_2;break;
                   case 2: current_target_0 = target3_0;current_target_1 = target3_1;current_target_2 = target3_2; break;
                   case 3: current_target_0 = target4_0;current_target_1 = target4_1;current_target_2 = target4_2; break;
               }
               ROS_INFO("Moving to target %d", target_index + 1);
           }
   //要持续发送的无人机的目标位置
      local_pos_pub0.publish(current_target_0);
      local_pos_pub1.publish(current_target_1);
      local_pos_pub2.publish(current_target_2);
   ```
   
   3. 配置`CMakeLists.txt`文件
   
      ```cmake
      add_executable(multi_offboard_takeoff src/multi_offboard_takeoff.cpp)
      target_link_libraries(multi_offboard_takeoff ${catkin_LIBRARIES})
      ```
   
   4. 编译工作区，设置环境变量
   
      ```bash
      catkin_make
      source devel/setup.bash
      ```
   
   5. 启动多无人机仿真环境
   
      ```bash
      roslaunch px4 multi_uav_mavros_sitl.launch
      ```
   
   6. 运行功能包
   
      ```bash
      rosrun multi_offboard_takeoff multi_offboard_takeoff
      ```

### 仿真结果：

