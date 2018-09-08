library(shiny)
library(reshape2)
library(dplyr)
library(plotly)
library(DT)
library(scales)

diamonds <- diamonds 

pdf(NULL)

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Diamond Dataset"),
  
  # Sidebar
  sidebarLayout(
    sidebarPanel(
      selectInput("color_select",
                  "Color:",
                  choices = levels(diamonds$color),
                  multiple = TRUE,
                  selectize = TRUE,
                  selected = c("D", "E", "F", "G", "H", "I", "J")
      ),
      sliderInput("carat_select",
                  "Carat:",
                  min = min(diamonds$carat, na.rm = T),
                  max = max(diamonds$carat, na.rm = T),
                  value = c(min(diamonds$carat, na.rm = T), max(diamonds$carat, na.rm = T)),
                  step = 1)
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Bar Plot", 
                 plotlyOutput("barplot")
        ),
        tabPanel("Point Plot",
                 plotlyOutput("pointplot")
        )
      )
    )
  )
)



# Define server logic
server <- function(input, output) {
  output$barplot <- renderPlotly({
    #dat <- subset(meltwars, name %in% input$char_select)
    ggplot(data = diamonds, aes(x=color, fill = color)) + 
      geom_bar(stat = "count") +
      scale_y_continuous(labels = comma) +
      ggtitle("Count of Diamonds by Color") +
      xlab("Color") +
      ylab("Count of Diamonds") +
      scale_fill_brewer(palette = "Blues")
  })
  output$pointplot <-renderPlotly({
    # This plot might be a bit too dense, it takes a VERY long time to load. I only took off a few points here. In the future use something like sample() to keep the number of points down.
    ggplotly(
      ggplot(data = diamonds, aes(x = carat, y = price, color = as.factor(color))) + 
        geom_point() +
        scale_y_continuous(labels = comma) +
        ggtitle("Diamonds Classified by Color, Price, and Carat") +
        xlab("Carat") +
        ylab("Price of Diamonds (in dollars") +
        scale_color_brewer(palette = "Oranges") 
    )
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
