.model small
.stack 100h
.data
buf db 10,?,10 dup(?) ; Entrada (máx 10 caracteres)
.code
main proc
mov ax, @data
mov ds, ax

mov ah, 0Ah         ; Leer cadena desde teclado
lea dx, buf
int 21h

lea si, buf+2       ; apuntar al primer carácter
mov cl, [buf+1]     ; número de caracteres ingresados
xor bx, bx          ; suma en BX


suma:
cmp cl, 0
je mostrar
mov al, [si]
cmp al, '0'
jb skip
cmp al, '9'
ja skip
sub al, '0'
add bl, al
skip:
inc si
dec cl
jmp suma

mostrar:
add bl, '0'
mov dl, bl
mov ah, 02h
int 21h

mov ah, 4Ch
int 21h


main endp
end main
