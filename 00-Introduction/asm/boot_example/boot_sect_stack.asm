mov ah, 0x0e ; Display character

mov bp, 0x8000 ; Es una dirección disponible alejada de la dirección 0x7c00, que no podemos sobreescribir
mov sp, bp ; Si la pila está vacía, entonces sp apunta a bp

; La pila mostrará los elementos del último al primero

push 'A'
push 'B'
push 'C'

; Con lo siguiente mostramos cómo la pila crece hacia abajo
; mov al, [0x7ffe] ; 0x8000 - 2
; int 0x10

; No podremos acceder a [0x8000]. Sólo podremos acceder a la parte superior de la pila, 0x7ffe

; mov al, [0x8000]
; int 0x10

; Con 'pop' podemos recuperar los caracteres de la pila

pop bx
mov al, bl
int 0x10 ; Muestra C

pop bx
mov al, bl
int 0x10 ; Muestra B

pop bx
mov al, bl
int 0x10 ; Muestra A

; Eliminamos los elementos de la pila
mov al, [0x8000]
int 0x10

; Bucle mágico que mantiene la consola activa
jmp $
times 510-($-$$) db 0
dw 0xaa55
