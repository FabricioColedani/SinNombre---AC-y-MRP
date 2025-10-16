    .file   "prime.c"
    .intel_syntax noprefix
    .text
    .globl  main
    .type   main, @function
main:
.LFB0:
    push    rbp
    mov     rbp, rsp
    sub     rsp, 32
    lea     rax, [rbp-8]          ; reserva espacio para 'n'
    mov     rsi, rax
    lea     rdi, .LC0             ; formato "%llu"
    mov     eax, 0
    call    scanf

    cmp     eax, 1
    jne     .Lerr

    mov     rax, QWORD PTR [rbp-8]
    cmp     rax, 2
    jb      .Lnot_prime

    mov     QWORD PTR [rbp-16], 2     ; i = 2
.Lfor:
    mov     rax, QWORD PTR [rbp-16]
    imul    rdx, rax, rax
    cmp     rdx, QWORD PTR [rbp-8]
    ja      .Lprime

    mov     rax, QWORD PTR [rbp-8]
    xor     rdx, rdx
    div     QWORD PTR [rbp-16]
    test    rdx, rdx
    je      .Lnot_prime

    add     QWORD PTR [rbp-16], 1
    jmp     .Lfor

.Lnot_prime:
    lea     rdi, .LC2              ; "El numero NO ES PRIMO"
    mov     eax, 0
    call    printf
    mov     eax, 0
    jmp     .Lend

.Lprime:
    lea     rdi, .LC1              ; "El numero ES PRIMO"
    mov     eax, 0
    call    printf
    mov     eax, 0
    jmp     .Lend

.Lerr:
    lea     rdi, .LC3              ; "Entrada invalida"
    mov     eax, 0
    call    printf
    mov     eax, 1

.Lend:
    leave
    ret

    .section    .rodata
.LC0:
    .string "%llu"
.LC1:
    .string "El numero ES PRIMO"
.LC2:
    .string "El numero NO ES PRIMO"
.LC3:
    .string "Entrada invalida"
