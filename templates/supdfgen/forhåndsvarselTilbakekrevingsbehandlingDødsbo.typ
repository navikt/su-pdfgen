#import "/templates/supdfgen/lib.typinc": *
#set document(title: "Supplerende stønad")
#set page(paper: "a4", margin: (top: 20mm, bottom: 20mm, left: 22mm, right: 22mm), footer: context align(right)[Side #counter(page).display()])
#set text(font: "Source Sans Pro", size: 10pt)
#let data = json("/data/supdfgen/forhåndsvarselTilbakekrevingsbehandlingDødsbo.json")
#let personalia = get(data, "personalia")

= Supplerende stønad











    
== Vi vurderer om boet må betale tilbake supplerende stønad


    

        Avdøde #get(data, "personalia.fornavn") #get(data, "personalia.etternavn") har fått utbetalt
        #currency(get(data, "kravgrunnlag.sumBruttoSkalTilbakekreve"), truncate: true) kroner for mye
        supplerende stønad fra og med #get(data, "fraOgMed") til og med #get(data, "tilOgMed").
    



    

        Før vi avgjør om dette beløpet skal betales tilbake, har boet rett til å uttale seg. Dette må boet gjøre
        innen 14 dager etter at boet har fått dette varselet.
    


    

        Dette er kun et varsel om at vi vurderer å kreve tilbake det feilutbetalte beløpet. Det er ikke et vedtak om
        tilbakekreving.
    


    

        Hvis vi vedtar at boet må betale tilbake hele eller deler av det feilutbetalte beløpet, trekker vi fra
        skatten på beløpet vi krever tilbake.
    



    

        
== Hva som har skjedd

        
#get(data, "fritekst")


    


    

        
== Reglene for tilbakekreving

        

            Hvis mottakeren av feilutbetalingen forsto eller burde forstått at utbetalingen som han har mottatt er
            gjort på feil grunnlag, skal det feilutbetalte beløpet kreves tilbakebetalt. Når mottakeren er død, blir
            det avgjørende for spørsmålet om tilbakekreving hva dødsboet forsto eller burde forstått på det tidspunktet
            det fikk tilgang til avdødes post og bankkontoer.
        


        
Dette følger av lov om supplerende stønad § 13.


    


    

        
== Slik uttaler boet seg

        

            Dødsboet har rett til å uttale seg, skriftlig eller muntlig,
            før vi tar den endelige avgjørelsen om tilbakebetaling.
            Fristen for å gi uttale er 14 dager etter at boet har mottatt dette brevet.
        


        

            Dødsboet kan uttale seg muntlig ved fremmøte hos det lokale Nav-kontoret,
            ved å ringe telefonnummeret nedenfor, eller det kan sende et skriftlig svar sammen med forside.
            Boet finner forsiden under "Skjema og søknad" ved å velge "Pensjon" og deretter
            "Supplerende stønad til personer med kort botid i Norge". Bruk valget "Ettersendelse", "Ettersend på papir"
            og "Annet". Fyll ut aktuelle punkter og fødselsnummeret til avdøde før boet velger "Neste".
            Last ned "Førsteside til saken din" og skriv ut denne.
        


    


    

        
== Hva skjer videre i saken?

        

            Vi vil vurdere saken og sende boet et vedtak. Hvis boet må betale tilbake hele eller deler av beløpet, får
            boet beskjed i vedtaket om hvordan tilbakebetalingen skal skje.
        


    


    

        
== Boet har rett til innsyn

        

            Boet har som hovedregel rett til å se dokumentene i saken etter reglene i forvaltningsloven § 18.
        


    


    

        
== Har boet spørsmål?

        

            Kontakt oss gjerne på nav.no eller på telefon

                55 55 33 34
            
                55 55 33 33
            .
            Hvis boet oppgir fødselsnummeret til avdøde når
            de tar kontakt med Nav, kan vi lettere gi rask og god hjelp.
        


    







    

        
== Vedlegg: Beregning av feilutbetalt beløp

        

             
            

                 Periode · 
                 Feilutbetalt beløp · 
            

            
            

                

                     #get(data, "periode") · 
                     #currency(get(data, "bruttoSkalTilbakekreve"), truncate: true) kr · 
                


            
        

    

