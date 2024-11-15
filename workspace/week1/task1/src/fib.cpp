#include "fib.h"
#include <vector>

using namespace std;

Matrix matrixMultiply(const Matrix &a, const Matrix &b) {
    int n = a.size();
    Matrix result(n, vector<__int128>(n, 0));
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            for (int k = 0; k < n; ++k) {
                result[i][j] = (result[i][j] + a[i][k] * b[k][j]);
            }
        }
    }
    return result;
}

Matrix matrixPower(Matrix base, int exp) {
    int n = base.size();
    Matrix result(n, vector<__int128>(n, 0));
    for (int i = 0; i < n; ++i) {
        result[i][i] = 1;
    }
    while (exp > 0) {
        if (exp % 2 == 1) {
            result = matrixMultiply(result, base);
        }
        base = matrixMultiply(base, base);
        exp /= 2;
    }
    return result;
}

__int128 fibonacci(int n) {
    if (n == 0) return 0;
    if (n == 1) return 1;
    Matrix F(2, vector<__int128>(2));
    F[0][0] = 1;
    F[0][1] = 1;
    F[1][0] = 1;
    F[1][1] = 0;
    Matrix result = matrixPower(F, n - 1);
    return result[0][0];
}