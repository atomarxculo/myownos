[bits 16]

switch_to_pm:
    cli ; deshabilitamos las interrupciones
    lgdt [gdt_descriptor] ; Cargamos el GDT descriptor
    mov eax, cr0 ; Establecemos un bit en el registro de control de la CPU con cr0
    or eax, 0x1 ; Configuramos el modo 32-bit en cr0
    mov cr0, eax
    jmp CODE_SEG:init_pm ; Hacemos un salto usando un segmento diferente

[bits 32]

init_pm: ; Ahora usaremos instrucciones de 32-bit
    mov ax, DATA_SEG ; actualizamos los registradores de segmentos
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x90000 ; Actualizamos la pila en la parte superior del espacio libre
    mov esp, ebp

    call BEGIN_PM ; Llamamos a una etiqueta del código principal
