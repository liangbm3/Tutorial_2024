#include <px4_platform_common/px4_config.h>
#include <px4_platform_common/tasks.h>
#include <px4_platform_common/param.h>
#include <px4_platform_common/log.h>
#include <unistd.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <time.h>
#include<signal.h>

extern "C"  __EXPORT int my_example_app_main(int argc, char *argv[]);
volatile int running = 1;
void handle_signal(int sig) {
    running = 0;  // 当接收到信号时，停止计时
}
int my_example_app_main(int argc, char *argv[])
{
    if (argc < 2) {
        PX4_ERR("Usage: my_example_app <time|count a b>");
        return -1;
    }
    signal(SIGINT,handle_signal);
    // 处理 "my_example_app time" 命令
    if (strcmp(argv[1], "time") == 0) {
        PX4_INFO("Starting time print every second...");
        time_t start_time=time(NULL);
        double seconds=0;
        while (running) {
            time_t now = time(NULL);
            seconds =(float)difftime(now,start_time);
            PX4_INFO("Elapsed time: %.2f seconds",seconds);
            sleep(1);  // 每秒钟打印一次时间
        }
    }
    // 处理 "my_example_app count a b" 命令
    else if (strcmp(argv[1], "count") == 0) {
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
    else {
        PX4_ERR("Unknown command: %s", argv[1]);
        return -1;
    }

    return 0;
}
