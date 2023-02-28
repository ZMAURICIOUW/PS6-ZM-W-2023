library(tidyverse)
library(shiny)

stream <- read_delim("streaming-platform-data.csv")

ui <- fluidPage(
  titlePanel("Streaming Service Insights"),
  p("This is an app showing the movie data of different streaming platforms. There are ",
    nrow(stream), "rows and", ncol(stream), "columns."),
  sidebarLayout(
    sidebarPanel(
    ), 
    mainPanel(
    )
  )
)

server <- function(input, output) {
}

shinyApp(ui = ui, server = server)