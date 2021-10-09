[org 0x7c00] ; El inicio de la dirección de memoria del Boot Sector

mov ah, 0x0e


; Metodo 1
mov al, "1"
int 0x10
mov al, the_secret
int 0x10

; Metodo 2. Si utilizas el org 0x7c00 funciona, el resto no

mov al, "2"
int 0x10
mov al, [the_secret]
int 0x10

; Metodo 3. La dirección de memoria del Boot Sector es 0x7c00

mov al, "3"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10

; Metodo 4. El menos eficiente, tienes que saber el byte donde se encuentra el secret cada vez que cambias el código

mov al, "4"
int 0x10
mov bx, the_secret
add bx, 0x7c00
mov al, [bx]
int 0x10


the_secret:
    db "X"

jmp $ 
times 510-($-$$) db 0 
db 0x55, 0xaa