gdt_start: ; No se puede quitar las etiquetas, son necesarias para calcular tamaños y saltos
    ; GDT comienza con 8-byte nulos
    dd 0x0 ; 4 bytes
    dd 0x0 ; 4 bytes

; base = 0x0, limite = 0xfffff
; Para más detalles, pág. 36 os-dev.pdf
gdt_code:
    dw 0xffff      ; limite, bits 0-15
    dw 0x0          ; base, bits 0-15
    db 0x0          ; base, bits 16-23
    db 10011010b    ; flag 8 bits
    db 11001111b    ; flag 4 bits, limite, bits 16-19
    db 0x0          ; base, bits 24-31

; El codigo es el mismo, sólo cambia alguna flag
gdt_data:
    dw 0xffff      ; limite, bits 0-15
    dw 0x0          ; base, bits 0-15
    db 0x0          ; base, bits 16-23
    db 10010010b    ; flag 8 bits
    db 11001111b    ; flag 4 bits, limite, bits 16-19
    db 0x0          ; base, bits 24-31

gdt_end:

gdt_descriptor:
    dw gdt_end - gdt_start -1 ; tamaño 16 bit, siempre al menos 1 es de su verdadero tamaño
    dd gdt_start ; direccion 32 bit

; constantes para posterior uso
CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start