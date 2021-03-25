source("scripts/gas_function.R")
source("scripts/pg_pop_func.R")
source("scripts/line_function.R")
source("scripts/summary_table.R")

server <- function(input, output) {
  output$ghg_graph <- renderPlot(
    gas_function(input$x_value)
  )
 # output population graph
  output$ev_pop_graph <- renderPlot(
    pop_graph(input$EV_types)
  )
  output$table <- renderTable(
    table_function(a)
  )

  # Outputs a line graph
  output$linegraph <- renderPlot({
    gas_prices <- gas_prices %>%
      filter(Year >= input$slider[1] & Year <= input$slider[2])
    line_function(gas_prices)
  })
}
