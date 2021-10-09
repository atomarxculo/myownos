print:
    pusha ; Inserta todos los registros en la pila (En el siguiente orden: AX, CX, DX, BX, SP, BP, SI, DI)

; Hay que tener esto en cuenta. Es como un bucle while:
; while (string[i] !=0) { print string[i]; i++ }

start:
    mov al, [bx] ; 'bx' es la dirección base para esta cadena
    cmp al, 0 ; Compara dos operandos, se utiliza en ejecuciones condicionales como hacemos más abajo
    je done ; Es parecido a la función 'jmp', es como un 'if' que el valor que espera es 0

    ; Mostramos esta parte con ayuda de la BIOS
    mov ah, 0x0e
    int 0x10 ; 'al' ya contiene el caracter

    ; incrementa el puntero y hace el siguiente loop
    add bx, 1
    jmp start

done:
    popa
    ret

print_nl:
    pusha

    mov ah, 0x0e
    mov al, 0x0a ; nueva linea
    int 0x10
    mov al, 0x0d ; salto de linea
    int 0x10

    popa
    ret
