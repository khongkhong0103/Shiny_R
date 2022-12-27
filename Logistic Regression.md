
# 2. Hồi quy Logistic(Logistic Regression)
Phân tích hồi qui logistic là một kỹ thuật thống kê để xem xét mối liên hệ giữa biến độc lập (biến số hoặc biến phân loại) với biến phụ thuộc là biến nhị phân
## Nhận dữ liệu

```r
library(tidyverse)
```

```
## Error in library(tidyverse): there is no package called 'tidyverse'
```

```r
setwd("D:/2. School/CuoiKi R 2")
```

```
## Error in setwd("D:/2. School/CuoiKi R 2"): cannot change working directory
```

```r
df <- read.csv(file='./data/xAPI-Edu-Data.csv')
df <- select(df, -PlaceofBirth, -StageID, -SectionID, -Semester, -Relation, -ParentAnsweringSurvey,-GradeID,-Topic,-gender,  -ParentschoolSatisfaction,-NationalITy)
```

**Tạo thêm 1 cột mới để chỉ xem class có Phải là high không**

```r
df <- df %>%
  add_column(ClassH = if_else(.$Class == "H", 1, 0))
```

```
## Error in add_column(., ClassH = if_else(.$Class == "H", 1, 0)): could not find function "add_column"
```

```r
# head(df,30)
```
# chuẩn bị dữ liệu

```r
# the_data$Education <- as.factor(the_data$Education)
library(caTools)
set.seed(101) 
sample <- sample.split(df$Class, SplitRatio = 0.70) # SplitRatio = percent of sample==TRUE
# Training Data
train = subset(df, sample == TRUE)

# Testing Data
test = subset(df, sample == FALSE)
```


# Xây dụng Model


```r
# model = glm(ClassH ~Discussion, family = binomial(logit), data = train)
model = glm(ClassH ~Discussion, family = binomial(logit), data = train)
```

```
## Error in eval(predvars, data, env): object 'ClassH' not found
```

```r
summary(model)
```

```
## 
## Call:
## lm(formula = raisedhands ~ VisITedResources + AnnouncementsView + 
##     Discussion, data = train)
## 
## Residuals:
##     Min      1Q  Median      3Q     Max 
## -57.994 -11.087   0.718  11.761  60.475 
## 
## Coefficients:
##                   Estimate Std. Error t value Pr(>|t|)    
## (Intercept)        6.15564    2.37928   2.587   0.0101 *  
## VisITedResources   0.44084    0.04088  10.783  < 2e-16 ***
## AnnouncementsView  0.40462    0.05247   7.711 1.47e-13 ***
## Discussion         0.05388    0.04289   1.256   0.2099    
## ---
## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
## 
## Residual standard error: 19.48 on 332 degrees of freedom
## Multiple R-squared:  0.6005,	Adjusted R-squared:  0.5969 
## F-statistic: 166.4 on 3 and 332 DF,  p-value: < 2.2e-16
```

```r
test$predicted.ClassH = predict(model, newdata=test, type="response")
table(test$ClassH, test$predicted.ClassH > 0.5)
```

```
## Error in table(test$ClassH, test$predicted.ClassH > 0.5): all arguments must have the same length
```

Độ chính xác

```r
(92+7)/(92+7+9+36)
```

```
## [1] 0.6875
```
