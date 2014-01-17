suppressPackageStartupMessages(library(googleVis))
library(rCharts)
library(shiny)
library(plyr)
load("decadespctshiny.rda")
shinyServer(function(input, output) {
 
  # decade output
  output$decade=renderText({paste("Decade of ",input$Decade+1,"through ",input$Decade+10)})
  
  # rCharts
  choropleth3 <- function (x, data, colors, map = "usa", ...){
    fml = lattice::latticeParseFormula(x, data = data)
    data = transform(data, fillKey = fml$left)
    d <- Datamaps$new()
    d$set(scope = map, fills = as.list(colors), 
          data = dlply(data, fml$right.name), ...)
    return(d)
  }
  output$Chart1 = renderChart({
    Chart1=choropleth3(
      CrimeRateGroup~state,
      data = decadespctshiny[decadespctshiny$Decade_Beginning==input$Decade,],
      colors = c("","#4daf4a","#fc8d62","red")
    )
    Chart1$addParams(dom = 'Chart1') 
    return(Chart1)
  })
  
  # googleVis
  output$vcgooglevis = renderGvis({
    gvisGeoChart(decadespctshiny[decadespctshiny$Decade_Beginning==input$Decade,],
                 locationvar="State", colorvar="CrimeRateGroup",
                 options=list(region="US", displayMode="regions", 
                              resolution="provinces",
                              colorAxis="{colors:['#4daf4a','#fc8d62','red']}"
                 ))})
  
  
})
