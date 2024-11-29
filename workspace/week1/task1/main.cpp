#include<iostream>
using namespace std;

long Fi(long n){
    if(n==0) return 0;
    else if(n==1) return 1;
    else return Fi(n-1)+Fi(n-2);
}

int main(){
    cout<<"输入: ";
    long n;
    cin>>n;
    long result=Fi(n);
    cout<<"输出: "<<result<<endl;
}