library(shiny)
library(plotly)

year_range <-range(2000,2020)

vis_sidebar <- sidebarPanel(
  selectInput(
    inputId = "y_axis_input",
    label = "CO2 Source",
    choices = list("All Source"  = "co2" ,
                   "Trade CO2" = "trade_co2",
                   "Cement CO2" = "cement_co2",
                   "Coal CO2" = "coal_co2",
                   "Flaring CO2" = "flaring_co2",
                   "Gas CO2" = "gas_co2",
                   "Oil CO2" = "oil_co2",
                   "Other Industry CO2" = "other_industry_co2" 
    ),
    selected = "All Source" 
  ),
  
  sliderInput(
    inputId = "year",
    label = "Year Range",
    min = year_range[1],
    max = year_range[2],
    value = year_range
  )
)

vis_main <- mainPanel(
  h2("CO2 Production Amount From Different Source for Eight Countries"),
  plotlyOutput(outputId = "climate_plot"),
  
  h2("Insight"),
  p("The graph mainly explored the vaccination preferences of selected eight 
     countries which inclued both developed and undeveloped countries in
     each continent which means they can roughly summarize the law of emissions 
     around the world. The reason why I include that chart is that we can see 
     which country contribute more CO2 to our planet and what source is the major 
     contributor of CO2. From the chart, we can see, the amount of CO2 produced
     by each country vary a lotm however, the trend of CO2 production is
     increasing troughout years.")
)

introduction_panel <- tabPanel(
  "Introduction of the Analysis",
  titlePanel("Introduction"),
  p('CO2 is the major reason lead to climate change. For these analysis,
     we will focus on the major soure of CO2 in eight countries and the year
     period within 2000 to 2020. In the eight countries,', 
     textOutput("most_name", inline = TRUE), 'have the highest 
     CO2 emmsion in 2020 about', textOutput("most_co2", inline = TRUE), ' In 
     the eight countries,', textOutput("least_name", inline = TRUE), 
     'have the lowest CO2 emmsion in 2020 about', 
     textOutput("least_co2", inline = TRUE), 'In', 
     textOutput("most_year", inline = TRUE), 'we have the most CO2 emission(only
     for the eight countries we selected for this analysis).By this situation, 
     we can guess that Covid-19 have a good effect on reducing
     CO2 emmsion since there will be less industrial production around world.' )
)
  
vis_panel <- tabPanel(
  "World CO2 Analysis",
  titlePanel("World CO2 Visulization of Different Source"),
  sidebarLayout(
    vis_sidebar,
    vis_main
  )
)

ui <- navbarPage(
  "Climate Change Analysis",
  introduction_panel,
  vis_panel,
)