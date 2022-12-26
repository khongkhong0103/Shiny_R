#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
#server.R
library(shiny)
library(plotly)
library(dplyr)

getwd()
setwd("D:/ChuyenD_R/Test/HelloShiny/CK/Main")
getwd()

source('./scripts/scatter.R')
source('./scripts/bar.R')
data <- read.csv(file='./data/xAPI-Edu-Data.csv', stringsAsFactors = FALSE)
data2=data
dim(data)
data <- select(data, -PlaceofBirth, -StageID, -SectionID, -Semester, -Relation, -ParentAnsweringSurvey, -ParentschoolSatisfaction)

# 3 indicates high level (score of 90 - 100), 
# 2 indicates middle level (70 - 89), 1 indicates low level (0-69)
data$Class <- gsub('H', 3, data$Class)
data$Class <- gsub('M', 2, data$Class)
data$Class <- gsub('L', 1, data$Class)

# Define server logic required to draw a histogram
(function(input, output,session) {
  ########## Scatter rendering graph & table ##########
  output$scatterGraph <- renderPlotly({
    return(BuildScatter(data, input$gender, input$grade, input$topic, input$activity))
  })
  output$plotBox <- renderPlot(
    BoxBuild(data,input$activity)
  )
  output$scatterTable <- renderDataTable({
    return(ScatterTable(data, input$gender, input$grade, input$topic, input$activity))
  })
  
  
  output$scTable <- renderDataTable({
    return(TableCreate(data2))
  })
  
  output$geomGraph <- renderPlot(
    ggplot(data2, aes( y= eval(parse(text = input$y_axis)) )) +
      geom_bar(aes(fill =  eval(parse(text=input$fill))), position = position_stack(reverse = TRUE)) +
      theme(legend.position = "top") +
      ylab(input$y_axis)+ labs(fill = input$fill),
  )
  output$geomBar <- renderPlot(
    ggplot(data2, aes(x=eval(parse(text = input$fill)),fill=eval(parse(text = input$fill)))) +
      geom_bar() +geom_text(stat='count', aes(label=..count..), vjust=-1)+
      xlab(input$fill)+labs(fill = input$fill),
  )
})
