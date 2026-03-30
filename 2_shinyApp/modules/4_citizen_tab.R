library(shiny)


citizenTabUI <- function(id) {
  ns <- NS(id)
  
  tabItem(
    tabName = "Citizen",
    
    fluidRow(
      column(width = 7,   
             box(title = "Get Involved",
                 width = NULL,
                 solidHeader = T,
                 status = "primary",
                 h4("Monitoring large sea monsters often requires collaboration between state and federal governments, commercial and recreational fishermen, non-profit organizations, psychics, and members of the general public. Each stakeholder plays one or more important roles, and were it not for our partners in these industries as well as those in education and beach emergency response, our program would not be as robust as it is today."),
                 h2("", style = "margin-bottom: 20px;"),
                 h3("Citizen Science Opportunities"),
                 h2("", style = "margin-bottom: 20px;"),
                 h4(strong("Report sea monster sightings")),
                 h4("If you believe you see a sea monster in coastal Maine waters, you can report it via the 'Contact Us' page"),
                 h2("", style = "margin-bottom: 20px;"),
                 h4(strong("Report predated animals")),
                 h4("If you see an animal displaying fresh wounds that appear to have come from a sea monster, you can submit your sighting through the 'Contact Us' page. These records help to identify coastal areas where sea monster foraging may be prevelant."),
                 h2("", style = "margin-bottom: 20px;"),
                 h4(strong("Sponsor a receiver site")),
                 h4("If you or your community is interested in purchasing an acoustic receiver for us to place in a certain area, reach out to us via the 'Contact Us' page and select 'Research' as your inquiry subject. Let us know the area you are interested in, and we can discuss feasibility."),
                 h2("", style = "margin-bottom: 20px;"),
                 h4(strong("Receiver deployment")),
                 h4("Receiver sites are deployed in a joint effort between scientists and contracted commercial fishermen. As of now, sites to the west of Rockland are deployed by two fishermen. To the east of Rockland, sites are broken up between many fishermen. If you are interested in potentially participating, reach out to us on the 'Contact Us' page and and select 'Research' as your inqiry subject."),
                 h3("More Ways to Stay Engaged"),
                 h2("", style = "margin-bottom: 20px;"),
                 h4(strong("Visit the Maine Aquarium")),
                 h4("The",
                    tags$a("Maine State Aquarium",
                           href = "https://www.maine.gov/dmr/programs/education-division/aquarium",
                           target = "_blank"),
                    "located in West Boothaby Harbor is open each summer and has a series of interactive exhibits highlighting the ecosystems and various animals found in the Gulf of Maine, including sea monsters!"),
                 h2("", style = "margin-bottom: 20px;"),
                 h4(strong("Classroom education")),
                 h4("Upon request, DMR scientists have presented to students ranging from middle school to graduate school. If you're a teacher and are interested in having us talk to your students, reach out through the 'Contact Us' page to see our availability."),
                 h4(strong("Lectures and events")),
                 h4("Similarly, DMR scientists have given presentations to communities and at events on topics including sea monster ecology, safety measures, species identification, monster management, and conservation. While there is much information that can be found online, we recognize the value that comes from in-person events and discussions. If interested, reach out through the 'Contact Us' page to see our availability."),
                 h2("", style = "margin-bottom: 20px;")
                 ) #box
             ), #column
      
      
      
      column(width = 5,
             box(width = NULL,
                 solidHeader = F,
                 status = "success",
                 img(src="monster.jpg",
                     width = "100%",
                     style = "max-height: 300px; object-fit: cover;"),
                 p("Depiction of sea monster sighted off Casco Bay, ME. Credit: Emergence Magazine")),
             box(width = NULL,
                 solidHeader = F,
                 status = "success",
                 img(src="lr.jpg",
                     width = "100%",
                     style = "max-height: 300px; object-fit: cover;"),
                 p("Deployment of a real time receiver. Credit: Maine DMR")),
             box(width = NULL,
                 solidHeader = F,
                 status = "success",
                 img(src="aquarium.jpg",
                     width = "100%",
                     style = "max-height: 300px; object-fit: cover;"),
                 p("Maine Aquarium. Credit: Boothbay Harbor Chamber of Commerce"))
             ) #column
      ) #fluidRow
    ) #tabItem
} #UI
      
      
#---SERVER----------------------------------------------------------------------

citizenTabServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
  }) #moduleServer
} #server
