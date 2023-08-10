#!/bin/bash
# Función para la opción generar.sh
generar() {
    read -p "Ingrese la cantidad de imágenes a generar: " cantidad_imagenes
    bash generar.sh "$cantidad_imagenes"
}

# Función para la opción descomprimir.sh
descomprimir() {
    read -p "Ingrese el nombre del archivo comprimido: " archivo_comprimido
    read -p "Ingrese el nombre del archivo de suma de verificación: " archivo_s>
    bash descomprimir.sh "$archivo_comprimido" "$archivo_suma_verificacion"
}

# Función para la opción procesar.sh
procesar() {
    bash procesar.sh
}


