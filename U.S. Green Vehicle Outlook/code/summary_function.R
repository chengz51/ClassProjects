library(dplyr)

source("scripts/line_function.R")

# Filters for the gasoline prices adjusted for inflation.
gas_prices <- gas_prices %>%
  filter(prices == "gasoline_price_2018")

# Returns a list of information containing the peak gas price,
# the peak year, the lowest year, the three most recent prices
# and the average gas price over the years. Uses the 2018
# prices rather than the uninflated prices.
get_summary_info <- function(dataset) {
  list(
    peak_price = max(dataset$total),
    peak_year = dataset %>%
      filter(total == max(total)) %>%
      pull(year),
    lowest_year = dataset %>%
      filter(total == min(total)) %>%
      pull(year),
    three_recent_prices = dataset %>%
      arrange(-year) %>%
      head(n = 3) %>%
      pull(total),
    average_price = round(mean(dataset$total), 3)
  )
}
