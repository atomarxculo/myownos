[org 0x7c00]

    mov bp, 0x8000 ; Establecemos la pila lejos de donde vamos a trabajar nosotros
    mov sp, bp

    mov bx, 0x9000 ; es:bx = 0x0000:0x9000 = 0x09000
    mov dh, 2 ; lee dos sectores
    ; La BIOS configura 'dl' para nuestro disco
    ; Hay que usar la opción '-fda' en qemu: qemu -fda file.bin
    call disk_load

    mov dx,[0x9000] ; Recuperamos la primera palabra cargada, 0xDADA
    call print_hex

    call print_nl

    mov dx, [0x9000 + 512] ; La primera letra palabra del segundo sector cargado, 0xface
    call print_hex

    jmp $

%include "boot_sect_print.asm"
%include "boot_sect_print_hex.asm"
%include "boot_sect_disk.asm"

; Bucle mágico
times 510-($-$$) db 0
dw 0xaa55

; Sector de arranque = sector 1 de cylinder 0 of head 0 of hdd 0
; ahora en sector 2 ...

times 256 dw 0xdada ; sector 2 = 512 bytes
times 256 dw 0xface ; sector 3 = 512 bytes

