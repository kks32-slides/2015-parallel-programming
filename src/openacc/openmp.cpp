#include <cstdio>
#include <cstdlib>

int main() {
  int N = 1000000;
  int ITERS = 1000;

  float *a, *b;
  a = (float *)malloc(N * sizeof(float));
  b = (float *)malloc(N * sizeof(float));

  for (int i = 0; i < N; ++i)
    a[i] = 1;
  for (int i = 0; i < N; ++i)
    b[i] = 2;

  for (int iter = 0; iter < ITERS; ++iter) {
    for (int i = 0; i < N; ++i)
      b[i] = b[i] * b[i];
    for (int i = 0; i < N; ++i)
      a[i] = b[i] + a[i];
    for (int i = 0; i < N; ++i)
      b[i] = b[i] / a[i];
  }
  free(a);
  free(b);
}
