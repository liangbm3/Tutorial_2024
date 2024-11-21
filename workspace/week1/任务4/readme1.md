# 第一周考核任务

## 任务一（已完成）
![alt text](<2024-11-19 21-22-35 的屏幕截图.png>)
***我选择使用递归法完成任务***
##### A.运行方法
vscode中打开cpp文件后，ctrl+shift+b用g++编译后运行程序，输入n值后即可输出f(n)
*[运行无异常请忽略（）
   如果输出结果后出现路径显示（【1】+Done...），调试运行界面选自定义调试配置-g++，在生成`launch.json`中的`configurations`字段添加“`"miDebuggerArgs": "-q -ex quit; wait() { fg >/dev/null; }; /bin/gdb -q --interpreter=mi",`
“，且`program`一行为“`"program": "${fileDirname}/${fileBasenameNoExtension}",`“，方可正常显示]*
##### B.任务内容
1. 首先定义函数f，输入参数为n，并规定前两项对应f数值，以便之后利用递推关系得出后续项。
2. 用if语句判断n值并执行相应范围内的运算
3. 定义主函数，用"`std::cout<<`"提示输入n值,用"`std::cin>>`"调用n，并用"`std::cout<<`"输出f计算结果

## 任务二（已完成）
![alt text](<2024-11-19 21-57-43 的屏幕截图.png>)

##### A.运行方法
cd到任务2文件夹，用"`./book.sh`"等命令运行脚本
##### B.任务内容
1. 编写`#!/bin/bash`，以在终端中运行脚本
2. 通过检查参数数量来识别"`./book.sh`"指令，并输出"book.txt"文件中书目内容
3. 提取输入选项及参数，分辨并进行不同操作
   1. 添加书目相关`-a)`
      1. 用`if`语句，`grep`命令判断输入书号是否已存在，不存在则用$调用变量，用`>>`定位文件以添加相应书目，反之则输出已存在书目信息
   2. 删除书目相关`-r)`
      1. 同`if`语句，若存在，用变量`confirm`储存响应的`y/n`并判断执行与否，同时输出提示文字，若不存在则输出提示
   3. 搜索书目相关`-l)`
      1. 同`if`语句，若存在，则输出书目信息，反之则输出不存在提示
   4. 错误提示相关
      1. 若以上全非，则提示输入信息错误，并输出正确输入格式

## 任务三（已完成）

### Publisher与Subscriber（已完成）
![alt text](<2024-11-19 21-28-42 的屏幕截图.png>)

##### A.运行方法
1. vscode中ctrl+shift+b用cmake编译，
2. 打开三个终端，一个运行`roscore`，其余两个终端`cd Tutorial_2024/workspace/week1/任务3/catkin_ws/`后运行`rosrun ssr_pkg chao_node`和`rosrun ssr_pkg ma_node`*（若找不到文件，在终端中`source ~/Tutorial_2024/workspace/week1/任务3/catkin_ws/devel/setup.bash`，根据具体文件位置调整awa）*
##### B.任务内容
1. 完成创建ros工作空间，配置相应环境变量等操作（设置文件创建等），以确保后继操作顺利完成
2. 在`catkin_ws/src/`中创建`ssr_pkg`，在此目录下创建`src`，`msg`文件夹，分别用于存放源文件，消息文件
3. 编写任务文件
   1. 自定义消息类型文件
      1. 命名文件为`Carry.msg`
      2. 编写消息文件内容，设置了三个固定消息，一个随机数值
   2. Publisher（发布者）源文件
      1. 命名文件为`chao_node.cpp`，并添加相应头文件（ros与消息包头文件）
      2. 编写源文件内容，创建句柄，初始化节点，设置话题名称以链接订阅者节点，并设置循环发布消息
   3. Subscriber（订阅者）源文件
      1. 命名文件为`ma_node.cpp`，并添加相应头文件（ros与消息包头文件）
      2. 编写源文件内容，定义回调函数，设置打印消息内容，初始化节点，设置循环回调，订阅主题链接发布者节点，并用“`ros::spinOnce()`“函数防止回调函数被阻塞（订阅者文件中采用两种信息格式单纯为了颜色不同有辨别度）
   4. CMakeLists.txt文件
      1.  在“`find_package()`”函数中添加“`message_generation`“（保证cmake正确查找组件）
      2.  取消“`add_message_file`“注释，并添加需要应用的自定义消息文件“`Carry.msg`”
      3.  在文件最后声明需要编译的节点文件，添加目标依赖以便正确编译
   5. package.xml文件
      1. 在`<exec_depend>`与`<build_depend>`中添加相应依赖
4. 用cmake编译工作空间，并运行测试
### Client与Server（已完成）
![alt text](<2024-11-21 12-50-45 的屏幕截图-1.png>)

##### A.运行方法
1. vscode中ctrl+shift+b用cmake编译，
2. 打开三个终端，一个运行`roscore`，其余两个终端`cd Tutorial_2024/workspace/week1/任务3/catkin_workspace/`后运行`rosrun simple_service_communication service.server`和`rosrun simple_service_communication service.client`*（若找不到文件，在终端中`source ~/Tutorial_2024/workspace/week1/任务3/catkin_workspace/devel/setup.bash`，根据具体文件位置调整awa）*
##### B.任务内容
1. 同上，完成创建ros工作空间等前置操作
2. 在`catkin_workspace/src`中创建`simple_service_communication`,在此目录下创建`srv`文件夹，用于存放服务文件
3. 编写任务文件
   1. 自定义服务文件
      1. 命名文件为`Service.srv`
      2. 编写服务文件内容，接收两个数值，用“`---`”隔开，输出和、积、相等与否
   2. Client（客户端）源文件
      1. 命名文件为`service.client.cpp`，并添加相应头文件（ros与服务文件头文件）
      2. 编写源文件内容，初始化节点，创建服务句柄，再通过句柄创建客户端与服务数据对象，再通过“`if (client.call(srv)) {`“判断服务是否调用成功，并输出相应结果与提示
   3. Server（服务端）源文件
      1. 命名文件为`service.server.cpp`，并添加相应头文件（ros与服务文件头文件）
      2. 编写源文件内容，定义回调函数，设置打印服务数据对象，初始化节点，通过句柄链接客户端，设置循环回调，并处理接收到的服务请求，输出结果
   4. CMakeLists.txt文件
      1. 在“`find_package()`”函数中添加“`message_generation`“
      2. 取消“`add_service_files`“注释，并添加需要应用的自定义服务文件“`Service.srv`”
      3. 在文件最后声明需要编译的节点文件，添加目标依赖以便正确编译
   5. package.xml文件
      1. 在`<exec_depend>`与`<build_depend>`中添加相应依赖
4. 用cmake编译工作空间，并运行测试