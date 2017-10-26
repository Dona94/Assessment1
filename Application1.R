library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Application 1"),
numericInput("n", "Enter the number of samples", 10, min = NA, max = NA, step = NA,width = NULL),
  
  

   sidebarLayout(
      sidebarPanel(
        sliderInput("mean",
                    "Enter the mean:",
                    min = 0,
                    max = 100,
                    value = 10)
      ),
      sidebarLayout(
        sidebarPanel(
      
      sliderInput("sd",
                  "Enter the SD:",
                  min = 0,
                  max = 50,
                  value = 10)
   ),

      
      
      # Show a plot of the generated distribution
      mainPanel(
         plotOutput("distPlot")
      )
   )
   )
)


# Define server logic required to draw a histogram
server <- function(input, output) {
   
   output$distPlot <- renderPlot({
      
     x <-rnorm(input$n,input$mean,input$sd)
  hist(x)
      
    
   })
}
# Run the application 
shinyApp(ui = ui, server = server)

