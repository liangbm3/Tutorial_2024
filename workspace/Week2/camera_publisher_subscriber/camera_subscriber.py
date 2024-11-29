#!/usr/bin/env python

import rospy
import cv2
from sensor_msgs.msg import Image
from cv_bridge import CvBridge

# 全局变量，用于存储CvBridge实例
bridge = CvBridge()

def image_callback(msg):
    try:
        # 将ROS图像消息转换为OpenCV图像
        cv_image = bridge.imgmsg_to_cv2(msg, desired_encoding='bgr8')
    except CvBridgeError as e:
        print(e)
        return

    # 将BGR图像转换为灰度图像
    gray_image = cv2.cvtColor(cv_image, cv2.COLOR_BGR2GRAY)

    # 显示灰度图像
    cv2.imshow("Gray Image", gray_image)
    cv2.waitKey(1)  # 等待1毫秒，以便屏幕更新

    # 当按下'q'键时，退出显示
    if cv2.waitKey(1) & 0xFF == ord('q'):
        cv2.destroyAllWindows()

def main():
    # 初始化ROS节点
    rospy.init_node('opencv_image_listener', anonymous=True)
    
    # 订阅图像话题
    rospy.Subscriber("/camera/image_raw", Image, image_callback)
    
    # 保持Python脚本运行，直到被终止
    rospy.spin()

if __name__ == '__main__':
    main()