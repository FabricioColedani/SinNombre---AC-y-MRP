; =============================================
; Cálculo del factorial en Turbo Assembler (DOS)
; =============================================

.model small
.stack 100h

.data
msg1    db 'Ingrese un numero (0-8): $'
msg2    db 13,10,'El factorial es: $'
numero  db ?
result  dw 1
buffer  db 6 dup('$')

.code
main proc
    mov ax, @data
    mov ds, ax
    
    ; Mostrar mensaje para ingresar número
    mov ah, 09h
    lea dx, msg1
    int 21h
    
    ; Leer número desde teclado
    mov ah, 01h
    int 21h
    sub al, '0'      ; Convertir ASCII a número
    mov numero, al
    
    ; Calcular factorial
    call calcular_factorial
    
    ; Mostrar resultado
    mov ah, 09h
    lea dx, msg2
    int 21h
    
    ; Convertir resultado a ASCII y mostrar
    mov ax, result
    call mostrar_numero
    
    ; Salir del programa
    mov ah, 4Ch
    int 21h
main endp

; =============================================
; PROCEDIMIENTO: calcular_factorial
; =============================================
calcular_factorial proc
    mov cl, numero
    cmp cl, 0
    je fin_factorial    ; Si es 0, factorial = 1
    
    mov ax, 1           ; Inicializar resultado en 1
    mov bl, 1           ; Contador i = 1
    
ciclo:
    mul bl              ; AX = AX * BL (factorial * i)
    inc bl              ; i = i + 1
    cmp bl, cl          ; ¿i <= número?
    jbe ciclo           ; Si sí, continuar ciclo
    
fin_factorial:
    mov result, ax      ; Guardar resultado
    ret
calcular_factorial endp

; =============================================
; PROCEDIMIENTO: mostrar_numero
; =============================================
mostrar_numero proc
    mov bx, 10
    mov cx, 0
    
convertir:
    mov dx, 0
    div bx
    push dx
    inc cx
    cmp ax, 0
    jne convertir
    
mostrar:
    pop dx
    add dl, '0'
    mov ah, 02h
    int 21h
    loop mostrar
    
    ret
mostrar_numero endp

end main
