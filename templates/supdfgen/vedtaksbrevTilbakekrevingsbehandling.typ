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

#let data = json("/data/supdfgen/vedtaksbrevTilbakekrevingsbehandling.json")
#let personalia = get(data, "personalia")
#let sakstype = get(data, "sakstype")
#let månedsoversikt = get(data, "månedsoversiktMedSum")
#let skalTilbakekreve = truthy(get(data, "skalTilbakekreve"))

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

#let har-du-spørsmål() = [
  == Har du spørsmål?

  Du finner nyttig informasjon på
  #if sakstype == "ALDER" [
    www.nav.no/supplerende-stonad-over-67.
  ] else [
    www.nav.no/supplerende-stonad-flyktninger.
  ]

  #if sakstype == "ALDER" [
    Du kan også kontakte oss på 55 55 33 34.
  ] else [
    Du kan også kontakte oss på 55 55 33 33.
  ]
]

#let klage-og-innsyn(klagetekst, extraVedtaksInfoForKlage: none) = [
  == Du har rett til å klage

  #klagetekst

  #if truthy(extraVedtaksInfoForKlage) [
    #extraVedtaksInfoForKlage
  ]

  == Du har rett til innsyn

  På www.nav.no/minside kan du se dokumentene i saken din.

  #har-du-spørsmål()
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

#let informasjon-om-klage-og-anke() = [
  #pagebreak()

  = Vedlegg: Informasjon om klage og anke

  == Veiledning fra Nav ‑ forvaltningsloven § 11

  Vi har plikt til å veilede deg om dine rettigheter og plikter i saken din, både før,
  under og etter saksbehandlingen. Dersom du har spørsmål eller er usikker på noe, vil
  vi gjøre vårt beste for å hjelpe deg.

  == Hjelp fra andre ‑ forvaltningsloven § 12

  Du kan be om hjelp fra andre under hele saksbehandlingen, for eksempel av advokat,
  rettshjelper, en organisasjon du er medlem av eller en annen myndig person. Hvis den
  som hjelper deg ikke er advokat, må du gi denne personen en skriftlig fullmakt. Bruk
  gjerne skjemaet du finner på Fullmakt ‑ nav.no (https://www.nav.no/fullmakt).

  == Klage på vedtaket ‑ folketrygdloven § 21‑12

  Du kan klage på vedtaket innen seks uker fra du mottok det. Kontoret som har fattet
  vedtaket vil da vurdere saken din på nytt. Hvis du ikke får gjennomslag for klagen
  din, blir den sendt videre til Nav klageinstans for ny vurdering og avgjørelse.
  Dersom du heller ikke får gjennomslag hos klageinstansen, kan du anke saken inn for
  Trygderetten.

  == Hvordan sende inn klage?

  Klagen må være skriftlig og inneholde ditt navn, fødselsnummer og adresse. Du kan
  benytte skjemaet som du finner på Klage og anke ‑ nav.no
  (https://www.nav.no/klage). Klagen kan sendes via innlogging på nettsiden vår,
  Forside privatperson ‑ nav.no (https://www.nav.no), eller sendes til oss i posten
  til

  Nav skanning\
  Postboks 1400\
  0109 OSLO

  Hvis du velger å sende klagen per post, må du huske å undertegne den. Hvis klagen
  ikke er undertegnet, vil vi dessverre måtte returnere den til deg.

  == Hva må klagen inneholde?

  Du må skrive

  - hvilket vedtak du klager på
  - hvilken endring i vedtaket du ber om

  Du bør også

  - skrive hvorfor du mener vedtaket er feil
  - nevne erklæringer og andre dokumenter som du legger ved klagen

  Nav kan hjelpe deg med å skrive ned klagen.

  == Tilbakekreving

  Du må som hovedregel begynne å betale tilbake når du får fakturaen, selv om du
  klager på vedtaket. Dette framgår av forvaltningsloven § 42 med tilhørende
  rundskriv.

  Nav kan av eget tiltak bestemme at tilbakekrevingen skal utsettes til klagen er
  behandlet, for eksempel hvis vi ser at det er sannsynlig at det påklagede vedtaket
  blir omgjort. Du kan også søke om utsettelse av tilbakebetaling til klagen er
  behandlet. Vi gjør deg oppmerksom på at det ikke gis utsettelse bare av økonomiske
  grunner.

  == Du kan få dekket utgifter

  Får du medhold, kan du få dekket vesentlige utgifter som har vært nødvendige for å
  få endret vedtaket.

  Du kan ha krav på fri rettshjelp etter rettshjelploven. Informasjon om denne
  ordningen kan du få hos statsforvalteren, advokater eller Nav.

  Du kan lese om saksomkostninger i forvaltningsloven § 36.
]

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

#if skalTilbakekreve [
  = Du må betale tilbake supplerende stønad.

  #fødselsnummer()

  Du har fått for mye supplerende stønad som du må betale tilbake.

  Beløpet du skylder før skatt er kr
  #currency(get(månedsoversikt, "sumBruttoSkalTilbakekreve"), truncate: true). Dette
  er hele det feilutbetalte beløpet.

  Du skal betale kr
  #currency(get(månedsoversikt, "sumNettoSkalTilbakekreve"), truncate: true) etter
  skatt er trukket fra.

  == Hvordan har vi kommet fram til at du må betale tilbake?

  #fritekst(get(data, "fritekst"))

  Vedtaket er gjort etter reglene i lov om supplerende stønad § 13.

  == Skatt og skatteoppgjør

  Skatten som er trukket fra beløpet du skal betale tilbake, er beregnet etter det du
  har blitt trukket i skatt i gjennomsnitt per måned. Det betyr at beløpet du skal
  tilbakebetale etter skatt, ikke alltid er likt med det beløpet du fikk inn på
  kontoen din.

  Nav gir opplysninger til Skatteetaten om skattebeløpet og om beløpet du skal betale
  tilbake før skatt er trukket i fra. Skatteetaten vil vurdere om det er grunnlag for
  å endre skatteoppgjør.

  == Hvordan betale tilbake pengene du skylder

  Du vil få faktura fra Skatteetaten på det beløpet du skal betale tilbake.

  På fakturaen vil det stå informasjon om nøyaktig beløp, kontonummer og forfallsdato.

  Du finner mer informasjon på skatteetaten.no/betale.
] else [
  = Du må ikke betale tilbake supplerende stønad

  #fødselsnummer()

  Vi har kommet frem til at du ikke skal betale tilbake for mye utbetalt supplerende
  stønad på #currency(get(data, "bruttoSkalIkkeTilbakekreveSummert"), truncate: true)
  kroner, fordi vilkårene for tilbakekreving ikke er oppfylt.

  == Hvordan har vi kommet fram til at du ikke må betale tilbake?

  #fritekst(get(data, "fritekst"))
]

#if skalTilbakekreve [
  #klage-og-innsyn(
    [
      Du kan klage innen 6 uker fra den datoen du mottok vedtaket. I vedlegget finner
      du mer informasjon om klage og anke.
    ],
    extraVedtaksInfoForKlage: [
      Du må som hovedregel begynne å betale beløpet tilbake når du får fakturaen selv
      om du klager på dette vedtaket. Dette følger av forvaltningsloven § 42. Hvis du
      får vedtak om at du ikke trengte å betale tilbake hele eller deler av beløpet du
      skyldte, betaler vi pengene tilbake til deg.
    ],
  )
] else [
  #klage-og-innsyn(
    [
      Du kan klage innen 6 uker fra den datoen du mottok vedtaket. Du finner skjema og
      informasjon på www.nav.no/klage.
    ],
    extraVedtaksInfoForKlage: get(data, "extraVedtaksInfoForKlage"),
  )
]

#hilsen()

#if skalTilbakekreve [
  #informasjon-om-klage-og-anke()
  #feilutbetalingstabell()
]
