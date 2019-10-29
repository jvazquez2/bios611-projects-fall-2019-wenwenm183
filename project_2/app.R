library(shiny)
library(tidyverse)
source("helper_functions.R", local = F)

# Define UI for application that answers three questions: 
  #From the total number of client, identify one-time clients and frequent (visit at least 2 times in one year) clients 
  #Use a heatmap to understand the relationship between services and time of the year 
  #Use a Scatter plot to describe the statistics over the years. 
ui <- fluidPage(
  
  # App title ----
  titlePanel("Project 2"),
  
  # Sidebar layout with input and output definitions ----

  navlistPanel("Analysis of UMD", 
                tabPanel("Clients",
                         h4('Plot of Different types of Clients'), 
                         sidebarLayout(
                           sidebarPanel(
                             # Input the type of client (one-time, frequent, or total number of client) for line plot
                             selectInput("client", "Please Select Variable for Client",
                             choices=list("One-time"="One-time", 
                                          "Frequent"="Frequent",
                                          "Total"="Total"), 
                                          selected=1
                             ), 
                             textOutput("value3")
                           ),
                           mainPanel(
                             plotOutput(outputId = "LinePlot")
                           ) 
                         )
                ),
                 
                tabPanel("Heatmap", 
                         h4('Heatmap of Different Services Provided by UMD'),
                         sidebarLayout(
                           sidebarPanel(
  # Input the services that are provided by the UMD to generate a heatmap using year and month.
                             selectInput("heatmap", "Please Select Variable for Heatmap",
                                         choices = list("Bus" = "Bus", 
                                                        "Food" = "Food", 
                                                        "Cloth" = "Cloth", 
                                                        "School_kits"="School_kits", 
                                                        "Hygiene_kits"="Hygiene_kits"), 
                                         selected = 1
                             ),
                             textOutput("value")
                           ),
                           # Main panel for displaying outputs ----
                           mainPanel(
                             # Output: plot for each of the variables ----
                             plotOutput(outputId = "popPlot")
                           ) 
                         )
                ),
                
                tabPanel("Scatter Plots", 
                         h4('Scatter Plots of Different Services Provided by UMD'), 
                         sidebarLayout(
                           sidebarPanel(
                             selectInput("Scatter", 
                                         h5("Scatter Plots of Which Variable"), 
 # Input the services that are provided by the UMD to generate a scatter plot on the relationship between service and year.    
                                         choices = list("Bus" = "Bus", 
                                                        "Food" = "Food", 
                                                        "Cloth" = "Cloth", 
                                                        "School_kits"="School_kits", 
                                                        "Hygiene_kits"="Hygiene_kits"), 
                                         selected = 1
                             ),
                             textOutput("value2")
                           ),
                         mainPanel( 
                           # Output: plot for each of the variables ----
                           plotOutput("Scatterplot")
                         ) 
                )
                )
  )
)




server <- function(input, output) {
  
# line plot to show the growth of one-time, frequent, and total client in the last 20 years. 
  output$value3 <- renderPrint({ 
    paste("You have selected", input$client)
  })
  
  
  output$LinePlot <- renderPlot({
    p1(input$client)
  })
# Heatmap to show the relationship between year, month, and different services
  output$value <- renderPrint({ 
    paste("You have selected", input$heatmap)
  })
  
  
  output$popPlot <- renderPlot({
    plot(input$heatmap)
    
  })
  
#Scatterplot to show the relationship between services and year, to examine growth and usage
  output$value2 <- renderPrint({ 
    paste("You have selected", input$Scatter)
  })
  
  output$Scatterplot <- renderPlot({
    plot1(input$Scatter)
  })
  
  
  
  
}

# Create Shiny app ----
shinyApp(ui, server)
