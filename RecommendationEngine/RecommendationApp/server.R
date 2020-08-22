#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


# Define server logic required to recommend film
library(shiny)
library(proxy)
library(recommenderlab)
library(reshape2)
source("recommender.R")

shinyServer(function(input, output) {
    
    output$table <- renderTable({
        movie_recommendation(input$select1, input$select2, input$select3,input$rating1,input$rating2,input$rating3)
    })
    
}
)