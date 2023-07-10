#!/bin/bash

# Ruta de la carpeta que contiene las imágenes originales
carpeta_origen="imagenes"

# Ruta de la carpeta de destino para las imágenes recortadas
carpeta_destino="imagenes_recortadas"

# Crear la carpeta de destino si no existe
mkdir -p "$carpeta_destino"

# Patrón para verificar nombres de personas válidos
patron_nombre="[A-Z][a-z]+"

# Recorrer las imágenes originales en la carpeta de origen
for imagen_origen in "$carpeta_origen"/*.jpg; do
  nombre_archivo=$(basename "$imagen_origen" .jpg)

  # Verificar si el nombre de archivo cumple el patrón de nombres de personas válidos
  if [[ $nombre_archivo =~ $patron_nombre ]]; then
    # Recortar la imagen a una resolución de 512x512 utilizando ImageMagick
    convert "$imagen_origen"  -resize 512x512^ -gravity center -extent 512x512 "$carpeta_destino/$nombre_archivo.jpg"
    echo "Imagen recortada: $nombre_archivo.jpg"
  else
    echo "Nombre de archivo inválido: $nombre_archivo.jpg"
  fi
done

echo "Proceso completado."
