[org 0x7c00] ; El inicio de la dirección de memoria del Boot Sector

    mov bp, 0x9000 ; Definimos la pila
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print

    call switch_to_pm
    jmp $ ; Esto en realidad nunca se ejecutará

%include "../main/main_function_print.asm"
%include "32bit-gdt.asm"
%include "32bit-print.asm"
%include "32bit-switch.asm"

[bits 32]
BEGIN_PM: ; Después del cambio llegaremos aquí
    mov ebx, MSG_PROT_MODE
    call print_string_pm ; Se escribirá en la esquina superior izquierda
    jmp $

MSG_REAL_MODE db "Iniciado en modo 16-bit", 0
MSG_PROT_MODE db "Cargado en modo protegido 32-bit", 0

; Bucle mágico que mantiene la consola activa
times 510-($-$$) db 0
dw 0xaa55
