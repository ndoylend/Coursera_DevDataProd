library(shiny)

shinyUI(fluidPage(
	titlePanel("Estimated Water Consumption"),
  fluidRow(
    column(9, strong("Probabilistic Inputs")),
    column(3, strong("Probabilistic Output"))
  ),
  fluidRow(
    column(3, style = "background-color: #ffffcc; border-style: solid; border-width: 1px;",
           plotOutput("fl_areaPlot", height="auto"),
           strong("Area (m2)"),
           sliderInput("fl_area_range", "Range of values:", min = 100, max = 2500, value = c(400, 600), step = 50),
           numericInput("fl_area_mode", "Most likely value:", 500, step = 50),
           textOutput("fl_area")),
    column(3, style = "background-color: #ffffcc; border-style: solid; border-width: 1px;",
           plotOutput("spec_occPlot", height="auto"),
           strong("Occupancy (m2/person)"),
           sliderInput("spec_occ_range", "Range of values:", min = 0, max = 50, value = c(8, 16)),
           numericInput("spec_occ_mode", "Most likely value:", 15, step = 1),
           textOutput("spec_occ")),
    column(3, style = "background-color: #ffffcc; border-style: solid; border-width: 1px;",
           plotOutput("ind_consumpPlot", height="auto"),
           strong("Consumption (l/person.day)"),
           sliderInput("ind_consump_range", "Range of values:", min = 0, max = 50, value = c(8, 14)),
           numericInput("ind_consump_mode", "Most likely value:", 10, step = 1),
           textOutput("ind_consump")),
    column(3, style = "background-color: #ccffff; border-style: solid; border-width: 1px;",
           plotOutput("daily_consumpPlot", height="auto"),
           strong("Total Consumption (l/day)"),
           textOutput("daily_consump"))
  ),
  fluidRow(
    column(9, strong("Instructions"),
           br("This shiny application demonstrates a simple probabilistic calculation of an
              office building's daily hot water consumption. Each input parameter has a slider
              for setting the range of possible values and a numeric input for entering the most
              likely value. The most likely value must fall within the range of possible values
              in order to obtain a valid input distribution. There is also a numeric input for 
              specifing the number of random samples used to generate the distributions."),
           em("Please see",
           a(href="http://ndoylend.github.io/Coursera_DevDataProd","here"),
           "for the accompanying slidify presentation.")
    ),     
    column(3, strong("Settings"),
           numericInput("n", "Random sample size:", value = 10000, min = 10, max = 100000, step = 1000)
    )
  )
))

