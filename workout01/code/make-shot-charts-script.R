######################################
## Title: Make Shot Charts
## Description: Create individual shot charts per player, and then one facetted one with them all.
## Inputs: Combined shot data from all 5 players
## Outputs: Individual pdfs of each players shot data, and then one pdf and png of the facetted plot of shot data
######################################

library(jpeg)
library(grid)
library(ggplot2)
library(dplyr)

#court image
court_file <- "../images/nba-court.jpeg"

#create raste object
court_image <- rasterGrob(
  readJPEG(court_file),
  width=unit(1,"npc"),
  height=unit(1, "npc")
)

data <- read.csv("../data/shots-data.csv")

#Shot charts of each player:
curry_shots <- data[data$name == "Stephen Curry",]

curry_plot <- ggplot(data = curry_shots) + annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) + 
  ggtitle("Short Chart: Stephen Curry (2016 Season)") + 
  theme_minimal()

ggsave("../images/stephen-curry-shot-chart.pdf", plot=curry_plot, width=6.5, height=5)

durant_shots <- data[data$name == "Kevin Durant",]

durant_plot <- ggplot(data = durant_shots) + annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) + 
  ggtitle("Short Chart: Kevin Durant (2016 Season)") + 
  theme_minimal()

ggsave("../images/kevin-durant-shot-chart.pdf", plot=durant_plot, width=6.5, height=5)

thompson_shots <- data[data$name == "Klay Thompson",]

thompson_plot <- ggplot(data = thompson_shots) + annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) + 
  ggtitle("Short Chart: Klay Thompson (2016 Season)") + 
  theme_minimal()

ggsave("../images/klay-thompson-shot-chart.pdf", plot=thompson_plot, width=6.5, height=5)

green_shots <- data[data$name == "Draymond Green",]

green_plot <- ggplot(data = green_shots) + annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) + 
  ggtitle("Short Chart: Draymond Green (2016 Season)") + 
  theme_minimal()

ggsave("../images/draymond-green-shot-chart.pdf", plot=green_plot, width=6.5, height=5)

iguodala_shots <- data[data$name == "Andre Iguodala",]

iguodala_plot <- ggplot(data = iguodala_shots) + annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag)) + 
  ylim(-50, 420) + 
  ggtitle("Short Chart: Andre Iguodala (2016 Season)") + 
  theme_minimal()

ggsave("../images/andre-iguodala-shot-chart.pdf", plot=iguodala_plot, width=6.5, height=5)

#Facetted Shot Chart:
facet_plot <- ggplot(data=data) + annotation_custom(court_image, -250, 250, -50, 420) +
  geom_point(aes(x = x, y = y, color = shot_made_flag), size=1) + 
  ylim(-50, 420) + 
  ggtitle("Short Charts: GSW (2016 Season)") + 
  theme_minimal() +
  facet_wrap(~name)

ggsave("../images/gsw-shot-charts.pdf", plot=facet_plot, width = 8, height = 7)
ggsave("../images/gsw-shot-charts.png", device=png(), plot=facet_plot, width = 8, height = 7)

