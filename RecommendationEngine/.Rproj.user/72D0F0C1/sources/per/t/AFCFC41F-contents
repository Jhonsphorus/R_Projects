#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinythemes)

movies2 <- read.csv("movies.csv", header = TRUE, stringsAsFactors=FALSE)

shinyUI(fluidPage(theme = shinytheme("sandstone"),
    
    # Application title
    tags$h1(style="color:#210B61", tags$b("PhorusRecommender"),align='center'),
    #titlePanel("Loan Risk Analysis Platform"),
    tags$hr(),
    
    tags$h4(style="color:#210B61",tags$b("PhorusRecommender is a platform that recommends ten other movies based on three movies 
                                            selected and rated by the users"),align='center'),
    tags$hr(),
    
    # Panel heading
    tags$h4(tags$b("Movies Selection Panel"),style="color:#088A68"),
    
    # Sidebar with a numeric input, select input and action button for obtaining user's input
    sidebarLayout(
        sidebarPanel(
            selectInput("select1", label = "Select First Movie",
                        choices = as.character(movies2$title[1:9742])),
            numericInput("rating1", label ="Rate First Movie",value = 1, min = 1, max = 5 ),
            
            selectInput("select2", label ="Select Second Movie",
                        choices = as.character(movies2$title[1:9742])),
            numericInput("rating2", label ="Rate Second Movie",value = 1, min = 1, max = 5 ),
            
            
            selectInput("select3", label ="Select Third Movie",
                        choices = as.character(movies2$title[1:9742])),
            numericInput("rating3", label ="Rate Third Movie",value = 1, min = 1, max = 5 ),
            
            submitButton("Submit")                                                            
            
        ),
        
        # Creating object of the outputs
        mainPanel(
            
            #fluidRow(tags$b("You Might Like to Buy These Movies Too!"),
                     #tableOutput("table"))  
            tags$b(h3("You Might Like to Buy These Movies Too!")),
            tableOutput("table")
        
        )
    )
)
)