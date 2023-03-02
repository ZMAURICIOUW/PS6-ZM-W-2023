library(tidyverse)
library(shiny)

stream <- read_delim("streaming-platform-data.csv")
serviceType <- c("Netflix", "Hulu", "Prime Video", "Disney+")

ui <- fluidPage(
  titlePanel("Streaming Service Insights"),
  tabsetPanel(
    tabPanel("General",
             p("This is an app showing the movie data of different streaming 
               platforms based on their age, Rotten Tomatoes rating, and year.
               There are ", nrow(stream), "rows and", ncol(stream), "columns. 
               The dataset was made and posted on Kaggle.com about three years 
               ago, and was most recently updated about a year ago.
               It was mainly inspired by the questions of", em('Which streaming 
               platform(s) can I find this movie on?'), "and", em('What are the 
               target age group movies available on each streaming platform?'), 
               "While there is no original author, there was an available 
               collaborator under the name of Ruchi Bhatia who seems to own the 
               dataset, so I believe they are the author.")),
    tabPanel("Plot",
             titlePanel("Histogram: Movies per Platform (By Age Rating)"),
             sidebarLayout(
               sidebarPanel(
                 selectInput(
                 "service",
                 "Streaming service type:",
                 serviceType,
                 selected = "Netflix"
                 )
               ), 
               mainPanel(
                 plotOutput("hist"),
                 p("This is a plot output of")
               ),
             )
    ),
    tabPanel("Table",
             sidebarLayout(
               sidebarPanel(
               ), 
               mainPanel(
                 dataTableOutput("table")
               )
             )
    )
  ),
)

server <- function(input, output) {
  
  ##plot outputs
  output$hist <- renderPlot({
    ##plot inputs
    service <- input$service
    
    ageDemograph <- stream %>%
      filter(Age != "NA") %>% 
      mutate(Netflix = sum(Netflix), Hulu = sum(Hulu), 
                `PrimeVideo` = sum(`Prime Video`), `Disney+` = sum(`Disney+`)) %>% 
      select(Age, service) %>% 
    
    #ggplot(aes(x = Age, y = Netflix, fill = as.factor(Age)))
    ggplot(aes_string("Age", input$service, fill="Age")) +
      geom_bar(stat = "identity", position = "dodge")
  })
  
  output$table <- renderDataTable({
    stream %>% 
      sample(10)
  })
}

shinyApp(ui = ui, server = server)