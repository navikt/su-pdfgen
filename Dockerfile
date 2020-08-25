FROM docker.pkg.github.com/navikt/pdfgen/pdfgen:0073e78ea89798dc8b24900ea2b500f2efa3ca97

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
