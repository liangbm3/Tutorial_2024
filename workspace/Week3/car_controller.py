#!/usr/bin/env python

import rospy
from std_msgs.msg import String
from geometry_msgs.msg import Twist

def control_car(command):
    """
    根据手势命令控制小车的回调函数。

    参数：
        command (String): 检测到并发布的手势命令。
    """
    twist = Twist()  # 创建一个 Twist 消息实例，用于发布速度指令
    if command.data == "forward":  # 如果手势命令是“forward”
        twist.linear.x = 1.0  # 设置线速度为正值，小车前进
    elif command.data == "backward":  # 如果手势命令是“backward”
        twist.linear.x = -1.0  # 设置线速度为负值，小车后退
    elif command.data == "left":  # 如果手势命令是“left”
        twist.angular.z = 1.0  # 设置角速度为正值，小车左转
    elif command.data == "right":  # 如果手势命令是“right”
        twist.angular.z = -1.0  # 设置角速度为负值，小车右转
    else:  # 其他命令或无效命令
        twist.linear.x = 0.0  # 停止线速度
        twist.angular.z = 0.0  # 停止角速度

    rospy.loginfo(f"Car action: {command.data}")  # 在日志中打印当前动作
    cmd_vel_pub.publish(twist)  # 发布 Twist 消息给小车


if __name__ == "__main__":
    rospy.init_node('car_controller', anonymous=True)  # 初始化 ROS 节点
    cmd_vel_pub = rospy.Publisher('/cmd_vel', Twist, queue_size=10)  # 创建发布者发布到 /cmd_vel 话题
    rospy.Subscriber('gesture_topic', String, control_car)  # 订阅 'gesture_topic' 话题
    rospy.spin()  # 保持节点运行，等待回调
