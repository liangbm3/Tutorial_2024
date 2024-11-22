#include <iostream>

// 函数声明
int fibonacci(int n);

int main() {
    int n;
    std::cout << "请输入整数n: ";
    std::cin >> n; // 从用户那里获取整数n

    // 计算斐波那契数列的第n个数
    int result = fibonacci(n);

    std::cout << "斐波那契数列的第" << n << "个数是: " << result << std::endl;

    return 0;
}

// 函数定义
int fibonacci(int n) {
    if (n <= 1) {
        return n; // 基本情况
    } else {
        return fibonacci(n - 1) + fibonacci(n - 2); // 递归计算
    }
}