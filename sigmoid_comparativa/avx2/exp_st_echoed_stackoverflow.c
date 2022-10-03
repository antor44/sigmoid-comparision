#include <stdio.h>
#include <math.h>
#define MAXSIZE 1000000
#define REIT 10000
#define XXX -5
/*    gcc -O3 -m64 exp_st.c -lm    */


int main(){
    int r;
    int i;
    double p;
    static double xv[MAXSIZE];
    static double yv[MAXSIZE];


  for (r = 0; r < REIT; r++) {
    p = XXX;

    for (i = 0; i < MAXSIZE; i++) {

      xv[i]=p;
      yv[i]=exp(p);

    p += 0.00001;
    }
  }

  for (i=0;i<MAXSIZE;i++){
      printf("x=%.20lf, e^x=%.20lf\n",xv[i],yv[i]);
  }

    return 0;
}
