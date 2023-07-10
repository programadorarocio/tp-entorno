#!/bin/bash

# Verificar si se han proporcionado los archivos como argumentos
if [ $# -ne 2 ]; then
  echo "Error: Debes proporcionar dos archivos como argumentos."
  echo "Uso: bash descomprimir_imagenes.sh <archivo_comprimido> <archivo_suma_verificacion>"
  exit 1
fi

# Archivo comprimido de imágenes
archivo_comprimido=$1

# Archivo de suma de verificación
archivo_suma_verificacion=$2

# Verificar si el archivo comprimido existe
if [ ! -f "$archivo_comprimido" ]; then
  echo "Error: El archivo comprimido '$archivo_comprimido' no existe."
  exit 1
fi

# Verificar si el archivo de suma de verificación existe
if [ ! -f "$archivo_suma_verificacion" ]; then
  echo "Error: El archivo de suma de verificación '$archivo_suma_verificacion' no existe."
  exit 1
fi


# Descomprimir las imágenes
carpeta_destino="imagenes"
unzip -q "$archivo_comprimido" -d "$carpeta_destino"

# Verificar la suma de verificación del archivo comprimido
hash=$(sha256sum "$archivo_comprimido" | awk '{ print $1 }')
checksum=$(cat "$archivo_suma_verificacion")

if [ "$hash" != "$checksum" ]; then
  echo "Error: La suma de verificación no coincide. Los archivos podrían estar corruptos."
  exit 1
fi

echo "Proceso completado. Las imágenes se han descomprimido correctamente."
