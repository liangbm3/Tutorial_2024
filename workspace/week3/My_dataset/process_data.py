import os
import random
import shutil
from sklearn.model_selection import train_test_split

def create_directory(directory):
    """创建目录，如果目录不存在的话"""
    if not os.path.exists(directory):
        os.makedirs(directory)

def shuffle_and_split_data(image_dir, label_dir, output_image_dir, output_label_dir,
                            val_image_dir, val_label_dir, test_image_dir, test_label_dir,
                            train_txt_path, val_txt_path, test_txt_path, val_size=0.2, test_size=0.1):
    # 获取所有图片和对应标签的路径
    images = [f for f in os.listdir(image_dir) if f.endswith('.jpg') or f.endswith('.png')]
    images = sorted(images)  # 排序以确保一致性
    
    # 过滤掉没有标签的图片
    valid_images = []
    valid_labels = []
    
    for img in images:
        lbl = img.replace('.jpg', '.txt').replace('.png', '.txt')
        if os.path.exists(os.path.join(label_dir, lbl)):  # 如果标签文件存在
            valid_images.append(img)
            valid_labels.append(lbl)
    
    # 使用 train_test_split 分割数据集，首先分割出验证集和剩余数据（训练集 + 测试集）
    train_val_images, test_images, train_val_labels, test_labels = train_test_split(valid_images, valid_labels, test_size=test_size, random_state=42)
    
    # 然后从剩余的训练集和验证集数据中，分割出验证集
    train_images, val_images, train_labels, val_labels = train_test_split(train_val_images, train_val_labels, test_size=val_size, random_state=42)
    
    # 创建必要的目录
    create_directory(output_image_dir)
    create_directory(output_label_dir)
    create_directory(val_image_dir)
    create_directory(val_label_dir)
    create_directory(test_image_dir)
    create_directory(test_label_dir)

    # 复制文件到对应目录
    def copy_files(image_list, label_list, image_target_dir, label_target_dir):
        for img, lbl in zip(image_list, label_list):
            shutil.copy(os.path.join(image_dir, img), os.path.join(image_target_dir, img))
            shutil.copy(os.path.join(label_dir, lbl), os.path.join(label_target_dir, lbl))
    
    copy_files(train_images, train_labels, output_image_dir, output_label_dir)
    copy_files(val_images, val_labels, val_image_dir, val_label_dir)
    copy_files(test_images, test_labels, test_image_dir, test_label_dir)
    
    # 写入 .txt 文件，记录每张图片的路径
    def write_paths_to_txt(image_list, txt_file_path):
        with open(txt_file_path, 'w') as f:
            for img in image_list:
                f.write(f"{os.path.join(image_dir, img)}\n")
    
    write_paths_to_txt(train_images, train_txt_path)
    write_paths_to_txt(val_images, val_txt_path)
    write_paths_to_txt(test_images, test_txt_path)

    print(f"Data split completed. Train: {len(train_images)} | Validation: {len(val_images)} | Test: {len(test_images)}")

# 使用示例：
image_dir = "./images"  # 图像文件夹
label_dir = "./labels"  # 标签文件夹
output_image_dir = "./train/images"  # 训练集图像
output_label_dir = "./train/labels"  # 训练集标签
val_image_dir = "./val/images"  # 验证集图像
val_label_dir = "./val/labels"  # 验证集标签
test_image_dir = "./test/images"  # 测试集图像
test_label_dir = "./test/labels"  # 测试集标签
train_txt_path = "./train.txt"  # 训练集路径列表
val_txt_path = "./val.txt"  # 验证集路径列表
test_txt_path = "./test.txt"  # 测试集路径列表

# 调用函数进行数据集拆分
shuffle_and_split_data(image_dir, label_dir, output_image_dir, output_label_dir,
                       val_image_dir, val_label_dir, test_image_dir, test_label_dir,
                       train_txt_path, val_txt_path, test_txt_path, val_size=0.2, test_size=0.1)
