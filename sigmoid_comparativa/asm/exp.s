# Taylor: exp(x) = 1 + x + x^2/2 + x^3/6 + x^4/24 + ...
# gcc exp.s -no-pie

.section .data

XXX:        .double   -5
INIT:       .double   1
COUNT:      .int      30
MAXSIZE:    .int      999999
REIT:       .int      100
INC:        .double   0.00001
xv:         .fill     8000000
yv:         .fill     8000000
STOR:       .int      0

format:     .asciz    "x=%lf, e^x=%.20lf\n"

.extern     printf

.section .text
.globl main

main:
    movq %rsp, %rbp #for correct debugging

#Taylor

      movl   REIT, %r11d
loop:
      movsd  XXX, %xmm0    # x in xmm0
      movl   MAXSIZE, %edx


iteration:
      movsd  INIT, %xmm1   # init factorial
      movsd  INIT, %xmm2   # init power series
      movsd  INIT, %xmm3   # init Taylor series
      movl   COUNT, %ecx   # countdown
      xor    %ebx, %ebx    # init factorial loop

top:
      incl   %ebx

#factorial

factorial:
      cmp   $1, %ebx         # n<=1 ?
      je    cont

      cvtsi2sd %ebx, %xmm4
      mulsd %xmm4, %xmm1     # n* factorial(n-1)

cont:
      mulsd  %xmm0, %xmm2    # x^y
      movsd  %xmm2, %xmm4
      divsd  %xmm1, %xmm4
      addsd  %xmm4, %xmm3    # update Taylor series
      decl   %ecx
      jnz    top

      # store array
      movsd  %xmm0, xv(,%edx,8)
      movsd  %xmm3, yv(,%edx,8)

      addsd  INC, %xmm0
      decl   %edx
      jnz    iteration


      movl   MAXSIZE, %ebx
      movl   %r11d, STOR

output:
      push   %rbp            # Push stack
      mov    $format, %rdi   # first arg, format
      movsd  xv(,%ebx,8), %xmm0    # first double xmm0
      movsd  yv(,%ebx,8), %xmm1    # second double
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
