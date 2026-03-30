library(shiny)
library(shinydashboard)
library(dashboardthemes)
library(here)

### Load data
sites <- read.csv("data/data.csv")
temp <- read.csv("data/temp.csv")

### Load modules
source("modules/1_map_tab.R")
source("modules/2_about_tab.R")
source('modules/3_safety_tab.R')
source('modules/4_citizen_tab.R')
source('modules/5_contact_tab.R')


### UI Layout
ui <- dashboardPage( 
  
  dashboardHeader(
    title = "Maine Sea Monster Data Portal",
    titleWidth = 330,
    tags$li(
      class = "dropdown",
      tags$a(
        href = "enter link url here",
        target = "_blank", "Return to ___ Website",
        style = "color: black;
        font-weight: bold;
        text-decoration: underline;
        margin-right: 20px;") #tags$a
    ) #tags$li
  ), #dashboardHeader
  
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Map", tabName = "Map"), 
      menuItem("About The Survey", tabName = "About"), 
      menuItem("Sea Monsters and Safety", tabName = "Safety"),
      menuItem("Get Involved", tabName = "Citizen"),
      menuItem("Contacts Us", tabName = "Contact")
    ) #sidebarMenu
  ), #dashboardSidebar
  
  
  dashboardBody(
    shinyDashboardThemes(theme = "poor_mans_flatly"),
    tags$head(
      tags$style(HTML(".box-title {
          font-size: 20px !important;
          font-weight: bold;
        }")) #tags$style
      ), #tags$head
    
    tags$head(
      tags$style(HTML("/* Fix header at top */
        .main-header {
          position: fixed;
          width: 100%;
          z-index: 1000;}
        /* Adjust body padding so content isn't hidden behind header */
        .content-wrapper, .right-side {
          padding-top: 50px; /* adjust to your header height */}")) #tags$style
      ), #tags$head
    
    tags$style(HTML("body, .content-wrapper, .right-side {
        background-color: #CDCBC5 !important;  /* background */
        background-image: none !important;}
      /* Default cursor */
      body {cursor: url('cursor.png'), auto;}
      /* Cursor for clickable elements on hover */
      button:hover,
      a:hover,
      input:hover,
      select:hover,
      textarea:hover {cursor: url('cursor2.png'), auto !important;}
      /* Specific fix for select dropdown arrow */
      select::-ms-expand { /* IE/Edge */
        cursor: url('cursor2.png'), auto !important;}
      select {-webkit-appearance: none; /* Chrome/Safari */
        -moz-appearance: none;    /* Firefox */
        appearance: none;}
      /* Add top padding only when columns stack (small screens) */
        @media (max-width: 991px) { 
          .content-wrapper, .right-side {
            padding-top: 100px !important;}}")
               ), #tags$style
    
    tabItems(
      mapTabUI("mapTab"),
      aboutTabUI("aboutTab"),
      safetyTabUI("safetyTab"),
      citizenTabUI("citizenTab"),
      contactTabUI("contactTab")
    ) #tabsItems
  ) #dashboardBody 
) #ui

# --- SERVER ---
server <- function(input, output, session) {
  mapTabServer("mapTab", sites, temp)
  aboutTabServer("aboutTab")
  safetyTabServer("safetyTab")
  citizenTabServer("citizenTab")
  contactTabServer("contactTab")
  } #server

# --- Run App ---
shinyApp(ui, server)
