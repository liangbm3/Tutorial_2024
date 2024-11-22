#include <iostream>
using namespace std;

int solution(int i)
{
    if(i==0) return 0;
    if(i==1) return 1;
    //特例特判：初始的i=0，i=1，分别对应0和1
    return solution(i-1)+solution(i-2);
    //递归至i-1和i-2，直至i=0或i=1
}

int main()
{
    int n;
    cin>>n;//输入n
    int sum;
    sum=solution(n);
    cout<<sum<<endl;//输出结果
    return 0;
}