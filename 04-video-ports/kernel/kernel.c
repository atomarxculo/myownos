#include "../drivers/ports.h"

void main(){
    /* Posición del cursor de la pantalla: Solicita bytes al registro de control VGA (0x3d4)
    14 = byte alto del cursor y 15 = byte bajo del curso */
    port_byte_out(0x3d4, 14);
    // Los datos se devuelven en el registro de datos VGA (0x3d5)
    int position = port_byte_in(0x3d5);
    position = position << 8; // Byte alto

    port_byte_out(0x3d4, 15); // Haciendo una petición al byte bajo
    position += port_byte_in(0x3d5);

    /* Las 'celdas' VGA consisten en el carácter y sus datos de control
    p.ej. 'blanco sobre fondo negro', 'texto rojo sobre fondo blanco'*/
    int offset_from_vga = position * 2;

    /* Ahora vamos a examinar ambas variables con gdb, ya que todavía no sabemos como mostrar cadenas por pantalla.
    Ejecutamos 'make debug' y en la consola gdb:
    * (breakpoint) b kernel.c:21
    * continue
    * print position
    * print offset_from_vga
    */

    /* Escribimos en la posición actual del cursor, lo hemos hecho alguna vez*/
    char *vga = 0xb8000;
    vga[offset_from_vga] = 'X';
    vga[offset_from_vga+1] = 0x0f; // Texto blanco sobre fondo negro
}
