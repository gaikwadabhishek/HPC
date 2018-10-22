#include<iostream>
#include<omp.h>
using namespace std;





void merge(int a[],int low, int mid ,int mid1, int high)
{
     int temp[50] ,i,j,k=0;
     i=low;
     j=mid1;
   
     while(i<= mid && j<= high)
    {
       if(a[i] < a[j])
       {
 
        temp[k++] = a[i++];
     
       }
       else
       {
         temp[k++] = a[j++];
       }



    }

    while(i<= mid)
    {

      temp[k++] = a[i++];
  
    }

    while(j<= high)
    {

      temp[k++] = a[j++];
 
    }


   for(i=low,j=0;i<=high;i++,j++)
   {
      a[i] = temp[j]; 
   }


}


void mergesort(int a[],int low,int high)
{
    int mid;
    if(low < high)
    {
       mid=(low+high)/2;
       #pragma omp parallel sections
       {

          #pragma omp section
          {
   
                     mergesort(a,low,mid);
          }

          #pragma omp section
          {
                  
                   mergesort(a,mid+1,high);
             
          }




      }
 
      merge(a,low,mid,mid+1,high);
    }

}

int main()
{
   int *a,n,i;

   cout<<"\n\nEnter the number of elements :";
   cin>>n;
   
   a=new int[n];
   
   cout<<"\n\nEnter the numbers :";
   for(i=0; i<n ;i++)
   {
    
       cin>>a[i];
   
   }

   cout<<"\n\nArray Before Sorting =>  ";
   for(i=0; i<n ;i++)
   {
     cout<<a[i]<<"  ";
   }
  
   mergesort(a,0,n-1);

   cout<<"\n\nArray after Sorting => ";
   for(i=0; i<n ;i++)
   {
     cout<<a[i]<<"  ";
   }
   cout<<"\n";

   return 0;
}






