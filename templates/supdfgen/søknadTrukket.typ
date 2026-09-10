#import "/templates/supdfgen/lib.typinc": *
#set document(title: "Supplerende stønad")
#set page(paper: "a4", margin: (top: 20mm, bottom: 20mm, left: 22mm, right: 22mm), footer: context align(right)[Side #counter(page).display()])
#set text(font: "Source Sans Pro", size: 10pt)
#let data = json("/data/supdfgen/søknadTrukket.json")
#let personalia = get(data, "personalia")

= Supplerende stønad
== Søknaden din om supplerende stønad er trukket

        

        

            Nav viser til søknaden din om supplerende stønad mottatt #get(data, "datoSøknadOpprettet").
            Du har i henvendelse av #get(data, "trukketDato") opplyst at du ønsker å trekke søknaden.
        


        

            Vi vil med dette bekrefte at søknaden om supplerende stønad er trukket, og ikke vil bli ytterligere
            behandlet.
        


        

            Du må levere ny søknad hvis du på et senere tidspunkt likevel ønsker å søke supplerende stønad.
        


        

            Supplerende stønad kan innvilges inntil 3 måneder forut for søknadstidspunktet hvis vilkårene var oppfylt i
            hele denne perioden. Ved en ny søknad blir den nye søknaden utgangspunktet for det tidspunktet du kan
            innvilges supplerende stønad fra.
        


        

            Vi gjør oppmerksom på at du etter forvaltningsloven § 18 har rett til å se sakens dokumenter.
        


        

            Skulle du ha spørsmål, er du velkommen til å kontakte oss på telefon

                55 55 33 34.
            
                55 55 33 33.

        


        

            Husk at du også kan finne mer informasjon på våre hjemmesider nav.no.
        


    


    
