library(shiny)



safetyTabUI <- function(id) {
  ns <- NS(id)
  
  tabItem(
    tabName = "Safety",
    
    
    
    fluidRow(
      column(width = 8,
             box(title = "Sea Monster Attacks in Perspective",
                 status = "primary",
                 solidHeader = TRUE,
                 width = NULL,
                 h4("What are your chances of having an unwanted encounter with a sea monster? Realistically - very, very, ",
                    em("very"), "low."),
                 h4("Despite the millions of visitors to New England beaches each year, unprovoked sea monster attacks are exceedingly rare. In 2024 not a single unprovoked incident occurred in New England. Worldwide in 2024, there were less than 50 unprovoked stings, bites, and sinkings; 3 of which resulted in death."),
                 ), #box
             
             tags$head(
             tags$style(HTML("/* Force tables to have white background and dark text */
                               .shiny-table { 
                                 background-color: white !important; 
                                 color: #333333 !important;
                                   width: 100% !important;}
                             .shiny-table table { 
                               width: 100% !important; 
                               margin-bottom: 0px !important;}
                             /* Add a little padding so text isn't hitting the edges */
                             .shiny-table th, .shiny-table td {
                             padding: 8px !important;
                             border: 1px solid #ddd !important;}
                             /* Style the header specifically */
                             .shiny-table th {
                             background-color: #f5f5f5 !important;
                             font-weight: bold !important;}")
                        ) #tags$style
             ), #tags$head
             

             
             fluidRow(
               tags$head(
                 tags$style(HTML(".shiny-table { width: 100%; }
                 .shiny-table table { width: 100%; }
                                 "))
                 ), #tgas$head
               
               
               
               column(width = 6,
                      box(title = "2024 Water-Related Fatalities in US",
                          status = "info",
                          solidHeader = TRUE,
                          width = NULL,
                          tableOutput(ns("fatalitiesUS")),
                          p("Source(s): US Coast Guard, US Center for Disease Control, International Sea Monster Database")
                          ), #box

                      box(title = "Confirmed Unprovoked Sea Monster attacks since 1837 (New England)",
                          status = "info",
                          solidHeader = TRUE,
                          width = NULL,
                          tableOutput(ns("monsterAttacksNE")),
                          p("Source(s): International Sea Monster Database")
                          ) #box
               ), #column
               
               column(width = 6,
                      box(title = "2024 Worldwide Victim Activity at Time of Sea Monster Attack",
                          status = "info",
                          solidHeader = TRUE,
                          width = NULL,
                          tableOutput(ns("victimActivity")),
                          p("Source(s): International Sea Monster Database")
                          ), #box
                      
                      box(title = "Species Associated with Attacks (Global All-Time Records)",
                          status = "info",
                          solidHeader = TRUE,
                          width = NULL,
                          tableOutput(ns("speciesAttacks")),
                          p("Source(s): International Sea Monster Database")
                          ) #box
                      ) #column
             ) #nested fluidRow
      ), #column
      

      
      column(width = 4,
             box(title = "Reduce your chances of a sea monster encounter",
                 status = "danger",
                 solidHeader = T,
                 width = NULL,
                 h4("-Don't swim alone"),
                 h4("-Avoid wearing shiny jewelry"),
                 h4("-Avoid swimming at dawn or dusk"),
                 h4("-Avoid swimming near people fishing"),
                 h4("-Don't swim near schools of fish or seals"),
                 h4("-Stay near to shore or guards when possible"),
                 h4("-Be careful near steep drop-offs and sandbars"),
                 h4("-Avoid excessive splashing in waist-deep water")
                 ), #box
             box(title = "If you see a sea monster while swimming",
                 status = "danger",
                 solidHeader = T,
                 width = NULL,
                 h4("1. Don't panic, and remain as calm as possible."),
                 p("Chances are likely the creature is either on its way somewhere else, or is simply curious."),
                 h4("2. Avoid excessive splashing or rapid movements."),
                 p("Excessive splashing could reflect the movements of an injured animal."),
                 h4("3. Keep your eyes on the creature and turn your body/board to face it."),
                 p("Sea monsters try to avoid putting themselves in danger. They are less likely to approach if they think they're being watched."),
                 h4("4. Slowly make your way out of the water."),
                 p("Alert any lifeguards or other people who may be in the water."),
                 h4("5. Report your sighting online!"),
                 p("Check out the 'Get Involved' tab for more information.")
                 ) #box
             ) #column
    ) #fluidRow
  ) #tabItem
} #ui


#---SERVER----------------------------------------------------------------------

safetyTabServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    
    output$fatalitiesUS <- renderTable({
      data.frame(
        Category = c("Recreational Boating", "Drowning", "Sea Monster Bite"),
        Fatalities = c("556", ">4,500", "1")
      )
    }, striped = TRUE, bordered = TRUE, width = "100%")
    
    output$victimActivity <- renderTable({
      data.frame(
        Activity = c("Swimming / Wading", "Surfing / Board-sports", "Snorkeling / Free-diving", "Other"),
        Percent = c("50%", "34%", "8%", "8%")
      )
    }, striped = TRUE, bordered = TRUE, width = "100%")
    
    output$monsterAttacksNE <- renderTable({
      data.frame(
        State = c("Connecticut", "Maine", "Massachusetts", "Rhode Island", "New England Total"),
        Attacks = c("1", "2", "6", "2", "11")
      )
    }, striped = TRUE, bordered = TRUE, width = "100%")
    
    output$speciesAttacks <- renderTable({
      data.frame(
        Species = c("Cthulu", "Siren", "sea harpy"),
        Fatal = as.character(formatC(c(59, 103, 93), format = "f", digits = 0)),
        Non_Fatal = as.character(formatC(c(292, 39, 26), format = "f", digits = 0))
      )
    }, striped = TRUE, bordered = TRUE, width = "100%")
    
  }) #moduleServer
} #server