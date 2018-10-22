#include<stdio.h>
#include<stdlib.h>
#include<cuda.h>
#define N 4
#define TPB 2

__global__ void matrixMul(int *a,  int *b,int *c ,int n)
{
   int row = blockIdx.y * blockDim.y + threadIdx.y ;
   int col = blockIdx.x * blockDim.x + threadIdx.x ; 
   int i;
   int sum=0;
   for( i=0 ;i<N; i++)
   {
     sum+= a[row * N+i] * b[i * N+col];
   }
   c[row * N+col] = sum;
}


int main()
{
  int *h_a,*h_b,*h_c,*d_a,*d_b,*d_c;
  
  int size = sizeof(int)*N*N;
  
  h_a = (int*)malloc(size);
  h_b = (int*)malloc(size);
  h_c = (int*)malloc(size);

  cudaMalloc(&d_a,size);
  cudaMalloc(&d_b,size);
  cudaMalloc(&d_c,size);

  int i,j;

  for(i=0; i<N*N;i++)
  {
    
       h_a[i]=random() % N;
       h_b[i]=random() % N; 
    
  } 
  
  printf("\nMatrx A =>\n");
  for(i=0;i<N;i++)
  {
    for(j=0;j<N;j++)
    {
      printf(" %d",h_a[i*N+j]);
    }
    printf("\n");
  }

  printf("\nMatrx B =>\n");
  for(i=0; i<N ;i++)
  {
    for(j=0; j<N ;j++)
    {
      printf(" %d",h_b[i*N+j]);
    }
    printf("\n");
  }

  cudaMemcpy(d_a,h_a,size,cudaMemcpyHostToDevice);
  cudaMemcpy(d_b,h_b,size,cudaMemcpyHostToDevice);
   
  int BLOCK_SIZE= N/TPB;
  dim3 GridSize(BLOCK_SIZE,BLOCK_SIZE);
  dim3 BlockSize(TPB, TPB);

  matrixMul<<<GridSize,BlockSize>>>(d_a , d_b ,d_c,N);

  cudaMemcpy(h_c,d_c, size, cudaMemcpyDeviceToHost);

  printf("\nMatrx C =>\n");
  for(i=0;i<N;i++)
  {
    for(j=0;j<N;j++)
    {
      printf(" %d",h_c[i*N+j]);
    }
    printf("\n");
  }

  cudaFree(d_a);
  cudaFree(d_b);
  cudaFree(d_c);

  free(h_a);
  free(h_b);
  free(h_c);

  return 0;

}
