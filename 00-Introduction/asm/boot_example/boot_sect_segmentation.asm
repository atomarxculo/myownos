; No funciona

mov ah, 0x0e ; Display character

mov al, [the_secret]
int 0x10 ; Esto así no va a funcionar, habría que definir el [org 0x7c00]

mov bx, 0x7c00 ; Nos posicionamos ahí
mov ds, bx
; Aquí se hace una advertencia que no entiendo. "WARNING: from now on all memory references will be offset by 'ds' implicitly"
mov al, [the_secret]
int 0x10

mov al, [es:the_secret]
int 0x10 ; No va a funcionar porque la posición de 'es' actualmente es 0x000

mov bx, 0x7c00
mov es, bx
mov al, [es:the_secret]
int 0x10

jmp $

the_secret:
    db "X"

times 510-($-$$) db 0
dw 0xaa55
