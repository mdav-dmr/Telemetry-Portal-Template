library(shiny)


contactTabUI <- function(id) {
  ns <- NS(id)
  
  tabItem(
    tabName = "Contact",
    fluidRow(
      column(width = 8,   
             box(title = "Contact Form",
                 width = NULL, solidHeader = TRUE, status = "primary",
                 h4("The Sea Monster Program at the Maine DMR prides itself on transparency, outreach, and public engagement. There are a limited number of staff members assigned to this work, and so we kindly ask for your patience in responding to emails, particularly during summer months."),
                 textInput(ns("name"), "Your Name", width = "300px"),
                 textInput(ns("email"), "Your Email", width = "300px"),
                 radioButtons(ns("inquiryType"), "Type of Inquiry",
                              choices = c("Media", "Research", "Sighting", "Public Event", "Other")),
                 textAreaInput(ns("message"), "Message", "", width = "450px", height = "150px"),
                 actionButton(ns("send"), "Send Message"),
                 hr(),
                 textOutput(ns("status")) 
             ) #box
      ) #column
    ) #fluidRow
  ) #tabItem
} #ui

#---SERVER---
contactTabServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    
    observeEvent(input$send, {
      # Debug line
      print("Button Pressed - Attempting to send...") 
      
      # Ensure fields aren't empty
      req(input$name, input$email, input$message)
      
      power_automate_url <- "enter Power Automate url here"
      
      payload <- list(
        name = input$name,
        email = input$email,
        inquiry_type = input$inquiryType,
        message = input$message
      )
      
      # Send the request
      res <- tryCatch({
        httr::POST(
          url = power_automate_url,
          body = payload,
          encode = "json",
          httr::timeout(10) # Prevent hanging if the internet is slow
        )
      }, error = function(e) return(e))
      
      # Handle result
      if (inherits(res, "error")) {
        output$status <- renderText(paste("❌ Connection Error:", res$message))
      } else if (res$status_code >= 200 && res$status_code < 300) {
        output$status <- renderText("✅ Message sent successfully!")
      } else {
        output$status <- renderText(paste("⚠️ Error Code:", res$status_code))
      }
    }) 
  })
}