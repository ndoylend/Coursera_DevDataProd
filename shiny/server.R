library(shiny)
library(triangle)

shinyServer(function(input, output) {

  fl_area <- reactive({
    validate(
        need(input$fl_area_mode >= min(input$fl_area_range) & input$fl_area_mode <= max(input$fl_area_range),
             "Check input: value out of range"),
        need(input$n >= 2, "Check input: sample size too low")
    )
    rtriangle(n = input$n , c = input$fl_area_mode, a = min(input$fl_area_range), b = max(input$fl_area_range))
  })
  spec_occ <- reactive({
    validate(
      need(input$spec_occ_mode >= min(input$spec_occ_range) & input$spec_occ_mode <= max(input$spec_occ_range),
           "Check input: value out of range"),
      need(input$n >= 2, "Check input: sample size too low")
    )
    rtriangle(n = input$n, c = input$spec_occ_mode, a = min(input$spec_occ_range), b = max(input$spec_occ_range))
  })
  ind_consump <- reactive({
    validate(
      need(input$ind_consump_mode >= min(input$ind_consump_range) & input$ind_consump_mode <= max(input$ind_consump_range),
           "Check input: value out of range"),
      need(input$n >= 2, "Check input: sample size too low")
    )
    rtriangle(n = input$n, c = input$ind_consump_mode, a = min(input$ind_consump_range), b = max(input$ind_consump_range))
  })
  daily_consump <- reactive((fl_area() / spec_occ()) * ind_consump())
  
  output$fl_areaPlot <- renderPlot({
    par(bg = NA)
    plot(density(fl_area()), main = "Floor area", xlab="(m2)")
  }, height = 300, width = 300)
  
  output$fl_area <- renderText({
    c("Median: ",round(median(fl_area()), digits = 1)," m2")
  })

  output$spec_occPlot <- renderPlot({
    par(bg = NA)
    plot(density(spec_occ()), main = "Occupancy density", xlab="(m2/person)")
  }, height = 300, width = 300)
  
  output$spec_occ <- renderText({
    c("Median: ", round(median(spec_occ()), digits = 1), " m2")
  })
  
  output$ind_consumpPlot <- renderPlot({
    par(bg = NA)
    plot(density(ind_consump()), main = "Individual consumption", xlab="(l/(person.day))")
  }, height = 300, width = 300)
  
  output$ind_consump <- renderText({
    c("Median: ", round(median(ind_consump()), digits = 1), " l/(person.day)")
  })

  output$daily_consumpPlot <- renderPlot({
    par(bg = NA)
    plot(density(daily_consump()), main = "Total consumption", xlab="(l/day)")
  }, height = 300, width = 300)

  output$daily_consump <- renderText({
    c("Median: ", round(median(daily_consump()), digits = 1), " l/day")
  })

})
