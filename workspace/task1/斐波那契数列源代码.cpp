#include <iostream>
using namespace std;

int fibonaqi_rolling_array(int n) {
    if (n == 0) return 0;
    if (n == 1) return 1;
    
    int a = 0, b = 1;
    for (int i = 2; i <= n; ++i) {
        int temp = a + b;
        a = b;
        b = temp;
    }
    
    return b;
}

int main() {
    int n;
    cin >> n;
    cout << fibonaqi_rolling_array(n) << endl;
    return 0;
}
