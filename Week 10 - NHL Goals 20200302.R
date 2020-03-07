#---Load packages
library(tidyverse)
library(readr)
library(lubridate)
library(ggrepel)
library(viridis)

#---Load data
game_goals <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-03/game_goals.csv')

top_250 <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-03/top_250.csv')

season_goals <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2020/2020-03-03/season_goals.csv')

#---Inspect data
glimpse(game_goals)

glimpse(top_250)

glimpse(season_goals)

#---Base plot
p <- ggplot(data = top_250, aes(x = raw_rank, y = total_goals))

#---Final plot
total_goals <- p + geom_point()+
  geom_label_repel(data = subset(top_250, active == "Active"), 
                    aes(x=raw_rank, y=total_goals, 
                    label = paste(player,total_goals,sep = ","),
                    col = yr_start),
                   size = 2)+
  theme_minimal()+
  scale_color_viridis(limits = c(min(subset(top_250$yr_start, top_250$active=="Active")),
                                  max(subset(top_250$yr_start, top_250$active=="Active"))),
                      breaks = c(min(subset(top_250$yr_start, top_250$active=="Active")),
                                 2001,2006,
                                 max(subset(top_250$yr_start, top_250$active=="Active"))),
                      name = "Year Started")+
  labs(
    title = "Top 250 NHL Goal Scorers of All Time",
    subtitle = "Highlighting currently active players",
    x = "Rank",
    y = "Total Goals"
  )

#---View plot
total_goals
