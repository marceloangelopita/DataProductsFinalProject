library(shiny)

# Acrescentar botao para clicar
# Verificação de campo (endDate depois de startDate)
# Como fazer o checkbox funcionar? ifelse? tem algo melhor?

shinyUI(fluidPage(
    titlePanel("Compare return over investment from top market value companies"),
    sidebarLayout(
        sidebarPanel(
            checkboxInput("aapl_cb", "Show/Hide Apple", value = F),
            checkboxInput("msft_cb", "Show/Hide Microsoft", value = F),
            checkboxInput("fb_cb", "Show/Hide Facebook", value = F),
            checkboxInput("amzn_cb", "Show/Hide Amazon", value = F), 
            dateInput("startDate", "Start Date", value = "2016-01-01", min = "2013-05-01", max = "2017-08-07", 
                      format = "yyyy-mm-dd", language = "en"),
            dateInput("endDate", "End Date", value = "2016-10-01", min = "2013-05-02", max = "2017-08-08", 
                      format = "yyyy-mm-dd", language = "en"),
            submitButton("Submit")
        ), 
        mainPanel(
            plotOutput("plotOutputModel")
        )
    )
))
