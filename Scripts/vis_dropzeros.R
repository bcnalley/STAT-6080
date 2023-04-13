# Visualizations Drop Zeros

library(readr)
library(tidyverse)
library(ggplot2)
#
load("~/School/Data Technologies/Group Project/STAT-6080/data-raw/all_qb_tds.RData")
load("~/School/Data Technologies/Group Project/STAT-6080/data-raw/td_final_list.RData")
# load("~/School/Data Technologies/Group Project/STAT-6080/data-raw/letter_urls.RData")

# drop_high_low <- read_csv("data-raw/drop_high_low.csv")
# one_season <- read_csv("data-raw/one_season.csv")
drop_zeros <- read_csv("data-raw/drop_zeros.csv")
# retire_best <- read_csv("data-raw/retire_best.csv")
# ten_seasons <- read_csv("data-raw/ten_seasons.csv")


means_dz <- numeric()
dataset_dz <- drop_zeros %>%
  select(-c(QB, ...1))
for(i in 1:nrow(dataset_dz)) {
  means_dz[i] <- mean(unlist(dataset_dz[i, ]))
}

simulations_dz <- drop_zeros %>%
  mutate(mean = means_dz) %>%
  arrange(-mean)

total_sim_mean_dz <- mean(simulations_dz$mean)


data_dz <- simulations_dz %>%
  select(-c(QB, ...1, mean))
sim_means_dz <- colMeans(data_dz)
# Plot of the distribution
plot(sim_means_dz, main = "Mean touchdown passes for each simulation \n (Removed Zeros)",
     ylab = "simulated mean",
     xlab = "simulation number")
abline(h = total_sim_mean_dz, lwd = 3)


hist(simulations_dz$mean, main = "Means touchdown passes of players \n (Removed Zeros)",
     xlab = "Mean value",
     ylab = "Number of Players")



# Top Twelve
top_t_dz <- simulations_dz[1:12,]
top_t_dz
# Note that Jim Kelly, Andrew Luck, and Tony Romo are not of the top twelve pre-specified.
top_twelve_dz <- top_t_dz %>%
  pivot_longer(X1:X1000, values_to = "tdp")
top_means_dz <- top_twelve_dz %>%
  group_by(QB) %>%
  summarize(cum_prop = cumsum(tdp) / 1:1000)
top_means_dz

one <- top_means_dz %>%
  filter(QB == "Peyton Manning")
two <- top_means_dz %>%
  filter(QB == "Tom Brady")
three <- top_means_dz %>%
  filter(QB == "Drew Brees")
four <- top_means_dz %>%
  filter(QB == "Andrew Luck")
five <- top_means_dz %>%
  filter(QB == "Brett Favre")
six <- top_means_dz %>%
  filter(QB == "Philip Rivers")
seven <- top_means_dz %>%
  filter(QB == "Dan Marino")
eight <- top_means_dz %>%
  filter(QB == "Ben Roethlisberger")
nine <- top_means_dz %>%
  filter(QB == "Eli Manning")
ten <- top_means_dz %>%
  filter(QB == "Tony Romo")
eleven <- top_means_dz %>%
  filter(QB == "Jim Kelly")
twelve <- top_means_dz %>%
  filter(QB == "Carson Palmer")

plot(
  x = 1:1000, y = one$cum_prop,
  type = "l",
  ylim = c(130, 320),
  main = "Cumulative mean for Top Twelve players \n (Removed Zeros)",
  sub = "Other Players: Peyton Manning, Drew Brees,\n Brett Favre, Philip Rivers, Dan Marino, Ben Roethlisberger,\n Eli Manning, and Carson Palmer",
  ylab = "Touchdown passes",
  xlab = "",
)
legend("bottomright", legend = c("Tom Brady", "Andrew Luck, Tony Romo, and Jim Kelly", "All others"),
       col = c("blue", "red", "black"), lty = 1:1, cex = 0.8)
lines(x = 1:1000, y = two$cum_prop, col = "blue")
lines(x = 1:1000, y = three$cum_prop)
lines(x = 1:1000, y = four$cum_prop, col = "red")
lines(x = 1:1000, y = five$cum_prop)
lines(x = 1:1000, y = six$cum_prop)
lines(x = 1:1000, y = seven$cum_prop)
lines(x = 1:1000, y = eight$cum_prop)
lines(x = 1:1000, y = nine$cum_prop)
lines(x = 1:1000, y = ten$cum_prop, col = "red")
lines(x = 1:1000, y = eleven$cum_prop, col = "red")
lines(x = 1:1000, y = twelve$cum_prop)


# Plot by group
plot(
  x = 1:1000, y = one$cum_prop,
  type = "l",
  ylim = c(130, 320),
  main = "Cumulative mean for Top Twelve players \n (Removed Zeros)",
  ylab = "Touchdown passes",
  xlab = "Simulation",
  col = "darkblue"
)
legend("bottomright", legend = c("Peyton Manning, Tom Brady, Drew Brees, and Andrew Luck", "All others"),
       col = c("darkblue", "darkred"), lty = 1:1, cex = 0.8, lwd = 2)
lines(x = 1:1000, y = two$cum_prop, col = "darkblue")
lines(x = 1:1000, y = three$cum_prop, col = "darkblue")
lines(x = 1:1000, y = four$cum_prop, col = "darkblue")
lines(x = 1:1000, y = five$cum_prop, col = "darkred")
lines(x = 1:1000, y = six$cum_prop, col = "darkred")
lines(x = 1:1000, y = seven$cum_prop, col = "darkred")
lines(x = 1:1000, y = eight$cum_prop, col = "darkred")
lines(x = 1:1000, y = nine$cum_prop, col = "darkred")
lines(x = 1:1000, y = ten$cum_prop, col = "darkred")
lines(x = 1:1000, y = eleven$cum_prop, col = "darkred")
lines(x = 1:1000, y = twelve$cum_prop, col = "darkred")










