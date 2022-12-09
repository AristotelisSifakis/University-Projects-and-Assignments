#include <stdio.h>
#include <stdlib.h>
#include "mpi.h"

int main(int argc, char** argv)
{
	int my_rank;
	int component;
	int a,amount,num_proc;
	int tag1=50,tag2=60,tag3=70,tag4=80;
	int target,source;
	//tag1 -> send,recv amount
	//tag2 -> send,recv elements to/from process/es
	//tag3 -> send,recv status of series and defective element
	//tag4 -> send,recv component
	
	MPI_Status status;
	int x;
	int data[200];
	int data_loc[200];
	int sorted,edge;
	//the component that breaks the assention
	
    
	MPI_Init(&argc, &argv);
	MPI_Comm_rank(MPI_COMM_WORLD, &my_rank);
	MPI_Comm_size(MPI_COMM_WORLD, &a);

	if (my_rank == 0)
	{
		printf("The amount of numbers:\n");
		scanf("%d", &amount);

		printf("The amount of %d numbers:\n",amount);
		for (x=0; x<amount; x++)
			scanf("%d", &data[x]);
        for (target = 1; target < a; target++)
            MPI_Send(&amount, 1, MPI_INT, target, tag1, MPI_COMM_WORLD);
       
	    num_proc = amount/a;  x=num_proc;
        
        for (target = 1; target < a; target++)
        {
            MPI_Send(&data[x], num_proc, MPI_INT, target, tag2,
                       MPI_COMM_WORLD);
            x+=num_proc;
        }
        for (x=0; x<num; x++)
            data_loc[x]=data[x];
	}
	 
	 else
    
	{
        MPI_Recv(&amount, 1, MPI_INT, 0, tag1, MPI_COMM_WORLD, &status);
        num_proc = amount/a;
        MPI_Recv(&data_loc[0], num_proc, MPI_INT, 0, tag2, MPI_COMM_WORLD, &status);
        MPI_Send(&data_loc[0],1,MPI_INT,my_rank-1,tag4,MPI_COMM_WORLD);
		
		if (my_rank<a-1)
		{
			MPI_Recv(&edge,1, MPI_INT, my_rank+1, tag4, MPI_COMM_WORLD, &status);
			//printf("\nEDGE OF %d IS %d\n",my_rank+1,edge);
		}
		
		/*
		for (x=0 ; x<num_proc ; x++)
			printf("\n%d ",data_loc[x]);
		printf("\n");*/
		  
    }
    sorted=1;
	for (x=0 ; x<num_proc-1 ; x++)
	{
		if(data_loc[x] > data_loc[x+1] )
		{
			sorted=0;
			//here is the component=data_loc[x];
		}
		
		
		if((x+1==num_proc-1) && data_loc[x+1]>edge && my_rank!=a-1)
		{
			sorted=0;
			//here is the component=data_loc[x+1];
		}
	
    }
	
	if (my_rank != 0) 
        MPI_Send(&sorted, 1, MPI_INT, 0, tag3, MPI_COMM_WORLD);
		
		//send send the component
	
	else 
	{
		if (sorted==0)
		{
			printf("\n\n\n(NO) the assending order dissolved during the process: %d \nDefective element : %d\n" , my_rank,component);
			
		}
		for (source=1 ; source<a ; source++)
		{
			MPI_Recv(&sorted,1,MPI_INT,source,tag3,MPI_COMM_WORLD,&status);
			
			//revc receive the component
			
			if ( sorted == 0 )
			{
				printf("\n\n\n(NO)  the assending order dissolved during the process: %d \nDefective element : %d\n" , source,component);
				
			}
				
		}	
	}

    MPI_Finalize();
}
