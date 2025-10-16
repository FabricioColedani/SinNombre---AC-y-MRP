; prime_nasm64.asm - Determina si un numero es primo (NASM, x86-64 linux)
; Compilar: nasm -f elf64 prime_nasm64.asm -o prime.o
; Link:    gcc prime.o -o prime

global main
extern printf
extern scanf
section .data
    fmt_in  db "%llu",0
    fmt_out1 db "El numero ES PRIMO",10,0
    fmt_out2 db "El numero NO ES PRIMO",10,0

section .bss
    num resq 1

section .text
main:
    ; prologue
    push rbp
    mov rbp, rsp

    ; scanf("%llu", &num)
    lea rdi, [rel fmt_in]
    lea rsi, [rel num]
    xor rax, rax
    call scanf

    ; cargar numero en rax
    mov rax, [rel num]      ; rax = n
    cmp rax, 2
    jae .check_loop
    ; n < 2 -> no primo
    lea rdi, [rel fmt_out2]
    xor rax, rax
    call printf
    jmp .done

.check_loop:
    mov rcx, 2              ; i = 2
.loop:
    ; if i*i > n -> es primo
    mov rdx, rcx
    imul rdx, rcx           ; rdx = rcx*rcx
    cmp rdx, rax
    ja .is_prime

    ; if n % i == 0 -> not prime
    mov rbx, rcx
    xor rdx, rdx            ; clear rdx for div
    mov rax, [rel num]      ; dividend in rax
    xor rdx, rdx
    div rbx                 ; quotient in rax, remainder in rdx
    cmp rdx, 0
    je .not_prime

    inc rcx
    jmp .loop

.is_prime:
    lea rdi, [rel fmt_out1]
    xor rax, rax
    call printf
    jmp .done

.not_prime:
    lea rdi, [rel fmt_out2]
    xor rax, rax
    call printf

.done:
    mov eax, 0
    ; epilogue
    mov rsp, rbp
    pop rbp
    ret
