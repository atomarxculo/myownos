// La siguiente no hace nada, fuerza que vaya a la función main()

void funcion_inutil(){

}

void main() {
    char* video_memory = (char*) 0xb8000;
    *video_memory = 'X';
}
