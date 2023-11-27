# su-pdfgen
PDF generator for supplerende stønad. Kjør lokalt docker image med  `./run_development.sh`

PDFene kan testes lokalt på `http://localhost:8081/api/v1/genpdf/<application>/<template>`, f.eks.
http://localhost:8081/api/v1/genpdf/supdfgen/vedtakInnvilgelse

Templatene vil bruke flettedata fra json-fil med samme navn som template i `data/supdfgen`

## Hjelpefunksjoner

https://github.com/navikt/pdfgen-core/blob/main/src/main/kotlin/no/nav/pdfgen/core/template/Helpers.kt

### Stor forbokstav

Eksempel `{{capitalize sats}}`

### Kronebeløp

Eksempel `{{currency_no satsBeløp true}}`

Boolean-parameteret angir om beløpet skal avrundes til heltall, altså uten desimaler/øre. Merk at det ikke skjer noen avrunding,
desimalene/ørene fjernes bare.

### Docker hub tags
https://hub.docker.com/r/navikt/pdfgen/tags
