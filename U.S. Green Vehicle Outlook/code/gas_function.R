library(dplyr)
library(ggplot2)
library(tidyr)
df <- read.csv("data/us-ghg-emissions_fig-1.csv", stringsAsFactors = FALSE)
#Add a column for the sum for all the gases
df_update <- df %>%
  mutate(greenHouseGas = Carbon.dioxide + Methane +
    Nitrous.oxide + HFCs..PFCs..SF6..and.NF3)

gas <- df_update %>%
  select(-greenHouseGas) %>%
  gather(type, count, Carbon.dioxide:HFCs..PFCs..SF6..and.NF3)

#Create a function to graph the Greenhouse Gas per year
gas_function <- function(num) {
  if (num == 0) {
    gas <- gas
    color <- "Dark2"
  } else if (num == 1) {
    gas <- gas[1:25, 1:3]
    color <- "Dark2"
  } else if (num == 2) {
    gas <- gas[26:50, 1:3]
    color <- "PRGn"
  } else if (num == 3) {
    gas <- gas[51:75, 1:3]
    color <- "PiYG"
  } else if (num == 4) {
    gas <- gas[76:100, 1:3]
    color <- "RdBu"
  }
  g <- ggplot(gas, aes(x = Year, y = count, fill = type)) +
    ggtitle("Greenhouse Gas per year") +
    geom_bar(stat = "identity") +
    labs(
      x = "Year",
      y = "Greenhouse Gas emssion
      units: (million metric tons of CO2 equivalents)"
    ) + scale_fill_brewer(palette = color)
   g + coord_cartesian(xlim = c(1900, 2100), ylim = c(0, 100000))
  return(g)
}
