library(shiny)



aboutTabUI <- function(id) {
  ns <- NS(id)
  
  tabItem(
    tabName = "About",
    
    fluidRow(
      column(width = 7,
       box(title = "Program Origins",
           width = NULL,
           solidHeader = T,
           status = "primary",
           h4("The Sea Monster Monitoring Program was created partly in response to people being scared of, well, sea monsters! On Friday the 13th at some point in history, a sea dragon was spotted near Vinalhaven. This led to a surge in public interest, as is often the case following sightings of mystical beings. While such events are rare, they can have a significant impact on how people perceive risk when in and on the ocean."),
           h4("In the years following, Maine iniated a preliminary research project to track sea monster activity in State waters. Results from the survey would reveal more activity from sea monsters than was previously expected, and it was determined to solidify the program for continued monitoring into the future.")),
       box(title = "Survey Framework",
           width = NULL,
           solidHeader = T,
           status = "primary",
           h3("Tagging"),
           h4("Since 2015, ",
              tags$a("Maine scientists",
                     href = "enter website url here",
                     target = "_blank"),
              "has been tagging sea monsters in the Gulf of Maine. The most common type of tag they've been using are called acoustic transmitters, each which is programmed to transmit a unique ultrasonic signature."),
           h3("Monitoring Stations"),
           h4("Sea monsters that have been outfitted with acoustic transmitters can be detected by stationary underwater devices called acoustic receivers. Acoustic receivers are placed in fixed locations underwater near areas of interest, such as beaches. When a tagged fish swims within 1,500-3,000' of an acoustic receiver, the receiver records a detection event, which includes the date and time of the detection as well as that transmitter's unique signature. In most cases, acoustic receivers are not able to send alerts in real time to scientists or beach officials when a detection event occurs, because most receivers don't have a way of communicating over long distances. Rather, detection events must be downloaded at the end of a season when receivers are physically retrieved. As such, data from these surveying methods are more appropriate for long-term monitoring to determine seasonal and spatial trends in sea monster presence, rather than real time public safety."),
           h3("Seasonality"),
           h4("In 2020, acoustic receivers were deployed in August and retrieved in December. From 2021 to present, receivers are deployed during May, checked during August/September, and retrieved during October/November. This timing coincides with the primary season that sea monsters are present, but likely misses some early arivals and late departures. Most receivers are not deployed during winter to mitigate potential loss due to weather, which would result in lost data.")
           ) #box
       ), #column
      
      
      
      column(width = 5,
             box(width = NULL,
                 solidHeader = F,
                 status = "success",
                 img(src="tagging.jpg",
                     width = "100%",
                     style = "max-height: 300px; object-fit: cover;"),
                 p("Dr. (Name redacted) tagging a sea monster. Credit: Maine DMR")),
             box(width = NULL,
                 solidHeader = F,
                 status = "success",
                 img(src="receiver.jpg",
                     width = "100%",
                     style = "max-height: 300px; object-fit: cover;"),
                 p("Acoustic Receiver, model VR2Tx. Credit: Innovasea, Inc.")),
             box(width = NULL,
                 solidHeader = F,
                 status = "success",
                 img(src="anchors and receivers.jpg",
                     width = "100%",
                     style = "max-height: 300px; object-fit: cover;"),
                 p("Maine DMR receiver moorings. Credit: Maine DMR"))
             ) #column
      ) #fluidRow
    ) #tabItem
} #UI
      
      
#---SERVER----------------------------------------------------------------------

aboutTabServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
  }) #moduleServer
} #server
