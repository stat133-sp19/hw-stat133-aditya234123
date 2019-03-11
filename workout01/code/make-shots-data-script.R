######################################
## Title: Make Shots Data
## Description: Take the 5 csv files and make some changes to each, save their summaries, then combine them all and export the data.
## Inputs: The 5 csv files containing the data for the 5 players. 
## Outputs: Create summaries of each data frame. As well as export the combined data from all players.
######################################

#Inputs
curry <- read.csv("../data/stephen-curry.csv", stringsAsFactors = FALSE)
green <- read.csv("../data/draymond-green.csv", stringsAsFactors = FALSE)
durant <- read.csv("../data/kevin-durant.csv", stringsAsFactors = FALSE)
thompson <- read.csv("../data/klay-thompson.csv", stringsAsFactors = FALSE)
iguodala <- read.csv("../data/andre-iguodala.csv", stringsAsFactors = FALSE)

curry$name <- rep(c("Stephen Curry"), nrow(curry))
green$name <- rep(c("Draymond Green"), nrow(green))
durant$name <- rep(c("Kevin Durant"), nrow(durant))
thompson$name <- rep(c("Klay Thompson"), nrow(thompson))
iguodala$name <- rep(c("Andre Iguodala"), nrow(iguodala))

curry$shot_made_flag[curry$shot_made_flag=="y"] <- "shot_yes"
curry$shot_made_flag[curry$shot_made_flag=="n"] <- "shot_no"
green$shot_made_flag[green$shot_made_flag=="y"] <- "shot_yes"
green$shot_made_flag[green$shot_made_flag=="n"] <- "shot_no"
durant$shot_made_flag[durant$shot_made_flag=="y"] <- "shot_yes"
durant$shot_made_flag[durant$shot_made_flag=="n"] <- "shot_no"
thompson$shot_made_flag[thompson$shot_made_flag=="y"] <- "shot_yes"
thompson$shot_made_flag[thompson$shot_made_flag=="n"] <- "shot_no"
iguodala$shot_made_flag[iguodala$shot_made_flag=="y"] <- "shot_yes"
iguodala$shot_made_flag[iguodala$shot_made_flag=="n"] <- "shot_no"

curry$minute <- curry$period * 12 - curry$minutes_remaining
green$minute <- green$period * 12 - green$minutes_remaining
durant$minute <- durant$period * 12 - durant$minutes_remaining
thompson$minute <- thompson$period * 12 - thompson$minutes_remaining
iguodala$minute <- iguodala$period * 12 - iguodala$minutes_remaining

sink(file="../output/stephen-curry-summary.txt")
summary(curry)
sink()

sink(file="../output/draymond-green-summary.txt")
summary(green)
sink()

sink(file="../output/klay-thompson-summary.txt")
summary(thompson)
sink()

sink(file="../output/andre-iguodala-summary.txt")
summary(iguodala)
sink()

sink(file="../output/kevin-durant-summary.txt")
summary(durant)
sink()

combined_data <- rbind(curry, green, thompson, iguodala, durant)

write.csv(
  x=combined_data,
  file="../data/shots-data.csv"
)

sink(file="../output/shots-data-summary.txt")
summary(combined_data)
sink()



