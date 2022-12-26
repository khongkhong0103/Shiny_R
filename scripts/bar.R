BuildBar <- function(data, yvar) {
  # nhóm dữ liệu theo quốc tịch và lớp học (điểm kiểm tra)
  # tổng giá trị của  giơ tay phát biểu, tài nguyên đã truy cập, xem thông báo, nhóm thảo luận
  # để tìm số lượng học sinh tham gia vào lớp học ở mỗi quốc gia (cũng như cấp độ họ đạt được từ bài kiểm tra)
  group.data <- group_by(data, NationalITy, Class) %>% 
    summarise(mean.activity = mean(raisedhands + VisITedResources + AnnouncementsView + Discussion)) %>%
    arrange(Class, NationalITy)
  
  # chọn tập dữ liệu khác làm đầu vào của người dùng
  if(yvar == "High Performance") {
    group.data <- filter(group.data, Class == 3)
  } else if (yvar == "Middle Performance") {
    group.data <- filter(group.data, Class == 2)
  } else if (yvar == "Low Performance") {
    group.data <- filter(group.data, Class == 1)
  }
  

  m <- list(l = 80, r = 50, b = 80, t = 20, pad = 4)
  
  # tạo biểu đồ thanh; trục x là quốc tịch của học sinh và trục y là sự tham gia tích cực vào lớp học
  return(plot_ly(group.data, x = ~group.data$NationalITy, y = ~group.data$mean.activity, 
                 type = 'bar', color = group.data$Class) %>%
           layout(yaxis = list(title = 'Muc do tham gia'), xaxis = list(title = 'Quoc tịch'), barmode = 'stack', margin = m, height = 500)
  )
}

BarTable <- function(data, yvar) {
  table.data <- group_by(data, NationalITy, Class) %>% 
    summarise(raisedhands = round(mean(raisedhands), digits = 1), VisITedResources = round(mean(VisITedResources), digits = 1), 
              AnnouncementsView = round(mean(AnnouncementsView), digits = 1), Discussion = round(mean(Discussion), digits = 1),
              mean.activity = mean(raisedhands + VisITedResources + AnnouncementsView + Discussion)) %>%
    arrange(Class, NationalITy)
  
  if(yvar == "High Performance") {
    table.data <- filter(table.data, Class == 3)
  } else if (yvar == "Middle Performance") {
    table.data <- filter(table.data, Class == 2)
  } else if (yvar == "Low Performance") {
    table.data <- filter(table.data, Class == 1)
  }
  return(table.data)
}