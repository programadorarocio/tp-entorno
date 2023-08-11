# Usar una imagen base que contenga el interprete de comandos necesario para ej>
FROM ubuntu:latest

# Actualizar repositorios e instalar herramientas necesarias
#RUN chmod +x *.sh
RUN apt-get update && apt-get install -y wget && apt-get install -y imagemagick

# Copiar scripts y archivos al contenedor
COPY *.sh /tp-entorno/
#COPY README.md /tp-entorno/

# Establecer directorio de trabajo
WORKDIR /tp-entorno

VOLUME ["$PWD:/tp-entorno"]

# Definir comando por defecto al iniciar el contenedor
CMD ["bash", "menu.sh"]
