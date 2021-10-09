[org 0x7c00]

mov bx, HELLO
call print

jmp $

%include "main_function_print.asm"

HELLO:
    db 'Hello World', 0

; Bucle mágico que mantiene la consola activa
times 510-($-$$) db 0
dw 0xaa55
