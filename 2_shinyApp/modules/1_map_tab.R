library(shiny)
library(leaflet)
library(plotly)



mapTabUI <- function(id) {
  ns <- NS(id)
  
  tabItem(
    tabName = "Map",
    
    fluidRow(
      
      column(width = 12,
             box(title = "Ahoy!",
                 status = "primary",
                 width = NULL,
                 solidHeader = T,
                 
                 h3("Note: This website is satire. Sea Monsters are probably(?) unreal."),
                 
                 h4("The map below displays the general location of monitoring stations and their affiliated data as part of the Maine Sea Monster Monitoring Program. Data from retired sites not shown. For more information, see the 'About the Survey' page. We recommend expanding this window to full-screen on a computer for the best exeprience."),
                 
                 h4("Sea monsters tagged by ",
                    tags$a("Maine DMR.",
                           href = "https://www.maine.gov/dmr/home",
                           target = "_blank"), (" "),
                    h4(strong("The map below is not to be used as a public safety tool.")))
             ) #box
      ), #column
      
      
      column(width = 6,
             box(title = "2023 Sea Monster Station Map",
                 status = "primary",
                 width = NULL,
                 solidHeader = TRUE,
                 
                 leafletOutput(ns("map"), height = 500)) #box
      ), #column
      
      
      column(width = 6,
             box(title = "Site ID (select one below or on the map)",
                 status = "primary",
                 solidHeader = TRUE,
                 width = NULL,
                 
                 selectInput(ns("siteSelect"), "",
                             choices = NULL)
             ), #box
             
             box(title = "Sea Monster Statistics By Site",
                 status = "primary",
                 solidHeader = TRUE,
                 width = NULL,
                 
                 uiOutput(ns("siteInfo"))) #box
      ), #column
      
      
      column(width = 12,
             box(title = "Receiver Funded by:",
                 status = "primary",
                 solidHeader = TRUE,
                 width = 4,
                 
                 uiOutput(ns("sponsorSite"))), #box
             
             box(title = "Next Data Check:",
                 status = "primary",
                 solidHeader = TRUE,
                 width = 4,
                 
                 uiOutput(ns("checkSite"))), #box
             
             box(title = "Initial Monitoring Year for this Site:",
                 status = "primary",
                 solidHeader = TRUE,
                 width = 4,
                 
                 uiOutput(ns("originSite"))) #box
      ), #column
      
      
      column(width = 12,
             uiOutput(ns("tempBoxUI"))
             
      ) #column
      
    ) #fluidRow
    
  ) #tabItem
} #ui



#---SERVER----------------------------------------------------------------------

mapTabServer <- function(id, sites, temp) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    
    
    updateSelectInput(session, "siteSelect",
                      choices = c("Select a site" = "", na.omit(sites$ID)))
    
    
    
    output$map <- renderLeaflet({
      leaflet(data = sites,
              options = leafletOptions(zoomControl = TRUE, minZoom = 7, maxZoom = 12)) %>%
        addTiles() %>%
        setView(lng = -70.2, lat = 43.5, zoom = 9) %>%
        addCircleMarkers(
          lng = ~lon, lat = ~lat,
          fillColor = "red", color = "black", weight = 1, stroke = T, fillOpacity = 0.8,
          radius = 7, label = ~ID, layerId = ~ID) %>%
        addLabelOnlyMarkers(
          lng = ~lon,
          lat = ~lat,
          label = ~ID,
          labelOptions = labelOptions(
            noHide = TRUE,
            direction = 'bottom',
            textOnly = TRUE,
            style = list(
              "font-size" = "15px",
              "color" = "black",
              "text-align" = "center")))
    }) #output$map
    
    
    
    # Sync map clicks with dropdown
    observeEvent(input$map_marker_click, {
      click <- input$map_marker_click
      if (!is.null(click$id)) {
        updateSelectInput(session, "siteSelect", selected = click$id)}
    }) #observeEvent
    
    
    
    # Highlight selected receiver
    observe({
      req(input$siteSelect)
      sel <- sites[sites$ID == input$siteSelect, ]
      
      leafletProxy(ns("map")) %>%
        clearGroup("selected") %>%
        addCircleMarkers(
          lng = sel$lon,
          lat = sel$lat,
          color = "gold",
          radius = 8,
          fillOpacity = 1,
          group = "selected")
    }) #observe
    
    
    
    # Info output with shinydashboard boxes
    output$siteInfo <- renderUI({
      req(input$siteSelect)
      s <- sites[sites$ID == input$siteSelect, ]
      
      fluidRow(
        
        # 2023 Sea Monster Stats box
        box(
          title = "2023 Data", 
          status = "info", 
          solidHeader = TRUE, 
          width = 12,
          
          p(strong("Date of Deployment:"), as.character(s$deploy_date)),
          p(strong("Date of Last Check:"), as.character(s$lastCheck)),
          p(strong("Tagged sea monsters detected in 2023**:"), s$transmittersDet2023),
          p(strong("Visits from tagged sea monsters in 2023:"), s$transmitterVisits2023),
          p(strong("Dates of Activity in 2023:"), s$dates2023)
          ), #box
        
        # Historical Sea Monster Stats box
        box(
          title = "Historical Data", 
          status = "info", 
          solidHeader = TRUE, 
          width = 12,
          
          p(strong("Number of years data is available:"), s$yrs_avail),
          p(strong("Total tagged sea monsters detected at this site:"), s$totalTransmitters),
          p(strong("Total visits from sea monsters at this site:"), s$totalVisits)
        ) #box
        
      ) #fluidRow
    }) #output
    
    
    
    # About Site output with a shinydashboard box
    output$sponsorSite <- renderUI({
      req(input$siteSelect)
      s <- sites[sites$ID == input$siteSelect, ]
      h4(s$sponsor)
    }) #renderUI
    
    
    
    # About Site output with a shinydashboard box
    output$originSite <- renderUI({
      req(input$siteSelect)
      s <- sites[sites$ID == input$siteSelect, ]
      h4(s$origin)
    }) #renderUI
    
    
    
    # About Site output with a shinydashboard box
    output$checkSite <- renderUI({
      req(input$siteSelect)
      s <- sites[sites$ID == input$siteSelect, ]
      h4(s$nextCheck)
    }) #renderUI
    
    
    # temperature plot
    filteredTable <- reactive({
      req(input$siteSelect)
      df <- temp[temp$ID == input$siteSelect[1], ]
      df <- df[order(df$datetime), ]
      if (nrow(df) > 1) {
        time_diff <- difftime(df$datetime[-1], df$datetime[-nrow(df)], units = "hours")
        df$temp[c(FALSE, time_diff > 12)] <- NA}
      df
    }) #reactive
    
    
    
    output$tempBoxUI <- renderUI({
      req(input$siteSelect)
      s <- sites[sites$ID == input$siteSelect, ]
      
      loc_label <- s$sensorLoc
      
      box(title = paste("2023", loc_label, "Temperature Recordings at Site", s$ID),
          status = "success",
          solidHeader = TRUE,
          width = NULL,
          plotlyOutput(ns("temp"))) 
    }) #renderUI
    
    
    
    output$temp <- renderPlotly({
      temp_data <- filteredTable()
      req(input$siteSelect)
      s <- sites[sites$ID == input$siteSelect, ]
      loc_label <- s$sensorLoc
      
      if (nrow(temp_data) > 0) {
        plot_ly(
          data = temp_data,
          x = ~datetime,
          y = ~temp,
          type = 'scatter',
          mode = 'lines',
          line = list(color = 'black', width = 1),
          marker = list(color = 'green', size = 1),
          hovertemplate = paste(
            "Datetime: %{x|%b %d %H:%M}", "<br>",
            loc_label, " Temp: %{y:.1f}°F<extra></extra>")) %>% 
          layout(
            annotations = list(
              x = 0.1,
              y = 0.9,
              text = "SST values shown are for example only",
              showarrow = FALSE,
              xref = "paper",
              yref = "paper",
              font = list(size = 18, color = "red")
            ),
            yaxis = list(
              title = paste(loc_label, "Temperature (°F)"), 
              tickfont = list(size = 15), 
              titlefont = list(size = 15)),
            xaxis = list(
              title = "Date",
              tickformat = "%b %d",
              dtick = 7 * 24 * 60 * 60 * 1000,
              tickangle = 45,
              tickfont = list(size = 12),
              titlefont = list(size = 15),
              type = "date"),
            plot_bgcolor = "rgba(0,0,0,0)",
            paper_bgcolor = "rgba(0,0,0,0)",
            margin = list(t = 40, b = 80, l = 60, r = 40),
            hoverlabel = list(font = list(size = 13)))} 
      else {
        # Completely empty plot with annotation
        plot_ly() %>%
          layout(
            annotations = list(
              x = 0.5,
              y = 0.5,
              text = "No temperature data available for this site",
              showarrow = FALSE,
              xref = "paper",
              yref = "paper",
              font = list(size = 18, color = "red")
            ),
            xaxis = list(visible = FALSE),
            yaxis = list(visible = FALSE)
          )
      }
    }) #renderPlotly
      }) #moduleServer
} #server
