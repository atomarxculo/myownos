mov ah, 0x0e ; Display character
mov al, 'H'
int 0x10
mov al, 'o'
int 0x10
mov al, 'l'
int 0x10
mov al, 'a'
int 0x10
mov al, ' '
int 0x10
mov al, 'S'
int 0x10
mov al, 'a'
int 0x10
mov al, 'm'
int 0x10
mov al, 'u'
int 0x10
mov al, 'e'
int 0x10
mov al, 'l'
int 0x10

jmp $ ; Realiza un salto al espacio de memoria actual

; Con estas dos líneas, hacemos que cree un bucle y que el sistemas siempre se esté ejecutando
times 510-($-$$) db 0 ; Times repite una acción n veces. DB (define byte 0), añade uno o mas bytes al codigo binario
dw 0xaa55
