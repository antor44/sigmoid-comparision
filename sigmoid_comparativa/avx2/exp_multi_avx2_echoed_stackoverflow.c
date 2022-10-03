
/* Performance test of a multithreaded exp(x) algorithm

based on AVX implementation of Giovanni Garberoglio


 Copyright (C) 2020 Antonio R.


     AVX implementation of exp:
     Modified code from this source: https://github.com/reyoung/avx_mathfun
     Based on "sse_mathfun.h", by Julien Pommier
     http://gruntthepeon.free.fr/ssemath/
     Copyright (C) 2012 Giovanni Garberoglio
     Interdisciplinary Laboratory for Computational Science (LISC)
     Fondazione Bruno Kessler and University of Trento
     via Sommarive, 18
     I-38123 Trento (Italy)


    This software is provided 'as-is', without any express or implied
    warranty.  In no event will the authors be held liable for any damages
    arising from the use of this software.
    Permission is granted to anyone to use this software for any purpose,
    including commercial applications, and to alter it and redistribute it
    freely, subject to the following restrictions:
    1. The origin of this software must not be misrepresented; you must not
       claim that you wrote the original software. If you use this software
       in a product, an acknowledgment in the product documentation would be
       appreciated but is not required.
    2. Altered source versions must be plainly marked as such, and must not be
       misrepresented as being the original software.
    3. This notice may not be removed or altered from any source distribution.
    (this is the zlib license)

  */

  /*    gcc -O3 -m64 -mavx2 -march=haswell expc_multi.c -pthread -lm    */

#include <stdio.h>
#include <stdlib.h>
#include <immintrin.h>
#include <math.h>
#include <pthread.h>
#define MAXSIZE 1000000
#define REIT 100000
#define XXX -5
#define num_threads 8

static float xv[MAXSIZE];
static float yv[MAXSIZE];
typedef __attribute__((aligned(32))) union {
  float f[8];
  __m256  v;
} V8SF;



__m256 exp256_ps(__m256 x) {

/*
  To increase the compatibility across different compilers the original code is
  converted to plain AVX2 intrinsics code without ingenious macro's,
  gcc style alignment attributes etc.
  Moreover, the part "express exp(x) as exp(g + n*log(2))" has been significantly simplified.
  This modified code is not thoroughly tested!
*/


__m256   exp_hi        = _mm256_set1_ps(88.3762626647949f);
__m256   exp_lo        = _mm256_set1_ps(-88.3762626647949f);

__m256   cephes_LOG2EF = _mm256_set1_ps(1.44269504088896341f);
__m256   inv_LOG2EF    = _mm256_set1_ps(0.693147180559945f);

__m256   cephes_exp_p0 = _mm256_set1_ps(1.9875691500E-4);
__m256   cephes_exp_p1 = _mm256_set1_ps(1.3981999507E-3);
__m256   cephes_exp_p2 = _mm256_set1_ps(8.3334519073E-3);
__m256   cephes_exp_p3 = _mm256_set1_ps(4.1665795894E-2);
__m256   cephes_exp_p4 = _mm256_set1_ps(1.6666665459E-1);
__m256   cephes_exp_p5 = _mm256_set1_ps(5.0000001201E-1);
__m256   fx;
__m256i  imm0;
__m256   one           = _mm256_set1_ps(1.0f);

        x     = _mm256_min_ps(x, exp_hi);
        x     = _mm256_max_ps(x, exp_lo);

  /* express exp(x) as exp(g + n*log(2)) */
        fx     = _mm256_mul_ps(x, cephes_LOG2EF);
        fx     = _mm256_round_ps(fx, _MM_FROUND_TO_NEAREST_INT |_MM_FROUND_NO_EXC);
__m256  z      = _mm256_mul_ps(fx, inv_LOG2EF);
        x      = _mm256_sub_ps(x, z);
        z      = _mm256_mul_ps(x,x);

__m256  y      = cephes_exp_p0;
        y      = _mm256_mul_ps(y, x);
        y      = _mm256_add_ps(y, cephes_exp_p1);
        y      = _mm256_mul_ps(y, x);
        y      = _mm256_add_ps(y, cephes_exp_p2);
        y      = _mm256_mul_ps(y, x);
        y      = _mm256_add_ps(y, cephes_exp_p3);
        y      = _mm256_mul_ps(y, x);
        y      = _mm256_add_ps(y, cephes_exp_p4);
        y      = _mm256_mul_ps(y, x);
        y      = _mm256_add_ps(y, cephes_exp_p5);
        y      = _mm256_mul_ps(y, z);
        y      = _mm256_add_ps(y, x);
        y      = _mm256_add_ps(y, one);

  /* build 2^n */
        imm0   = _mm256_cvttps_epi32(fx);
        imm0   = _mm256_add_epi32(imm0, _mm256_set1_epi32(0x7f));
        imm0   = _mm256_slli_epi32(imm0, 23);
__m256  pow2n  = _mm256_castsi256_ps(imm0);
        y      = _mm256_mul_ps(y, pow2n);
        return y;
}


void* run(void *received_Val){
  	int single_val = *((int *) received_Val);
    int r;
    int i;
    float p;
    int j;
    V8SF vx, vy;


  for (r = 0; r < REIT; r++) {
    p = XXX + 0.00001*single_val*MAXSIZE/num_threads;

    for (i = single_val*MAXSIZE/num_threads; i < (single_val+1)*MAXSIZE/num_threads; i += 8) {

      for (j= 0; j < 8; j++) {
        vx.f[j] = p;
        xv[i+j] = p;
        p = p + 0.00001;
      }

      __m256 x = _mm256_setr_ps(vx.f[0], vx.f[1], vx.f[2], vx.f[3], vx.f[4], vx.f[5], vx.f[6], vx.f[7]);
      __m256 y = exp256_ps(x);

      _mm256_store_ps(vy.f,y);

      for (j= 0; j < 8; j++) {
        yv[i+j] = vy.f[j];
      }

      p = p + 0.00001;

    }
  }

    return 0;
}


int main(){
    int i;
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
        printf("x=%.20f, e^x=%.20f\n",xv[i],yv[i]);
    }

    return 0;
}
