#include<iostream>
#include<omp.h>
using namespace std;

int binarySearch(int*,int,int,int);

int binarySearch(int *a,int low,int high,int key)
{
   int mid,mid1,high1,low1,low2,mid2,high2,found=0,loc=-1;
   mid = (low+high) /2;
   
   #pragma omp parallel sections
   {
      #pragma omp section
      {
          low1=low;
          high1=mid;
          while(low1<=high1)
          {
               if(!(key>=a[low1] && key <=a[high1]))
               {
                   low1 = low1+high1;
                   continue;
               }

                cout<<"\nHere1";
                mid1=(low1+high1) / 2;
                
                if(key==a[mid1])
                {
                   loc = mid1;
                   found = 1;
                   low1 = high1+1;
                   break;
                }
                else if(key>a[mid1])
                {
                   low1 = mid1+1;

                }
                else if(key < a[mid1])
                { 
                  
                   high1 = mid1 - 1;
                
                }
            
     
  
         } 
     } 

      #pragma omp section
      {
          low2=mid+1;
          high2=high;
          while(low2<=high2)
          {
               if(!(key>=a[low2] && key <=a[high2]))
               {
                   low2 = low2 + high2;
                   continue;
               }

                cout<<"\nHere2";
                mid2=(low2 + high2) / 2;
                
                if(key==a[mid2])
                {
                   loc = mid2;
                   found = 1;
                   low2 = high2 + 1;
                   break;
                }
                else if(key>a[mid2])
                {
                   low2 = mid2+1;

                }
                else if(key < a[mid2])
                { 
                  
                   high2 = mid2 - 1;
                
                }
            
     
  
         }          

      }

   }

    return loc;
}
int main()
{
  int *a,n,i,key,loc=-1;
  
  cout<<"\n\nEnter the number of elemnts => ";
  cin>>n;

  a=new int[n];

  for(i=0; i<n ;i++)
  {
    cin>>a[i];
  }
  
  cout<<"\n\n Elemnts => ";
  for(i=0; i<n ;i++)
  {
    cout<<a[i]<<" ";
  }

  cout<<"\n\nEnter elemnt to search =>";
  cin>>key;
  
  loc = binarySearch(a,0,n-1,key);

  if(loc==-1)
  {
   
   cout<<"\n\nKey Not Found";

  }
  else
  {

   cout<<"\n\nKey Fonf At position => "<<loc+1;

  }
 
  return 0;

  

}  


