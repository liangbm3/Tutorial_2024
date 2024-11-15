#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;
#ifndef FIB_H
#define FIB_H

typedef vector<vector<__int128> > Matrix;

Matrix matrixMultiply(const Matrix &a, const Matrix &b);

Matrix matrixPower(Matrix base, int exp);

__int128 fibonacci(int n);

#endif