//Runnable example
#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

struct my_Struct{
	int index;
	int value;
};
void* my_Func(void *received_struct){
	struct my_Struct *struct_ptr = (struct my_Struct*) received_struct;
    printf("index: %d  |  value: %d \n", struct_ptr->index, struct_ptr->value);
	//Now use 'struct_ptr->index', 'struct_ptr->value' as you wish
}
int main(){
	struct my_Struct mystruct_1[5];
	
	printf("\nEnter 5 numbers:\n");
	for (int i=0; i<5; i++){
		scanf("%d", &mystruct_1[i].value);
		mystruct_1[i].index = i;
	}
	pthread_t tid[5];
	for(int i=0; i<5; i++){
		pthread_create(&(tid[i]), NULL, my_Func, &mystruct_1[i]);
	}
	for (int i=0; i<5; i++){	
		pthread_join(tid[i], NULL);
	}
}
//To run: gcc [C FILE].c -lpthread -lrt
// ./a.out

//Grepper Profile: https://www.codegrepper.com/app/profile.php?id=9192
