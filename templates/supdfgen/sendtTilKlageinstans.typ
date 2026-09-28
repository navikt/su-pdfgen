#import "/templates/supdfgen/lib.typinc": *
#set document(title: "Supplerende stønad")
#set page(paper: "a4", margin: (top: 20mm, bottom: 20mm, left: 22mm, right: 22mm), footer: context align(right)[Side #counter(page).display()])
#set text(font: "Source Sans Pro", size: 10pt)
#let data = json("/data/supdfgen/sendtTilKlageinstans.json")
#let personalia = get(data, "personalia")

= Supplerende stønad
== Vi har sendt saken til Nav Klageinstans

        

            Fødselsnummer: #get(data, "personalia.fødselsnummer")
        


        
Vi har mottatt klagen din på vedtaket om supplerende stønad #get(data, "vedtakDato"), og kommet
            frem til at det ikke endres. Nav Klageinstans skal derfor vurdere saken din på nytt.



        
Informasjon om saksbehandlingstid finner du på nav.no.



        
== Dette har vi lagt vekt på i vurderingen vår

        
Vi viser til vedtak av #get(data, "vedtakDato") og klagen din på dette vedtaket som vi mottok
            #get(data, "klageDato").



        
 #get(data, "fritekst") 


        
Har du nye opplysninger eller ønsker å uttale deg, kontakt Nav
            Klageinstans på nav.no eller på telefon 21 07 17 30.



        
== Du har rett til innsyn

        På nav.no/minside kan du se dokumentene i saken din.

        
== Har du spørsmål?

        
 Du finner nyttig informasjon på

                www.nav.no/supplerende-stonad-over-67.
            
                nav.no/supplerende-stonad-flyktninger.

        



        
 Kontakt gjerne Nav Klageinstans på nav.no eller på telefon 21 07 17 30.
            Hvis du oppgir fødselsnummeret ditt når du tar kontakt med Nav, kan de
            lettere gi deg rask og god hjelp. 


    


    
