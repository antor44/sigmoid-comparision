#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "sse_mathfun.h"
#define MAXSIZE 1000000
#define REIT 100000
#define XXX -5

typedef ALIGN16_BEG union {
  float f[4];
  v4sf  v;
} ALIGN16_END V4SF;

/*    gcc -DPRINT_ARRAY -DUSE_SSE2 -O3 -m64 exp_sse2_float_st_echoed.c -lm -mfpmath=sse -msse    */


int main(){
    int r;
    int i;
    double p;
    static double xv[MAXSIZE];
    static double yv[MAXSIZE];


  for (r = 0; r < REIT; r++) {
    p = XXX;
    V4SF vx, vy;

    for (i = 0; i < MAXSIZE; i++) {

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

#ifdef PRINT_ARRAY
      for (i=0;i<MAXSIZE;i++){
          printf("x=%.20f, e^x=%.20f\n",xv[i],yv[i]);
      }
#endif

    return 0;
}
