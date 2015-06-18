library(shiny)
library(ggplot2)

shinyServer(
  function(input, output) {
    state <- reactiveValues(x=vector("numeric"), y=vector("numeric"))
    
    observeEvent(input$addpoint, {
      state$x <- append(isolate(state$x), input$x)
      state$y <- append(isolate(state$y), input$y)
    })
    
    observeEvent(input$clearpoints, {
      state$x <- vector("numeric")
      state$y <- vector("numeric")
    })
    
    output$plot <- renderPlot({
      table <- data.frame(x=state$x, y=state$y)
      if(nrow(table) == 0)
        return()
      g <- ggplot(data=table, aes(x=x, y=y))
      g <- g + coord_cartesian(xlim = c(-10, 10), ylim=c(-10, 10))
      g <- g + geom_point(size=3, colour='red')
      g <- g + geom_smooth(method='lm')
      g
    })
    
    output$table <- renderTable({
      data.frame(x=state$x, y=state$y)
    })
  })