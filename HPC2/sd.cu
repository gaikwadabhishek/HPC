#include<stdio.h>
#include<stdlib.h>
#include<cuda.h>
#include<math.h>

#define N 10



__global__ void sum(double *a,double *o)
{
  int i;
  int id=threadIdx.x;
  for(i=0; i< N ;i++)
  {
     if(id<i)
   {
     a[id]+=a[id+i];
   } 
  }

  o[0]=a[0];
}


__global__ void standardDeviation(double *a,double avg)
{
  
   int id=threadIdx.x;
  
   if(id < N)
   {
      a[id] -= avg;
      a[id]  = a[id] * a[id];

   }
    
}

int main()
{
  
  double *h_a,*d_a,*oh_a,*od_a,*d_a1;
  int size= N * sizeof(double);
  
  h_a=(double *)malloc(size);
  oh_a=(double*)malloc(size);

  cudaMalloc(&d_a,size);
  cudaMalloc(&d_a1,size);
  cudaMalloc(&od_a,size);
  
  int i;
  for(i=0 ;i<N ;i++)
  {
    h_a[i] = random() % N;
  }

  printf("\n\nNumbers =>");
  for(i=0 ;i<N ;i++)
  {
    printf("%lf ",h_a[i]);
  }
  
  cudaMemcpy(d_a, h_a,size,cudaMemcpyHostToDevice);
  cudaMemcpy(d_a1, h_a,size,cudaMemcpyHostToDevice);

  sum<<<1, N/2>>>(d_a,od_a);

  cudaMemcpy(oh_a, od_a,size,cudaMemcpyDeviceToHost);

  printf("\n\nSum => %lf",oh_a[0]);

  float arithmeticMean=(float)oh_a[0]/N;

  printf("\n\nArithmetic Mean => %f",arithmeticMean);

   
  standardDeviation<<<1, N>>>(d_a1,arithmeticMean);

  sum<<<1, N/2>>>(d_a1,od_a);
  
  cudaMemcpy(oh_a, od_a,size,cudaMemcpyDeviceToHost);

  double temp =oh_a[0]/N;

  
  
  printf("\n\nStandard Deviation => %lf\n\n",sqrt(temp));
  

  cudaFree(d_a);
  cudaFree(od_a);
  cudaFree(d_a1);
  free(h_a);
  free(oh_a);
  
  return 0;  
  
}
