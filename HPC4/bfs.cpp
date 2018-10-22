#include<iostream>
#include<stdlib.h>
#include<queue>

using namespace std;

class node
{
  public:
   node *left,*right;
   int data;

};
class BFS
{
 public:
 node *insert(node*,int);
 void bfs(node*);
};

node* insert(node *root,int data)
{
	if(!root)
	{
		root=new node;
		root ->left =NULL;
		root ->right =NULL;
		root ->data =data;
		return root;
	}

	queue<node *>q;
	q.push(root);
	while(!q.empty())
	{
       node *temp=q.front();
       q.pop();

       if(temp->left==NULL)
       {
       	  temp->left=new node;
       	  temp->left->left=NULL;
       	  temp->left->right=NULL;
       	  temp->left->data=data;
       	  return root;
       }
       else
       {
       	 q.push(temp->left);
       }

       if(temp->right==NULL)
       {
       	  temp->right=new node;
       	  temp->right->left=NULL;
       	  temp->right->right=NULL;
       	  temp->right->data=data;
       	  return root;
       }
       else
       {
       	 q.push(temp->right);
       }


	}
}
void bfs(node *head)
{
	queue<node *>q;
	q.push(head);

	int qSize;
	while(!q.empty())
	{
		qSize=q.size();
		#pragma omp parallel for 
		for(int i=0; i < qSize; i++)
               {
           	 node *curNode;
          	#pragma omp critical
          	{
              curNode=q.front();
              q.pop();
              cout<<curNode->data<<"  ";

         	}
         	#pragma omp critical
         	{
         		if(curNode->left)
         		
         			q.push(curNode->left);
         		
         		if(curNode->right)
         		
         			q.push(curNode -> right);
         		
         	}
          }	 
	    
	}
}


int main()
{
  node *root=NULL;
  char choice;
  int data;
  do
  {
    cout<<"\nEnter node data:";
    cin>>data;
    root= insert(root,data);

    cout<<"\n\nDo ypu want to add another node ?";
    cin>>choice; 
  }while(choice =='y' || choice=='Y');

  bfs(root);

 return 0;

}
