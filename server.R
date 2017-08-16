library(shiny)
library(caret)
library(dplyr)
library(reshape2)
library(quantmod)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$plotOutputModel <- renderPlot({
        
        start <- input$startDate
        end <- input$endDate
        
        companies_in <- c(input$aapl_cb, input$msft_cb, input$fb_cb, input$amzn_cb)
        
        companies <- c("AAPL", "MSFT", "FB", "AMZN")
        
        companies2 <- companies[companies_in]
        
        getSymbols(companies, src = "yahoo", from = start, to = end)
        
        index <- index(get(companies[1]))
        df1 <- as.data.frame(get(companies[1]))
        df2 <- as.data.frame(get(companies[2]))
        df3 <- as.data.frame(get(companies[3]))
        df4 <- as.data.frame(get(companies[4]))
        
        df <- data.frame(Date = index) %>% mutate(Apple = df1$AAPL.Open / df1[1, 1] - 1, 
                                                  Microsoft = df2$MSFT.Open / df2[1, 1] - 1, 
                                                  Facebook = df3$FB.Open / df3[1, 1] - 1, 
                                                  Amazon = df4$AMZN.Open / df4[1, 1] - 1) %>% as.data.frame()
        
        meltdf <- melt(df, id = "Date")
        
        colnames(meltdf) <- c("Date", "Company", "Return")
        
        ggplot(meltdf, aes(Date, Return, colour = Company, group = Company)) + geom_line() + 
            scale_y_continuous(labels = percent) +
            ggtitle("Return from top market value companies")
        
    })
  
})
