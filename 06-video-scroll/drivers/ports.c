// Lee un byte del puerto especificado

unsigned char port_byte_in (unsigned short port){
    unsigned char result;
    /* Sintaxis de ensamblador en C
    Los registros de origen y destino se cambian desde NASM
    * '"=a"(result)' ; Establecemos la variable de C 'result' en el valor del registro eax
    * '"d" (port)' ; Mapea la variable de C 'port' en el registro edx
    * Las entradas y salidas están separadas por dos puntos.
    */
    // De esta manera podemos hacer llamadas a funciones de asm
    __asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
    return result;
}

void port_byte_out (unsigned short port, unsigned char data){
    __asm__("out %%al, %%dx" : : "a" (data), "d" (port));
}

unsigned short port_word_in (unsigned short port){
    unsigned short result;
    __asm__("in %%dx, %%al" : "=a" (result) : "d" (port));
    return result;
}

void port_word_out (unsigned short port, unsigned char data){
    __asm__("out %%al, %%dx" : : "a" (data), "d" (port));
}
