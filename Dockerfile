# søk opp pdfgen her i GAR: https://console.cloud.google.com/artifacts/browse/nais-management-233d?invt=AbuYmw
FROM europe-north1-docker.pkg.dev/nais-management-233d/pdfgen/pdfgen:2.0.74

COPY templates /app/templates
COPY fonts /app/fonts
COPY resources /app/resources
