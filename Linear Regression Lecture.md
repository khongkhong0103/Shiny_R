---
title: "Hồi quy tuyến tính"
output: html_document
---
# 1. Hồi quy tuyến tính(Linear Regression)
Phân tích hồi quy tuyến tính là một phương pháp phân tích quan hệ giữa biến phụ thuộc Y với một hay nhiều biến độc lập X. Mô hình hóa sử dụng hàm tuyến tính. Các tham số của mô hình được ước lượng từ dữ liệu. Hồi quy tuyến tính được sử dụng rộng rãi trong thực tế do tính chất đơn giản hóa của hồi quy
![](https://ichi.pro/assets/images/max/724/1*DZAFS7dcfgNRwtwiGojqMg.png)
#Nhận dữ liệu

```r
setwd("D:/2. School/CuoiKi R 2")
```

```
## Error in setwd("D:/2. School/CuoiKi R 2"): cannot change working directory
```

```r
df <- read.csv(file='./data/xAPI-Edu-Data.csv')
# head(df)
```
# Làm sạch dữ liệu

```r
any(is.na(df))
```

```
## [1] FALSE
```

# Xây dụng mô hình
### Chia dữ liệu thành tập train và test

```r
library(caTools)
set.seed(101) 
sample <- sample.split(df$gender, SplitRatio = 0.70) # SplitRatio = percent of sample==TRUE
# Training Data
train = subset(df, sample == TRUE)

# Testing Data
test = subset(df, sample == FALSE)
```
### Training Model

```r
model <- lm(raisedhands~VisITedResources+AnnouncementsView+Discussion, data=train)
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
### Giải thích Model
Trong R, dùng hàm lm() dùng để ước tính tham số cho mô hình hồi quy tuyến tính bằng phương pháp bình phương tối thiểu. Cú pháp: lm(y∼x,data)

Trong đó, y là biến phụ thuộc, x là biến tiên lượng hay còn gọi là biến độc lập. Theo bộ dữ liệu đang dùng thì biến phụ thuộc là raisedhands và biến độc lập là gồm 3 biến: VisITedResources+AnnouncementsView+Discussion

Theo kết quả đưa ra, mô hình hồi quy sẽ là: **raisedhands=6,15564+0,44084.VisITedResources+0,40462.AnnouncementsView+0,05388.Discussion**

Residuals: Phần dư là sự khác biệt giữa các giá trị thực tế của biến mà bạn đang dự đoán và các giá trị được dự đoán từ hồi quy của bạn - y - ŷ.
R-squared: Chỉ số để đánh giá mức độ phù hợp của mô hình, càng gần về 1 thì độ chính xác càng cao

### Đánh giá mô hình

```r
raisedhands.predictions <- predict(model,test)
results <- cbind(raisedhands.predictions,test$raisedhands) 
colnames(results) <- c('pred','real')
results <- as.data.frame(results)

to_zero <- function(x){
    if  (x < 0){
        return(0)
    }else{
        return(x)
    }
}

results$pred <- sapply(results$pred,to_zero)
SSE = sum((results$pred - results$real)^2)
SST = sum( (mean(df$raisedhands) - results$real)^2)

R2 = 1 - SSE/SST
R2
```

```
## [1] 0.4834618
```

```r
summary(model)$r.squared
```

```
## [1] 0.6005123
```

```r
summary(model)$adj.r.squared
```

```
## [1] 0.5969025
```

```r
temp.test <- data.frame(VisITedResources=c(3),AnnouncementsView=c(6),Discussion=c(9))
predict(model,temp.test)
```

```
##        1 
## 10.39079
```

```r
tmp = 6.15564+0.44084*3+0.40462*6+0.05388*9
tmp
```

```
## [1] 10.3908
```










```r
# Some code
```
