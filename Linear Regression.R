# install.packages("rmarkdown")
# install.packages("knitr")


library(rmarkdown)
library(knitr)
library(ggplot2)
library(car)
library(caret)
library(corrplot)

getwd()
setwd("D:/ChuyenD_R/CuoiKi R")
getwd()

source('./scripts/scatter.R')
source('./scripts/bar.R')
data <- read.csv(file='D:/ChuyenD_R/CuoiKi R/data/xAPI-Edu-Data.csv')
#data <- read.csv(file = "")
str(data)
head(data)
summary(data)
any(is.na(data))
View(data)


library(ggthemes)
library(dplyr)
# Biểu đồ tương quan là một cách tuyệt vời để khám phá dữ liệu và xem liệu có bất kỳ thuật ngữ tương tác nào không. Hãy bắt đầu bằng cách chỉ lấy dữ liệu số 
df = data
num.cols <- sapply(df, is.numeric)
num.cols
cor.data <- cor(df[,num.cols])
cor.data


library(corrplot)
library(corrgram)

corrplot(cor.data,method='color')


corrgram(df,order=TRUE, lower.panel=panel.shade,
         upper.panel=panel.pie, text.panel=panel.txt)

# Sẽ dự đoán số lần giơ tay phát biểu của học sinh
ggplot(df,aes(x=raisedhands)) + geom_histogram(bins=20,alpha=0.5,fill='blue') + theme_minimal()

# Building a Model¶
#------ 1. Train and Test Data

library(caTools)
# Set a random see so your "random" results are the same as this notebook
set.seed(101) 

# Split up the sample, basically randomly assigns a booleans to a new column "sample"
sample <- sample.split(df$raisedhands, SplitRatio = 0.70) # SplitRatio = percent of sample==TRUE

# Training Data
train = subset(df, sample == TRUE)

# Testing Data
test = subset(df, sample == FALSE)

#------ 2.Training our Model
# model <- lm(raisedhands ~ .,train)
model <- glm(raisedhands~VisITedResources+AnnouncementsView+Discussion, data=train)

summary(model)
# -------can use raisedhands,VisITedResources,AnnouncementsView,Discussion

# Grab residuals
res <- residuals(model)

# Convert to DataFrame for gglpot
res <- as.data.frame(res)

head(res)



ggplot(res,aes(res)) +  geom_histogram(fill='blue',alpha=0.5)
plot(model)
# 
raisedhands.predictions <- predict(model,test)

results <- cbind(raisedhands.predictions,test$raisedhands) 
colnames(results)
results <- as.data.frame(results)
results



to_zero <- function(x){
  if  (x < 0){
    return(0)
  }else{
    return(x)
  }
}


results$pred <- sapply(results$pred,to_zero)
mse <- mean((results$real-results$pred)^2)
print(mse)



SSE = sum((results$pred - results$real)^2)
SST = sum( (mean(df$raisedhands) - results$real)^2)

R2 = 1 - SSE/SST
R2

