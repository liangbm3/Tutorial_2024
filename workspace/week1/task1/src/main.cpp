#include "fib.h"

using namespace std;

void printInt128(__int128 num) {
    if (num == 0) {
        cout << "0";
        return;
    }
    string result;
    while (num > 0) {
        result += '0' + num % 10;
        num /= 10;
    }
    reverse(result.begin(), result.end());
    cout << result;
}

int main() {
    int n;
    cout << "Enter the value of n: ";
    cin >> n;
    cout << "Fibonacci number " << n << " is ";
    printInt128(fibonacci(n));
    cout << endl;
    return 0;
}