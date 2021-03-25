library(dplyr)
source("scripts/population_function.R")
#( group_by function already used in population_function)
# load in all the datasets
ev_num_data <- read.csv("data/SupplyData.csv", stringsAsFactors = FALSE)
ghg_emisson <- read.csv("data/us-ghg-emissions_fig-1.csv",
  stringsAsFactors = FALSE
)
gas_prices <- read.csv("data/10641_gasoline_prices_by_year.csv",
  stringsAsFactors = FALSE
)


gas_prices <- gas_prices %>%
  mutate(
    Year = Year,
    gasoline_price = Gasoline.Price,
    inflation_adjuster = Inflation.Adjuster,
    gasoline_price_2018 = Gasoline.Price..2018.
  )

  

# fliter out the info between year 1994-2014
ev_num_data9414 <- ev_pop_table %>%
  filter(Year < 2015) %>%
  select(Year, ttl_num)
ghg_emisson9414 <- ghg_emisson %>%
  mutate(
    ttl_ghg =
      Carbon.dioxide +
        Methane +
        Nitrous.oxide +
        HFCs..PFCs..SF6..and.NF3
  ) %>%
  filter(Year > 1993) %>%
  select(Year, ttl_ghg)
gas_prices9414 <- gas_prices %>%
  filter(Year > 1993 & Year < 2015) %>%
  select(Year, Gasoline.Price..2018.)

# joint the tables together to get summary infomation

tb1 <- left_join(ev_num_data9414,
  ghg_emisson9414,
  by = "Year"
)
summary9414 <- left_join(tb1, gas_prices9414,
  by = "Year"
)
col_names <- c(
  "Year", "number of EV population in US",
  "Greenhouse Emission (million metric tons)",
  "Gasoline current price ($/gallon)"
)

a <- summary9414[7:21, ]
colnames(a) <- col_names

table_function <- function(a) {
  t <- a
  return(t)
}
