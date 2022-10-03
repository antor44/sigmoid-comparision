#include "sse_mathfun.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <pthread.h>
#define MAXSIZE 1000000
#define REIT 100000
#define XXX -5
#define num_threads 8

typedef ALIGN16_BEG union {
  float f[4];
  v4sf  v;
} ALIGN16_END V4SF;

static float xv[MAXSIZE];
static float yv[MAXSIZE];

/*    gcc -DPRINT_ARRAY -DUSE_SSE2 -O3 -m64 exp_float_multi_echoed.c -pthread -lm -mfpmath=sse -msse
   */


void* run(void *received_Val){
  	int single_val = *((int *) received_Val);
    int r;
    int i;
    float p;

  for (r = 0; r < REIT; r++) {
    p = XXX + 0.00001*single_val*MAXSIZE/num_threads;

    V4SF vx, vy;


    for (i = single_val*MAXSIZE/num_threads; i < (single_val+1)*MAXSIZE/num_threads; i += 4) {

      vx.f[0] = p;
      vx.f[1] = p + 0.00001;
      vx.f[2] = p + 0.00002;
      vx.f[3] = p + 0.00003;
      xv[i]=p;
      xv[i+1] = p + 0.00001;
      xv[i+2] = p + 0.00002;
      xv[i+3] = p + 0.00003;

      vy.v=exp_ps(vx.v);

      yv[i]=vy.f[0];
      yv[i+1]=vy.f[1];
      yv[i+2]=vy.f[2];
      yv[i+3]=vy.f[3];

      p += 0.00004;

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
#ifdef PRINT_ARRAY
    for (i=0;i<MAXSIZE;i++){
        printf("x=%.20f, e^x=%.20f\n",xv[i],yv[i]);
    }
#endif

/* compare exp_ps with the double precision exp from math.h,
   print the relative error             */
for (i=0;i<1000000;i+= 124000){
       printf("i = %i  x =%16.9e   y =%16.9e   exp_dbl =%16.9e   rel_err =%16.20e\n",
          i,xv[i],yv[i],exp((double)(xv[i])),
          ((double)(yv[i])-exp((double)(xv[i])))/exp((double)(xv[i])) );
}




    return 0;
}
