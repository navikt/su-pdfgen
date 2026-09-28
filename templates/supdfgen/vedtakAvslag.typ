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

#let data = json("/data/supdfgen/vedtakAvslag.json")
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

#let avslagsgrunn-tekst(grunn) = {
  if grunn == "UFØRHET" [
    Du har ikke fått vedtak om uføretrygd der vilkårene i folketrygdloven §§ 12-4 til
    12-7 er oppfylte.
  ] else if grunn == "FLYKTNING" [
    Du har ikke status som flyktning etter § 28 i Utlendingsloven.
  ] else if grunn == "OPPHOLDSTILLATELSE" {
    if sakstype == "ALDER" [
      Du har ikke varig lovlig opphold i Norge.
    ] else [
      Du har ikke lovlig opphold i Norge.
    ]
  } else if grunn == "BOR_OG_OPPHOLDER_SEG_I_NORGE" [
    Du er ikke registrert bosatt i Norge.
  ] else if grunn == "INNLAGT_PÅ_INSTITUSJON" [
    Du oppholder deg på institusjon.
  ] else if grunn == "UTENLANDSOPPHOLD_OVER_90_DAGER" [
    Du skal oppholde deg utenfor Norge i mer enn 90 dager.
  ] else if grunn == "FAMILIEGJENFORENING" [
    Du har fått oppholdstillatelse i Norge på grunn av familiegjenforening med barn,
    barnebarn, nevø eller niese. I det første vedtaket ditt om oppholdstillatelse ble
    det stilt krav til at den du søkte gjenforening med, skulle forsørge deg. Selv om
    dette familiemedlemmet ikke lenger forsørger deg, har du likevel ikke rett til
    supplerende stønad.
  ] else if grunn == "ALDERSPENSJON_FOLKETRYGDEN" [
    Du utnytter ikke fullt ut din rett til alderspensjon fra folketrygden, som er et
    krav for å kunne få rett til supplerende stønad. Dersom du ikke har søkt om
    alderspensjon, kan du kontakte Nav for å få vurdert om det er aktuelt.
  ] else if grunn == "ALDERSPENSJON_ANDRE_NORSKE_PENSJONSORDNINGER" [
    Du er registrert som medlem i en tjenestepensjonsordning. Vi har ikke mottatt
    informasjon om at du har fått vedtak fra denne ordningen. Du må ha utnyttet
    retten til alle pensjoner i Norge og utlandet for å få rett til supplerende
    stønad.
  ] else if grunn == "ALDERSPENSJON_UTENLANDSKE_PENSJONSORDNINGER" [
    Du har ikke fått vedtak om pensjon fra utlandet, som er et krav for å få rett til
    supplerende stønad.
  ] else if grunn == "FORMUE" [
    #if harEktefelle [
      Formuen du og ektefellen/samboeren din har til sammen er mer enn halvparten av
      folketrygdens grunnbeløp. For tiden er dette
      #currency(halvGrunnbeløp, truncate: true) kroner.
    ] else [
      Formuen din er mer enn halvparten av grunnbeløpet, som for tiden er
      #currency(halvGrunnbeløp, truncate: true) kroner.
    ]
    Hvis formuen din blir mindre, kan du søke om supplerende stønad på nytt. Du kan
    ikke gi bort formuen din for å få rett til supplerende stønad. Derfor må du
    dokumentere hva du har brukt formuen til hvis du søker på nytt.
  ] else if grunn == "PERSONLIG_OPPMØTE" [
    Du har ikke møtt personlig på Nav-kontoret, og har ikke dokumentert at du har
    vært for syk til å møte eller levert fullmakt som gir noen rett til å møte for
    deg.
  ] else if grunn == "FOR_HØY_INNTEKT" [
    #if harEktefelle [
      Inntekten du og ektefellen/samboeren din har til sammen er for høy.
    ] else [
      Du har for høy inntekt.
    ]
    Inntekten er høyere enn det du kan få i supplerende stønad.
  ] else if grunn == "SU_UNDER_MINSTEGRENSE" [
    Stønaden vi har beregnet til deg er for lav til at den kan utbetales. Vi kan ikke
    utbetale stønad som er under to prosent av den høyeste stønadssatsen.
  ] else if grunn == "MANGLENDE_DOKUMENTASJON" [
    Du har ikke sendt inn den dokumentasjonen vi har bedt om. Vi har derfor ikke
    nødvendig informasjon for å kunne vurdere om du har rett til supplerende stønad.

    Hvis vi mottar den dokumentasjonen vi har bedt om innen klagefristen, vil vi
    vurdere søknaden på ny.
  ] else {
    none
  }
}

#let avslagsliste() = {
  let punkter = items(get(data, "avslagsgrunner"))
    .map(avslagsgrunn-tekst)
    .filter(punkt => punkt != none)
  if punkter.len() > 0 { list(..punkter) }
}

#let formue-rad(formue, felt, tekst, negativ: false) = {
  let verdi = get(formue, felt)
  if not positive(verdi) { return () }
  (
    [#tekst],
    align(right)[#if negativ [-]#currency(verdi) kr],
  )
}

#let formue-tabell(formue) = {
  let rader = ()
  rader += formue-rad(
    formue,
    "verdiSekundærBoliger",
    "Verdi på bolig, fritidsbolig eller tomt utover vanlig bolig",
  )
  rader += formue-rad(formue, "verdiSekundærKjøretøyer", "Verdi på sekundære kjøretøy")
  rader += formue-rad(formue, "pengerIBanken", "Penger du har i banken")
  rader += formue-rad(formue, "depositumskonto", "Depositumskonto", negativ: true)
  rader += formue-rad(formue, "pengerIKontanter", "Penger i kontanter")
  rader += formue-rad(formue, "aksjerOgVerdiPapir", "Aksjer, aksjefond, eller verdipapirer")
  rader += formue-rad(formue, "pengerSøkerSkyldes", "Penger eller verdier noen skylder deg")
  if rader.len() > 0 {
    table(
      columns: (1fr, auto),
      stroke: none,
      inset: (x: 0pt, y: 3pt),
      ..rader,
    )
  }
}

#let formue() = {
  let formueVerdier = get(data, "formueVerdier")
  if formueVerdier == none { return }
  heading(level: 2)[Din formue]
  formue-tabell(get(formueVerdier, "søkersFormue"))
  let epsFormue = get(formueVerdier, "epsFormue")
  if epsFormue != none {
    heading(level: 2)[Ektefelle/samboers formue]
    formue-tabell(epsFormue)
  }
  table(
    columns: (1fr, auto),
    stroke: none,
    inset: (x: 0pt, y: 3pt),
    [*Totalt*], align(right)[*#currency(get(formueVerdier, "totalt")) kr*],
  )
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

= Vi har avslått søknaden din om supplerende stønad

#fødselsnummer()

Vi har avslått fordi:

#avslagsliste()

Vedtaket er gjort etter lov om supplerende stønad for personer med kort botid i Norge
#paragrafer(get(data, "avslagsparagrafer")).

#if truthy(get(data, "fritekst")) [
  #fritekst(get(data, "fritekst"))
]

#if inneholder(get(data, "avslagsgrunner"), "FORMUE") [
  #formue()
]

#if truthy(get(data, "beregningsperioder")) [
  #beregning()
]

#felles-info()

#hilsen()
