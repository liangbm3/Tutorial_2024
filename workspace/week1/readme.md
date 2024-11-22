# week1

## task1. 斐波那契数列

使用了动态规划的思想来减少复杂度

- **效果展示**
>[task1](./task1.png)


## task2. Linux Shell

先实现了各个功能的函数，再用if控制主程序分支实现了要求

- **效果展示**
>[task1](./task1.png)



## task3. Linux Shell

安装了ros并运行海龟功能包

- **效果展示**
>[task3](./ros.png)

tips:已在主文件夹的.bashrc中添加source /home/fanfanfufuh/catkin_ws/devel/setup.bash
### task3.1. 简单话题通信和自定义消息

创建了信息类型data，发布节点在循环中发布0-1000的数字，订阅节点接收并输出数字

依次输入roscore -> rosrun learning_topic data_subscriber ->rosrun learning_topic data_publisher使用

- **效果展示**
>[task3.1](./task3.1.png)


### task3.2. 简单服务通信

创建了信息类型包含num1,num2,客户端发送至服务端并收到结果计算完成的信息并打印，服务端计算并打印数字和返回完成计算的信息

依次输入roscore -> rosrun learning_service datacal_server->rosrun learning_service datacal_client 使用


- **效果展示**
>[task3.2](./task3.2.png)




