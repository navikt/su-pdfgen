#import "/templates/supdfgen/lib.typinc": *

#set document(title: "Vedtak om supplerende stønad")
#set page(
  paper: "a4",
  margin: (top: 20mm, bottom: 20mm, left: 22mm, right: 22mm),
  footer: context align(right)[Side #counter(page).display()],
)
#set text(font: "Source Sans Pro", size: 10pt)

#let data = json("/data/supdfgen/vedtakInnvilgelse.json")
#let personalia = get(data, "personalia")

#align(left)[#image("/resources/Navlogo.png", width: 30mm, alt: "NAV logo")]
#v(16mm)
#if personalia != none [
  #get(personalia, "fornavn") #get(personalia, "etternavn")\
  Dato: #get(personalia, "dato")\
  Saksnummer: #get(personalia, "saksnummer")
]

= Du får supplerende stønad

Fødselsnummer: #get(personalia, "fnr")

Du får supplerende stønad fra #get(data, "fradato") til og med
#get(data, "tildato") fordi du er
#if get(data, "sakstype") == "ALDER" [
  over 67 år og har kort botid i Norge.
] else [
  ufør flyktning.
]

Vedtaket er gjort etter lov om supplerende stønad til personer med kort botid i
Norge, §§ 3, 5, 6 og 7.

#if truthy(get(data, "fritekst")) [
  #get(data, "fritekst")
]

== Slik beregner vi din supplerende stønad

#for periode in items(get(data, "beregningsperioder")) [
  === #capitalize(get(periode, "periode.fraOgMed")) til
  #capitalize(get(periode, "periode.tilOgMed"))

  Supplerende stønad, #get(periode, "sats") sats:
  #currency(get(periode, "satsbeløpPerMåned")) kr

  #if truthy(get(periode, "fradrag.bruker")) [
    Vi har redusert stønaden din med inntekt og andre fradrag.
  ]

  *Sum per måned:* #currency(get(periode, "ytelsePerMåned")) kr
]

Stønaden reguleres automatisk i samsvar med grunnbeløpet fra 1. mai hvert år.
