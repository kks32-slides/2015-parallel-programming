#include <omp.h>

#include <cstdio>
#include <cstdlib>
const unsigned size = 1000000;
const unsigned chunk = 10;
int main(int argc, char* argv[]) {
  int i;
  float a[size], b[size], sum = 0.0;
  // Some initializations
  for (i = 0; i < size; ++i) a[i] = b[i] = 1.0;

// parallel dot product
#pragma omp parallel for default(shared) private(i) \
  schedule(dynamic, chunk) reduction(+:sum)
  for (i = 0; i < size; ++i) sum += (a[i] * b[i]);

  printf("Sum = %f\n", sum);
}
