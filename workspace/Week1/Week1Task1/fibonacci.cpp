/**********************************************************************
 * FileName: fibonacci.cpp
 * Author: @Ethan-Zhengsy
 * Version: 1.0.0
 * Date: 2024.11.19
 * Description: 给定一个整数 n，计算并返回斐波那契数列的第 n 项。
 * Function List: 
        1. main : 主函数，接收一个整数n, 输出返回结果
        2. getFibonacci : 接收整数n, 递归计算斐波那契数列的第n项并返回
 **********************************************************************/

#include <iostream>

/**
 * @brief 斐波那契数列递归函数
 * @param n 斐波那契数列项数
 * 
 * @return 返回数列的值
 */
int getFibonacci(int n) {
    if (n == 0) return 0;	///递归终点 F(0) = 0
    else if (n == 1) return 1;	///递归终点 F(1) = 1
    else {
        /**
         * 斐波那契数列递归式
         * F(n) = F(n - 1) + F(n - 2)
        */
        return getFibonacci(n - 1) + getFibonacci(n - 2);
    }
}

int main() {
    int n;  ///斐波那契数列项数
    std::cin >> n;  
    std::cout << getFibonacci(n) << std::endl;
    return 0;
}
