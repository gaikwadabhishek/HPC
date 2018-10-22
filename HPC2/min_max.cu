#include<stdio.h>
#include<stdlib.h>
#include<cuda.h>
#define N 5

__global__ void maximumElement(int *a,int *o)
{

  
    int of;

    int id = threadIdx.x;

     for(of=N/2; of>0;of=of/2)
     {
	if(id<of)
	{
		if(a[id+of] > a[id])
		{
			a[id] = a[id+of];
		}
	}
     }
	if(a[0]<a[N-1])
	{
		a[0]=a[N-1];
	}
        o[0] = a[0];
  
}

__global__ void minimumElement(int *a,int *o)
{

    int of;

    int id = threadIdx.x;

     for(of=N/2;of>0;of=of/2)
     {
	if(id<of)
	{
		if(a[id+of] < a[id])
		{
			a[id] = a[id+of];
		}
	}
     }
	if(a[0]>a[N-1])
	{
		a[0]=a[N-1];
	}
       o[0] = a[0];
  
}




int main()
{
   int *host,*device,*output_host,*output_device;
   int choice;

   int size=N*sizeof(int);
   
   host = (int*)malloc(size);
   output_host = (int*)malloc(size);

   cudaMalloc(&device,size);
   cudaMalloc(&output_device,size);


   int i;
   /*
   for(i=0 ; i<N ;i++)
   {

     host[i] = random() %N;
 
   }*/

   host[0]=7;
host[1]=2;
host[2]=6;
host[3]=3;
host[4]=1;

   printf("\n\n Vector  => ");
   for(i=0 ; i<N ;i++)
   {

     printf("%d ",host[i]);
     
   }

   cudaMemcpy(device,host,size,cudaMemcpyHostToDevice);
   
   printf("\n\n1.Maximum Elemnt\n2.Minimum Elemnt\n\nEnter your choice :");
    scanf("%d",&choice);

   if(choice==1)
   {

    maximumElement<<<2,N/2>>>(device,output_device);   

   }
   else
   {
    
    minimumElement<<<2,N/2>>>(device,output_device);

   }

   cudaMemcpy(output_host,output_device,size,cudaMemcpyDeviceToHost);
     
   if(choice==1)
   {

    printf("\n\nMaximum elemnt => %d",output_host[0]); 
    
   }
   else
   {

   printf("\n\nMinimum elemnt => %d",output_host[0]); 

   }
    
   cudaFree(device);
   cudaFree(output_device);
   free(host);
   free(output_host);
   
   return 0; 

}
