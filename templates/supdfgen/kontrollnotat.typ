#import "/templates/supdfgen/lib.typinc": *
#set document(title: "Supplerende stønad")
#set page(paper: "a4", margin: (top: 20mm, bottom: 20mm, left: 22mm, right: 22mm), footer: context align(right)[Side #counter(page).display()])
#set text(font: "Source Sans Pro", size: 10pt)
#let data = json("/data/supdfgen/kontrollnotat.json")
#let personalia = get(data, "personalia")

= Supplerende stønad







    
== Kontrollnotat


    

         
            

                 
== Kontrollnotat
 · 
            

        
        
            

                 
                    *Navn:*

                    #get(data, "navn.fornavn")

                    #get(data, "navn.etternavn")
         · 
         
            *Saksnummer:*

            #get(data, "saksnummer")
         · 
        

    

         
            *Dato og tidspunkt:*

            #get(data, "dagensDatoOgTidspunkt")
             · 
          · 
        

    
    



        

             
                

                     
                        
== Personlig oppmøte

                     · 
                

            
            
                

                     
                        *Har bruker møtt personlig?*
                     · 
                     

                            Ja
                        
                            Nei

                     · 
                

            
        

    

                 
                    

                         
                            
== Fullmakt og legeerklæring

                         · 
                    

                
                
                    

                         
                            *Foreligger det fullmakt og legeerklæring som bekrefter at sykdom gjør at bruker ikke kan møte personlig?*
                         · 
                         

                                Ja
                            
                                Nei

                         · 
                    

                
            

    

         
            

                 
                    
== Kontroll av reisedokumenter

                 · 
            

        
        
            

                 
                    *Har bruker framvist originalt pass og eventuelle andre originale reisedokumenter?*
                 · 
                 

                        Ja
                    
                        Nei

                 · 
            

            

                 
                    *Er det nye stempler i passet siden forrige møte?*
                 · 
                 

                        Ja
                    
                        Nei

                 · 
            

        
    



     
        

             
                
== Reise til utlandet

             · 
        

    
    
        

             
                *Har bruker vært utenlands siden siste møte?*
             · 
             

                    Ja
                
                    Nei

             · 
        


        

             
                *Registrerte utenlandsopphold*
             · 
             


                     
#get(data, "this")


                
                    
Ingen registrerte utenlandsopphold


             · 
        


        

             
                *Har bruker planer om å reise utenlands?*
             · 
             

                    Ja
                
                    Nei

             · 
        


        

             
                *Planlagte reisedatoer*
             · 
             


                     
#get(data, "this")


                
                    
Ingen datoer registrert


             · 
        


   

         
            *Har bruker fått beskjed om at reisedokumenter, billetter/boardingpass må tas vare på?*
         · 
         

                Ja
            
                Nei

         · 
    


    





     
        

             
                
== Økonomisk situasjon

             · 
        

    
    
        

             
                *Er det endringer i den økonomiske situasjonen for bruker eller ektefelle/partner/samboer?*
             · 
             

                    Ja
                
                    Nei

             · 
        

    





     
        

             
                
== Andre forhold

             · 
        

    
    
        

             
                *Er det endringer i andre forhold av betydning for stønaden (f.eks. sivilstand, institusjonsopphold, oppholdstillatelse)?*
             · 
             

                    Ja
                
                    Nei

             · 
        

    





     
        

             
                
== Skatteopplysninger

             · 
        

    
    
        

             
                *Er siste skattemelding og grunnlag for skatt for bruker og eventuell ektefelle/partner/samboer levert?*
             · 
             

                    Ja
                
                    Nei

             · 
        

    





     
        

             
                
== Kommentar

             · 
        

    
    
        

             

                    #get(data, "fritekst")
                
                    Ingen kommentar registrert

             · 
        

    




  

      

          Signatur,
          #get(data, "navn.fornavn")


              #get(data, "navn.mellomnavn")

          #get(data, "navn.etternavn"),
          #get(data, "dagensDatoOgTidspunkt")
      


      
--------------------------------------------------


    


        

    

