# Based on https://github.com/rstudio/shiny-examples/tree/master/082-word-cloud
# Books were downloaded from http://www.gutenberg.org

library(tm)
library(wordcloud)
library(memoise)
 
# The list of valid books
books <<- list("Emma" = "emma",
               "Mansfield Park" = "mansfield",
               "Northanger Abbey" = "northanger",
               "Persuasion" = "persuasion",
               "Pride and Prejudice" = "pride",
               "Sense and Sensibility" = "sense")

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(book) {
  text <- readLines(sprintf("./%s.txt.gz", book),
                    encoding="UTF-8")

  myCorpus = Corpus(VectorSource(text))
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus = tm_map(myCorpus, removeWords,
                    c(stopwords("SMART"), "thy", "thou", "thee", "the", "and", "but"))

  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))

  m = as.matrix(myDTM)

  sort(rowSums(m), decreasing = TRUE)
})

