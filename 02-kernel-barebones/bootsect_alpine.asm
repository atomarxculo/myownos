[org 0x7c00]
KERNEL_OFFSET equ 0x1000 ; El mismo valor que hemos puesto al vincular el kernel

    mov [BOOT_DRIVE], dl ; La BIOs pone la unidad de arranque en 'dl' al arrancar
    mov bp, 0x9000
    mov sp, bp

    call load_kernel ; Lee el kernel desde el disco
    call switch_to_pm ; Deshabilita interrupciones, carga GDT, etc y salta a 'BEGIN_PM'
    jmp $ ; Nunca es ejecutado

%include "../asm/main/main_function_print.asm"
%include "../asm/main/main_function_print_hex.asm"
%include "../asm/boot_example/boot_sect_disk.asm"
%include "../asm/32-bit/32bit-gdt.asm"
%include "../asm/32-bit/32bit-print.asm"
%include "../asm/32-bit/32bit-switch.asm"

[bits 16]
load_kernel:
    mov bx, KERNEL_OFFSET ; Lee del disco y lo almacena en 0x1000
    mov dh, 2
    mov dl, [BOOT_DRIVE]
    call disk_load
    ret

[bits 32]
BEGIN_PM:
    call print_string_pm
    call KERNEL_OFFSET ; Le damos el control al kernel
    jmp $ ; Se mantiene aquí cuando el kernel nos devuelva el control, si ocurre

BOOT_DRIVE db 0 ; Conviene guardarlo en memoria porque 'dl' puede sobrescribirse

; Bucle mágico que mantiene la consola activa
times 510-($-$$) db 0
dw 0xaa55
