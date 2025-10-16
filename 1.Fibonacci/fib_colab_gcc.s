        .file   "fib_colab.c"
        .section .rodata
.LC0:
        .string "Ingrese n: "
.LC1:
        .string "F(%d) = %llu\n"
        .text
        .globl  main
        .type   main, @function
main:
        push    rbp
        mov     rbp, rsp
        sub     rsp, 32           # reservar espacio local

        # printf("Ingrese n: ");
        lea     rdi, .LC0
        xor     eax, eax
        call    printf

        # scanf("%d", &n)
        lea     rsi, [rbp - 4]
        lea     rdi, .LC_SCANF_FMT  # supuesto símbolo con "%d"
        xor     eax, eax
        call    scanf

        # cargar n en eax
        mov     eax, [rbp - 4]
        mov     esi, eax            # parámetro de printf después

        # casos n == 0 o n == 1
        cmp     eax, 0
        je      .Lprint_zero
        cmp     eax, 1
        je      .Lprint_one

        # inicialización: a = 0, b = 1, i = 2
        mov     QWORD PTR [rbp - 16], 0    # a
        mov     QWORD PTR [rbp - 8], 1     # b
        mov     ecx, 2                     # contador i

.Lloop:
        cmp     ecx, [rbp - 4]             # si i > n ?
        jg      .Ldone
        # c = a + b
        mov     rax, QWORD PTR [rbp - 16]  # rax = a
        add     rax, QWORD PTR [rbp - 8]   # rax = a + b
        # desplazar
        mov     QWORD PTR [rbp - 16], QWORD PTR [rbp - 8]  # a = b
        mov     QWORD PTR [rbp - 8], rax                    # b = c
        inc     ecx
        jmp     .Lloop

.Ldone:
        # imprimir resultado: printf("F(%d) = %llu\n", n, b)
        mov     rsi, QWORD PTR [rbp - 8]   # b como argumento
        mov     edi, [rbp - 4]             # n como primer argumento
        lea     rdi, .LC1
        xor     eax, eax
        call    printf
        jmp     .Lexit

.Lprint_zero:
        mov     esi, 0
        mov     edi, [rbp - 4]
        lea     rdi, .LC1
        xor     eax, eax
        call    printf
        jmp     .Lexit

.Lprint_one:
        mov     esi, 1
        mov     edi, [rbp - 4]
        lea     rdi, .LC1
        xor     eax, eax
        call    printf
        jmp     .Lexit

.Lexit:
        mov     eax, 0
        leave
        ret

        .size   main, .-main
