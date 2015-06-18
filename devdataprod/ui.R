library(shiny)
shinyUI(
  pageWithSidebar(
    # Application title
    headerPanel("Linear regressor"),
    sidebarPanel(
      p('enter points, and always push "Add point" and you will see them appear in the plot.
        When you want to start ofver "Clear points" and your dataset is reset'),
      numericInput('x', 'x coordinate', 0, min = -10, max = 10, step = 1),
      numericInput('y', 'y coordinate', 0, min = -10, max = 10, step = 1),
      actionButton('addpoint', 'Add point'),
      actionButton('clearpoints', 'Clear points'),
      h3('Your data for the plot'),
      tableOutput('table')
    ),
    mainPanel(
      h3('Visualisation of your data'),
      p('here, you see your data plotted with a linear regression on them. For each added
        point, the regression line is updated. Please consider, that points that are directly
        above each other, i.e. no different in the x-coordinate, will not produce a linear 
        regression line. Other than that, have fun.'),
      plotOutput('plot', height = "600px", width = "600px"),
      a('View source on github', href='https://github.com/DanielFabian/datasciencecoursera/tree/master/devdataprod')
    )
  )
)