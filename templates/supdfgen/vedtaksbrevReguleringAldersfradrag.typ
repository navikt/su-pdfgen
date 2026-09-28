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

#let data = json("/data/supdfgen/vedtaksbrevReguleringAldersfradrag.json")
#let personalia = get(data, "personalia")
#let sakstype = get(data, "sakstype")

#let positive(value) = {
  if type(value) == int or type(value) == float { value > 0 } else { false }
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

#let felles-info() = [
  == Du har rett til å klage

  Du kan klage innen 6 uker fra den datoen du mottok vedtaket. Du finner skjema og
  informasjon på www.nav.no/klage.

  #if truthy(get(data, "extraVedtaksInfoForKlage")) [
    #get(data, "extraVedtaksInfoForKlage")
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

#let satsgrunn-tekst(satsGrunn) = {
  if satsGrunn == "ENSLIG" {
    "Deler ikke bolig med voksne barn eller andre voksne"
  } else if satsGrunn == "DELER_BOLIG_MED_VOKSNE_BARN_ELLER_ANNEN_VOKSEN" {
    "Deler bolig med voksne barn eller andre voksne"
  } else if satsGrunn == "DELER_BOLIG_MED_EKTEMAKE_SAMBOER_UNDER_67" {
    "Ektefelle eller samboer er under 67 år og ikke ufør flyktning"
  } else if satsGrunn == "DELER_BOLIG_MED_EKTEMAKE_SAMBOER_67_ELLER_ELDRE" {
    "Ektefelle eller samboer er 67 år eller eldre"
  } else if satsGrunn == "DELER_BOLIG_MED_EKTEMAKE_SAMBOER_UNDER_67_UFØR_FLYKTNING" {
    "Ektefelle eller samboer under 67 år og ufør flyktning"
  } else {
    ""
  }
}

#let satsoversikt() = {
  let oversikt = get(data, "satsoversikt")
  if oversikt == none { return }
  [
    Maksimal ytelse per måned (før eventuelle fratrekk) bestemmes av sivilstatus og
    bosituasjon. Følgende vurderinger er lagt til grunn:
  ]
  table(
    columns: (auto, 1fr, auto, auto),
    stroke: 0.5pt,
    inset: 4pt,
    [*Periode*], [*Vurdering*], [*Sats*], [*Beløp*],
    ..items(get(oversikt, "perioder"))
      .map(periode => (
        [#get(periode, "fraOgMed")-#get(periode, "tilOgMed")],
        [#satsgrunn-tekst(get(periode, "satsGrunn"))],
        [#capitalize(get(periode, "sats"))],
        [#currency(get(periode, "satsBeløp")) kr],
      ))
      .flatten(),
  )
}

#let utenlandsk-inntekt-rader(utenlandskInntekt) = {
  if utenlandskInntekt == none { return () }
  (
    (
      table.cell(colspan: 2)[
        #set text(size: 9pt)
        #pad(left: 12pt)[
          + Beløp i utenlandsk valuta:
            #get(utenlandskInntekt, "valuta")
            #currency(get(utenlandskInntekt, "beløpIUtenlandskValuta")) kr
          + Kurs ved beregning: #currency(get(utenlandskInntekt, "kurs")) kr
        ]
      ],
    ),
  )
}

#let beregningsperiode-tabell(periode) = {
  let rader = ()
  rader.push((
    [*#capitalize(get(periode, "periode.fraOgMed")) til #get(periode, "periode.tilOgMed")*],
    [],
  ))
  rader.push((
    [Supplerende stønad, #get(periode, "sats") sats],
    align(right)[#currency(get(periode, "satsbeløpPerMåned")) kr],
  ))
  for fradrag in items(get(periode, "fradrag.bruker")) {
    let fradragstype = get(fradrag, "type")
    rader.push((
      if fradragstype == "Sosialstønad" [Fradrag for utbetalt sosialstønad] else [#fradragstype],
      align(right)[-#currency(get(fradrag, "beløp")) kr],
    ))
    rader += utenlandsk-inntekt-rader(get(fradrag, "utenlandskInntekt"))
  }
  let epsFradrag = items(get(periode, "fradrag.eps.fradrag"))
  if epsFradrag.len() > 0 {
    for fradrag in epsFradrag {
      rader.push((
        [#get(fradrag, "type") (Ektefelle/samboer)],
        align(right)[#("- ")#currency(get(fradrag, "beløp")) kr],
      ))
      rader += utenlandsk-inntekt-rader(get(fradrag, "utenlandskInntekt"))
    }
    if positive(get(periode, "epsFribeløp")) {
      rader.push((
        [Fribeløp (Ektefelle/samboer)],
        align(right)[#currency(get(periode, "epsFribeløp")) kr],
      ))
    }
  }
  rader.push((
    [*Sum per måned*],
    align(right)[*#currency(get(periode, "ytelsePerMåned")) kr*],
  ))
  table(
    columns: (1fr, auto),
    stroke: none,
    inset: (x: 0pt, y: 3pt),
    ..rader.flatten(),
  )
  if truthy(get(periode, "fradrag.eps.harFradragMedSumSomErLavereEnnFribeløp")) [
    Inntekten til ektefelle/samboer er under fribeløpet på
    #currency(get(periode, "epsFribeløp"), truncate: true) kr per måned og er derfor
    ikke med i regnestykket for denne perioden.
  ]
}

#let beregning() = [
  == Slik beregner vi din supplerende stønad:

  #satsoversikt()

  #for periode in items(get(data, "beregningsperioder")) [
    #beregningsperiode-tabell(periode)
  ]

  Stønaden reguleres automatisk i samsvar med grunnbeløpet fra 1. mai hvert år.
  Økningen etterbetales vanligvis i juni.
]

#brevhode()

= Vi har vurdert din supplerende stønad på nytt

#fødselsnummer()

Alderspensjonen din økte i #get(data, "FraOgMedMåned") fordi du har fått økt
minstepensjon. Den supplerende stønaden din er derfor omregnet fra
#get(data, "fraOgMed"), måneden etter at alderspensjonen din økte.

Etter forvaltningsloven § 16 skal en part som ikke allerede har uttalt seg i
saken, enten ved søknad eller på en annen måte, varsles om revurdering i
forkant av vedtak. Varsling kan unnlates hvis det anses åpenbart unødvendig.
Fordi vurderingen vår ikke vil kunne endres på bakgrunn av eventuelle
tilbakemeldinger fra deg, er varsling unnlatt.

== Begrunnelse

Hvis inntekten din endrer seg i stønadsperioden, skal den supplerende stønaden
din endres hvis inntektsendringen gjør at du får minst 10 prosent endring i
utbetalt supplerende stønad.

Hvis inntekten øker, skal den supplerende stønaden omregnes fra måneden etter at
inntekten økte. Stønaden skal omregnes fra samme måned som inntektsendringen
hvis inntekten din blir redusert.

Økningen i alderspensjonen din medfører minst 10 prosent endring i utbetalt
supplerende stønad.

Den supplerende stønaden din er derfor endret #get(data, "fraOgMed"). Vedtaket
er gjort etter lov om supplerende stønad til personer med kort botid i Norge §§
10 og 11 tredje ledd.

#if truthy(get(data, "beregningsperioder")) [
  #beregning()
]

#felles-info()

#hilsen()
