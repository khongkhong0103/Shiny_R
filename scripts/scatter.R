# BuildScatter file: function that returns a plotly scatter plot
library(plotly)
library(stringr)

### Data prep for both scatterplot and table ###
DataPrep <- function(data, input.gender, input.grade, input.topic) {
  if (input.gender != "All") {
    data <- filter(data, gender == input.gender)
  }
  if (input.grade != "All") {
    data <- filter(data, GradeID == input.grade)
  }
  if (input.topic != "All") {
    data <- filter(data, Topic == input.topic)
  }
  return(data)
}

### Build Scatter Plot Graph###
BuildScatter <- function(data, input.gender, input.grade, input.topic, activity) {
  ##############################
  data<-mean_test(data,activity)
  data<-total_test(data,activity)
  ##############################
  scatter.data <- DataPrep(data, input.gender, input.grade, input.topic)
  # Get x and y max
  xmax <- max(scatter.data[,activity]) * 1.1
  ymax <- as.numeric(max(scatter.data[,"Class"])) * 1.1
  x.equation <- paste0('~', activity)
  y.equation <- paste0('~', "Class")
  
  # Returns a plotly map with rating as a y axis and given value as a x axis
  return(plot_ly(data = scatter.data, x = eval(parse(text = x.equation)), 
                 y = eval(parse(text = y.equation)),
                 type="scatter",
                 mode='markers', 
                 marker = list(
                   opacity = .4, 
                   size = 10
                 )) %>% 
           layout(xaxis = list(range = c(-1, xmax), title = activity), 
                  yaxis = list(range = c(-1, ymax), title = "Student Performance")
           )
  )
}

### Build Table of data being used to draw the scatterplot ###
ScatterTable <- function(data, input.gender, input.grade, input.topic, activity) {
  ##############################
  data<-mean_test(data,activity)
  data<-total_test(data,activity)
  ##############################
  table.data <- DataPrep(data, input.gender, input.grade, input.topic)
  table.data <- select(table.data, -NationalITy) %>%
                select(gender, GradeID, Topic, activity,Class)
  return(table.data)
}





####################################################################
BoxBuild <- function(data,input.activity){
  data<-mean_test(data,input.activity)
  data<-total_test(data,input.activity)
  ggplot(data, aes(x=Class, y=eval(parse(text=input.activity)))) + geom_boxplot()+coord_flip()+ggtitle("Biểu đồ") +
   xlab("Class")+ ylab(input.activity)
}
TableCreate <- function(data) {
  table.data <- data
  table.data <- select(table.data,  -PlaceofBirth) %>%
    select(gender,NationalITy, GradeID, StageID, Topic,raisedhands,VisITedResources,AnnouncementsView,Discussion,Relation, ParentAnsweringSurvey, ParentschoolSatisfaction,Class)
  return(table.data)
}
mean_test <- function(data,activity){
  if(activity == "mean"){
    d<-data[c("raisedhands"	,"VisITedResources",	"AnnouncementsView"	,"Discussion")]
    data$mean<-rowMeans(d)
  }
  return(data)
}
total_test <- function(data,activity){
  if (activity == "total"){
    d<-data[c("raisedhands"	,"VisITedResources",	"AnnouncementsView"	,"Discussion")]
    data$total<-rowSums(d,na.rm = TRUE)
  }
  return(data)
}
####################################################################





# # BuildScatter file: function that returns a plotly scatter plot
# library(plotly)
# library(stringr)

# ### Data prep for both scatterplot and table ###
# DataPrep <- function(data, input.gender, input.grade, input.topic) {
#   if (input.gender != "All") {
#     data <- filter(data, gender == input.gender)
#   }
#   if (input.grade != "All") {
#     data <- filter(data, GradeID == input.grade)
#   }
#   if (input.topic != "All") {
#     data <- filter(data, Topic == input.topic)
#   }
#   return(data)
# }

# ### Build Scatter Plot Graph###
# BuildScatter <- function(data, input.gender, input.grade, input.topic, activity) {
  
#   scatter.data <- DataPrep(data, input.gender, input.grade, input.topic)
  
#   # Get x and y max
#   xmax <- max(scatter.data[,activity]) * 1.1
#   ymax <- as.numeric(max(scatter.data[,"Class"])) * 1.1
#   x.equation <- paste0('~', activity)
#   y.equation <- paste0('~', "Class")
  
#   # Returns a plotly map with rating as a y axis and given value as a x axis
#   return(plot_ly(data = scatter.data, x = eval(parse(text = x.equation)), 
#                  y = eval(parse(text = y.equation)),
#                  type="scatter",
#                  mode='markers', 
#                  marker = list(
#                    opacity = .4, 
#                    size = 10
#                  )) %>% 
#            layout(xaxis = list(range = c(-1, xmax), title = activity), 
#                   yaxis = list(range = c(-1, ymax), title = "Student Performance")
#            )
#   )
# }

# ### Build Table of data being used to draw the scatterplot ###
# ScatterTable <- function(data, input.gender, input.grade, input.topic, activity) {
#   table.data <- DataPrep(data, input.gender, input.grade, input.topic)
#   table.data <- select(table.data, -NationalITy) %>%
#     select(gender, GradeID, Topic, activity)
#   return(table.data)
  
  
# }

# TableCreate <- function(data) {
#   table.data <- data
#   table.data <- select(table.data,  -PlaceofBirth) %>%
#     select(gender,NationalITy, GradeID, StageID, Topic,raisedhands,VisITedResources,AnnouncementsView,Discussion,Relation, ParentAnsweringSurvey, ParentschoolSatisfaction,Class)
#   return(table.data)
# }

# BoxBuild <- function(data,input.activity){
#   data<-mean_test(data,input.activity)
#   data<-total_test(data,input.activity)
#   ggplot(data, aes(x=Class, y=eval(parse(text=input.activity)))) + geom_boxplot()+coord_flip()+ggtitle("Biểu đồ") +
#    xlab("Class")+ ylab(input.activity)
# }