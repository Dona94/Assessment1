library(shiny)
if (interactive()) {
  ui <- fluidPage(
    # Application title
    titlePanel("Application 2"),
    sidebarLayout(
      sidebarPanel(
        fileInput("file1", "Choose CSV File",
                  accept = c(
                    "text/csv",
                    "text/comma-separated-values,text/plain",
                    ".csv")
        ),
        tags$hr(),
        checkboxInput("header", "Header", TRUE)
        ,
        
        selectInput("var", "Select a variable:",
                    c("Age" = "age",
                      "Height" = "height",
                      "Weight" = "weight",
                      "Bmi" = "bmi")),
        radioButtons("cols", "Choose the desired colour",
                     c("Blue",
                       "Green",
                       "Red",
                       "Pink")))
      
      
      ,
      mainPanel(
        tableOutput("data"),
        plotOutput("contents")
      )))
  
  
  server <- function(input, output){
    output$data <-renderTable({
      infile <-input$file1
      if (is.null(infile))
        return(NULL)
      c <-read.csv(infile$datapath, header = input$header)
      
    })
    output$contents <-renderPlot({
      (req(input$file1))
      infile <- input$file1
      data <-read.csv(infile$datapath, header=input$header)
      var <-input$var
      col <-input$cols
      boxplot(data[,var], col=col, main=paste("Variable: ", var))
    })}
  # Run the application
  shinyApp(ui = ui, server = server)
  
}