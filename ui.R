library(shiny)

# Define UI for application that draws a histogram
shinyUI(
    fluidPage(
        # Application title
        titlePanel("Number of wars in different regions"),
        
        # Sidebar with a slider input for the number of bins
        sidebarLayout(
            sidebarPanel(
                checkboxGroupInput('checkGroup',
                                   label=h3('Select regions'),
                                   choices=list('West Hemisphere' = 'West Hemisphere',
                                                'Europe'          = 'Europe',
                                                'Africa'          = 'Africa',
                                                'Middle East'     = 'Middle East',
                                                'Asia'            = 'Asia',
                                                'Oceania'         = 'Oceania'),
                                   selected=NULL
                )
            ), 
            # Show a plot of the generated distribution
            mainPanel(
                plotOutput("distPlot")
            )
        )
    )
)
