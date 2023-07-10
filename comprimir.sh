#!/bin/bash

# Ruta de la carpeta que contiene las imágenes originales
carpeta_origen="imagenes"

# Ruta de la carpeta de destino para las imágenes recortadas
carpeta_destino="imagenes_recortadas"

# Archivo para guardar la lista de nombres de las imágenes
archivo_lista_nombres="lista_nombres.txt"

# Archivo para guardar la lista de nombres válidos
archivo_lista_nombres_validos="lista_nombres_validos.txt"

# Archivo para guardar el total de personas cuyos nombres terminan con "a"
archivo_total_nombres_terminan_a="total_nombres_terminan_a.txt"

# Crear la carpeta de destino si no existe
mkdir -p "$carpeta_destino"

# Patrón para verificar nombres de personas válidos
patron_nombre="[A-Z][a-z]+"

# Array para almacenar los nombres de las imágenes
nombres_imagenes=()

# Array para almacenar los nombres válidos
nombres_validos=()

# Contador para el total de nombres que terminan con "a"
total_nombres_terminan_a=0

# Recorrer las imágenes originales en la carpeta de origen
for imagen_origen in "$carpeta_origen"/*.jpg; do
  nombre_archivo=$(basename "$imagen_origen" .jpg)

  # Verificar si el nombre de archivo cumple el patrón de nombres de personas válidos
  if [[ $nombre_archivo =~ $patron_nombre ]]; then
    # Recortar la imagen a una resolución de 512x512 utilizando ImageMagick
    convert "$imagen_origen" -resize 512x512^ -gravity center -extent 512x512 "$carpeta_destino/$nombre_archivo.jpg"
    echo "Imagen recortada: $nombre_archivo.jpg"

    # Almacenar el nombre de la imagen en el array
    nombres_imagenes+=("$nombre_archivo")

    # Verificar si el nombre termina con "a" y aumentar el contador
    if [[ $nombre_archivo =~ [aA]$ ]]; then
      total_nombres_terminan_a=$((total_nombres_terminan_a + 1))
    fi

     # Almacenar el nombre válido en el array
    nombres_validos+=("$nombre_archivo")
  else
    echo "Nombre de archivo inválido: $nombre_archivo.jpg"
  fi
done

# Guardar la lista de nombres de las imágenes en un archivo
printf "%s\n" "${nombres_imagenes[@]}" > "$archivo_lista_nombres"

# Guardar la lista de nombres válidos en un archivo
printf "%s\n" "${nombres_validos[@]}" > "$archivo_lista_nombres_validos"

# Guardar el total de personas cuyos nombres terminan con "a" en un archivo
echo "$total_nombres_terminan_a" > "$archivo_total_nombres_terminan_a"

echo "Proceso completado."

