# Some installation and settings

# library(devtools)
# install_github('jalapic/engsoccerdata', username = "jalapic")

# if(!"engsoccerdata" %in% installed.packages()) {
#   
#   install.packages("engsoccerdata")
# }
  
library(engsoccerdata)
library(ggplot2)

# data(package="engsoccerdata")    # lists datasets currently available


comparePerformance <- function(season) {

  barca_all_games <- spain[spain$home == "FC Barcelona" | spain$visitor == "FC Barcelona",]
 
  top_competitors <- c("Athletic Bilbao","Atletico Madrid","Real Madrid",
                       "Sevilla FC","Valencia CF")
  
  barca_top_contests <- barca_all_games[barca_all_games$home %in% top_competitors |
                                          barca_all_games$visitor %in% top_competitors,]
  
  barca_top_contests_season = barca_top_contests[barca_top_contests$Season == season,]
  
  return(barca_top_contests_season)
  
}

library(shiny)
shinyServer(
  function(input,output) {
    output$season <- renderPrint({input$season})

        output$newPlot <- renderPlot({top_contests <- comparePerformance(input$season)
    
              plot(top_contests$hgoal, col = "blue", pch=19)
              points(top_contests$vgoal, col = "blue", pch=19)
              points(top_contests$hgoal[top_contests$home=="FC Barcelona"],
                     col = "red", pch = 19)
              points(top_contests$vgoal[top_contests$visitor=="FC Barcelona"],
                     col = "red", pch = 19)
              
              barca_home_games <- top_contests[top_contests$home=="FC Barcelona",]
              barca_goal_difference_home <- barca_home_games$hgoal - barca_home_games$vgoal
              
              barca_away_games <- top_contests[top_contests$visitor == "FC Barcelona",]
              barca_goal_difference_away <- barca_away_games$vgoal - barca_away_games$hgoal
 
              top_competitors <- c("Athletic Bilbao","Atletico Madrid","Real Madrid",
                               "Sevilla FC","Valencia CF")
    
              score_sheet <- NULL
              score_sheet <- data.frame(top_competitors)
              score_sheet$top_competitors <- as.character(score_sheet$top_competitors)
              
              home_games <- top_contests[top_contests$visitor %in% top_competitors & top_contests$Season == input$season,]
              away_games <- top_contests[top_contests$home %in% top_competitors & top_contests$Season == input$season,]
              
              d2 <- merge(score_sheet,home_games, by.x = "top_competitors", by.y = "visitor")
              d3 <- merge(d2,away_games, by.x = "top_competitors", by.y = "home")
              
              gda <- as.integer(d3$vgoal.y - d3$hgoal.y)
              gdh <- as.integer(d3$hgoal.x - d3$vgoal.x)
              ylim1 <- min(gdh, gda)
              ylim2 <- max(gdh, gda)
              
              plot(d3$hgoal.x - d3$vgoal.x, xlab = "Competitors", ylab = "Goals difference of FC Barcelona", 
                   main = paste("FC Barcelona's goal differences with top competitors in La Liga in ",input$season),
                   xaxt = "n", type = "n", 
                   ylim = c(ylim1, ylim2))
    
              legend("topright", legend = c("Goals diffrence Home", "Goals difference Away"), col=c("magenta","blue"), pch = c('H','A'))
              axis(1, 1:5 , labels = d3$top_competitors, tick = FALSE )
              abline(h=0)
              points(gda, col = "blue", pch = "A", lwd = 2)
              points(gdh, col = "magenta", pch = 'H', lwd = 2)
    
          })

  }
)