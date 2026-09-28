#import "/templates/supdfgen/lib.typinc": *
#set document(title: "Supplerende stønad")
#set page(paper: "a4", margin: (top: 20mm, bottom: 20mm, left: 22mm, right: 22mm), footer: context align(right)[Side #counter(page).display()])
#set text(font: "Source Sans Pro", size: 10pt)
#let data = json("/data/supdfgen/avvistKlage.json")
#let personalia = get(data, "personalia")

= Supplerende stønad
== Nav har avvist klagen din

        

            Fødselsnummer: #get(data, "personalia.fødselsnummer")
        

        
#get(data, "fritekst")


    

