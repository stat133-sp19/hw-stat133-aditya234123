#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)

#' @title future_value
#' @description returns the computed future value of an investment
#' @param amount initial investment amount
#' @param rate annual return rate
#' @param years how many years
#' @return computed future value
future_value <- function(amount, rate, years) {
  return (amount*((1+rate)^years))
}

#' @title annuity
#' @description returns the computed future value of annuity
#' @param contrib how much money contributed each year
#' @param rate annual return rate
#' @param years how many years
#' @return computed future value of annuity
annuity <- function(contrib, rate, years) {
  return(contrib*((((1+rate)^years)-1)/rate))
}

#' @title growing_annuity
#' @description returns the computed future value of growing annuity
#' @param contrib how much money contributed each year
#' @param rate annual return rate
#' @param growth growth rate
#' @param years how many years
#' @return computed future value of growing annuity
growing_annuity <- function(contrib, rate, growth, years) {
  return (contrib*((((1+rate)^years)-((1+growth)^years))/(rate-growth)))
}



# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Saving/Investment Scenarios"),
   
  fluidRow(
    column(4,
           sliderInput("initial", label = h3("Initial Amount"), min = 0, 
                       max = 100000, value = 1000, pre = "$", step = 500)
    ), 
    column(4,
           sliderInput("return_rate", label = h3("Return Rate (in %)"), min = 0, 
                       max = 20, value = 5, step = 0.1)
    ),
    column(4,
           sliderInput("years", label = h3("Years"), min = 0, 
                       max = 50, value = 20, step = 1)
    )
    ),
  
  fluidRow(
    column(4,
           sliderInput("annual_contrib", label = h3("Annual Contribution"), min = 0, 
                       max = 50000, value = 2000, pre = "$", step = 500)
    ), 
    column(4,
           sliderInput("growth_rate", label = h3("Growth Rate (in %)"), min = 0, 
                       max = 20, value = 2, step = 0.1)
    ),
    column(4,
           selectInput("facet", label = h3("Facet?"), 
                       choices = list("No" = 1, "Yes" = 2), 
                       selected = 1)
    )
  ),
  titlePanel("Timelines"),
  fluidRow(plotOutput("timeline")),
  titlePanel("Balances"),
  fluidRow(tableOutput("balances_table"))
)
   


# Define server logic required to draw a histogram
server <- function(input, output) {
  
  modalities <- reactive({
    no_contrib <- vector(length = input$years)
    fixed_contrib <- vector(length = input$years)
    growing_contrib <- vector(length = input$years)
    no_contrib[1] <- input$initial
    fixed_contrib[1] <- input$initial
    growing_contrib[1] <- input$initial
    
    for (i in 2:(input$years+1)) {
      no_contrib[i] <- future_value(input$initial, input$return_rate/100, i-1)
      fixed_contrib[i] <- no_contrib[i] + annuity(input$annual_contrib, input$return_rate/100, i-1)
      growing_contrib[i] <- no_contrib[i] + growing_annuity(input$annual_contrib, input$return_rate/100, input$growth_rate/100, i-1)
    }
    
    modalities <- data.frame(year=0:input$years, no_contrib=no_contrib, fixed_contrib=fixed_contrib, growing_contrib=growing_contrib)
    modalities
  })
   
   output$timeline <- renderPlot({
     modalities <- modalities()
     
     if (input$facet == 1) {
       ggplot() + 
         geom_line(data = modalities, aes(x = year, y = no_contrib, color = "no")) + 
         geom_line(data = modalities, aes(x = year, y = fixed_contrib, color = "fixed")) +
         geom_line(data = modalities, aes(x = year, y = growing_contrib, color = "growing")) + 
         ggtitle("Savings using different investment methods") + 
         xlab("Years") +
         ylab("Value") + 
         theme_minimal() +
         scale_colour_manual(name = 'Modality', 
                             guide = 'legend',
                             values = c('no' = 'red',
                                        'fixed' = 'green',
                                        'growing' = 'blue'), 
                             labels = c('no' = "No Contribution",
                                        'fixed' = "Fixed Contribution",
                                        'growing' = "Growing Contribution"),
                             breaks = c("no", "fixed", "growing")) +
         scale_x_continuous(breaks=1:input$years)
     } else {
       flatten <- c(modalities[,2], modalities[,3], modalities[,4])
       years_rep <- rep(modalities[,1], 3)
       facet_col <- c(rep("no_contrib", input$years+1), rep("fixed_contrib", input$years+1), rep("growing_contrib", input$years+1))
       df_facet <- data.frame(year=years_rep, values=flatten, facet=facet_col)
       df_facet$facet = factor(df_facet$facet, levels = c("no_contrib", "fixed_contrib", "growing_contrib")) # For proper order
       ggplot(df_facet) + 
         geom_area(aes(x = year, y = values, color = facet, fill = facet), alpha = 0.5) + 
         geom_point(aes(x = year, y = values, color = facet)) + 
         geom_line(aes(x = year, y = values, color = facet)) + 
         facet_wrap(~ facet) + 
         xlab("Year") + 
         ylab("Value") + 
         theme_minimal() + 
         ggtitle("Three modes of investing")
     }
   })
   
   output$balances_table <- renderTable({
     modalities()
   })
}

# Run the application 
shinyApp(ui = ui, server = server)

