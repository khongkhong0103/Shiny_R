#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(shinydashboard)

# Define UI for application that draws a histogram

dashboardPage(
  dashboardHeader(title ='VKU' , titleWidth = 230,
                  dropdownMenu(type = "messages",
                               messageItem(
                                 from = "Sales Dept",
                                 message = "Sales are steady this month."
                               ),
                               messageItem(
                                 from = "New User",
                                 message = "How do I register?",
                                 icon = icon("question"),
                                 time = "13:45"
                               ),
                               messageItem(
                                 from = "Support",
                                 message = "The new server is ready.",
                                 icon = icon("life-ring"),
                                 time = "2014-12-01"
                               )
                  ),
                  dropdownMenu(type = "notifications",
                               notificationItem(
                                 text = "5 new users today",
                                 icon("users")
                               ),
                               notificationItem(
                                 text = "12 items delivered",
                                 icon("truck"),
                                 status = "success"
                               ),
                               notificationItem(
                                 text = "Server load at 86%",
                                 icon = icon("exclamation-triangle"),
                                 status = "warning"
                               )
                  ),
                  dropdownMenu(type = "tasks", badgeStatus = "success",
                               taskItem(value = 90, color = "green",
                                        "Documentation"
                               ),
                               taskItem(value = 17, color = "aqua",
                                        "Project X"
                               ),
                               taskItem(value = 75, color = "yellow",
                                        "Server deployment"
                               ),
                               taskItem(value = 80, color = "red",
                                        "Overall project"
                               )
                  )
  ),
  dashboardSidebar(
    sidebarMenu(
      id = "sidebar",
      menuItem("Tổng quan", tabName ="dashboard", icon = icon("dashboard")),
      menuItem("Dataset", tabName ="data", icon = icon("database")),
      menuItem(text ="Biểu đồ phân tán", tabName ="viz", icon = icon("chart-line")),
      menuItem("Biểu đồ đa biến", tabName ="map", icon = icon("map")),
      menuItem("Biểu đồ thanh", tabName ="map1", icon = icon("map")),
      menuItem("Mô hình", tabName ="model", icon = icon("map")),
      menuItem("Tổng kết", tabName ="summary", icon = icon("table"))
      
    )
  ),
  dashboardBody(
    tabItems(
      # first tab item 
      tabItem( tabName = "dashboard",
               tabPanel("Tổng quan", 
                        mainPanel( width = "100%",
                          tags$h1("Phân tích kết quả học tập của sinh viên",style="color:red"),
                          tags$div(
                            tags$h3("Nguồn gốc Dataset: "),
                            tags$div ("Đây là một dataset giáo dục được thu thập từ hệ thộng quản lý học tập (LMS) có tên là Kalboard 360. 
                                 Kalboard 360 là một LMS đa tác nhân, được thiết kế để hỗ trợ việc học tập thông qua việc sử dụng công nghệ tiên tiến. 
                                 Dữ liệu được thu thập bằng cách sử dụng công cụ theo dõi hoạt động của người học, được gọi là API trải nghiệm - experience API (xAPI). 
                                 xAPI là một thành phần của TLA(the training and learning architecture) cho phép theo dõi tiến trình học tập và hành động của người học 
                                 như là đọc một bài báo hoặc xem một video đào tạo"),
                            tags$h3("Các thuộc tính trong Dataset: "),
                            tags$p("Có 16 thuộc tính và 480 trường trong dataset.Trong đó các thuộc tính chính :"),
                            tags$ul(
                              tags$li("gender: giới tính"),
                              tags$li("NationalITy: Nơi sinh (Quốc gia)"),
                              tags$li("StageID: Nhóm trình độ học tập"),
                              tags$li("GradeID: Nhóm lớp học tập"),
                              tags$li("Topic: Chủ đề học tập"),
                              ##########################################
                              tags$li("raisedhands: Số lần phát biểu"),
                              ##########################################
                              tags$li("VisITedResources: Số lần truy cập tài liệu"),
                              tags$li("AnnouncementsView: Số lần xem thông báo"),
                              tags$li("Discussion: Số lần làm việc nhóm"),
                            ),
                            ##################################################################################
                            tags$h3("Bảng dữ liệu"),
                            #################################################################################
                            tags$p("Học sinh sẽ được chia thành 3 nhóm dựa trên tổng điểm hoặc điểm của họ;"),
                            tags$ul(
                              tags$li("Low-Level: điểm số đạt khoảng từ 0 đến 69"),
                              tags$li("Middle-Level: điểm số đạt khoảng từ 70 đến 89"),
                              tags$li("High-Level: điểm số đạt khoảng từ 90 đến 100")
                            ),
                            tags$h3("Về đối tượng quan tâm của Dataset: "),
                            tags$p("Có rất nhiều người sẽ rất quan tâm đến dataset này. 
                                 Bậc phụ huynh, học sinh , giáo viên và bất cứ ai liên quan đến hệ thống giáo dục sẽ quan tâm đến việc sử dụng dataset này. 
                                 Ứng dụng này sẽ tập trung phần nhiều vào những bậc phụ huynh. Thành tích học tập ở trường của học sinh là điều mà phụ huynh thường quan tâm, 
                                 và việc tập hợp và phân tích tập dữ liệu liên quan sẽ cho cái nhìn trực quan cho họ biết những yếu tố có thể ảnh hưởng đến kết quả của học sinh."),
                            tags$h3("Câu hỏi nghiên cứu: "),
                            tags$p("các câu hỏi nghiên cứu cho dataset:"),
                            tags$ul(
                              tags$li("Những loại hành vi học tập nào dẫn đến việc nâng cao điểm số của học sinh?"),
                              tags$li("Giới tính có bị ảnh hưởng nhiều hơn bởi những hành vi học tập?"),
                              tags$li("Học sinh đến từ quốc gia nào có xu hướng đạt thành tích học tập trung bình cao nhất?"),
                              tags$li("Việc có mức độ tham gia các hoạt động cao hơn ảnh hưởng như thế nào đến việc đạt được thành tích học tập tốt hơn ở mỗi quốc gia?")
                            )
                          ),
                          tags$h1("Nhóm trình bày"),
                          tags$div(
                            tags$ul(
                              tags$li("Nguyễn Trọng Tâm - 18IT294"),
                              tags$li("Nguyễn Quốc Tuấn - 19IT209"),
                              tags$li("Tôn Đức Nam - 18IT341"),
                              tags$li("Trần Minh Quân  19IT268")
                            ),
                            
                          )
                        )),
      ),
      
      tabItem( tabName = "data",
               tabBox(id = "t1" ,width ="100%",
                      tabPanel("Data", icon =icon("address-card"),
                               dataTableOutput("scTable"),
                               #tags$p("**biểu đồ phân tán có thể không được hiển thị nếu không có sự kết hợp phù hợp của các yếu tố đã chọn**")
                               ),
                  #    tabPanel(title = "Data", icon =icon("address-card"), h4("tabpane2 ")),
                   #   tabPanel(title = "Structure", icon =icon("address-card"), h4("tabpane 3 ")),
                    #  tabPanel(title = "Structure Stats", icon =icon("address-card"), h4("tabpane 4 ")),
               )
      ),
      tabItem(tabName ="viz",
              titlePanel('Các yếu tố nào có thể ảnh hưởng đến kết quả học tập?'),
              tags$h5("Thay đổi thuộc tính trục x để thấy mối quan hệ với thành tích (performance)"),
              radioButtons("activity", 
                           label = "Hoạt động:", 
                           choices = list("Raised hand" = "raisedhands", "Visited resource" = "VisITedResources", "Viewing announcement" = "AnnouncementsView", 
                                          "Discussion group" = "Discussion","Average activity"="mean","Total activities"="total"),
                           selected = "raisedhands",inline=TRUE),
              #user input of gender
              tags$h3("Lọc dữ liệu để xem giới tính, mức điểm và chủ đề cụ thể"),
             
              fluidRow(
                #user input of gender
                column(3,
                       selectInput(inputId = "gender",
                                   "Giới tính:",
                                   choices = list("All", "Male" = "M", "Female" = "F"),
                                   selected = "All")
                ),
                #user input of grade level
                column(3,
                       selectInput(inputId = "grade",
                                   "Nhóm lớp:",
                                   choices = list("All", "G-02", "G-03", "G-04",
                                                  "G-05", "G-06", "G-07", "G-08", 
                                                  "G-09", "G-10", "G-11", "G-12"),
                                   selected = "All")
                ),
                #user input of topic
                column(3,
                       selectInput(inputId = "topic", 
                                   "Chủ đề:",
                                   choices = list("All", "English", "French", "Arabic", "IT", "Math", 
                                                  "Chemistry", "Biology", "Science", "History", 
                                                  "Spanish", "Quran", "Geology"), 
                                   selected = "All")
                )
              ),
              tabBox(id ="",width="100%",
                     tabPanel("Biều đồ",
                              plotlyOutput('scatterGraph'),
                              tags$p("**biểu đồ phân tán có thể không được hiển thị nếu không có sự kết hợp phù hợp của các yếu tố đã chọn**")
                              ),
                     tabPanel("Biều đồ hộp",
                              plotOutput('plotBox'),
                              tags$p("**biểu đồ phân tán có thể không được hiển thị nếu không có sự kết hợp phù hợp của các yếu tố đã chọn**")),
                     tabPanel("Tóm tắt",
                              #tags$br(),
                              tags$p("Kết quả học tập của học sinh bị ảnh hưởng bởi nhiều yếu tố khác nhau. Với biểu đồ phân tán này, 
                                     chúng tôi khám phá mối tương quan giữa các hoạt động của học sinh và hiệu quả học tập của họ.
                                            Ở trục Y,thành tích học tập: 1 tương ứng hiệu quả học tập thấp, 2 tương ứng hiệu quả học tập trung bình, và 3 là hiệu quả học tập cao."),
                              tags$p("Nút radio có sẵn ở bên trái cho phép người dùng chọn các loại hoạt động khác nhau mà sinh viên tham gia 
                                            và xem mối tương quan giữa số lượng hoạt động mà sinh viên tham gia và mức độ kết quả học tập của họ."), 
                              tags$p("Mối tương quan giữa hoạt động của học sinh và thành tích học tập của họ có thể mạnh hơn hoặc yếu hơn đối với các giới tính khác nhau,
                                            các cấp lớp khác nhau, cũng như cho các môn học khác nhau. Drop-menu có sẵn bên dưới các lựa chọn hoạt động cho
                                            phép người dùng lọc dữ liệu để xem các mối tương quan của một nhóm cụ thể."),
                              tags$br(),
                              tags$p("Hạn chế: "),
                              tags$ul(
                                tags$li("Tập dữ liệu mà chúng tôi sử dụng đưa ra ba giá trị danh nghĩa cho thành tích của học sinh: thành tích cao, trung bình và thấp. 
                                               Những học sinh nhận được 69 được phân loại vào thành tích Cấp thấp, trong khi học sinh nhận được 70 được phân loại thành thành tích Trung bình, mặc dù điểm của họ rất giống nhau."),
                                tags$li("Biểu đồ cũng cho thấy mối tương quan giữa tính hiệu quả và tần suất hoạt động học tập mà sinh viên tham gia.Tuy nhiên, tương quan không có nghĩa là hoàn toàn đúng, thực tế
                                               có rất nhiều yếu tố khác nhau ảnh hưởng đến kết quả của biến.")
                              )
                              
                              ),
                     tabPanel("Bảng", dataTableOutput("scatterTable"))
                     
                     )
              ),
      tabItem(tabName ="map",
              titlePanel('Liên kết giữa các thuộc tính?'),
              tags$h3("Các câu hỏi đặt ra từ biểu đồ"),
              tags$ul(
                tags$li("Tỉ lệ giới tính trong các môn học? Các giới tính thường hứng thứ ở những môn học nào?"),
                tags$li("Các môn học ở các nước ?"),
                tags$li("Việc nghỉ học nhiều có ảnh hưởng tới kết quả học tập?")
              ),
              tags$h3("Thay đổi thuộc tính để thấy mối quan hệ"),
      
              
              fluidRow(
                #user input of gender
                column(3,
                       selectInput(inputId = "y_axis",
                                   "Trục y:",
                                   choices = list("Gender" = "gender", "National" = "NationalITy","Stage level"="StageID",
                                                  "Grade level"="GradeID","Topic"="Topic","Parent responsible for student"="Relation",
                                                  "The Degree of parent satisfaction from school"="ParentschoolSatisfaction",
                                                  "The number of absence days for each student"="StudentAbsenceDays",
                                                  ####################
                                                  "Performance"="Class"
                                                  #####################
                                                  
                                   ),
                                   selected = "Topic")
                ),
                #user input of grade level
                column(3,
                       selectInput(inputId = "fill",
                                   label = "Thành phần:",
                                   choices = list("Gender" = "gender", "National" = "NationalITy","Stage level"="StageID",
                                                  "Grade level"="GradeID","Topic"="Topic","Parent responsible for student"="Relation",
                                                  "The Degree of parent satisfaction from school"="ParentschoolSatisfaction",
                                                  "The number of absence days for each student"="StudentAbsenceDays",
                                                  ########################
                                                  "Performance"="Class"
                                                  ########################
                                   ),
                                   selected = "gender")
                )
              ),
              
              tabBox(id ="",width="100%",
                     tabPanel("Biều đồ",  plotOutput('geomGraph'),
                              tags$p("**biểu đồ có thể không được hiển thị nếu không có sự kết hợp phù hợp của các yếu tố đã chọn**")
                              ),
                     tabPanel("Biều đồ so sánh",plotOutput('geomBar'),
                              tags$p("**biểu đồ có thể không được hiển thị nếu không có sự kết hợp phù hợp của các yếu tố đã chọn**")
                              )
                     )
              ),
      tabItem(tabName ="map1", width="100%",
              titlePanel('Học sinh đến từ quốc gia nào có xu hướng đạt thành tích học tập trung bình cao nhất?'),
              #user input of activity
              fluidRow(
                #user input of gender
                column(3,
                       selectInput(inputId = "performance",
                                   label = "Hiệu suất:", 
                                   choices = c("All","High Performance", "Middle Performance", "Low Performance"), 
                                   selected = "All")
                )
                ),
              tabBox(id ="",width="100%",height = "100%",
                     tabPanel("Biều đồ",
                              plotlyOutput('barGraph')
                              ),
                     tabPanel("Tổng kết",
                              tags$br(),
                              tags$p("Thông qua biểu đồ thanh chúng em có những câu hỏi sau:"),
                              tags$ol(
                                tags$li("Học sinh từ quốc gia nào tích cực tham gia các hoạt động học thuật hơn?"),
                                tags$li("Sự tham gia hoạt động trong lớp cao hơn ảnh hưởng đến việc đạt được thành tích học tập như thế nào?")
                              ),
                              tags$p("Trục x trên biểu đồ thanh hiển thị Quốc tịch: Egypt, Iran, Iraq, Jordan, KW, lebanon, Lybia, Morocco, Palestine, SaudiArabia, Syria, Tunis, USA, and venzuela"),
                              tags$p("Trục y trên biểu đồ thanh hiển thị Mức độ tham gia: Trung bình của lượt giơ tay,truy cập tài nguyên, xem thông báo,thảo luận nhóm"),
                              tags$p("Biểu đồ thanh tổng hợp cho thấy mức độ tham gia của sinh viên ở mỗi quốc gia. Màu sắc khác nhau có nghĩa là mức độ hiệu suất. Bộ
                                          chọn ở bên trái cho phép người dùng lọc học sinh theo từng cấp độ hiệu suất. "),
                              tags$p("Quốc gia có thành tích học tập tốt nhất là Syria (khoảng 330 lần tham gia). Quốc gia có thành tích học tập kém nhất là SaudiArabia (khoảng 141 lần tham gia). ")
                              ),
                     tabPanel("Bảng", dataTableOutput("barTable"))
                     
                     )
              ),
      tabItem(tabName ="model",
              tabBox(id ="",width="100%",
                     
                     
                     )
              ),
      tabItem(tabName ="summary",
                       mainPanel( width = "100%",
                         tags$div(
                           tags$h3("Những yếu tố nào ảnh hưởng đến kết quả học tập?"),
                           tags$p("Từ tab biểu đồ phân tán, có thể lọc qua bốn tùy chọn khác nhau có thể ảnh hưởng đến kết quả học tập của học sinh.
                                 Khi chúng ta xem xét từng tính năng, rõ ràng là các trường hợp này thấp hơn,(giơ tay, xem thông báo, tham gia nhóm thảo luận)
                                 dẫn đến mật độ học sinh cao hơn được lập biểu đồ cùng với hiệu suất theo cấp thấp hơn.
                                 Ví dụ: chọn tùy chọn giơ tay mặc định trên trục x, ta có thể thấy một mối quan hệ rõ ràng: những sinh viên giơ tay ít hơn đang chiếm xếp hạng thành tích là 1.
                                 Rõ ràng là tần số cao hơn của các tác vụ này không trực tiếp thể hiện hiệu suất theo cấp độ cao hơn, nhưng việc áp dụng các bộ lọc bổ sung có thể cho thấy bằng chứng nổi bật hơn. "),
                           tags$h3("Liệu giới tính có xu hướng ảnh hưởng đến học tập không?"),
                           tags$p("Đối với phụ nữ, có xu hướng trực tiếp hơn đối với yếu tố tiếp cận nguồn tài liệu học tập.
                                 Chúng ta thấy rằng tần suất thực hiện nhiệm vụ này thấp hơn cho thấy nhiều sinh viên sẽ đạt điểm hiệu suất thấp hơn(1 hoặc 2) và tần suất truy cập tài nguyên cao hơn tạo cơ hội đạt điểm hiệu suất cao. 
                                 Đối với nam giới, xu hướng này nổi bật hơn khi hiển thị kết quả dữ liệu từ việc giơ tay. Chúng ta cũng có thể thấy rằng ở cả nữ và nam nếu sự tham gia thấp hơn vào các yếu tố này có thể dẫn đến cơ hội được xếp vào cấp độ hiệu suất thấp. "),
                           tags$h3("Học sinh từ quốc gia nào có xu hướng đạt thành tích học tập trung bình cao nhất?"),
                           tags$p("Như đã đề cập trước đây, dữ liệu hiệu suất trung bình thấp nhất mà chúng ta tìm thấy là từ  Saudi Arabia(Ả Rập Xê Út) với 141 lần đạt hiệu suất là 1,
                                 và thành tích học tập trung bình cao nhất đến từ Syria (tham gia 330 lần) "),
                           tags$h3("Việc tham gia các hoạt động cao hơn có tác dụng đến thành tích học tập của sinh viên không?"),
                           tags$p("Để nhận điểm xếp loại hiệu suất thấp (điểm 1) mức độ tham hoạt động học tập gia dao động từ 29-141 lần tham gia.
                                 Để nhận được xếp loại hiệu suất trung bình (điểm 2) mức độ tham gia dao động từ 126-266 lần tham gia.
                                 Để nhận được xếp hạng hiệu suất cấp cao (điểm 3), mức độ tham gia dao động từ 223-330
                                 Do đó tần suất tham gia hoạt động học tập cao hơn cần thiết để nhận được cấp độ phân loại hiệu suất cao nhất và điều ngược lại cũng có thể xảy ra
                                  trong đó số lượng tham gia thấp hơn dẫn đến cơ hội nhận được điểm thấp hơn. ")
                         ),
                         tags$div(
                           tags$h3("Tổng kết"),
                           tags$p("Bằng cách phân tích các biểu đồ, chúng ta có thể xác định rằng tồn tại mối quan hệ tích cực rõ ràng giữa kết quả học tập của học sinh và
                          sự tham gia hoạt động học tập của họ. Tuy nhiên có thể có một số yếu tố khác có thể đang ảnh hưởng đến mối quan hệ. ")
                         )
                       )
                     
                     
              )
    )
    
  ),
)
