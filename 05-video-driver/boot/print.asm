print:
    pusha

start:
    mov al, [bx]
    cmp al, 0
    je done

    mov ah, 0x0e
    int 0x10

    add bx, 1
    jmp start  

done:
    popa
    ret

print_nl:
    pusha

    mov ah, 0x0e
    mov al, 0x0a ; nueva linea
    int 0x10
    mov al, 0x0d ; salto de linea
    int 0x10

    popa
    ret
