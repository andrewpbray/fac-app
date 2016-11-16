library(shiny)

shinyUI(fluidPage(
  
  # Application title
  headerPanel("Reed College Faculty Load Shiny App"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput("range_yrs",
                  "Time span:",
                  min = 2007,
                  max = 2015,
                  value = c(2012, 2015),
        sep = ""
      ),
      
#      checkboxGroupInput("depts", "Departments to include:",
#        unique(d$Department),
#        selected = unique(d$Department)
#        ),
      
      # conditionalPanel(
      #  condition = "input.depts %in% dist_d$Department",
      #   selectInput("smoothMethod", "Method",
      #     list("lm", "glm", "gam", "loess", "rlm"))
      # )
      checkboxGroupInput("courses", "Courses to include:", 
                         unique(d$courseid),
                         selected = unique(d$courseid)
      ),
      br(),
      checkboxInput("HUM", "Include HUM in total?", value = TRUE)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Equity", 
          selectizeInput("y_var", "Variable to plot", 
            choices = c("Thesis Load/FTE", "# Student Units / FTE", "Exposure / FTE"),
            selected = "Thesis Load/FTE"),
          plotlyOutput("equity_plot")),
        tabPanel("Intro Sci", 
          br(),
          p("Enrollment by Department"),
          plotlyOutput("intro_sci_plot"),
          br(),
          p("Enrollment/FTE by Department"),
          plotlyOutput("byFTE"))
      )
    )
  )

)
)