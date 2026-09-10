#import "/templates/supdfgen/lib.typinc": *

#set document(title: "Søknad om supplerende stønad")
#set page(paper: "a4", margin: 22mm, footer: context align(right)[Side #counter(page).display()])
#set text(font: "Source Sans Pro", size: 10pt)

#let data = json("/data/supdfgen/soknad.json")
#let søknad = get(data, "søknadInnhold")

= Søknad om supplerende stønad

== For NAV
#get(søknad, "forNav")

== Personopplysninger
#get(søknad, "personopplysninger")

== Boforhold
#get(søknad, "boforhold")

#if get(søknad, "uførevedtak") != none [
  == Uførevedtak
  #get(søknad, "uførevedtak")
]

#if get(søknad, "flyktningsstatus") != none [
  == Flyktningstatus og oppholdstillatelse
  #get(søknad, "flyktningsstatus")
  #get(søknad, "oppholdstillatelse")
]

#if get(søknad, "harSøktAlderspensjon") != none [
  == Alderspensjon
  #get(søknad, "harSøktAlderspensjon")
]

#if get(søknad, "oppholdstillatelseAlder") != none [
  == Oppholdstillatelse
  #get(søknad, "oppholdstillatelseAlder")
]

== Formue
#get(søknad, "formue")

== Inntekt og pensjon
#get(søknad, "inntektOgPensjon")

#if get(søknad, "boforhold.delerBoligMed") == "EKTEMAKE_SAMBOER" [
  == Ektefelle eller samboer
  #get(søknad, "ektefelle.formue")
  #get(søknad, "ektefelle.inntektOgPensjon")
]

== Utenlandsopphold
#get(søknad, "utenlandsopphold")
