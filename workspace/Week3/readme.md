# 第三周任务说明

---
- Author: 郑思扬
- Reviced: 郑思扬
- Date: 2024-12-3
- Version: 1.0.0
- Abstract: 空队第三周任务说明

---
## 任务一
### 识别拍摄手势
#### 任务内容说明
> - Functions:   
>   &emsp;利用给出的权重对五种手势的图片进行推理
> - Depend Libraries:  
>   &emsp;依赖 - yolov5  
>   &emsp;依赖 - detect.py
#### 运行过程
&emsp;打开 **anaconda的虚拟环境**  
&emsp;cd到python解释器所在的文件夹,我的是
```
D:
cd D:\UserDFile\Pycharm\pytorch_dl
```
&emsp;然后激活 **python环境**
```
conda activate D:\UserDFile\Pycharm\pytorch_dl
```
&emsp;然后cd到包含[待处理图片](./Week3Task1/)的文件夹，例如
```
cd D:\UserDFile\GithubFileClone\Tutorial_2024\workspace\Week3\Week3Task1
```
&emsp;运行指令
```
python D:/UserDFile/Pycharm/pytorch_dl/yolov5/yolov5/detect.py --weights D:/UserDFile/GithubFileClone/Tutorial_2024/tasks/week3/视觉组/source/exp6/weights/best.pt --img 640 --conf 0.25 --source D:/UserDFile/GithubFileClone/Tutorial_2024/workspace/Week3/Week3Task1/test photo
```
&emsp;其中路径需要替换成实际路径
&emsp;然后按照提示的路径即可找到[识别结果](./Week3Task1/result%20photo/)
### 摄像头实时预测
#### 任务内容说明
> - Functions:   
>   &emsp;利用使用电脑摄像头实时进行手势预测
> - Depend Libraries:  
>   &emsp;依赖 - yolov5  
>   &emsp;依赖 - detect.py
#### 运行过程
&emsp;打开 **anaconda的虚拟环境**  
&emsp;cd到python解释器所在的文件夹,我的是
```
D:
cd D:\UserDFile\Pycharm\pytorch_dl
```
&emsp;然后激活 **python环境**
```
conda activate D:\UserDFile\Pycharm\pytorch_dl
```
&emsp;运行指令
```
python D:/UserDFile/Pycharm/pytorch_dl/yolov5/yolov5/detect.py --weights D:/UserDFile/GithubFileClone/Tutorial_2024/tasks/week3/视觉组/source/exp6/weights/best.pt --source 0
```
&emsp;[运行结果截图](./Week3Task1/print%20screen/)

---
## 任务二
#### 任务内容说明
> - Functions:   
>   &emsp;利用数据集训练一个手势识别模型
> - Depend Libraries:  
>   &emsp;依赖 - yolov5  
>   &emsp;依赖 - train.py
#### 运行过程
&emsp;将提供的 **dataset文件夹** 复制到yolov5的根目录下  
&emsp;打开 **anaconda的虚拟环境**  
&emsp;cd到python解释器所在的文件夹,我的是
```
D:
cd D:\UserDFile\Pycharm\pytorch_dl
```
&emsp;然后激活 **python环境**
```
conda activate D:\UserDFile\Pycharm\pytorch_dl
```
&emsp;然后cd 到 dataset文件夹下
```
cd  D:\UserDFile\Pycharm\pytorch_dl\yolov5\yolov5\dataset
```
&emsp;然后需要对数据集的数据进行处理，利用**process_data.py**将数据集打乱和分割成训练集、验证集和测试集。
```
python process_data.py
```
&emsp;在dataset文件夹下会生成以下文件/文件夹：
+ `test`
+ `train`
+ `val`
+ `train.txt`
+ `val.txt`
+ `test.txt`
![生成](./Week3Task2/process_data结果.jpg)
&emsp;然后返回到 **yolov5** 文件夹下，用数据集训练一个权重
```
 D:/UserDFile/Pycharm/pytorch_dl/yolov5/yolov5/train.py --data D:/UserDFile/Pycharm/pytorch_dl/yolov5/yolov5/dataset/config.yaml --epochs 50 --batch-size 16
```
&emsp;经过漫长的等待，训练完成
![训练结果](./Week3Task2/train.py运行结果.png)
&emsp;按照提示路径可以看到[训练结果和得到的权重](./Week3Task2/exp4/)
&emsp;然后利用训练得到的权重按任务一中步骤进行手势识别即可
