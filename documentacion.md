# Aplicaciones necesarias
* sudo apt update
* sudo apt install nasm
* sudo apt-get install qemu-system

# Comandos para crear el .bin y una MV que ejecute el SO

`nasm -f bin boot.asm -o boot.bin`
`qemu-system-x86_64 -drive format=raw,file=boot.bin`

# Mostrar un caracter por pantalla

mov ah, 0x0e    ; Seleccionamos la función "Escribir caracter"
mov al, <char>  ; El caracter que se va a mostrar
int 0x10        ; Llamamos a la interrupción de la BIOS (?)

# Definición AX, AH, AL

AX es el registrador/acumulador primario en 16 bits que se divide en AH y AL.

# Definición BX, BH, BL

BX es el registrador base dividido en BH y BL.

# Dirección de memoria Boot Sector

La dirección de memoria del Boot Sector es 0x7c00. Referencia en fichero os-dev.pdf pág. 14

# Compilar fichero C

Con la etiqueta `-ffreestanding` compilará el código independientemente del sistema.
`i386-elf-gcc -ffreestanding -c function.c -o function.o`

Examinar el código máquina generado por la compilación:
`i386-elf-objdump -d function.o`

Crear un fichero binario. Pondremos el desplazamiento en 0x0, ya que no sabemos dónde se colocará en la memoria.
`i386-elf-ld -o function.bin -Ttext 0x0 --oformat binary function.o`

Decompilar fichero binario.
`ndisasm -b 32 function.bin`

# Rutas a agregar para el compilador
export PREFIX="/usr/local/i386elfgcc"
export TARGET=i386-elf
export PATH="$PREFIX/bin:$PATH"
