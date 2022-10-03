#include "sse_mathfun.h"
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <pthread.h>
#define MAXSIZE 1000000
#define REIT 100000
#define XXX -5
#define num_threads 8

/*typedef ALIGN16_BEG union {
  float f[4];
  v4sf  v;
} ALIGN16_END V4SF;

static float xv[MAXSIZE];
static float yv[MAXSIZE];
*/

typedef float  FLOAT32[MAXSIZE] __attribute__((aligned(16)));
static FLOAT32 xv;
static FLOAT32 yv;

/*    gcc -DPRINT_ARRAY -DUSE_SSE2 -O3 -m64 exp_float_multi_echoed2.c -pthread -lm -mfpmath=sse -msse
   */


void* run(void *received_Val){
  	int single_val = *((int *) received_Val);
    int r;
    int i;
    float p;
    float *xp;
    float *yp;

  for (r = 0; r < REIT; r++) {
    p = XXX + 0.00001*single_val*MAXSIZE/num_threads;

/*  V4SF vx, vy; */

    yp = yv + single_val*MAXSIZE/num_threads;

    for (i = single_val*MAXSIZE/num_threads; i < (single_val+1)*MAXSIZE/num_threads; i += 4) {

      xv[i]=p;
      xv[i+1] = p + 0.00001;
      xv[i+2] = p + 0.00002;
      xv[i+3] = p + 0.00003;

      yp=exp_ps(p, p + 0.00001, p + 0.00002, p + 0.00003);


      yp += 4;
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

    return 0;
}
