#include <iostream>

//定义函数f，并规定特殊值n=0和n=1时的返回值为0和1
int f(int n) {
    if (n == 0) {
        return 0;
    } else if (n == 1) {
        return 1;
    } else {
        return f(n - 1) + f(n - 2);
    }
}

//主函数
int main() {
    int n;
    //"std::cout <<"输出提示信息到控制台，提示该程序的用法
    std::cout << "请输入要计算的斐波那契数列的项数n(0<=n<=50)";
    //"std::cin >>"从控制台输入数据到变量n
    std::cin >> n;
    //判断输入的n是否在0~50之间，并用"std::cout <<"函数输出计算结果到控制台,"std::endl"表示换行
    std::cout << "斐波那契数列的第" << n << "项是：" << f(n) << std::endl;
    return 0;
}
