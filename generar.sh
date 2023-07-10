!/bin/bash

# Verificar si se ha proporcionado la cantidad de imágenes como argumento
if [ $# -eq 0 ]; then
  echo "Error: Debes proporcionar la cantidad de imágenes a generar como argumento."
  exit 1
fi

# Cantidad de imágenes a generar
cantidad_imagenes=$1

# Ruta del dataset con los nombres de personas
dataset_url="https://raw.githubusercontent.com/adalessandro/EdP-2023-TP-Final/main/dict.csv"

# Ruta del servicio web para generar imágenes
servicio_web_url="https://thispersondoesnotexist.com"

# Carpeta de destino para las imágenes
carpeta_destino="imagenes"

# Crear la carpeta de destino si no existe
mkdir -p "$carpeta_destino"

# Descargar el dataset de nombres
wget -q "$dataset_url" -O nombres.csv

# Leer el archivo CSV y crear una lista con los nombres
lista_nombres=()
while IFS=',' read -r nombre _ ; do
  lista_nombres+=("$nombre")
done < "nombres.csv"

# Función para generar un nombre de archivo al azar
generar_nombre() {
  local nombre_index=$((RANDOM % ${#lista_nombres[@]}))
  echo "${lista_nombres[$nombre_index]}"
}

# Generar las imágenes
for ((i=1; i<=cantidad_imagenes; i++))
do
  nombre=$(generar_nombre)
  imagen_url="$servicio_web_url"

  # Descargar la imagen
  curl -s -o "$carpeta_destino/$nombre.jpg" "$imagen_url"

  # Esperar un segundo entre descargas
  sleep 1
done

# Función para generar un nombre de archivo al azar
generar_nombre() {
  local nombre_index=$((RANDOM % ${#lista_nombres[@]}))
  echo "${lista_nombres[$nombre_index]}"
}

# Generar las imágenes
for ((i=1; i<=cantidad_imagenes; i++))
do
  nombre=$(generar_nombre)
  imagen_url="$servicio_web_url"

  # Descargar la imagen
  curl -s -o "$carpeta_destino/$nombre.jpg" "$imagen_url"

  # Esperar un segundo entre descargas
  sleep 1
done

# Comprimir las imágenes en un archivo ZIP
zip -r imagenes.zip "$carpeta_destino"

# Generar el hash del archivo ZIP
hash=$(sha256sum imagenes.zip | awk '{ print $1 }')


# Guardar el hash en un archivo
echo "$hash" > checksum.txt

# Eliminar el archivo CSV de nombres
rm nombres.csv

echo "Proceso completado."
