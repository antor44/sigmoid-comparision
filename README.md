# Comparing Sigmoid Calculation Efficiency: Multithreading and Single Threading Across Programming Languages in Low-Level ML Code
---

After researching some codes of main basic algorithms in low-level Machine Learning, such as the logistic regression algorithm, the most computationally expensive function for the processor is the mathematical calculation of the sigmoid function or computing exp on individual elements of a matrix.


## Programming languages comparison, single thread codes, some with different algorithms:

![pi_cam_preview_usb.py](https://github.com/antor44/sigmoid-comparison/blob/main/Test_ML_algorithm.jpg)

Most codes are based on standard mathematical libraries of the corresponding programming language, all relying on the same Taylor algorithm with constants. This holds true at least for positive numbers. However, it may vary slightly in each programming language. For negative numbers, the Taylor algorithm may be replaced by another due to the issue of partial variables with very high values or overflowing. Alternatively, the same algorithm, such as [avx_mathfun](https://github.com/reyoung/avx_mathfun), may be employed, utilizing Taylor with range reduction combined with a Chebyshev-type approximation polynomial to compute 8 exp in parallel with AVX2 instructions. Variations of Taylor may also be used for higher precision variables than double. For [quad precision or 128 bits](https://codebrowser.dev/glibc/glibc/sysdeps/ieee754/ldbl-128/e_expl.c.html), the standard C employs a table-based algorithm using the Abraham Ziv's formula, ['Fast Evaluation of Elementary Mathematical Functions with Correctly Rounded Last Bit'](https://dl.acm.org/doi/abs/10.1145/114697.116813).

Matlab and Octave algorithms are calculated in three modes: by passing an entire matrix to the library that calculates the exp function of each element of the matrix, by passing columns or rows, and by passing each element of the matrix individually.

Matlab and Octave codes are equal, but Matlab code runs on a remote virtual machine provided by Matlab.

Assembly code is a conventional Taylor algorithm except it does not include constants.

The gcc exp and gcc expf codes are based on functions from the standard mathematical library in C.

gcc AVX2 code is based on the same Taylor algorithm with constants, like standard mathematical libraries.


## Comparison of C multithreading codes from different approaches, same base algorithm:

![pi_cam_capture_usb.py](https://github.com/antor44/sigmoid-comparison/blob/main/exp_test3.jpg)

All codes are based on the same Taylor algorithm with constants, same relative error. The gcc exp (double) and gcc expf (float) codes rely on functions from the standard mathematical library in C, while the gcc SSE2 (4x float) code is based on the well-known [Julien Pommier library](http://gruntthepeon.free.fr/ssemath/). The gcc AVX2 (8x float) code also employs the Taylor algorithm with constants, such as avx_mathfun.
