library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
    # Application title
    titlePanel("Word Cloud for Jane Austen's works"),
    
    sidebarLayout(
        # Sidebar with a slider and selection inputs
        sidebarPanel(
            selectInput("selection", "Choose a book:",
                        choices = books),
            sliderInput("freq",
                        "Choose the minimum frequency of the words to display:",
                        min = 1,  max = 50, value = 15),
            sliderInput("max",
                        "Choose the maximum number of words to display:",
                        min = 1,  max = 300,  value = 100),
            hr(),
            actionButton("Update wordcloud", "Create wordcloud!")
        ),
        
        # Show Word Cloud
        mainPanel(
            plotOutput("plot", height = "500px")
        )
    )
))