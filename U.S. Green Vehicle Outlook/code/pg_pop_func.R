library(dplyr)
library(ggplot2)
library(tidyr)
library(DataCombine)
# load in the data first
ev_num_data <- read.csv("data/SupplyData.csv", stringsAsFactors = FALSE)

# group by year,filter out the growth of the EV population each year.
# Then accumulate the growth and see the
# trends of electrical vehicle population.
# However, I want to look at the EV types this time.
# Additionally, this data is grouped by EV type as well.
ev_pop_table_pg <- ev_num_data %>%
  group_by(Year, Weight.Class) %>%
  summarise(num_per_year = sum(Number.of.Vehicles))

ev_pop_table <- ev_num_data %>%
  group_by(Year) %>%
  summarise(num_per_year = sum(Number.of.Vehicles)) %>%
  mutate(ttl_num = cumsum(num_per_year))
#to get the accumulative values, we seperate the tables into three
# heavy weight EV numbers
hvy_table <- ev_pop_table_pg %>%
  filter(Weight.Class == "Heavy Duty") %>%
  select(-Weight.Class)
  #mutate(ttl_num_year=cumsum(num_per_year))
mid_table <- ev_pop_table_pg %>%
  filter(Weight.Class == "Medium Duty") %>%
  select(-Weight.Class)
lt_table <- ev_pop_table_pg %>%
  filter(Weight.Class == "Light Duty") %>%
  select(-Weight.Class)

#just observed the table,
#we can see the mid duty EV first appeared in 1996.
# here a row is inserted so that it's easier for further analysis.
# (1994,1995 mid duty EV population=0)
mid_new1 <- c(1994, 0)
mid_table <- InsertRow(mid_table, NewRow = mid_new1, RowNum = 1)
mid_new2 <- c(1995, 0)
mid_table <- InsertRow(mid_table, NewRow = mid_new2, RowNum = 2)
#we can also see the heavy duty EV has no increments in 2004 2011 2012 .
# here a row is inserted so that it's easier for further analysis.
# (1994,1995 mid duty EV population=0)
hvy_new1 <- c(2004, 0)
hvy_new2 <- c(2011, 0)
hvy_new3 <- c(2012, 0)
hvy_table <- InsertRow(hvy_table, NewRow = hvy_new1, RowNum = 1)
hvy_table <- InsertRow(hvy_table, NewRow = hvy_new2, RowNum = 2)
hvy_table <- InsertRow(hvy_table, NewRow = hvy_new3, RowNum = 3)
hvy_table <- arrange(hvy_table, Year)
# compared to the increment of EV population,
# we are more interested in total number of EV each year.
lt_table$ttl_num_lt <- cumsum(lt_table$num_per_year)
mid_table$ttl_num_mid <- cumsum(mid_table$num_per_year)
hvy_table$ttl_num_hvy <- cumsum(hvy_table$num_per_year)
# finally, graph function and shiny input list
pop_list  <- list("number of light duty EV" = 1,
                  "number of medium duty EV" = 2,
                  "number of heavy duty EV" = 3,
                  "number of total EV" = 4)
pop_graph <- function(num) {
  if (num == 1) {
    point_line_chart <- ggplot(data = lt_table) +
      ggtitle("light duty EV population trend") +
      geom_point(mapping = aes(x = Year,
                           y = ttl_num_lt),
               stat = "identity",
               color = "red") +
      geom_line(mapping = aes(x = Year,
                            y = ttl_num_lt),
                color = "red") +
      labs(
        x = "Year",
        y = "number of light duty EV in the US ")
    return(point_line_chart)
  }
  else if (num == 2) {
    point_line_chart <- ggplot(data = mid_table) +
      ggtitle("medium duty EV population trend") +
      geom_point(mapping = aes(x = Year,
                           y = ttl_num_mid),
               stat = "identity",
               color = "blue") +
      geom_line(mapping = aes(x = Year,
                            y = ttl_num_mid),
                color = "blue") +
      labs(
        x = "Year",
        y = "number of medium duty EV in the US ")
    return(point_line_chart)
  }
  else if (num == 3) {
    point_line_chart <- ggplot(data = hvy_table) +
      ggtitle("heavy duty EV population trend") +
      geom_point(mapping = aes(x = Year,
                           y = ttl_num_hvy),
               stat = "identity",
               color = "pink") +
      geom_line(mapping = aes(x = Year,
                            y = ttl_num_hvy),
                color = "green") +
      labs(
        x = "Year",
        y = "number of heavy duty EV in the US ")
    return(point_line_chart)
  }
  else {
    point_line_chart <- ggplot(data = ev_pop_table) +
    ggtitle("total EV population trend") +
    geom_point(mapping = aes(x = Year,
                           y = ttl_num),
               stat = "identity",
               color = "black") +
    geom_line(mapping = aes(x = Year,
                          y = ttl_num),
              color = "black") +
      labs(
        x = "Year",
        y = "number of total EV in the US ")
    return(point_line_chart)
  }
}
