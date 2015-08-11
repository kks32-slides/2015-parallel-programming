#include <stdio.h>

// Define constants for array and thread block dimensions
// You don't need to change these
#define ARRAY_ELEMENTS 10
#define BLOCK_SIZE 10

// Stage 3: Implement the kernel
__global__ void copyArray(int *arraySrc_d, int *arrayDest_d)
{
    // There's only a single thread block in this example
    // so we can just use the thread index to access the array
    if (threadIdx.x < ARRAY_ELEMENTS)
        arrayDest_d[threadIdx.x] = arraySrc_d[threadIdx.x];
}


int main( int argc, char** argv) 
{
    // pointer for host memory
    int *arraySrc_h, *arrayDest_h;

    // pointer for device memory
    int *arraySrc_d, *arrayDest_d;

    size_t memSize = ARRAY_ELEMENTS * sizeof(int);
    arraySrc_h  = (int *) malloc(memSize);
    arrayDest_h = (int *) malloc(memSize);
    if (arraySrc_h == NULL || arrayDest_h == NULL){
        printf("\nError in host memory allocation. Exiting");
        exit(1);
    }

    // Stage 1: Allocate device memory
    cudaMalloc(&arraySrc_d, memSize);
    cudaMalloc(&arrayDest_d, memSize);
    
    // Define Grid and Block dimensions - in this example there's only one block
    dim3 dimGrid(1);
    dim3 dimBlock(BLOCK_SIZE);

    //Set host source array with some test values
    for (int j = 0; j < ARRAY_ELEMENTS; j++)
    {
        arraySrc_h[j] = j;
    }

    //Stage 2: copy the source array to the device
    cudaMemcpy(arraySrc_d, arraySrc_h, memSize, cudaMemcpyHostToDevice);    

    //Stage 4: Call the kernel function
    copyArray<<<dimGrid, dimBlock>>>(arraySrc_d, arrayDest_d);

    // block until the device has completed
    cudaThreadSynchronize();

    //Stage 5: Copy arrayDest_d back to the host arrayDest_h
    cudaMemcpy(arrayDest_h, arrayDest_d, memSize, cudaMemcpyDeviceToHost);

    // Verify the data was copied correctly
    for (int j = 0; j < ARRAY_ELEMENTS; j++)
    {
        if (arrayDest_h[j] != arraySrc_h[j])
        {
            printf("\nERROR: Destination array is not equal to Source array\n");
            exit(-1);
        }
    }


    // free device memory
    cudaFree(arraySrc_d);
    cudaFree(arrayDest_d);

    // free host memory
    free(arraySrc_h);
    free(arrayDest_h);

    printf("Correct!\n");

    return 0;
}



