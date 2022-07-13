#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#define n 1

int main(int argc, char argv[])
{
	int pid1,pid2,pid3,pid4,pid5,pid6,fd[2], num;
	int status=0,status1,status2;
	pid_t child_pid, wpid;
	char message[50];
	pid1=fork();
	if (pid1==0) 
	{ 
		pid3=fork(); 
		if (pid3==0)
		{
			
			close(fd[0]);
			dup2(fd[1],1);
			close(fd[1]);
			printf("P3: PID=%d,PPID=%d\n",getpid(),getppid());
			printf("Hello from you child\n");
			scanf("%s", message);
			exit(0);
		}
        else
        {
			sleep(1);
	    	printf("P1: PID=%d,PPID=%d\n",getpid(),getppid());
		    exit(0);
	    } 
    }
    else
    {
	    pid2=fork(); 
	    if (pid2==0)
	    {
			
			for(int i=0; i<n; i++)
			{
		    	pid4=fork();
	   			 if (pid4==0)
				{
				printf("P4: PID=%d,PPID=%d\n",getpid(),getppid());
				exit(0);
				}	
				pid5=fork();
				if (pid5==0)
				{
					printf("P5: PID=%d,PPID=%d\n",getpid(),getppid());
					exit(0);
				}
			}
		while((wpid=wait(&status))>0);
		printf("PID_child1=%d, PID_child2=%d\n", getpid(), getpid());
		pid6=fork();
		if (pid6==0)
		{
			printf("P6: PID=%d,PPID=%d\n",getpid(),getppid());
			exit(0);
		}
		wait(&status2);
		printf("P2: PID=%d,PPID=%d\n",getpid(),getppid());
		exit(0);
		
	}
    waitpid(pid1,&status1,0);
	printf("P0: PID=%d,PPID=%d\n",getpid(),getppid());
    execlp("cat","cat","/home/maria/askhsh2.c", NULL);
    }
}
