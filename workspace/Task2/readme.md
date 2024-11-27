# Task2

- Author： @skoyhs
- Date： 2024.11.27
- Abstract：第二周任务实现内容
- Version: 1.0.0
- Remind: 非必要文件已经忽略了，具体可见`.gitignore`文件

## 任务一：my_example_app

***注：*** 实现内容放在`my_example_app`文件夹中

### 实现思路：

首先要明白`int my_example_app_main(int argc, char *argv[])`中的 `argc` 和 `argv` 的含义：

`argc`：是终端命令行中输入参数的个数。

`argv`：是终端命令行中的参数数组。

所以我们可以通过`argv`来获得参数，从而判断程序应该执行的功能。

### 实现过程：

1. 在`examples`文件夹中创建`my_example_app`程序，添加`CMakeLists.txt`、`Kconfig`、`my_example_app`三个文件。

2. 编写程序：

   关键代码展示：

   ```c++
   //我在实现的过程中发现我的程序无法通过ctrl+c的方式终止时间输出，所以我添加了一个信号捕捉的功能，当我输入ctrl+c时，程序会接收到SIGINT的信号，然后控制running赋值为0，终止时间输出.
   void handle_signal(int sig){
   running = 0;
   }
   signal(SIGINT,handle_signal);
   
   //处理命令time 
   if (strcmp(argv[1], "time") == 0) {
           PX4_INFO("Starting time print every second...");
           time_t start_time=time(NULL);//获取程序开始执行的时间
           double seconds=0;
           while (running) {
               time_t now = time(NULL);//获取当前时间
               seconds =(float)difftime(now,start_time);//计算时间差值
               PX4_INFO("Elapsed time: %.2f seconds",seconds);
               sleep(1);  // 每秒钟打印一次时间
           }
       }
   //处理命令count
   else if (strcmp(argv[1], "count") == 0) {
           //判断指令输入是否正确
           if (argc != 4) {
               PX4_ERR("Usage: my_example_app count a b");
               return -1;
           }
   
           // 将参数a和b转换为整数
           int a = atoi(argv[2]);
           int b = atoi(argv[3]);
           int sum = a + b;
           PX4_INFO("The sum of %d and %d is: %d", a, b, sum);
       }
   ```

   3. 修改`CMakeLists.txt`和`Kconfig`

      ```cmake
      px4_add_module(
      	MODULE examples__my_example_app_
      	MAIN my_example_app
      	STACK_MAIN 2000
      	SRCS
      		my_example_app.cpp
      	DEPENDS
      	)
      ```

      ```cmake
      menuconfig EXAMPLES_MY_EXAMPLE_APP
              bool "my_example_app"
      	default n
      	---help---
      	        Enable support for my_example_app
      
      ```

      

### 程序执行结果：

