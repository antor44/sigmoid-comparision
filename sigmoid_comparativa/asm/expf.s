# Taylor: exp(x) = 1 + x + x^2/2 + x^3/6 + x^4/24 + ...


.section .data

XXX:        .float    1
INIT:       .float    1
COUNT:      .int      10
MAXSIZE:    .int      9
REIT:       .int      1
INC:        .float    0.00001
xv:         .fill     8000000
yv:         .fill     8000000
STOR:       .int      0

format:     .asciz    "x=%f, e^x=%.20f\n"

.extern     printf

.section .text
.globl main

main:

#Taylor

      movl   REIT, %r11d
loop:
      movss  XXX, %xmm0    # x in xmm0
      movl   MAXSIZE, %edx


iteration:
      movss  INIT, %xmm1   # init factorial
      movss  INIT, %xmm2   # init power series
      movss  INIT, %xmm3   # init Taylor series
      movl   COUNT, %ecx   # countdown
      xor    %ebx, %ebx    # init factorial loop

top:
      incl   %ebx

#factorial

factorial:
      cmp   $1, %ebx         # n<=1 ?
      je    cont

      cvtsi2ss %ebx, %xmm4
      mulss %xmm4, %xmm1     # n* factorial(n-1)

cont:
      mulss  %xmm0, %xmm2    # x^y
      movss  %xmm2, %xmm4
      divss  %xmm1, %xmm4
      addss  %xmm4, %xmm3    # update Taylor series
      decl   %ecx
      jnz    top

      # store array
      movss  %xmm0, xv(,%edx,8)
      movss  %xmm3, yv(,%edx,8)

      addss  INC, %xmm0
      decl   %edx
      jnz    iteration


      movl   MAXSIZE, %ebx
      movl   %r11d, STOR

output:
      push   %rbp            # Push stack
      mov    $format, %rdi   # first arg, format
      movss  xv(,%ebx,8), %xmm0    # first double xmm0
      movss  yv(,%ebx,8), %xmm1    # second double
      mov    $2, %rax        # 2 xmm
      call   printf
      pop    %rbp

      decl   %ebx
      jnz    output

      movl   STOR, %r11d
      decl   %r11d
      jnz    loop


      movl   $1, %eax        #exit
      movl   $0, %ebx
      int    $0x80
