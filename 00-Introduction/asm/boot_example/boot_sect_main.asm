[org 0x7c00]

mov bx, HELLO
call print

call print_nl

mov bx, GOODBYE
call print

call print_nl

jmp $

; Incluimos los ficheros
%include "boot_sect_print.asm"

; Podemos definir cadenas de texto como bytes, pero hay que terminar con un byte nulo (como en C)
HELLO:
    db 'Hola Samuel', 0

GOODBYE:
    db 'Adios', 0

; Bucle mágico que mantiene la consola activa

times 510-($-$$) db 0
dw 0xaa55
