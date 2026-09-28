#import "/templates/supdfgen/lib.typinc": *
#set document(title: "Supplerende stønad")
#set page(paper: "a4", margin: (top: 20mm, bottom: 20mm, left: 22mm, right: 22mm), footer: context align(right)[Side #counter(page).display()])
#set text(font: "Source Sans Pro", size: 10pt)
#let data = json("/data/supdfgen/avsluttRevurdering.json")
#let personalia = get(data, "personalia")

= Supplerende stønad
== Varsel om at ny vurdering av din supplerende stønad er blitt avsluttet

        

        

            Vi har ikke funnet grunnlag for å revurdere din supplerende stønad, din supplerende stønad vil derfor ikke
            bli endret.
        



        
#get(data, "fritekst")



        
    


