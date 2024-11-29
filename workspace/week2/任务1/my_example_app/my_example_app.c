/****************************************************************************
 *
 *   Copyright (c) 2012-2022 PX4 Development Team. All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in
 *    the documentation and/or other materials provided with the
 *    distribution.
 * 3. Neither the name PX4 nor the names of its contributors may be
 *    used to endorse or promote products derived from this software
 *    without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
 * COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 * BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
 * OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
 * AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
 * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
 * ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
 * POSSIBILITY OF SUCH DAMAGE.
 *
 ****************************************************************************/
/**
 * @file px4_simple_app.c
 * Minimal application example for PX4 autopilot
 *
 * @author Example User <mail@example.com>
 */
#include <px4_platform_common/log.h>
#include <stdio.h>
#include <time.h>
#include <string.h>


__EXPORT int my_example_app_main(int argc, char *argv[]);

int my_example_app_main(int argc, char *argv[])
{
    //判读输入参数，并选择执行报时和计算a+b
    if (argc == 2 && strcmp(argv[1], "time") == 0) {
        // 使用clock_gettime(CLOCK_REALTIME, &start_time)获取程序启动时间
        struct timespec start_time, current_time;
        clock_gettime(CLOCK_REALTIME, &start_time);

        // 循环打印距离程序启动的时间
        while (1) {
            clock_gettime(CLOCK_REALTIME, &current_time);

            // 计算时间差（秒）
        long seconds = current_time.tv_sec - start_time.tv_sec;
        // 计算时间差（纳秒部分）
        long nanoseconds = current_time.tv_nsec - start_time.tv_nsec;
        // 调整负数纳秒部分
        if (nanoseconds < 0) {
         seconds--;
         nanoseconds += 1000000000;
}

        // 打印距离程序启动的时间
        PX4_INFO("Elapsed time: %ld.%09ld seconds", seconds, nanoseconds);

            // 等待一秒
            sleep(1);
        }
    } else if (argc == 4 && strcmp(argv[1], "count") == 0) {
        // 将输入的字符转换为整数并计算a + b
        int a = atoi(argv[2]);
        int b = atoi(argv[3]);

        int result = a + b;

        PX4_INFO("The sum of a and b is %d", result);
    } else {
        //输出报错，提示信息
        PX4_INFO("Invalid command. Usage: my_example_app time or my_example_app count a b");
    }

    return 0;
}