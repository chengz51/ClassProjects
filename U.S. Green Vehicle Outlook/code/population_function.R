library(dplyr)
library(ggplot2)
library(tidyr)
# load in all the datasets need
ev_num_data <- read.csv("data/SupplyData.csv", stringsAsFactors = FALSE)
ghg_emisson <- read.csv("data/us-ghg-emissions_fig-1.csv",
  stringsAsFactors = FALSE
)
gas_prices <- read.csv("data/10641_gasoline_prices_by_year.csv",
  stringsAsFactors = FALSE
)

# group by year,filter out the growth of the EV population each year.
# Then accumulate the growth and see the
# trends of electrical vehicle population.
ev_pop_table <- ev_num_data %>%
  group_by(Year) %>%
  summarise(num_per_year = sum(Number.of.Vehicles)) %>%
  mutate(ttl_num = cumsum(num_per_year))

# start plotting
population_function <- function(df) {
  ggplot(data = ev_pop_table) +
    ggtitle("EV population trends & EV population growth trend") +
    geom_line(
      mapping = aes(
        x = Year,
        y = ttl_num,
        color ="red"
      )
    ) +
    geom_bar(
      mapping = aes(
        x = Year,
        y = num_per_year,
       # color="blue"
      ),
      stat = "identity"
    ) +
    scale_color_discrete(
      name = "number variable",
      labels = c(
        "number of increase",
        "number of EV population"
      )
    ) +
    geom_point(
      mapping = aes(
        x = Year,
        y = ttl_num,
        color = "red"
      )
    ) +
    geom_point(
      mapping = aes(
        x = Year,
        y = num_per_year,
        color = "blue"
      )
    ) +
    labs(
      x = "Year",
      y = "number of EV in the US "
    )
}

