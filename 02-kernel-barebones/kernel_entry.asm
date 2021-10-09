[bits 32]
[extern main] ; Define el punto de llamada. Debe llamarse igual que la función main de kernel.c
call main ; Llama a la función de C. El linker sabrá donde se coloca en la memoria
jmp $

; Tenemos que generar un fichero ELF en vez de un fichero binario que después vincularemos con kernel.o
; Comando: nasm kernel_entry.asm -f elf -o kernel_entry.o
