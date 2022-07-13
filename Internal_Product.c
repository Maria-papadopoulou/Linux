#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
struct thread_data MyData;
void* Internal_Product();
void initArray();
int total_sum=0,count=0,numberOfThread,n=0;
pthread_mutex_t mutex;


struct thread_data
{       int* A;
        int* B;
    
};


int main(int argc, char **argv)
{
 pthread_t PThread[150];

    initArray();
   do
{
        printf("Number of threads!(n mod threads == 0):");
        scanf("%d",&numberOfThread); 
        printf("mod:%d\n",n%numberOfThread);
    }while(n%numberOfThread!=0);

    pthread_mutex_init(&mutex,NULL);

    for(int i=0;i<numberOfThread;i++)
{

        if (pthread_create(PThread+i, NULL, &Internal_Product, NULL) != 0)
	{    
				return 1;
        }
    }
    
    
   for(int i=0;i<numberOfThread;i++)
{

        if (pthread_create(PThread+i, NULL, &Internal_Product, NULL) != 0)
{    
            return 1;
        }
    }
    
    
    for(int i=0;i<numberOfThread;i++)
{
        if (pthread_join(PThread[i], NULL) != 0) 
{

            return 10;
        }
  }

    printf("Inner Product: %d\n",total_sum);

    pthread_mutex_destroy(&mutex);
}
    

void initArray()
{
    int data;
    printf("Size for arrays:\n");
    scanf("%d",&n);
     MyData.A=(int*)malloc(sizeof(int)*n);
      MyData.B=(int*)malloc(sizeof(int)*n);
    printf("\nInserting numbers for Vector/Array 1:\n");
    for(int i=0;i<n;i++)
{
 printf("Number%d :",i+1);
        scanf("%d",&data);
        MyData.A[i]=data;    
    }

    printf("\nInserting numbers for Vector/Array 2:\n");
    for(int i=0;i<n;i++)
{
        printf("Number%d : ",i+1);
        scanf("%d",&data);
        MyData.B[i]=data;    
    }
    
}

void* Internal_Product() 
{
  for (int i = 0; i < n/numberOfThread; i++)
 {
        pthread_mutex_lock(&mutex); 
        int tmp=(MyData.A[count])*(MyData.B[count]);
        total_sum=total_sum+tmp;
        pthread_mutex_unlock(&mutex);
        count++;
    }
}
