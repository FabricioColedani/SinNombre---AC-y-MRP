; =============================================
; Cálculo del factorial en NASM (Linux, 32 bits)
; =============================================

section .data
    msg1    db 'Ingrese un numero (0-8): ', 0
    len1    equ $ - msg1
    msg2    db 'El factorial es: ', 0
    len2    equ $ - msg2
    newline db 10, 0

section .bss
    numero  resb 1
    result  resw 1
    buffer  resb 6

section .text
    global _start

_start:
    ; Mostrar mensaje para ingresar número
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80
    
    ; Leer número desde teclado
    mov eax, 3
    mov ebx, 0
    mov ecx, numero
    mov edx, 1
    int 0x80
    
    ; Convertir ASCII a número
    mov al, [numero]
    sub al, '0'
    mov [numero], al
    
    ; Calcular factorial
    call calcular_factorial
    
    ; Mostrar "El factorial es: "
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80
    
    ; Mostrar resultado
    mov ax, [result]
    call mostrar_numero
    
    ; Nueva línea
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    
    ; Salir
    mov eax, 1
    mov ebx, 0
    int 0x80

calcular_factorial:
    mov cl, [numero]
    cmp cl, 0
    je .fin
    
    mov eax, 1
    mov bl, 1
    
.ciclo:
    mul bl
    inc bl
    cmp bl, cl
    jbe .ciclo
    
.fin:
    mov [result], ax
    ret

mostrar_numero:
    mov ebx, 10
    mov ecx, 0
    
.convertir:
    mov edx, 0
    div ebx
    push edx
    inc ecx
    cmp eax, 0
    jne .convertir
    
.mostrar:
    pop edx
    add dl, '0'
    mov [buffer], dl
    
    mov eax, 4
    mov ebx, 1
    mov ecx, buffer
    mov edx, 1
    int 0x80
    
    loop .mostrar
    ret
