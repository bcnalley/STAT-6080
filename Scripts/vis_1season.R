# Visualizations 1 Season

library(readr)
library(tidyverse)
library(ggplot2)
#
load("~/School/Data Technologies/Group Project/STAT-6080/data-raw/all_qb_tds.RData")
load("~/School/Data Technologies/Group Project/STAT-6080/data-raw/td_final_list.RData")
# load("~/School/Data Technologies/Group Project/STAT-6080/data-raw/letter_urls.RData")

# drop_high_low <- read_csv("data-raw/drop_high_low.csv")
one_season <- read_csv("data-raw/one_season.csv")
# drop_zeros <- read_csv("data-raw/drop_zeros.csv")
# retire_best <- read_csv("data-raw/retire_best.csv")
# ten_seasons <- read_csv("data-raw/ten_seasons.csv")

################### ONE SEASON ###################

# There are 1000 columns of data points
# What are each of the data points?
#   The number of touchdown passes for a certain player for 1 season (simulated 1000 times).
# What am I trying to visualize?
#   The distribution of touchdown passes



# test <- one_season %>%
#   filter(QB == "Tom Brady") %>%
#   group_by(QB) %>%
#   mutate(mean = mean(X1:X1000)) %>%
#   arrange(-mean)

means <- numeric()
dataset0 <- one_season %>%
  select(-c(QB, ...1))
for(i in 1:nrow(dataset0)) {
  means[i] <- mean(unlist(dataset0[i, ]))
}

one_season <- one_season %>%
  mutate(mean = means) %>%
  arrange(-mean)

total_sim_mean <- mean(one_season$mean)

# drew_one_seas <- one_season %>%
#   filter(QB == "Drew Brees")
# cumProp <- drew_one_seas %>%
#   select(-c(QB, mean, ...1)) %>%
#   print(.[1,])

data <- one_season %>%
  select(-c(QB, ...1, mean))
sim_means <- colMeans(data)
# Plot of the distribution
plot(sim_means, main = "Mean touchdown passes for each simulation \n (One season)",
     ylab = "simulated mean",
     xlab = "simulation number")
abline(h = total_sim_mean, lwd = 3)

# sim_means1 <- as.data.frame(sim_means)
# ggplot(sim_means1, aes(x = 1:1000, y = sim_means) +
#          geom_point(data = sim_means1$sim_means))

hist(one_season$mean, main = "Means touchdown passes of players \n (One season)",
     xlab = "Mean value",
     ylab = "Number of Players")

# Randomly select 3 players
set.seed(327)
players <- sample(1:685, 3)
players

three_players <- one_season %>%
  filter(...1 %in% players)
three_players

# Rodney Peete
rodney <- three_players %>%
  filter(QB == "Rodney Peete") %>%
  select(-c(...1, QB, mean)) %>%
  pivot_longer(X1:X1000, names_to = "sim_num", values_to = "td_passes")

cum_prop_rodney <- cumsum(rodney$td_passes) / 1:1000
cum_prop_rodney
plot(
  x = 1:1000, y = cum_prop_rodney, type = "l",
  main = "Cumulative mean for Rodney Peete over 1000 simulations",
  ylab = "Touchdown passes",
  xlab = "Simulation"
)

# Thaddeus Lewis
thadd <- three_players %>%
  filter(QB == "Thaddeus Lewis") %>%
  select(-c(...1, QB, mean)) %>%
  pivot_longer(X1:X1000, names_to = "sim_num", values_to = "td_passes")

cum_prop_thadd <- cumsum(thadd$td_passes) / 1:1000
cum_prop_thadd
plot(
  x = 1:1000, y = cum_prop_thadd, type = "l",
  main = "Cumulative mean for Thaddeus Lewis over 1000 simulations",
  ylab = "Touchdown passes",
  xlab = "Simulation"
)


# Willie Totten
willie <- three_players %>%
  filter(QB == "Willie Totten") %>%
  select(-c(...1, QB, mean)) %>%
  pivot_longer(X1:X1000, names_to = "sim_num", values_to = "td_passes")

cum_prop_willie <- cumsum(willie$td_passes) / 1:1000
cum_prop_willie
plot(
  x = 1:1000, y = cum_prop_willie, type = "l",
  main = "Cumulative mean for Willie Totten over 1000 simulations",
  ylab = "Touchdown passes",
  xlab = "Simulation"
)

# All together
plot(
  x = 1:1000, y = cum_prop_rodney,
  type = "l",
  main = "Cumulative means for three random players \n (One season)",
  ylab = "Touchdown passes",
  xlab = "Simulation",
)
lines(x = 1:1000, y = cum_prop_thadd, col = "red")
lines(x = 1:1000, y = cum_prop_willie, col = "blue")
legend("right", legend = c("Rodney Peete", "Thaddeus Lewis",
                                 "Willie Totten"),
       col = c("black", "red", "blue"), lty = 1:1, cex = 0.7)


# Top Twelve
top_t <- one_season[1:12,]
top_t
# Note that Jim Kelly and Andrew Luck are not of the top twelve pre-specified.
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
  filter(QB == "Fran Tarkenton")

plot(
  x = 1:1000, y = one$cum_prop,
  type = "l",
  ylim = c(10, 35),
  main = "Cumulative mean for Top Twelve players \n (One season)",
  sub = "Other Players: Peyton Manning, Tom Brady,\n Brett Favre, Philip Rivers, Dan Marino, Ben Roethlisberger,\n Eli Manning, Carson Palmer, Fran Tarkenton",
  ylab = "Touchdown passes",
  xlab = "",
)
legend("bottomright", legend = c("Drew Brees", "Andrew Luck and Jim Kelly", "All others"),
       col = c("blue", "red", "black"), lty = 1:1, cex = 0.8)
lines(x = 1:1000, y = two$cum_prop, col = "red")
lines(x = 1:1000, y = three$cum_prop, col = "blue")
lines(x = 1:1000, y = four$cum_prop)
lines(x = 1:1000, y = five$cum_prop)
lines(x = 1:1000, y = six$cum_prop)
lines(x = 1:1000, y = seven$cum_prop)
lines(x = 1:1000, y = eight$cum_prop)
lines(x = 1:1000, y = nine$cum_prop)
lines(x = 1:1000, y = ten$cum_prop, col = "red")
lines(x = 1:1000, y = eleven$cum_prop)
lines(x = 1:1000, y = twelve$cum_prop)









