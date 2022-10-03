#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <pthread.h>
#define MAXSIZE 1000000
#define REIT 100000
#define XXX -5
#define num_threads 8
static double xv[MAXSIZE];
static double yv[MAXSIZE];

/*    gcc -O3 -m64 exp_multi.c -pthread -lm    */


void* run(void *received_Val){
  	int single_val = *((int *) received_Val);
    int r;
    int i;
    double p;

  for (r = 0; r < REIT; r++) {
    p = XXX + 0.00001*single_val*MAXSIZE/num_threads;

    for (i = single_val*MAXSIZE/num_threads; i < (single_val+1)*MAXSIZE/num_threads; i++) {

      xv[i]=p;
      yv[i]=exp(p);

    p += 0.00001;
    }

  }

    return 0;
}


int main(){
    int i;
	  int ret;
	  pthread_t tid[num_threads];


    for (i=0;i<num_threads;i++){
      int *arg = malloc(sizeof(*arg));
      if ( arg == NULL ) {
        fprintf(stderr, "Couldn't allocate memory for thread arg.\n");
        exit(1);
      }

      *arg = i;
      	pthread_create(&(tid[i]), NULL, run, arg);
    }

    for(i=0; i<num_threads; i++)
    {
      	pthread_join(tid[i], NULL);
    }

    for (i=0;i<MAXSIZE;i++){
        printf("x=%.20lf, e^x=%.20lf\n",xv[i],yv[i]);
    }

    return 0;
}
