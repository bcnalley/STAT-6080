# Visualizations 10 Seasons

library(readr)
library(tidyverse)

one_season <- read_csv("data-raw/one_season.csv")
ten_seasons <- read_csv("data-raw/ten_seasons.csv")




means <- numeric()
dataset0 <- ten_seasons %>%
  select(-c(QB, ...1))
for(i in 1:nrow(dataset0)) {
  means[i] <- mean(unlist(dataset0[i, ]))
}

ten_seasons <- ten_seasons %>%
  mutate(mean = means) %>%
  arrange(-mean)

total_sim_mean <- mean(ten_seasons$mean)


data <- ten_seasons %>%
  select(-c(QB, ...1, mean))
sim_means <- colMeans(data)
# Plot of the distribution
plot(sim_means, main = "Mean touchdown passes for each simulation \n (Ten seasons)",
     ylab = "simulated mean",
     xlab = "simulation number")
abline(h = total_sim_mean, lwd = 3)


hist(ten_seasons$mean, main = "Means touchdown passes of players \n (Ten seasons)",
     xlab = "Mean value",
     ylab = "Number of Players")

# Randomly select 3 players
set.seed(837)
players <- sample(1:685, 3)
players

three_players <- ten_seasons %>%
  filter(...1 %in% players)
three_players

# Brett Favre
brett <- three_players %>%
  filter(QB == "Brett Favre") %>%
  select(-c(...1, QB, mean)) %>%
  pivot_longer(X1:X1000, names_to = "sim_num", values_to = "td_passes")

cum_prop_brett <- cumsum(brett$td_passes) / 1:1000
cum_prop_brett
plot(
  x = 1:1000, y = cum_prop_brett, type = "l",
  main = "Cumulative mean for Brett Favre over 1000 simulations",
  ylab = "Touchdown passes",
  xlab = "Simulation"
)

# Roy Zimmerman
roy <- three_players %>%
  filter(QB == "Roy Zimmerman") %>%
  select(-c(...1, QB, mean)) %>%
  pivot_longer(X1:X1000, names_to = "sim_num", values_to = "td_passes")

cum_prop_roy <- cumsum(roy$td_passes) / 1:1000
cum_prop_roy
plot(
  x = 1:1000, y = cum_prop_roy, type = "l",
  main = "Cumulative mean for Roy Zimmerman over 1000 simulations",
  ylab = "Touchdown passes",
  xlab = "Simulation"
)


# Jake Fromm
jake <- three_players %>%
  filter(QB == "Jake Fromm") %>%
  select(-c(...1, QB, mean)) %>%
  pivot_longer(X1:X1000, names_to = "sim_num", values_to = "td_passes")

cum_prop_jake <- cumsum(jake$td_passes) / 1:1000
cum_prop_jake
plot(
  x = 1:1000, y = cum_prop_jake, type = "l",
  main = "Cumulative mean for Jake Fromm over 1000 simulations",
  ylab = "Touchdown passes",
  xlab = "Simulation"
)

# All together
plot(
  x = 1:1000, y = cum_prop_brett,
  ylim = c(1, 265),
  type = "l",
  main = "Cumulative means for three random players \n (Ten seasons)",
  ylab = "Touchdown passes",
  xlab = "Simulation",
)
lines(x = 1:1000, y = cum_prop_roy, col = "red")
lines(x = 1:1000, y = cum_prop_jake, col = "blue")
legend("right", legend = c("Brett Favre", "Roy Zimmerman",
                           "Jake Fromm"),
       col = c("black", "red", "blue"), lty = 1:1, cex = 0.7)


# Top Twelve
top_t <- ten_seasons[1:12,]
top_t
# Note that Jim Kelly, Andrew Luck, and Tony Romo are not of the top twelve pre-specified.
top_twelve <- top_t %>%
  pivot_longer(X1:X1000, values_to = "tdp")
top_means <- top_twelve %>%
  group_by(QB) %>%
  summarize(cum_prop = cumsum(tdp) / 1:1000)
top_means

one <- top_means %>%
  filter(QB == "Peyton Manning")
two <- top_means %>%
  filter(QB == "Andrew Luck")
three <- top_means %>%
  filter(QB == "Drew Brees")
four <- top_means %>%
  filter(QB == "Tom Brady")
five <- top_means %>%
  filter(QB == "Brett Favre")
six <- top_means %>%
  filter(QB == "Philip Rivers")
seven <- top_means %>%
  filter(QB == "Dan Marino")
eight <- top_means %>%
  filter(QB == "Ben Roethlisberger")
nine <- top_means %>%
  filter(QB == "Eli Manning")
ten <- top_means %>%
  filter(QB == "Jim Kelly")
eleven <- top_means %>%
  filter(QB == "Carson Palmer")
twelve <- top_means %>%
  filter(QB == "Tony Romo")

plot(
  x = 1:1000, y = one$cum_prop,
  type = "l",
  ylim = c(150, 320),
  main = "Cumulative mean for Top Twelve players \n (Ten seasons)",
  sub = "Other Players: Peyton Manning, Drew Brees,\n Brett Favre, Philip Rivers, Dan Marino, Ben Roethlisberger,\n Eli Manning, and Carson Palmer",
  ylab = "Touchdown passes",
  xlab = "",
)
legend("bottomright", legend = c("Tom Brady", "Andrew Luck, Jim Kelly, and Tony Romo", "All others"),
       col = c("blue", "red", "black"), lty = 1:1, cex = 0.6)
lines(x = 1:1000, y = two$cum_prop, col = "red")
lines(x = 1:1000, y = three$cum_prop)
lines(x = 1:1000, y = four$cum_prop, col = "blue")
lines(x = 1:1000, y = five$cum_prop)
lines(x = 1:1000, y = six$cum_prop)
lines(x = 1:1000, y = seven$cum_prop)
lines(x = 1:1000, y = eight$cum_prop)
lines(x = 1:1000, y = nine$cum_prop)
lines(x = 1:1000, y = ten$cum_prop, col = "red")
lines(x = 1:1000, y = eleven$cum_prop)
lines(x = 1:1000, y = twelve$cum_prop, col = "red")













