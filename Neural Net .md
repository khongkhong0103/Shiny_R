# 3. Neural Net 
Mạng neural nhân tạo hay thường gọi ngắn gọn là mạng neural là một mô hình toán học hay mô hình tính toán được xây dựng dựa trên các mạng neural sinh học. Nó gồm có một nhóm các neural nhân tạo nối với nhau, và xử lý thông tin bằng cách truyền theo các kết nối và tính giá trị mới tại các nút.
![img](https://blog.itnavi.com.vn/uploads/2021/05/Neural-Network-l%C3%A0-g%C3%AC-2.jpg)
## Nhận dữ liệu

```r
library(tidyverse)
setwd("D:/2. School/CuoiKi R 2")
df <- read.csv(file='./data/xAPI-Edu-Data.csv')
df <- select(df, -PlaceofBirth, -StageID, -SectionID, -Semester, -Relation, -ParentAnsweringSurvey,-GradeID,-Topic,-gender,  -ParentschoolSatisfaction,-NationalITy,-StudentAbsenceDays)
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
library(neuralnet)
```

```
## Warning: package 'neuralnet' was built under R version 4.1.2
```

```
## 
## Attaching package: 'neuralnet'
```

```
## The following object is masked from 'package:dplyr':
## 
##     compute
```

```r
# help(neuralnet)
n <- names(train)
n
```

```
## [1] "raisedhands"       "VisITedResources"  "AnnouncementsView" "Discussion"        "Class"
```

```r
f <- as.formula(paste("Class ~", paste(n[!n %in% "Class"], collapse = " + ")))
f
```

```
## Class ~ raisedhands + VisITedResources + AnnouncementsView + 
##     Discussion
## <environment: 0x000002c94ccc1048>
```

```r
nn <- neuralnet(Class~raisedhands+VisITedResources ,data=train,hidden=c(5,3),linear.output=TRUE)
```

```
## Warning: Algorithm did not converge in 1 of 1 repetition(s) within the stepmax.
```

```r
# plot(nn)
```
