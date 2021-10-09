mov ah, 0x0e
mov al, 'H'
int 0x10
mov ah, 0x0e
mov al, 'o'
int 0x10
mov ah, 0x0e
mov al, 'l'
int 0x10
; int 0x10
; Si pones dos veces la interrupción, pinta dos veces el caracter
mov ah, 0x0e
mov al, 'a'
int 0x10
mov ah, 0x0e
mov al, ' '
int 0x10
mov ah, 0x0e
mov al, 'S'
int 0x10
mov ah, 0x0e
mov al, 'a'
int 0x10
mov ah, 0x0e
mov al, 'm'
int 0x10
mov ah, 0x0e
mov al, 'u'
int 0x10
mov ah, 0x0e
mov al, 'e'
int 0x10
mov ah, 0x0e
mov al, 'l'
int 0x10


jmp $ ; Realiza un salto al espacio de memoria actual

; Con estas dos líneas, hacemos que cree un bucle y que el sistemas siempre se esté ejecutando

times 510-($-$$) db 0 ; Times repite una acción n veces. DB (define byte 0), añade uno o mas bytes al codigo binario
db 0x55, 0xaa
