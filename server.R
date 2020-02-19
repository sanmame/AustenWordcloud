library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    # Define a reactive expression for the document term matrix
    terms <- reactive({
        input$update
        readRDS(file = (paste0("tm_",input$selection,".rds")))
        })
    
    # Make the wordcloud drawing predictable during a session
    wordcloud_rep <- repeatable(wordcloud)
    
    output$plot <- renderPlot({
        v <- terms()
        wordcloud_rep(names(v), v, scale=c(4,0.5),
                      min.freq = input$freq, max.words=input$max,
                      colors=brewer.pal(9, "Set1"))
    })
})
