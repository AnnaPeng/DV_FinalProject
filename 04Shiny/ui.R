#ui.R

require(shiny)
require(shinydashboard)
require(leaflet)
require(shinyBS)
dashboardPage(skin = "green",
               dashboardHeader(title = "Shiny Final Project - Car's Fuel Consumpsions In UK",
                               titleWidth = 500
               ),
  dashboardSidebar(
    sidebarMenu(
      menuItem("ScatterPlot", tabName = "scatterplot", icon = icon("th")),
      menuItem("Cross-Tab", tabName = "crosstab", icon = icon("th")),
      menuItem("Table", tabName = "table", icon = icon("th"))
    )
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "scatterplot",
              sliderInput("yr", "Please select the year from 2000 to 2013", 
                          min = 2000, max = 2013,  value = 13),
              checkboxGroupInput(inputId = "brand",
                                 label = "Manufacturer",
                                 choices = c("All","Audi", "Bentley Motors", "BMW", "Cadillac", "Chevrolet", "Chrysler Jeep", "Corvette", "Dodge", "Ferrari", "Fiat", "Ford", "Honda", "Hummer", "Hyundai", "Infiniti", "Isuzu", "Jaguar Cars", "Kia", "Lamborghini", "Land Rover", "Lexus", "Maserati", "Mazda", "McLaren", "Mercedes-Benz", "Mini", "Mitsubishi", "Nissan", "Porsche", "Rolls-Royce", "Saab", "Smart", "Subaru", "Suzuki", "Toyota", "Volkswagen", "Volvo"), selected = "ALL", inline = TRUE),
              #actionButton("tabBut2", "Click Here To View The Table"),
              textInput(inputId = "title", 
                        label = "ScatterPlot Title",
                        value = "Car's Fuel Consumpsions in UK"),
              actionButton(inputId = "clicks1",  label = "Click Here"),
              plotOutput("distPlot1")
              #bsModal("modalExample2", "Data Table", "tabBut2", size = "extra large",
                      #dataTableOutput("scatterplottable"))
      ),
      
        # Second tab content
        tabItem(tabName = "crosstab",
                actionButton(inputId = "light", label = "Light"),
                actionButton(inputId = "dark", label = "Dark"),
                sliderInput("KPI1", "KPI_Low_Max_value:", 
                            min = 1, max = 250,  value = 1),
                sliderInput("KPI2", "KPI_Medium_Max_value:", 
                            min = 250, max = 500,  value = 1),
                actionButton("tabBut", "Click Here To View The Table"),
                textInput(inputId = "title", 
                          label = "Crosstab Title",
                          value = "Car's Fuel Consumpsions In UK"),
                actionButton(inputId = "clicks2",  label = "Click Here"),
                plotOutput("distPlot2"),
                bsModal("modalExample", "Data Table", "tabBut", size = "large",
                        dataTableOutput("crosstabtable"))
      ),
      
      # Third tab content
      tabItem(tabName = "table",
              actionButton(inputId = "clicks3",  label = "Click Here To Get The Data"),
              dataTableOutput("table")
      )
    )
  )
)
