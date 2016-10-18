# Some refrence code to help me get started is at the bottom of the file!

library(shiny)
shinyUI(pageWithSidebar(
  headerPanel("FC Barcelona in La Liga during 2005-2015"),
  sidebarPanel(
    numericInput('season','Season',2015,min=2005,max=2015,step=1),
    
    h4('User Instructions'),
    h5('1. There is a widget on the top left that is used to input the season.'),
    h5('2. On the right, you see a plot that shows the goals difference of FC Barcelona with its competitors during the given season.'),
    h5('3. The goals difference for home games is shown with label H in magenta color.'),
    h5('4. The goals difference for away games is shown with label A in blue color.'),
    h5('5. The horizontal line is at goals difference of zero. This line indicates the drawn games.'),
    h5('6. The labels above the horizontal line at y = 0 show the games that Barca won by the number of goals on the y-axis.'),
    h5('7. The labels below the horizontal line at y = 0 show the games that Barca lost by the number of goals shown on the y-axis.'),
    h6('For any questions, write to me at mohsinrazadanish@gmail.com')
    
  ),
  mainPanel(
    plotOutput('newPlot')

  )
)
)

# library(shiny)
# shinyUI(pageWithSidebar(
#   headerPanel("Example plot"),
#   sidebarPanel(
#     sliderInput('mu', 'Guess at the mean',value=70,min=62,max=74,step=0.05)
#   ),
#   mainPanel(
#     plotOutput('newHist')
#     
#   )
# )
# )
# 
# library(shiny)
# shinyUI(pageWithSidebar(
#   headerPanel("Diabetes prediction"),
#   sidebarPanel(
#     numericInput('glucose','Glucose mg/dl',90,min=50,max=200,step=5),
#     submitButton('Submit')
#   ),
#   mainPanel(
#     h3('Results of prediction'),
#     h4('You entered'),
#     verbatimTextOutput("inputValue"),
#     h4('Which resulted in a prediction of'),
#     verbatimTextOutput("prediction")
#     
#   )
# )
# )

