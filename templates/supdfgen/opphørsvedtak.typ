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
#set list(indent: 6pt, spacing: 1em)

#let data = json("/data/supdfgen/opphørsvedtak.json")
#let personalia = get(data, "personalia")
#let sakstype = get(data, "sakstype")
#let harEktefelle = truthy(get(data, "harEktefelle"))
#let halvGrunnbeløp = get(data, "halvGrunnbeløp")

#let inneholder(values, target) = items(values).any(value => value == target)

#let positive(value) = {
  if type(value) == int or type(value) == float { value > 0 } else { false }
}

#let fritekst(value) = {
  if value == none { return }
  let linjer = str(value).split("\n")
  for (indeks, linje) in linjer.enumerate() {
    if indeks > 0 { linebreak() }
    linje
  }
}

#let paragrafer(verdier) = {
  let liste = items(verdier).map(verdi => str(verdi))
  if liste.len() == 0 { return "" }
  if liste.len() == 1 { return "§ " + liste.first() }
  "§§ " + liste.slice(0, liste.len() - 1).join(", ") + " og " + liste.last()
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

#let opphørsgrunn-tekst(grunn) = {
  if grunn == "UFØRHET" [
    Vi har mottatt opplysninger om at uføretrygden din er opphørt etter paragrafene
    12-4 til 12-7.
  ] else if grunn == "FOR_HØY_INNTEKT" {
    if harEktefelle [
      Nye opplysninger viser at inntekten du og ektefellen/samboeren din har til
      sammen er for høy.
    ] else [
      Nye opplysninger viser at du har for høy inntekt.
    ]
  } else if grunn == "SU_UNDER_MINSTEGRENSE" [
    Ny beregning av stønaden viser at den er for lav til at den kan utbetales. Vi kan
    ikke utbetale stønad som er under to prosent av den høyeste stønadssatsen.
  ] else if grunn == "UTENLANDSOPPHOLD" [
    Vi har opphørt fordi du har vært eller planlagt å være mer enn 90 dager i
    utlandet.
  ] else if grunn == "FORMUE" {
    if harEktefelle [
      Nye opplysninger viser at formuen du og ektefellen/samboeren din har til sammen
      er mer enn halvparten av folketrygdens grunnbeløp. For tiden er dette
      #halvGrunnbeløp kroner.

      Hvis formuen blir mindre, kan du søke om supplerende stønad på nytt. Du kan
      ikke gi bort formuen for å få rett til supplerende stønad. Derfor må du
      dokumentere hva formuen er brukt til hvis du søker på nytt.
    ] else [
      Nye opplysninger viser at formuen din er mer enn halvparten av folketrygdens
      grunnbeløp, som for tiden er #halvGrunnbeløp kroner.

      Hvis formuen blir mindre, kan du søke om supplerende stønad på nytt. Du kan
      ikke gi bort formuen for å få rett til supplerende stønad. Derfor må du
      dokumentere hva formuen er brukt til hvis du søker på nytt.
    ]
  } else if grunn == "MANGLENDE_DOKUMENTASJON" [
    Du har ikke levert nødvending dokumentasjon for at vi kan vurdere om du fortsatt
    har rett til supplerende stønad.
  ] else if grunn == "FLYKTNING" [
    Nye opplysninger viser at du ikke er registrert som flyktning etter
    utlendingslova §28. Vi har derfor opphørt din stønad som ufør flyktning.
  ] else if grunn == "OPPHOLDSTILLATELSE" [
    Nye opplysninger viser at du ikke har lovlig opphold i Norge.
  ] else if grunn == "BOR_OG_OPPHOLDER_SEG_I_NORGE" [
    Nye opplysninger viser at du ikke oppholder deg fast i Norge.
  ] else if grunn == "PERSONLIG_OPPMØTE" [
    Nye opplysninger viser at du ikke møtte personlig når du søkte om supplerende
    stønad eller ved kontrollsamtale.
  ] else if grunn == "INNLAGT_PÅ_INSTITUSJON" [
    Nye opplysninger viser at du er innlagt på institusjon.
  ] else if grunn == "ALDERSPENSJON" [
    Du har ikke fullt ut benyttet deg av retten til pensjon fra folketrygden eller
    andre norske eller utenlandske ordninger.
  ] else {
    none
  }
}

#let opphørsliste() = {
  let punkter = items(get(data, "opphørsgrunner"))
    .map(opphørsgrunn-tekst)
    .filter(punkt => punkt != none)
  if punkter.len() > 0 { list(..punkter) }
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

  #if truthy(get(data, "harFradrag")) [
    Vi har redusert stønaden din med inntekt og andre fradrag.
  ]

  #if sakstype == "UFØRE" and truthy(get(data, "forventetInntektStørreEnn0")) [
    Vi bruker alltid det høyeste beløpet av arbeidsinntekten din og din forventede
    inntekt etter uførhet når vi beregner stønaden din. Du ser i beregningen hvilket
    beløp vi bruker.
  ]

  #for periode in items(get(data, "beregningsperioder")) [
    #beregningsperiode-tabell(periode)
  ]

  Stønaden reguleres automatisk i samsvar med grunnbeløpet fra 1. mai hvert år.
  Økningen etterbetales vanligvis i juni.
]

#brevhode()

= Vedtak om opphør av supplerende stønad

#fødselsnummer()

#if inneholder(get(data, "opphørsgrunner"), "FAMILIEGJENFORENING") [
  Vi har opphørt stønaden din fordi oppholdstillatelsen din ikke gir deg rett til
  supplerende stønad.
] else [
  Vi har opphørt fordi:

  #opphørsliste()

  Stønaden din blir opphørt i perioden
  #get(data, "opphørsperiode.fraOgMed")-#get(data, "opphørsperiode.tilOgMed").

  Vedtaket er gjort etter lov om supplerende stønad for personer med kort botid i
  Norge #paragrafer(get(data, "avslagsparagrafer")).
]

#if truthy(get(data, "fritekst")) [
  #fritekst(get(data, "fritekst"))
]

#if truthy(get(data, "beregningsperioder")) [
  #beregning()
]

#felles-info()

#hilsen()
