#include<stdio.h>
#include<stdlib.h>
#include<math.h>

__global__ void add(double *a,double *b,double *c,int n)
{
  int id=blockIdx.x*blockDim.x+threadIdx.x;

  if(id<n)
  {
   c[id] = a[id] + b[id];
  }


}



int main()
{
  int n=8;
  double *h_a,*h_b,*h_c,*d_a,*d_b,*d_c;
  
  size_t bytes = n*sizeof(double);

  h_a=(double*)malloc(bytes);
  h_b=(double*)malloc(bytes);
  h_c=(double*)malloc(bytes);

  cudaMalloc(&d_a,bytes);
  cudaMalloc(&d_b,bytes);
  cudaMalloc(&d_c,bytes);

  int i;
  for(i=0;i<n;i++)
  {
    h_a[i]= random() %n;
    h_b[i]= random() %n;
  }
  
  printf("\n\nVector A =>");
  for(i=0;i<n;i++)
  {
   
    printf("%lf ",h_a[i]);

  }

  printf("\n\nVector B =>");
  for(i=0;i<n;i++)
  {
   
    printf("%lf ",h_b[i]);

  }
  
  cudaMemcpy(d_a,h_a,bytes,cudaMemcpyHostToDevice); 
  cudaMemcpy(d_b,h_b,bytes,cudaMemcpyHostToDevice); 

  int blockSize=2;

  int gridSize=(int)ceil((float)n/blockSize);

  add<<<gridSize,blockSize>>>(d_a,d_b,d_c,n);

  cudaMemcpy(h_c,d_c,bytes,cudaMemcpyDeviceToHost);

  printf("\n\nVector BC=>");
  for(i=0;i<n;i++)
  {
   
    printf("%lf ",h_c[i]);

  }

  cudaFree(d_a);
  cudaFree(d_b);
  cudaFree(d_c);
   
  free(h_a);
  free(h_b);
  free(h_c);
   
  return 0;
  


}

