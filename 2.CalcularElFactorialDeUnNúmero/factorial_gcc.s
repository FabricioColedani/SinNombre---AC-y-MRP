	.file	"factorial.c"
	.text
	.section	.rodata
.LC0:
	.string	"Ingrese un numero (0-20): "
.LC1:
	.string	"%d"
.LC2:
	.string	"El factorial de %d es: %llu\n"
	.text
	.globl	main
	.type	main, @function
main:
	pushq	%rbp
	movq	%rsp, %rbp
	subq	$32, %rsp
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$1, -24(%rbp)
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	leaq	-28(%rbp), %rax
	movq	%rax, %rsi
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	__isoc99_scanf@PLT
	movl	-28(%rbp), %eax
	testl	%eax, %eax
	js	.L2
	movl	$1, -32(%rbp)
	jmp	.L3
.L4:
	movl	-32(%rbp), %eax
	movl	%eax, %eax
	imulq	%rax, -24(%rbp)
	addl	$1, -32(%rbp)
.L3:
	movl	-28(%rbp), %eax
	cmpl	%eax, -32(%rbp)
	jle	.L4
	movl	-28(%rbp), %eax
	movq	-24(%rbp), %rdx
	movl	%eax, %esi
	leaq	.LC2(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L2:
	movl	$0, %eax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L6
	call	__stack_chk_fail@PLT
.L6:
	leave
	ret
