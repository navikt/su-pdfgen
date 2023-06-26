#!/bin/bash

CURRENT_PATH=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)

CONTAINER_NAME="su-pdfgen"

docker build -t "$CONTAINER_NAME" "$CURRENT_PATH"

docker run \
        --name "$CONTAINER_NAME" \
        -v "$CURRENT_PATH"/data:/app/data \
        -p 8081:8080 \
        -e DISABLE_PDF_GET=false \
        -it \
        --rm \
        "$CONTAINER_NAME"
