#include<stdio.h>

int fibonacci(int n) {
    if (n <= 1) {
        return n;
    }
    int a=0, b=1, c;
    for (int i=2; i<=n; i++) {
        c=a+b;
        a=b;
        b=c;
    }
    return b;
}

int main() {
    int n=10;
    scanf("%d", &n);
    printf("%d\n",fibonacci(n));
    return 0;
}