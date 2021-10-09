# $@ = fichero principal
# $< = primera dependencia
# $^ = Todas las dependencias

# La primera regla se ejecuta si no se le pasa ningún parametro
all: run

# Se construirán las dependencias necesarias
kernel.bin: kernel_entry.o kernel.o
	i386-elf-ld -o $@ -Ttext 0x1000 $^ --oformat binary

kernel_entry.o: kernel_entry.asm
	nasm $< -f elf -o $@

kernel.o: kernel.c
	i386-elf-gcc -ffreestanding -c $< -o $@

bootsect.bin: bootsect_alpine.asm
	nasm $< -f bin -o $@

os-image.bin: bootsect.bin kernel.bin
	cat $^ > $@

run: os-image.bin
	qemu-system-i386 $< -boot c
