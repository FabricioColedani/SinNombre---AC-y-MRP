; fib_nasm64.asm  -- NASM x86_64 Linux, usa llamadas a libc (scanf/printf)
global main
extern printf
extern scanf
section .data
    fmt_in  db "%d",0
    fmt_out db "F(%d) = %llu",10,0
    n_val   dd 0
section .text
main:
    ; prologue
    push rbp
    mov rbp, rsp

    ; scanf("%d", &n_val)
    lea rdi, [rel fmt_in]
    lea rsi, [rel n_val]
    xor rax, rax
    call scanf

    ; cargar n en edi
    mov eax, [rel n_val]
    mov edi, eax       ; edi = n

    cmp edi, 0
    je print_zero
    cmp edi, 1
    je print_one

    ; inicializar a=0, b=1
    xor rax, rax       ; a = 0
    mov rbx, 1         ; b = 1
    mov ecx, 2         ; i = 2
fib_loop:
    cmp ecx, edi
    gt_label:
    ; compare greater: we want while ecx <= edi
    ; implement: if ecx > edi jump done
    cmp ecx, edi
    jg fib_done
    ; c = a + b
    mov rdx, rax
    add rdx, rbx       ; rdx = a + b
    ; a = b
    mov rax, rbx
    ; b = c
    mov rbx, rdx
    inc ecx
    jmp fib_loop

fib_done:
    ; prepare printf format: printf("F(%d) = %llu\n", n, b)
    mov rsi, rbx       ; second arg -> %llu (value)
    mov edi, [rel n_val] ; first arg -> %d
    lea rdi, [rel fmt_out]
    xor rax, rax
    call printf
    jmp done

print_zero:
    mov rsi, 0
    mov edi, [rel n_val]
    lea rdi, [rel fmt_out]
    xor rax, rax
    call printf
    jmp done

print_one:
    mov rsi, 1
    mov edi, [rel n_val]
    lea rdi, [rel fmt_out]
    xor rax, rax
    call printf
    jmp done

done:
    mov eax, 0
    pop rbp
    ret
