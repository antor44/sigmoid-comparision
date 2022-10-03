	.file	"exp_multi_avx2_echoed_stackoverflow2.c"
	.text
	.p2align 4
	.globl	run
	.type	run, @function
run:
.LFB5309:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	vxorps	%xmm0, %xmm0, %xmm0
	leaq	xv(%rip), %rsi
	leaq	yv(%rip), %rax
	movl	$100000, %r8d
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	andq	$-32, %rsp
	movl	(%rdi), %r9d
	vmovsd	.LC3(%rip), %xmm7
	vmovaps	.LC10(%rip), %ymm15
	vmovaps	.LC11(%rip), %ymm14
	vcvtsi2sdl	%r9d, %xmm0, %xmm0
	vmulsd	.LC0(%rip), %xmm0, %xmm0
	vmovaps	.LC12(%rip), %ymm13
	vmulsd	.LC1(%rip), %xmm0, %xmm0
	imull	$125000, %r9d, %r9d
	vmovaps	.LC13(%rip), %ymm12
	vmovaps	.LC19(%rip), %ymm9
	vmovdqa	.LC20(%rip), %ymm11
	vfmadd132sd	.LC2(%rip), %xmm7, %xmm0
	vmovaps	.LC21(%rip), %ymm10
	movslq	%r9d, %rcx
	leal	125000(%r9), %edi
	salq	$2, %rcx
	addq	%rcx, %rsi
	addq	%rax, %rcx
	vcvtsd2ss	%xmm0, %xmm0, %xmm7
	vmovss	%xmm7, -4(%rsp)
	.p2align 4,,10
	.p2align 3
.L3:
	vmovss	-4(%rsp), %xmm0
	movl	%r9d, %edx
	xorl	%eax, %eax
	vmovaps	%xmm0, %xmm7
	.p2align 4,,10
	.p2align 3
.L2:
	vcvtss2sd	%xmm7, %xmm7, %xmm1
	vaddsd	.LC6(%rip), %xmm1, %xmm2
	addl	$8, %edx
	vaddsd	.LC0(%rip), %xmm1, %xmm3
	vaddsd	.LC4(%rip), %xmm1, %xmm5
	vaddsd	.LC5(%rip), %xmm1, %xmm6
	vaddsd	.LC8(%rip), %xmm1, %xmm4
	vaddsd	.LC9(%rip), %xmm1, %xmm0
	vcvtsd2ss	%xmm2, %xmm2, %xmm8
	vaddsd	.LC7(%rip), %xmm1, %xmm2
	vcvtsd2ss	%xmm3, %xmm3, %xmm3
	vunpcklps	%xmm3, %xmm7, %xmm3
	vcvtsd2ss	%xmm5, %xmm5, %xmm5
	vcvtsd2ss	%xmm6, %xmm6, %xmm6
	vunpcklps	%xmm6, %xmm5, %xmm5
	vaddsd	.LC22(%rip), %xmm1, %xmm1
	vcvtsd2ss	%xmm0, %xmm0, %xmm0
	vcvtsd2ss	%xmm4, %xmm4, %xmm4
	vunpcklps	%xmm0, %xmm4, %xmm4
	vmovlhps	%xmm5, %xmm3, %xmm3
	vcvtsd2ss	%xmm2, %xmm2, %xmm2
	vunpcklps	%xmm2, %xmm8, %xmm2
	vmovlhps	%xmm4, %xmm2, %xmm0
	vmovaps	.LC14(%rip), %ymm4
	vcvtsd2ss	%xmm1, %xmm1, %xmm7
	vinsertf128	$0x1, %xmm0, %ymm3, %ymm3
	vminps	%ymm15, %ymm3, %ymm0
	vmovaps	%ymm3, (%rsi,%rax)
	vmaxps	%ymm14, %ymm0, %ymm0
	vmulps	%ymm13, %ymm0, %ymm2
	vroundps	$8, %ymm2, %ymm2
	vfnmadd231ps	%ymm12, %ymm2, %ymm0
	vcvttps2dq	%ymm2, %ymm2
	vpaddd	%ymm11, %ymm2, %ymm2
	vfmadd213ps	.LC15(%rip), %ymm0, %ymm4
	vpslld	$23, %ymm2, %ymm2
	vfmadd213ps	.LC16(%rip), %ymm0, %ymm4
	vfmadd213ps	.LC17(%rip), %ymm0, %ymm4
	vfmadd213ps	.LC18(%rip), %ymm0, %ymm4
	vmulps	%ymm0, %ymm0, %ymm5
	vfmadd132ps	%ymm0, %ymm9, %ymm4
	vfmadd231ps	%ymm4, %ymm5, %ymm0
	vaddps	%ymm10, %ymm0, %ymm0
	vmulps	%ymm2, %ymm0, %ymm2
	vmovaps	%ymm2, (%rcx,%rax)
	addq	$32, %rax
	cmpl	%edx, %edi
	jg	.L2
	decl	%r8d
	jne	.L3
	xorl	%eax, %eax
	vzeroupper
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE5309:
	.size	run, .-run
	.p2align 4
	.globl	exp256_ps
	.type	exp256_ps, @function
exp256_ps:
.LFB5308:
	.cfi_startproc
	endbr64
	vminps	.LC10(%rip), %ymm0, %ymm0
	vmaxps	.LC11(%rip), %ymm0, %ymm0
	vmulps	.LC12(%rip), %ymm0, %ymm1
	vmovaps	.LC14(%rip), %ymm2
	vroundps	$8, %ymm1, %ymm1
	vfnmadd231ps	.LC13(%rip), %ymm1, %ymm0
	vcvttps2dq	%ymm1, %ymm1
	vpaddd	.LC20(%rip), %ymm1, %ymm1
	vfmadd213ps	.LC15(%rip), %ymm0, %ymm2
	vfmadd213ps	.LC16(%rip), %ymm0, %ymm2
	vpslld	$23, %ymm1, %ymm1
	vfmadd213ps	.LC17(%rip), %ymm0, %ymm2
	vfmadd213ps	.LC18(%rip), %ymm0, %ymm2
	vmulps	%ymm0, %ymm0, %ymm3
	vfmadd213ps	.LC19(%rip), %ymm0, %ymm2
	vfmadd231ps	%ymm2, %ymm3, %ymm0
	vaddps	.LC21(%rip), %ymm0, %ymm0
	vmulps	%ymm1, %ymm0, %ymm0
	ret
	.cfi_endproc
.LFE5308:
	.size	exp256_ps, .-exp256_ps
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC23:
	.string	"Couldn't allocate memory for thread arg.\n"
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC24:
	.string	"x=%.20f, e^x=%.20f\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB5310:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	leaq	run(%rip), %r13
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	xorl	%ebp, %ebp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	subq	$88, %rsp
	.cfi_def_cfa_offset 128
	movq	%fs:40, %rax
	movq	%rax, 72(%rsp)
	xorl	%eax, %eax
	movq	%rsp, %rbx
	movq	%rbx, %r12
	.p2align 4,,10
	.p2align 3
.L11:
	movl	$4, %edi
	call	malloc@PLT
	movq	%rax, %rcx
	testq	%rax, %rax
	je	.L19
	movl	%ebp, (%rax)
	movq	%r12, %rdi
	movq	%r13, %rdx
	xorl	%esi, %esi
	incl	%ebp
	addq	$8, %r12
	call	pthread_create@PLT
	cmpl	$8, %ebp
	jne	.L11
	leaq	64(%rbx), %rbp
	.p2align 4,,10
	.p2align 3
.L12:
	movq	(%rbx), %rdi
	xorl	%esi, %esi
	addq	$8, %rbx
	call	pthread_join@PLT
	cmpq	%rbp, %rbx
	jne	.L12
	leaq	yv(%rip), %rbx
	vxorps	%xmm2, %xmm2, %xmm2
	leaq	xv(%rip), %rbp
	leaq	4000000(%rbx), %r13
	leaq	.LC24(%rip), %r12
	.p2align 4,,10
	.p2align 3
.L13:
	vcvtss2sd	(%rbx), %xmm2, %xmm1
	movq	%r12, %rsi
	movl	$1, %edi
	movl	$2, %eax
	addq	$4, %rbx
	vcvtss2sd	0(%rbp), %xmm2, %xmm0
	addq	$4, %rbp
	call	__printf_chk@PLT
	cmpq	%r13, %rbx
	vxorps	%xmm2, %xmm2, %xmm2
	jne	.L13
	movq	72(%rsp), %rax
	xorq	%fs:40, %rax
	jne	.L20
	addq	$88, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L19:
	.cfi_restore_state
	movq	stderr(%rip), %rcx
	movl	$41, %edx
	movl	$1, %esi
	leaq	.LC23(%rip), %rdi
	call	fwrite@PLT
	movl	$1, %edi
	call	exit@PLT
.L20:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE5310:
	.size	main, .-main
	.local	yv
	.comm	yv,4000000,32
	.local	xv
	.comm	xv,4000000,32
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC0:
	.long	2296604913
	.long	1055193269
	.align 8
.LC1:
	.long	0
	.long	1093567616
	.align 8
.LC2:
	.long	0
	.long	1069547520
	.align 8
.LC3:
	.long	0
	.long	-1072431104
	.align 8
.LC4:
	.long	2296604913
	.long	1056241845
	.align 8
.LC5:
	.long	1297423721
	.long	1056929040
	.align 8
.LC6:
	.long	2296604913
	.long	1057290421
	.align 8
.LC7:
	.long	3944497965
	.long	1057634018
	.align 8
.LC8:
	.long	1297423721
	.long	1057977616
	.align 8
.LC9:
	.long	3620142034
	.long	1058167198
	.section	.rodata.cst32,"aM",@progbits,32
	.align 32
.LC10:
	.long	1118879909
	.long	1118879909
	.long	1118879909
	.long	1118879909
	.long	1118879909
	.long	1118879909
	.long	1118879909
	.long	1118879909
	.align 32
.LC11:
	.long	3266363557
	.long	3266363557
	.long	3266363557
	.long	3266363557
	.long	3266363557
	.long	3266363557
	.long	3266363557
	.long	3266363557
	.align 32
.LC12:
	.long	1069066811
	.long	1069066811
	.long	1069066811
	.long	1069066811
	.long	1069066811
	.long	1069066811
	.long	1069066811
	.long	1069066811
	.align 32
.LC13:
	.long	1060205080
	.long	1060205080
	.long	1060205080
	.long	1060205080
	.long	1060205080
	.long	1060205080
	.long	1060205080
	.long	1060205080
	.align 32
.LC14:
	.long	961571175
	.long	961571175
	.long	961571175
	.long	961571175
	.long	961571175
	.long	961571175
	.long	961571175
	.long	961571175
	.align 32
.LC15:
	.long	985088974
	.long	985088974
	.long	985088974
	.long	985088974
	.long	985088974
	.long	985088974
	.long	985088974
	.long	985088974
	.align 32
.LC16:
	.long	1007192328
	.long	1007192328
	.long	1007192328
	.long	1007192328
	.long	1007192328
	.long	1007192328
	.long	1007192328
	.long	1007192328
	.align 32
.LC17:
	.long	1026206145
	.long	1026206145
	.long	1026206145
	.long	1026206145
	.long	1026206145
	.long	1026206145
	.long	1026206145
	.long	1026206145
	.align 32
.LC18:
	.long	1042983594
	.long	1042983594
	.long	1042983594
	.long	1042983594
	.long	1042983594
	.long	1042983594
	.long	1042983594
	.long	1042983594
	.align 32
.LC19:
	.long	1056964608
	.long	1056964608
	.long	1056964608
	.long	1056964608
	.long	1056964608
	.long	1056964608
	.long	1056964608
	.long	1056964608
	.align 32
.LC20:
	.long	127
	.long	127
	.long	127
	.long	127
	.long	127
	.long	127
	.long	127
	.long	127
	.align 32
.LC21:
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.long	1065353216
	.section	.rodata.cst8
	.align 8
.LC22:
	.long	2296604913
	.long	1058338997
	.ident	"GCC: (Ubuntu 9.3.0-17ubuntu1~20.04) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
