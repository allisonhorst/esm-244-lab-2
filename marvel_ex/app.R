
library(shiny)
library(tidyverse)
library(shinythemes)
library(RColorBrewer)

# Reads just fine from parent directory I guess...
marvel <- read_csv("marvel-wikia-data.csv")

# Look at it! View(marvel) from console...you don't want that here. 

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Update theme:
  theme = shinytheme("slate"),
   
   # App title
   titlePanel("Marvel Characters"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         radioButtons("side",
                     "Choose a side:", 
                     c("Good Characters",
                       "Bad Characters",
                       "Neutral Characters"))
      ),
      
      # Show a plot of the generated distribution
      mainPanel(
        plotOutput(outputId = "marvelplot", height = "500px")
      )
   )
)

# Define server logic required to draw a graph
server <- function(input, output) {
   
output$marvelplot <- renderPlot({
  
  ggplot(filter(marvel, ALIGN == input$side), aes(x = Year)) +
    geom_histogram(aes(fill = SEX)) +
    scale_fill_brewer(palette = "RdPu") +
    theme_dark()
     
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

