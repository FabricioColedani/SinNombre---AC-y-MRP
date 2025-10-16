section .bss
buffer resb 128

section .text
global _start

_start:
; Leer entrada (stdin)
mov rax, 0 ; sys_read
mov rdi, 0
lea rsi, [buffer]
mov rdx, 128
syscall

xor rbx, rbx        ; suma en BL
mov rcx, rax        ; cantidad de bytes leídos
lea rsi, [buffer]


suma:
cmp rcx, 0
je imprimir
mov al, [rsi]
cmp al, '0'
jb siguiente
cmp al, '9'
ja siguiente
sub al, '0'
add bl, al
siguiente:
inc rsi
dec rcx
jmp suma

imprimir:
; Convertir suma (bl) a carácter
add bl, '0'
mov [buffer], bl
mov rax, 1 ; sys_write
mov rdi, 1 ; stdout
lea rsi, [buffer]
mov rdx, 1
syscall

; Salir
mov rax, 60     ; sys_exit
xor rdi, rdi
syscall
