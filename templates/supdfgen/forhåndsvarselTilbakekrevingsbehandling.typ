#import "/templates/supdfgen/lib.typinc": *
#set document(title: "Supplerende stønad")
#set page(paper: "a4", margin: (top: 20mm, bottom: 20mm, left: 22mm, right: 22mm), footer: context align(right)[Side #counter(page).display()])
#set text(font: "Source Sans Pro", size: 10pt)
#let data = json("/data/supdfgen/forhåndsvarselTilbakekrevingsbehandling.json")
#let personalia = get(data, "personalia")

= Supplerende stønad











    
== Varsel om at Nav vurderer å kreve tilbake feilutbetalt supplerende stønad

    


        
Du har fått utbetalt for mye supplerende stønad. Vi vurderer å kreve tilbake dette beløpet.


        
Beløpet er #get(data, "kravgrunnlag.sumBruttoSkalTilbakekreve") kroner før skatt.


        
Du finner flere detaljer om feilutbetalt beløp lenger ned i brevet.



        

            
== Hva har skjedd

            
#get(data, "fritekst")


        

    
        
#get(data, "fritekst")




    

        
== Dette legger vi vekt på i vurderingen vår

        
Når vi avgjør om du skal betale tilbake vurderer vi:


        

            
- Om du forsto eller burde forstått at beløpet du fikk utbetalt var feil
            
- Om du har gitt riktig informasjon til Nav
            
- Om du har gitt all informasjon til Nav i rett tid
            
- Hvilken informasjon du har fått fra Nav, blant annet i vedtak
        

        
Selv om det er Nav som er skyld i feilutbetalingen, kan vi kreve at du betaler tilbake pengene hvis du forsto
            eller burde forstått at utbetalingen skyldtes en feil.


    


    

        
== Reglene for tilbakekreving

        

            Hvis du forsto eller burde forstått at utbetalingen du har mottatt er gjort på feil grunnlag, skal det
            feilutbetalte beløpet kreves tilbakebetalt. Dette gjelder uavhengig av om det er Nav eller du som er skyld i
            feilutbetalingen/har forårsaket feilutbetalingen.
        


        
Dette følger av lov om supplerende stønad § 13.


        
Dersom Nav fatter vedtak om at du skal betale tilbake det du har fått for mye utbetalt, får du beskjed i
            vedtaket
            om hvordan tilbakebetalingen skal skje.


    


    

        
== Dette gjør du hvis du ønsker å uttale deg i saken

        
Du har rett til å uttale deg, skriftlig eller muntlig, før vi tar den endelige avgjørelsen om
            tilbakebetaling.
            Fristen for å gi uttale er 14 dager etter at du har mottatt dette brevet.


        
Du har rett til å se sakens dokumenter etter bestemmelsene i forvaltningsloven § 18.


    


    

        
Slik kan du uttale deg:


        

            
- Logg deg inn på nav.no eller
            
- Send et skriftlig svar
            
- Du kan få hjelp ved å ringe

                    55 55 33 34
                
                    55 55 33 33

                eller henvende deg til Nav-kontoret ditt
            
        

        

            Hvis du vil sende skriftlig svar, må du bruke forsiden fra

                
                    https://www.nav.no/ettersende\#supplerende-stonad-for-ufore-flyktninger-under-67-ar
                
            
                
                    https://www.nav.no/ettersende\#supplerende-stonad-for-personer-over-67-ar-med-kort-botid-i-norge
                

        


    







    

        
== Vedlegg: Beregning av feilutbetalt beløp

        

             
            

                 Periode · 
                 Feilutbetalt beløp · 
            

            
            

                

                     #get(data, "periode") · 
                     #currency(get(data, "bruttoSkalTilbakekreve"), truncate: true) kr · 
                


            
        

    

