library(shiny)
library(tidyverse)
source("helper_functions.R", local = F)

# Define UI for slider demo app ----
ui <- fluidPage(
  
  # App title ----
  titlePanel("Project_2"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar to demonstrate various slider options ----
    sidebarPanel(
      
      
      selectInput("select", label = h3("Select a variable"),
                  choices = list("Bus" = "Bus", "Food" = "Food", "Cloth" = "Cloth", "School"="School", "Hygiene"="Hygiene"), 
                  selected = 1),
      
      
      #output 
      fluidRow(column(width=12, verbatimTextOutput("value")))
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: plot for each of the variables ----
      plotOutput(outputId = "popPlot")
      
    )
  )
)



server <- function(input, output) {
  
  # 
  output$value <- renderPrint({ 
    paste("You have selected", input$select)
  })
  
  
  output$popPlot <- renderPlot({
    plot(input$select)
    
  })
  
}

# Create Shiny app ----
shinyApp(ui, server)
