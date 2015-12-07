# server.R
require("jsonlite")
require("RCurl")
require(ggplot2)
require(dplyr)
require(shiny)
require(shinydashboard)
require(leaflet)
require(DT)

shinyServer(function(input, output) {
  # Generate the data frame from the server
  df1 <- eventReactive(input$clicks1, {df <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from carconsump"'), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_pp9774', PASS='orcl_pp9774', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
  })
  
  # Code for input the year
  YEAR <- reactive({input$yr})     
  
  # Code for the check box
  checkBoxes <- eventReactive({input$brand}, {
    if (input$brand == "All" || is.null(input$brand))
    {
      checkBoxes = c("All","Audi", "Bentley Motors", "BMW", "Cadillac", "Chevrolet", "Chrysler Jeep", "Corvette", "Dodge", "Ferrari", "Fiat", "Ford", "Honda", "Hummer", "Hyundai", "Infiniti", "Isuzu", "Jaguar Cars", "Kia", "Lamborghini", "Land Rover", "Lexus", "Maserati", "Mazda", "McLaren", "Mercedes-Benz", "Mini", "Mitsubishi", "Nissan", "Porsche", "Rolls-Royce", "Saab", "Smart", "Subaru", "Suzuki", "Toyota", "Volkswagen", "Volvo")
    }
    else
    {
      checkBoxes = input$brand
    }
  }, ignoreNULL = FALSE)
  
  #scatterplot <- eventReactive(input$clicks1, {df_1 <- df1 %>% select(YEAR, COMBINED_IMPERIAL, ENGINE_CAPACITY, MANUFACTURER, TRANSMISSION_TYPE) %>% group_by(MANUFACTURER) %>% subset(YEAR %in% YEAR()) %>% subset(MANUFACTURER %in% checkBoxes())

  # First ggplot------------------------------------------------------
  output$distPlot1 <- renderPlot({   
    # Filter the year and the brand of the car based on the check box
    scatterplot <- df1() %>% select(YEAR, COMBINED_IMPERIAL, ENGINE_CAPACITY, MANUFACTURER, TRANSMISSION_TYPE) %>% group_by(MANUFACTURER) %>% subset(YEAR %in% YEAR()) %>% subset(MANUFACTURER %in% checkBoxes())
    
    plot1 <- ggplot() + 
      coord_cartesian() + 
      scale_x_continuous() +
      scale_y_continuous() +
      labs(title='Scatterplot of Engine Capacity VS. Gas Efficiency') +
      labs(x="Engine Capacity", y=paste("Gas Efficiency")) +
      layer(data=scatterplot, 
            mapping=aes(x=as.numeric(as.character(ENGINE_CAPACITY)), y=as.numeric(as.character(COMBINED_IMPERIAL)), color=MANUFACTURER),
            stat="identity", 
            stat_params=list(), 
            geom="point",
            geom_params=list(), 
            position=position_identity()
      )
    plot1
  }) 
  # End First ggplot---------------------------------------------------

#***********************************************************************#
  
  # Begin code for Second Tab:
  KPI_Low_Max_value <- reactive({input$KPI1})
  KPI_Medium_Max_value <- reactive({input$KPI2})
  rv <- reactiveValues(alpha = 0.50)
  observeEvent(input$light, { rv$alpha <- 0.50 })
  observeEvent(input$dark, { rv$alpha <- 0.75 })
  
  UK <- data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from carconsump"'), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_pp9774', PASS='orcl_pp9774', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
    
  UK1 <- UK %>% group_by(FUEL_TYPE, TRANSMISSION_TYPE) %>% summarize(AVERAGE_COST = round(mean(FUEL_COST_6000_MILES)))
  
  #UK2 <- UK1 %>% group_by(FUEL_TYPE, MANUFACTURER, SUM_URBAN_IMPERIAL) %>% summarize(SUM_CO2 = sum(CO2))
  
  df2 <- eventReactive(input$clicks2, {df <- UK1 %>% mutate(KPI = ifelse((AVERAGE_COST) <= KPI_Low_Max_value(), 'Most Efficiency', ifelse((AVERAGE_COST) <= KPI_Medium_Max_value(),'Normal', 'Least Efficiency')))
  })
  # Second ggplot------------------------------------------------------
  output$distPlot2 <- renderPlot(height=400, width=600,{   
    
      plot2 <- ggplot() + 
        coord_cartesian() + 
        scale_x_discrete() + 
        scale_y_discrete() +
        labs(title="Car's Fuel Consumptions In UK Crosstab\n") +
        labs(x=paste("TRANSMISSION TYPE"), y=paste("FUEL TYPE")
        ) +
        layer(data=df2(), 
              mapping=aes(x=TRANSMISSION_TYPE, y=FUEL_TYPE, label=AVERAGE_COST), 
              stat="identity", 
              stat_params=list(), 
              geom="text",
              geom_params=list(colour="black"), 
              position=position_identity()
        ) +
        layer(data=df2(), 
              mapping=aes(x=TRANSMISSION_TYPE, y=FUEL_TYPE, fill=KPI), 
              stat="identity", 
              stat_params=list(), 
              geom="tile",
              geom_params=list(alpha=rv$alpha), 
              position=position_identity()
        )
      plot2
      
    }) 
    output$crosstabtable <- renderDataTable({datatable(df2())})
    observeEvent(input$clicks2, {
      print(as.numeric(input$clicks2))
    })
  
#***********************************************************************#
  
  # Begin code for Third Tab:
  df3 <- eventReactive(input$clicks3, {data.frame(fromJSON(getURL(URLencode('skipper.cs.utexas.edu:5001/rest/native/?query="select * from carconsump"'), httpheader=c(DB='jdbc:oracle:thin:@sayonara.microlab.cs.utexas.edu:1521:orcl', USER='C##cs329e_pp9774', PASS='orcl_pp9774', MODE='native_mode', MODEL='model', returnDimensions = 'False', returnFor = 'JSON'), verbose = TRUE)))
    
  })
  
  output$table <- renderDataTable({datatable(df3())
  })
})
