library(dplyr)
library(ggplot2)
library(tidyr)

gas_prices <- read.csv("data/10641_gasoline_prices_by_year.csv",
  stringsAsFactors = FALSE
)

# Replaces the columns in formats that are more usable.
gas_prices <- gas_prices %>%
  mutate(
    year = Year,
    gasoline_price = Gasoline.Price,
    inflation_adjuster = Inflation.Adjuster,
    gasoline_price_2018 = Gasoline.Price..2018.
  ) %>%
  select(
    Year, gasoline_price,
    gasoline_price_2018,
    inflation_adjuster
  )

# Creates a line graph after inputting a dataset as an argument.
line_function <- function(dataset) {
  ggplot(dataset) +
    geom_line(mapping = aes(x = Year, y = gasoline_price_2018)) +
    labs(
      title = "Annual Gasoline Prices",
      x = "Year",
      y = "$ per Gallon"
    )
}
