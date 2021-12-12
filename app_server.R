library("shiny")
library("ggplot2")
library("plotly")
library("dplyr")
library("tidyverse")

climate_data <- read.csv('https://raw.githubusercontent.com/info-201a-au21/a4-climate-change-chilidragon/main/owid-co2-data.csv?token=AV6PPAZSX72XGMIAAP33QH3BX3RWK', stringsAsFactors = FALSE)

climate_data<- climate_data %>%
  filter(country %in% c(
    "America", "Australia", "United Kingdom", "Brazil", "China",
    "India", "Russia", "Canada"
  ))

server <- function(input, output){
  
  output$climate_plot <- renderPlotly({
    climate_data <- climate_data %>%
      filter(year > input$year[1], year < input$year[2])
  
    plot <- ggplot(data = climate_data) +
      geom_line(mapping = aes(x=year, y= !!as.name(input$y_axis_input), 
                              color= country))+
      labs(x="Year", y= paste(gsub("[[:punct:]]", " ", 
                                   input$y_axis_input), 'Amount')) +
      guides(fill=guide_legend(title="Country"))
  
    co_plot <- ggplotly(plot)
    return(co_plot)
  })
  
  output$most_co2 <- renderText({
    most_c <- climate_data %>%
      filter(year == 2020) %>%
      group_by(country) 
    return(paste0(max(most_c$co2), "."))
  })
  
  output$most_name <- renderText({
    most_c <- climate_data %>%
      filter(year == 2020) %>%
      group_by(country)
    
    most_n <- climate_data %>%
      filter(year == 2020) %>%
      group_by(country) %>%
      filter(co2 == max(most_c$co2))
    return(most_n$country)
  })
  
  output$least_co2 <- renderText({
    least_c <- climate_data %>%
      filter(year == 2020) %>%
      group_by(country)
    return(paste0(min(least_c$co2), "."))
  })
  
  output$least_name <- renderText({
    most_c <- climate_data %>%
      filter(year == 2020) %>%
      group_by(country)
    
    least_n <- climate_data %>%
      filter(year == 2020) %>%
      group_by(country) %>%
      filter(co2 == min(most_c$co2))
    return(least_n$country)
  })
  
  output$most_year <- renderText({
    most_y <- climate_data %>%
      filter(year > 2000) %>%
      group_by(year) %>%
      summarise(sum_co2 = sum(co2))
    year <- most_y %>%
      filter(sum_co2 == max(sum_co2))
    return(paste0((year$year), ","))
  })
}
