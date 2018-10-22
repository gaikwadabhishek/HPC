#include<stdio.h>
#include<stdlib.h>
#include<cuda.h>

__global__ void oddEven(int *d,int I, int n)
{
   int id=threadIdx.x;
   if(I==0 &&((id*2+1)<n))
   {
       if(d[id*2] > d[id*2+1])
       {
             int temp  = d[id*2];
             d[id*2]   = d[id*2+1];
             d[id*2+1] = temp;
   
       }

   }

   if(I==1 &&((id*2+2)<n))
   {
       if(d[id*2+1] > d[id*2+2])
       {
             int temp  = d[id*2+1];
             d[id*2+1]   = d[id*2+2];
             d[id*2+2] = temp;
   
       }

   }



}

int main()
{
   int input[100] , output[100], n, i;
   int *device;
   
   printf("\n\nEnter number of elements :");
   scanf("%d",&n);

   int size=n*sizeof(int);
   cudaMalloc(&device,size);
  
   printf("\n\nEnter numbers :");
   for(i=0 ;i<n ;i++)
   {
      scanf("%d",&input[i]);
    
   }
 
   printf("\n\nArray Before Sorting =>");
   for(i=0 ;i<n ;i++)
   {
      printf("%d  ",input[i]);
    
   }

   cudaMemcpy(device,input,size,cudaMemcpyHostToDevice);


   for(i=0 ;i<n ;i++)
   {
      oddEven<<<1,n>>>(device,i%2,n);
    
   }
   
   cudaMemcpy(output,device,size,cudaMemcpyDeviceToHost);

   printf("\n\nArray After Sorting =>");
   for(i=0 ;i<n ;i++)
   {
      printf("%d  ",output[i]);
    
   } 

   cudaFree(device);
  
   return 0;


}
