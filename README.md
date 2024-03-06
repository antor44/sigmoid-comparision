# Comparing Sigmoid Calculation Efficiency: Multithreading and Single Threading Across Programming Languages in Low-Level ML Code
---

## Programming languages comparison, single thread codes, some with different algorithms:

![pi_cam_preview_usb.py](https://github.com/antor44/sigmoid-comparison/blob/main/Test_ML_algorithm.jpg)

Most codes are based on standard mathematical libraries of the corresponding programming language, all relying on the same Taylor algorithm with constants, but they may vary slightly in each programming language.

Matlab and Octave algorithms are calculated in three modes: by passing an entire matrix to the library that calculates the exp function of each element of the matrix, by passing columns or rows, and by passing each element of the matrix individually.

Matlab and Octave codes are equal, but Matlab code runs on a remote virtual machine provided by Matlab.

Assembly code is a conventional Taylor algorithm except it does not include constants.

The gcc exp and gcc expf codes are based on functions from the standard mathematical library in C.

gcc AVX2 code is based on the same Taylor algorithm with constants, like standard mathematical libraries.


## Comparison of C multithreading codes from different approaches, same base algorithm:

![pi_cam_capture_usb.py](https://github.com/antor44/sigmoid-comparison/blob/main/exp_test3.jpg)

All codes are based on the same Taylor algorithm with constants, same relative error. The gcc exp and gcc expf codes rely on functions from the standard mathematical library in C, while the gcc SSE2 (4x float) code is based on the well-known [Julien Pommier library](http://gruntthepeon.free.fr/ssemath/). The gcc AVX2 (8x float) code also employs the Taylor algorithm with constants, same as standard mathematical libraries.
