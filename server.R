library(shiny)

# preprocess data for the app
source('df_list.R')

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    output$distPlot <- renderPlot({

        regions <- input$checkGroup
        
        par(mar=c(5,4,0,1))
        plot(NULL,
             xlim=c(1825,2005),
             ylim=c(0,115),
             xlab='Time',
             ylab='No of wars',
             main='',
             xaxt='n'     
        )
        axis(1,at=seq(1825,2005,15),las=2)
        
        if (length(regions) > 0 ) {
            colVector <- vector()
            for (reg in regions) {
                switch(reg,
                       'West Hemisphere'={lineColour <- 'Red'},
                       'Europe'={lineColour <- 'Blue'},
                       'Africa'={lineColour <- 'Black'},
                       'Middle East'={lineColour <- 'forestgreen'},
                       'Asia'={lineColour <- 'darkgoldenrod2'},
                       'Oceania'={lineColour <- 'blueviolet'}
                )
                lines(mydensity[[reg]],col=lineColour,lwd=2)
                colVector <- union(colVector,lineColour)
            }
            legend('topleft',
                   ncol=2,
                   legend=regions,
                   fill=colVector)
        }
        else {
            legend('topleft',
                   ncol=2,
                   legend='No regions are selected.')
        }
    })
})
