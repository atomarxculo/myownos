disk_load:
    pusha

    push dx

    mov ah, 0x02 ; Se encarga de leer sectores
    mov al, dh ; <- Numero de sectores para leer (0x01 .. 0x80)
    mov cl, 0x02 ; cl <- sector (0x01 .. 0x11)
                 ; 0x01 es nuestro sector de arranque, 0x02 es el primer sector disponible   
    mov ch, 0x00 ; ch <- Cilindro (0x0 .. 0x3FF, 2 bits por encima de 'cl')
    ; dl <- drive number. Lo configura como un parametro y lo toma de la BIOS
    ; (0 =  floppy, 1 = floppy2, 0x80 = hdd, 0x81 = hdd2)
    mov dh, 0x00 ; dh <- head number (0x0 .. 0xF)

    ; [es:bx] Puntero al búfer donde se almacenarán los datos
    int 0x13     ; Interrupción de la BIOS
    jc disk_error ; Hace el 'jmp' si hay carry

    pop dx
    cmp al, dh ; Compara dos operandos
    jne sectors_error ; Hace el 'jmp' cuando el valor no sea igual o no sea 0
    popa
    ret

disk_error:
    mov bx, DISK_ERROR
    call print
    call print_nl
    mov dh, ah ; ah =  codigo de error, dl = La unidad de disco que ha dado el error
    call print_hex
    jmp disk_loop

sectors_error:
    mov bx, SECTORS_ERROR
    call print

disk_loop:
    jmp $

DISK_ERROR: db 'Error en la lectura del disco', 0
SECTORS_ERROR: db 'Numero incorrecto de sectores leídos', 0
