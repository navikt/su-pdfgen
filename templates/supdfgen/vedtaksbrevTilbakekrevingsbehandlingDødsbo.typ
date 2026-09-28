#import "/templates/supdfgen/lib.typinc": *

#set document(title: "Supplerende stønad")
#set page(
  paper: "a4",
  margin: (top: 20mm, bottom: 20mm, left: 22mm, right: 22mm),
  footer: context align(right)[
    #text(size: 9pt)[Side #counter(page).display() av #counter(page).final().first()]
  ],
)
#set text(font: "Source Sans Pro", size: 11pt)
#set par(spacing: 1em, justify: false)
#set list(indent: 6pt, spacing: 0.8em)

#let data = json("/data/supdfgen/vedtaksbrevTilbakekrevingsbehandlingDødsbo.json")
#let personalia = get(data, "personalia")
#let sakstype = get(data, "sakstype")
#let månedsoversikt = get(data, "månedsoversiktMedSum")

#let fritekst(value) = {
  if value == none { return }
  let linjer = str(value).split("\n")
  for (indeks, linje) in linjer.enumerate() {
    if indeks > 0 { linebreak() }
    linje
  }
}

#let brevhode() = {
  if personalia == none { return }
  image("/resources/Navlogo.png", width: 32mm, alt: "Nav logo")
  v(28mm)
  block(below: 1.5em)[
    #get(personalia, "fornavn") #get(personalia, "etternavn")\
    Dato: #get(personalia, "dato")\
    Saksnummer: #get(personalia, "saksnummer")
  ]
}

#let fødselsnummer() = [
  Fødselsnummer #get(data, "personalia.fødselsnummer") (oppgi fødselsnummer ved
  henvendelser til oss)
]

#let hilsen() = {
  let saksbehandler = get(data, "saksbehandlerNavn")
  let attestant = get(data, "attestantNavn")
  block(above: 3em)[
    Med vennlig hilsen\
    #if truthy(saksbehandler) [
      #saksbehandler#if truthy(attestant) and attestant != saksbehandler [ og #attestant] hos
    ]
    Nav Familie- og pensjonsytelser Ålesund\
    #if not truthy(get(data, "ikkeVisPostadresse")) [
      \
      Postadresse:\
      Nav Skanning\
      Postboks 1402\
      0109 OSLO\
      Norge / Norway
    ]
  ]
}

#let feilutbetalingstabell() = {
  if månedsoversikt == none { return }
  let kantlinje = 0.5pt + rgb("#3E3832")
  pagebreak()
  heading(level: 1)[Vedlegg: Oversikt over feilutbetalingen]
  set text(size: 9pt)
  table(
    columns: (25mm, 25mm, 25mm, 20mm, 30mm),
    stroke: kantlinje,
    inset: (x: 5pt, y: 5pt),
    align: (left, right, left, right, right),
    fill: (x, y) => if y == 0 { rgb("#c6d9f1") },
    table.header(
      align(left)[*Periode*],
      align(left)[*Feilutbetalt beløp*],
      align(left)[*Tilbakebetaling*],
      align(left)[*Beløp før skatt*],
      align(left)[*Beløp du skal betale tilbake etter at skatt er trukket fra*],
    ),
    ..items(get(månedsoversikt, "sorterteMåneder"))
      .map(måned => (
        [#get(måned, "periode")],
        [#currency(get(måned, "bruttoSkalTilbakekreve"), truncate: true) kroner],
        if get(måned, "vurdering") == "SkalTilbakekreve" [Hele beløpet] else [
          Ingen tilbakebetaling
        ],
        [#currency(get(måned, "bruttoSkalTilbakekreve"), truncate: true) kroner],
        [#currency(get(måned, "nettoSkalTilbakekreve"), truncate: true) kroner],
      ))
      .flatten(),
    table.hline(stroke: 2pt + rgb("#3E3832")),
    [sum],
    [],
    [],
    [#currency(get(månedsoversikt, "sumBruttoSkalTilbakekreve"), truncate: true) kroner],
    [*#currency(get(månedsoversikt, "sumNettoSkalTilbakekreve"), truncate: true) kroner*],
  )
}

#brevhode()

= Boet må betale tilbake supplerende stønad

#fødselsnummer()

Vi har kommet frem til at for mye utbetalt supplerende stønad må betales tilbake.
Beløpet boet skylder før skatt er
#currency(get(månedsoversikt, "sumBruttoSkalTilbakekreve"), truncate: true) kr. Boet
skal betale tilbake
#currency(get(månedsoversikt, "sumNettoSkalTilbakekreve"), truncate: true) kr etter at
skatten er trukket fra.

Beløpet som er trukket i skatt får vi tilbake fra Skatteetaten.

Nedenfor følger en oversikt over periodene med feilutbetalinger og feilutbetalt beløp
inkludert skatt.

== Hvordan har vi kommet fram til at boet må betale tilbake?

#fritekst(get(data, "fritekst"))

== Skatt og skatteoppgjør

Vi gir opplysninger til Skatteetaten om dette vedtaket. Skatteetaten fastsetter det
endelige skattebeløpet, og vil vurdere om det er grunnlag for å endre skatteoppgjøret
ditt.

== Hvordan betaler boet tilbake?

Boet får faktura fra Skatteetaten på det beløpet som skal betales tilbake. På
fakturaen står det informasjon om nøyaktig beløp, kontonummer og forfallsdato. Boet
trenger ikke å gjøre noe før boet får fakturaen.

Boet finner mer informasjon på skatteetaten.no/betale.

== Boet har rett til å klage

Hvis boet mener at vedtaket er feil, kan boet klage innen 6 uker fra den datoen boet
mottok vedtaket. Skjema og informasjon finnes på nav.no/klage.

Klagen kan sendes digitalt via innlogging på nettsiden vår nav.no, eller i posten.

Skriftlig klage som sendes i posten må inneholde navn, fødselsnummer og adresse, og
den må være underskrevet av representant for boet. Klagen må sendes til Nav Familie-
og pensjonsytelser Ålesund sammen med forside fra nav.no.

Nav kan hjelpe med å skrive ned klagen.

Boet må skrive

- hvilket vedtak det klages på
- hvilken endring i vedtaket boet ber om

Boet bør også

- skrive hvorfor boet mener vedtaket er feil
- nevne erklæringer og andre dokumenter som boet legger ved klagen

Boet må som hovedregel begynne å betale tilbake når boet får fakturaen, selv om boet
klager på vedtaket. Dette følger av forvaltningsloven § 42 med tilhørende rundskriv.
Hvis boet får vedtak om at boet ikke trengte å betale tilbake hele eller deler av
beløpet boet skyldte, betaler vi pengene tilbake.

Nav kan av eget tiltak bestemme at tilbakekrevingen skal utsettes til klagen er
behandlet, for eksempel hvis vi ser at det er sannsynlig at det påklagede vedtaket
blir omgjort. Boet kan også søke om utsettelse av tilbakebetaling til klagen er
behandlet. Vi gjør oppmerksom på at det ikke gis utsettelse bare av økonomiske
grunner.

Hvis boet får medhold i klagen, kan boet få dekket vesentlige utgifter som har vært
nødvendige for å få endret vedtaket. Krav om dekning av saksomkostninger må settes
frem senest tre uker etter at melding om det nye vedtaket ble mottatt. Dette framgår
av forvaltningsloven § 36.

Boet kan ha krav på fri rettshjelp etter rettshjelploven. Informasjon om denne
ordningen kan boet få hos Statsforvalteren, advokater eller Nav.

== Boet har rett til innsyn

På nav.no/dittnav kan boet se dokumentene i saken til den avdøde.

== Har boet spørsmål?

Boet finner mer informasjon på nav.no. Hvis boet ikke finner svar på spørsmålet,
kontakt oss gjerne via kanalene som oppgis på nav.no/kontakt. Boet kan også kontakte
oss på telefon
#if sakstype == "ALDER" [55 55 33 34] else [55 55 33 33].

#hilsen()

#feilutbetalingstabell()
