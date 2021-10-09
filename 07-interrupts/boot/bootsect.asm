; Este código se podría reducir muchas líneas si no tuviera tantos print
[org 0x7c00]
KERNEL_OFFSET equ 0x1000 ; El mismo valor que hemos puesto al vincular el kernel

    mov [BOOT_DRIVE], dl ; La BIOs pone la unidad de arranque en 'dl' al arrancar
    mov bp, 0x9000
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print
    call print_nl

    call load_kernel ; Lee el kernel desde el disco
    call switch_to_pm ; Deshabilita interrupciones, carga GDT, etc y salta a 'BEGIN_PM'
    jmp $ ; Nunca es ejecutado

%include "boot/print.asm"
%include "boot/print_hex.asm"
%include "boot/disk.asm"
%include "boot/gdt.asm"
%include "boot/32bit-print.asm"
%include "boot/switch.asm"

[bits 16]
load_kernel:
    mov bx, MSG_LOAD_KERNEL
    call print
    call print_nl

    mov bx, KERNEL_OFFSET ; Lee del disco y lo almacena en 0x1000
    mov dh, 16
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[bits 32]
BEGIN_PM:
    mov ebx, MSG_PROT_MODE
    call print_string_pm
    call KERNEL_OFFSET ; Le damos el control al kernel
    jmp $ ; Se mantiene aquí cuando el kernel nos devuelva el control, si ocurre

; Mensajes que se van a imprimir

BOOT_DRIVE db 0 ; Conviene guardarlo en memoria porque 'dl' puede sobrescribirse
MSG_REAL_MODE db "Iniciado en modo 16-bit", 0
MSG_PROT_MODE db "Cargado en modo protegido 32-bit", 0
MSG_LOAD_KERNEL db "Cargando el kernel en memoria", 0

; Bucle mágico que mantiene la consola activa
times 510-($-$$) db 0
dw 0xaa55
