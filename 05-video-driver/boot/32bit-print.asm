; No podemos llamarla desde el boot loader.
[bits 32] ; Usamos el modo protegido de 32-bit

; Las constantes definidas

VIDEO_MEMORY equ 0xb8000
WHITE_ON_BLACK equ 0x0f ; el byte de color para cada carácter

print_string_pm:
    pusha
    mov edx, VIDEO_MEMORY

print_string_pm_loop:
    mov al, [ebx] ; [ebx] es la dirección de memoria de nuestro caracter
    mov ah, WHITE_ON_BLACK

    cmp al, 0 ; comprueba si es el final de la cadena
    je print_string_pm_done

    mov [edx], ax ; caracter almacenado + el atributo en la memoria de video
    add ebx, 1 ; siguiente carácter
    add edx, 2 ; siguiente posicion en la memoria de video

    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret
