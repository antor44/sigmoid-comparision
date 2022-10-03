//Runnable example
#include <stdio.h>
#include <pthread.h>

void* my_Func(void *received_arr_Val){

	int single_val = (int *)received_arr_Val;
    printf("Value: %d\n", single_val);
	//Now use single_val as you wish
}
int main(){
	int values[5];

	printf("\nEnter 5 numbers:\n");
	for (int i=0; i<5; i++){
		scanf("%d", &values[i]);
	}
	pthread_t tid[5];
	for(int i=0; i<5; i++){
		pthread_create(&(tid[i]), NULL, my_Func, values[i]);
	}
	for (int i=0; i<5; i++){
		pthread_join(tid[i], NULL);
	}
}
//To run: $ gcc [C FILE].c -lpthread -lrt
// $ ./a.out

//Grepper profile: https://www.codegrepper.com/app/profile.php?id=9192
