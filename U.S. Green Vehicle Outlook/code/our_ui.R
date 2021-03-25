library(shiny)
b64 <- base64enc::dataURI(file = "car.jpg", mime = "image/png")
introduction <- tabPanel(
  "Introduction Page",
  titlePanel(h1("U.S. Green Vehicle Outlook")),
  sidebarLayout(
    img(src = b64, width = "800", height = "500", align = "middle"),
    sidebarPanel(
      tags$h4("The appearance of electric vehicles came with
              controversies and the development of which had been really slow.
              However, In the past decade, as more advanced technology
              developed and supported the electric vehicle industry,
              the number of green vehicles indeed started growing at a
              fast pace.
              Firstly, with all the knowing knowledge on EV development,
              we used an EV population dataset to look at its growth patterns.
              To further explore the incentives of EV growth, we chose two
              datasets on greenhouse gas emission and gasoline prices
              over the year.By generating tables and graphs based on
              such datasets, we observed some distinct patterns
              corresponding to EV population growth. In this project,
              we displayed the dynamic webpages of three data charts:
                an EV population chart, a greenhouse gas emission bar
              chart, and a gasoline price line chart. Our data source
              is from the U.S. Department of Energy website
              (https://www.energy.gov/) and Environmental
              Protection Agency website.")
    )
  )
)

# page 1 layout
page_one <- tabPanel(
  "Population Page",
  titlePanel("Development of different type of EV"),
  sidebarLayout(
    sidebarPanel(
      radioButtons(
        inputId = "EV_types",
        label = h5("Different types of EV"),
        choices = pop_list,
        selected = 4
      )
    ),
    mainPanel(
      h3("Different Types of EVs growth trend"),
      plotOutput(outputId = "ev_pop_graph"),
      tags$div(
        tags$p("We noticed that there are different weight classes
               of electric vehicles. Therefore in this page, graphs are
               designed to describe the growth of different weight EV classes.
               By observating the patterns of growth and compare the
               pattern with total number growth, we can implement the
               weight class of EV that started to replace the conventional gas
               running vehicles in the market")
      )
    )
  )
)
# page2 layout
page_two <- tabPanel(
  "Greenhouse Gas Page",
  titlePanel("GreenHouse Gas Per Year"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "x_value",
        label = h5("Which year that you want to know about the Greenhouse
                   Gas edmission?"),
        choices = list(
          "All of the GreenHouse Gas" = 0, "Carbon.dioxide" = 1,
          "Methane" = 2, "Nitrous.oxide" = 3,
          "HFCs..PFCs..SF6..and.NF3" = 4
        ),
        selected = 0
      )
    ),
    mainPanel(
      h3("Greenhouse Gas per year"),
      plotOutput(outputId = "ghg_graph"),
      tags$div(
        tags$p("The graph on the right is intended to show the relationship the
                greenhouse gas emission in different years.
                Based on the graph, 2007's greenhouse gas emission reaches the
                highest amount and 1991 has the lowest amount.
                As a result, from 1990 - 2017, greenhouse gas emission
                increases as the time shifted. 2008-2014, there is a negative
                relationship between them.")
      )
    )
  )
)

# Creates a page that displays a line graph of the annual
# gasoline prices. The slider filters for a range of years.
page_three <- tabPanel(
  "Line Graph",
  titlePanel("Annual Gasoline Prices"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("slider",
        label = "Year Ranges",
        min = 1950, max = 2018, value = c(1950, 2018)
      )
    ),
    mainPanel(
      h3("Annual Gas Prices 1950-2018"),
      plotOutput("linegraph"),
      tags$div(
        tags$p("The line graph above represents the annual,
                inflation adjusted, gasoline prices in the US from 1950-2018.
                Gasoline prices were at a low in 1998, while prices peaked
                around 2011-2012. Looking at specific ranges, we can see that
                while prices went down after 2012, they started to rise again
                from 2016-onward.")
      )
    )
  )
)

conclusion_page <- tabPanel(
  "Conclusions Page",
  titlePanel("Conclusions"),
  sidebarLayout(
    sidebarPanel(
      tags$h5("The population of the electric vehicle steadily increased until
               it prospered at the beginning of the 20th century.
           Growth stagnated around 2003, but prospered again around 2010
           due to the introduction of the Nissan Leaf in Japan and the US.
           Green house emissions had increased every year from 1990 to 2008.
           Emissions decreased from 2008-2014, but increased again after.
           Gas prices in the US hit their low in 1998,
           and peaked in 2011. While prices decreased after 2011, they've
           started to increase again starting from 2016. Limited supply and
           increase demand could cause prices to increase or stagnate
           later on, but they probably won't be what they were in 1998.
           There was not a noticable correlation between the number of EV
           vehicles and the green house emissions per year from our data.
           The green house gases peaked around 2005-2010, while the number
           of electric vehicles have been increasing exponentially
           since 2010.
           There may not necessarily be a correlation between the growth of
           EVs and the annual gas prices as policies have been made to
           incentivize the purchase of EVs. While our data shows that
           electric vehicles are becoming increasingly popular as
           gas prices increase and as green house gases increase from
           around 2013 onward, correlation doesn't always mean causation.
           We can see that electric vehicles are a plausible solution
           as EV production has been around for years, EVs
           don't emit carbon, and EVs don't take in fossil fuel.")
    ),
    mainPanel(
      h3("Summary Information For This Report"),
      tableOutput(outputId = "table")
    )
  )
)

ui <- navbarPage(
  "U.S. Green Vehicle Outlook",
  introduction,
  page_one,
  page_two,
  page_three,
  conclusion_page,
  includeCSS("sty.css")
)
