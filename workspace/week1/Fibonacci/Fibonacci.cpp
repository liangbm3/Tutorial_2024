#include<iostream>
using namespace std;

int Fibonacci(int n)
{
    if(n==1)
    {
        return 1;
    }
    if(n==2)
    {
        return 1;
    }
    return Fibonacci(n - 1) + Fibonacci(n - 2);
}

int main(){
    int n;
    cout << "n = ";
    cin >> n;
    cout << Fibonacci(n) << endl;
    return 0;
}
