# 第二周考核任务-飞控组

## 任务一（已完成）

##### A.运行方法
按照考核要求中写启动px4后输入相关指令
##### B.任务内容
1. 先用if指令中`argc == 2 && strcmp(argv[1], "time"`与`argc == 4 && strcmp(argv[1], "count"`判断输入的参数是否正确，并选择执行
2. 循环打印输出时间，用`long seconds = current_time.tv_sec - start_time.tv_sec;`后再调整精确，再用`PX4_INFO("Elapsed time: %ld.%09ld seconds", seconds, nanoseconds);`打印结果，用`sleep(1);`间隔一秒打印
3. 打印输出计数，用`int a = atoi(argv[2]);`等转化输入并计算，而后用`PX4_INFO("Count: %d", count);`打印结果
4. 以上皆非，用`PX4_INFO("Invalid command. Usage: my_example_app time or my_example_app count a b");`提示输入错误
## 任务二（未完成）

##### A.运行方法
`cd cd ~/任务2/src`，编译，设置环境变量，在不同终端中分别运行`roslaunch px4_gazebo.launch``roslaunch mavros.launch`再运行`rosrun your_project_directory main`
*【仅限理论，实际上我由于MAVROS与px4之间的通信问题无法解决而无法完成】（网上有很多相同报错，我多方查找试了三天，拼尽全力无法战胜，遂放弃，QAQ）*
##### B.任务内容
1. 使用有限状态机 + PX4的OFFBOARD模式 +MAVROS
2. 设置全局变量，创建句柄，发布目标位置等，后用`ros::ServiceClient arming_client`和`ros::ServiceClient set_mode_client`创建服务客户端，分别用于解锁无人机和设置飞行模式。
3. `send_target_pose(const geometry_msgs::Point& target)`将点位置转化为带时间戳的姿态信息并发布到话题，`arm_and_set_offboard()``takeoff()``land()`模式解锁，起飞降落函数
4. 主函数初始化节点，订阅话题，通过`local_pos_pub`发布器进行ros通信，进而控制无人机与四个目标点的相对位置
5. 在`CMakeLists.txt`与`package.xml`中添加相关依赖等完成配置操作