#!/usr/bin/env python

import rospy
import cv2
from sensor_msgs.msg import Image
from cv_bridge import CvBridge
import sys

def main():
    # 初始化 ROS 节点
    rospy.init_node('opencv_camera_publisher', anonymous=True)

    # 设置发布话题
    image_pub = rospy.Publisher('/camera/image_raw', Image, queue_size=10)

    # 创建 CvBridge 对象
    bridge = CvBridge()

    # 打开摄像头
    cap = cv2.VideoCapture(0)  # 0 表示默认摄像头

    if not cap.isOpened():
        print("Error: Could not open video stream.")
        sys.exit()

    rate = rospy.Rate(10)  # 设置发布频率 10Hz

    while not rospy.is_shutdown():
        # 从摄像头读取图像
        ret, frame = cap.read()

        if not ret:
            print("Error: Failed to capture image.")
            break

        # 将 OpenCV 图像转换为 ROS 图像消息
        try:
            ros_image = bridge.cv2_to_imgmsg(frame, "bgr8")
        except Exception as e:
            print(e)
            continue

        # 发布图像消息
        image_pub.publish(ros_image)

        # 显示图像
        cv2.imshow("Camera", frame)

        # 按下 'q' 键退出
        if cv2.waitKey(1) & 0xFF == ord('q'):
            break

        rate.sleep()

    # 释放摄像头并关闭所有窗口
    cap.release()
    cv2.destroyAllWindows()

if __name__ == '__main__':
    main()
