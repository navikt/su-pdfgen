#import "/templates/supdfgen/lib.typinc": *
#set document(title: "Supplerende stønad")
#set page(paper: "a4", margin: (top: 20mm, bottom: 20mm, left: 22mm, right: 22mm), footer: context align(right)[Side #counter(page).display()])
#set text(font: "Source Sans Pro", size: 10pt)
#let data = json("/data/supdfgen/forhåndsvarsel.json")
#let personalia = get(data, "personalia")
#if personalia != none [#align(left)[#image("/resources/Navlogo.png", width: 30mm, alt: "NAV logo")] #v(12mm) #get(personalia, "fornavn") #get(personalia, "etternavn")\ Dato: #get(personalia, "dato")\ Saksnummer: #get(personalia, "saksnummer")]
= Supplerende stønad
== Varsel om at vi vil ta opp din supplerende stønad til ny vurdering

        

        
Vi har fått opplysninger som gjør det nødvendig å vurdere saken din på nytt.



        
#get(data, "fritekst")



        

            
== Du kan uttale deg i saken

            

                Før vi gjør vedtak i saken, har du rett til å uttale deg. Fristen for å uttale seg er 14 dager etter at du har mottatt dette brevet.
                Uttalelsen bør være skriftlig. Kontakt oss gjerne på telefon
                #if get(data, "sakstype") == "ALDER" [
                    55 55 33 34
                ] else [
                    55 55 33 33
                ]
                for råd og veiledning.
                Du har også som hovedregel rett til å se sakens dokumenter etter bestemmelsene i forvaltningsloven § 18.
            


            

                Hvis du vil sende din uttalelse pr post kan du finne forside med adresse på nav.no under «Søknad og skjema»,
                og «Pensjon»,
                #if get(data, "sakstype") == "ALDER" [
                    «Supplerende stønad til personer over 67 år med kort botid i Norge»
                ] else [
                    «Supplerende stønad til ufør flyktning»
                ]
                og «Ettersendelse».
            


        


        

            
== Plikt til å melde fra

            

                Du har i tidligere vedtak blitt orientert om plikten din til å melde fra om endringer i forhold som kan ha betydning for retten til eller størrelsen på ytelsen din.
            


        


    
    


