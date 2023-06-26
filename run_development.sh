#!/bin/bash

CURRENT_PATH=$(dirname "$(realpath "${BASH_SOURCE[0]}")")

CONTAINER_NAME="su-pdfgen"

if [ "$(docker ps -aq -f name=$CONTAINER_NAME)" ]; then
    docker start "$CONTAINER_NAME"
else
docker build -t "$CONTAINER_NAME" "$CURRENT_PATH"
docker run \
        -v "$CURRENT_PATH"/data:/app/data \
        -p 8081:8080 \
        -e DISABLE_PDF_GET=false \
        -it \
        "$CONTAINER_NAME"
fi
