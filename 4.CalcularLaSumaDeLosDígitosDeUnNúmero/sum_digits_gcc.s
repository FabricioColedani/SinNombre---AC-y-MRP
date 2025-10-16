.intel_syntax noprefix
.file "sum_digits.c"
.text
.section .rodata.str1.1,"aMS",@progbits,1
.LC0:
.string "%d\n" ; Formato para printf

.section .text.startup,"ax",@progbits
.p2align 4
.globl main
.type main, @function
main:
.LFB0:
.cfi_startproc
push rbx
.cfi_def_cfa_offset 16
.cfi_offset 3, -16
sub rsp, 128 ; Reservar espacio local (para buf[128])
mov esi, 128 ; longitud del buffer
lea rdi, [rsp] ; rdi apunta a buf
call fgets@PLT ; fgets(buf, 128, stdin)
test rax, rax
je .Lend ; Si fgets devuelve NULL → error

xor	ebx, ebx              ; suma = 0
mov	rax, rsp              ; rax apunta a buf


.Lloop:
movzx edx, byte ptr [rax]
test dl, dl
je .Ldone ; fin de cadena
call __ctype_b_loc@PLT
mov rcx, qword ptr [rax]
movzx eax, dl
test byte ptr [rcx+rax*2+1], 8 ; ¿Es dígito? (bitmask)
je .Lskip
sub dl, '0'
add bl, dl
.Lskip:
inc rax
jmp .Lloop

.Ldone:
movzx esi, bl
lea rdi, .LC0[rip]
xor eax, eax
call printf@PLT

.Lend:
add rsp, 128
pop rbx
ret
.cfi_endproc

.size main, .-main
.ident "GCC: (Debian 12.2.0) 12.2.0"
.section .note.GNU-stack,"",@progbits