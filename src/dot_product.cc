#include <cstdio>
#include <cstdlib>
const unsigned size = 1000000;
int main(int argc, char* argv[]) {
  int i;
  float a[size], b[size], sum = 0.0;
  // Some initializations
  for (i = 0; i < size; ++i) a[i] = b[i] = 1.0;

  // Dot product
  for (i = 0; i < size; ++i) sum += (a[i] * b[i]);

  printf("Sum = %f\n", sum);
}
