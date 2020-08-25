#!/bin/bash

CURRENT_PATH="$(cd "$(dirname "$1")"; pwd)/$(basename "$1")"

DOCKER_IMG="docker.pkg.github.com/navikt/pdfgen/pdfgen:0073e78ea89798dc8b24900ea2b500f2efa3ca97"
docker pull $DOCKER_IMG
docker run \
        -v $CURRENT_PATH/templates:/app/templates \
        -v $CURRENT_PATH/fonts:/app/fonts \
        -v $CURRENT_PATH/data:/app/data \
        -v $CURRENT_PATH/resources:/app/resources \
        -p 8081:8080 \
        -e DISABLE_PDF_GET=false \
        -it \
        --rm \
        $DOCKER_IMG