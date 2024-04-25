# Comparing Sigmoid Calculation Efficiency: Multithreading and Single Threading Across Programming Languages in Low-Level ML Code
---

After researching some codes of main basic algorithms in low-level Machine Learning, such as the logistic regression algorithm, the most computationally expensive function for the processor is the mathematical calculation of the sigmoid function or computing exp on individual elements of a matrix.

For the calculation of the exponential function, most codes rely on the standard mathematical libraries of their respective programming languages. However, they may vary slightly depending on the implementation of the compiler, C runtime, and the processor. No one software algorithm is as fast as possible and also accurate over the whole range of x values, so the library implements several different algorithms. Traditional Taylor polynomial calculations or the Maclaurin expansion version are inefficient. 

Modern techniques often involve the use of a lookup table to store precalculated values and polynomial adjustments to approximate the exponential function across a wider range of values. The employed algorithms utilize a series of techniques, such as range reduction and polynomial evaluation, to accurately and efficiently calculate the exponential function. This includes double-precision floating-point operations, bit manipulation, and advanced mathematical calculations to handle special cases and optimize performance. 

Algorithms like [avx_mathfun](https://github.com/reyoung/avx_mathfun) use range reduction in combination with a Chebyshev approximation-like polynomial to compute exponentials in parallel with AVX instructions. 

Variations may also be used for higher precision variables than double. For [quad precision or 128 bits](https://codebrowser.dev/glibc/glibc/sysdeps/ieee754/ldbl-128/e_expl.c.html), the standard C employs an algorithm using Abraham Ziv's formula, ['Fast Evaluation of Elementary Mathematical Functions with Correctly Rounded Last Bit'](https://dl.acm.org/doi/abs/10.1145/114697.116813).

## Programming languages comparison, single thread codes, some with different algorithms:

![pi_cam_preview_usb.py](https://github.com/antor44/sigmoid-comparison/blob/main/Test_ML_algorithm.jpg)


Matlab and Octave algorithms are calculated in three modes: by passing an entire matrix to the library that calculates the exp function of each element of the matrix, by passing columns or rows, and by passing each element of the matrix individually.

Matlab and Octave codes are equal, but Matlab code runs on a remote virtual machine provided by Matlab.

Assembly code is a conventional Taylor algorithm except it does not include constants.

The gcc exp and gcc expf codes are based on functions from the standard mathematical library in C.

The gcc AVX2 code is based on the same algorithm as avx_mathfun. It utilizes range reduction in combination with a Chebyshev approximation-like polynomial to compute 8 exponentials in parallel with AVX2 instructions.


## Comparison of C multithreading codes from different approaches, same base algorithm:

![pi_cam_capture_usb.py](https://github.com/antor44/sigmoid-comparison/blob/main/exp_test3.jpg)


All codes are either based on the same algorithm or share the same relative error within the range of input variables [-5, 5]. The gcc exp (double) and gcc expf (float) codes rely on functions from the standard mathematical library in C, while the gcc SSE2 (4x float) code is based on the well-known [Julien Pommier library](http://gruntthepeon.free.fr/ssemath/). The gcc AVX2 (8x float) is also based on the same algorithm as avx_mathfun.


