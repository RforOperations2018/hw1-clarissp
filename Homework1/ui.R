
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

require(tidyverse)
require(ggplot2)
require(plotly)
library(knitr)
opts_chunk$set(fig.width=12, fig.height=8, fig.path='Figs/')
# Data Stuff
require(dplyr)
require(tibble)
require(reshape2)
require(scales)
require(RColorBrewer)
pdf(NULL)

diamonds <- diamonds

ui <- fluidPage(
  #titlePanel defines the application title
  titlePanel("Diamonds Dataset"),
  #Fuctions for the sidebar
  sidebarLayout(
    sidebarPanel(
      selectInput("char",
                  "Color:",
                  choices = levels(diamonds$color),
                  multiple = TRUE,
                  selectize = TRUE,
                  selected = c("D", "E", "F", "G","H","I","J"))
    ),
    #Functions for the main panel 
    mainPanel(
      tabsetPanel(
        tabPanel("Plot",
                 plotlyOutput("plot1")
        ),
        tabPanel("Plot",
                 plotlyOutput("plot2")
        )
      )
    )
  )
)


#Functions for the Diamond Table 
plot1 <- ggplot(data = diamonds, aes(x=color, fill = color)) + 
  geom_bar(stat = "count") +
  scale_y_continuous(labels = comma) +
  ggtitle("Count of Diamonds by Color") +
  xlab("Color") +
  ylab("Count of Diamonds") +
  scale_fill_brewer(palette = "Blues")
```{r}

```


#Functions for the Diamonds Plot
plot2 <- ggplotly(
  ggplot(data = diamonds, aes(x = carat, y = price, color = as.factor(color))) + 
    geom_point() +
    scale_y_continuous(labels = comma) +
    ggtitle("Diamonds Classified by Color, Price, and Carat") +
    xlab("Carat") +
    ylab("Price of Diamonds (in dollars") +
    scale_color_brewer(palette = "Oranges") 
)
