#!/bin/bash

IMAGE_LOCAL="reverse-proxy:v2"
IMAGE_REMOTE="taartaimaanyao/reverse-proxy:v2"

echo "=== Login a Docker Hub ==="
docker login || { echo "Error en login"; exit 1; }

echo "=== Construyendo la imagen Docker ==="
docker build -t $IMAGE_LOCAL . || { echo "Error en build"; exit 1; }

echo "=== Tagueando imagen ==="
docker tag $IMAGE_LOCAL $IMAGE_REMOTE

echo "=== Pusheando imagen a Docker Hub ==="
docker push $IMAGE_REMOTE

echo "=== Imagen subida correctamente ==="
echo "=== Eliminando contenedor viejo si existe ==="
docker rm -f reverse-proxy 2>/dev/null

echo "=== Ejecutando el nuevo contenedor reverse-proxy:v2 desde Docker Hub ==="
docker run -d -p 80:80 --name reverse-proxy $IMAGE_REMOTE

echo "=== Todo listo ==="
echo "El contenedor reverse-proxy está corriendo en http://localhost/products"