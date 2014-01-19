library(rCharts)
shinyUI(bootstrapPage(
  div(class="row",
      div(class="span4",
          sliderInput("Decade","", min=1960, max=2000, value=1960,  format="###0",step=10,animate=animationOptions(loop=T, interval=2500)))),

  htmlOutput("decade"),
  img(src = "legend.png", height = 200, width = 200),
  tabsetPanel(
    tabPanel("rCharts", showOutput("Chart1","datamaps")),
    tabPanel("googleVis", htmlOutput("vcgooglevis"))
  )))
