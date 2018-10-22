#include<stdio.h>
#include<stdlib.h>
#include<cuda.h>

#define N 9

__global__ void sum(int *a,int *o)
{
  int of;
  int id=threadIdx.x;
  for(of=N/2 ; of > 0 ;of=of/2)
  {
     if(id<of)
   {
     a[id]+=a[id+of];
   } 
  }
  if(N%2==1)
  {
   a[0]=a[0]+a[N-1];
  }
  o[0]=a[0];
}

int main()
{
  
  int *h_a,*d_a,*oh_a,*od_a;
  int size= N * sizeof(int);
  
  h_a=(int*)malloc(size);
  oh_a=(int*)malloc(size);

  cudaMalloc(&d_a,size);
  cudaMalloc(&od_a,size);

  int i;
  for(i=0 ;i<N ;i++)
  {
    h_a[i] = random() % N;
  }

  printf("\n\nNumbers =>");
  for(i=0 ;i<N ;i++)
  {
    printf("%d ",h_a[i]);
  }
  
  cudaMemcpy(d_a, h_a,size,cudaMemcpyHostToDevice);

  sum<<<1, N/2>>>(d_a,od_a);

  cudaMemcpy(oh_a, od_a,size,cudaMemcpyDeviceToHost);

  printf("\n\nSum => %d",oh_a[0]);

  float arithmeticMean=(float)oh_a[0]/N;

  printf("\n\nArithmetic Mean => %f",arithmeticMean);

  cudaFree(d_a);
  cudaFree(od_a);
  free(h_a);
  free(oh_a); 

  return 0;  
  
}
