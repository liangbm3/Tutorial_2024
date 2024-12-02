# 该文件是一个简单的图像采集程序，用于采集图像数据集。
import cv2
import os

def create_dataset_directory(directory):
    """
    创建数据集存储文件夹
    """
    if not os.path.exists(directory):
        os.makedirs(directory)
        print(f"目录 {directory} 创建成功！")
    else:
        print(f"目录 {directory} 已存在。")

def capture_images(output_dir, prefix="image", start_index=0):
    """
    采集图像数据集
    :param output_dir: 保存图像的文件夹路径
    :param prefix: 保存文件的前缀名
    :param start_index: 文件命名起始编号
    """
    create_dataset_directory(output_dir)
    
    cap = cv2.VideoCapture(0)  # 0 表示使用默认摄像头
    if not cap.isOpened():
        print("无法打开摄像头。请检查设备连接！")
        return

    print("按 's' 保存图像，按 'q' 退出程序。")
    
    current_index = start_index
    while True:
        ret, frame = cap.read()
        if not ret:
            print("无法从摄像头读取图像！")
            break

        # 显示实时画面
        cv2.imshow("Camera - Press 's' to save, 'q' to quit", frame)

        # 检测键盘输入
        key = cv2.waitKey(1)
        if key == ord('s'):  # 按 's' 保存图像
            filename = f"{prefix}_{current_index:04d}.jpg"
            filepath = os.path.join(output_dir, filename)
            cv2.imwrite(filepath, frame)
            print(f"图像 {filename} 已保存。")
            current_index += 1
        elif key == ord('q'):  # 按 'q' 退出程序
            print("退出采集程序。")
            break

    # 释放摄像头资源
    cap.release()
    cv2.destroyAllWindows()

if __name__ == "__main__":
    output_folder = "dataset/images"  # 保存数据集的文件夹
    file_prefix = "sample"    # 文件名前缀
    starting_index = 0        # 起始编号

    capture_images(output_folder, file_prefix, starting_index)
