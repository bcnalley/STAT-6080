# Visualizations Retired after best

library(readr)
library(tidyverse)
#
load("~/School/Data Technologies/Group Project/STAT-6080/data-raw/all_qb_tds.RData")
load("~/School/Data Technologies/Group Project/STAT-6080/data-raw/td_final_list.RData")
# load("~/School/Data Technologies/Group Project/STAT-6080/data-raw/letter_urls.RData")

# drop_high_low <- read_csv("data-raw/drop_high_low.csv")
# one_season <- read_csv("data-raw/one_season.csv")
# drop_zeros <- read_csv("data-raw/drop_zeros.csv")
retire_best <- read_csv("data-raw/retire_best.csv")
# ten_seasons <- read_csv("data-raw/ten_seasons.csv")


means_ret <- numeric()
dataset_ret <- retire_best %>%
  select(-c(QB, ...1))
for(i in 1:nrow(dataset_ret)) {
  means_ret[i] <- mean(unlist(dataset_ret[i, ]))
}

sims_ret <- retire_best %>%
  mutate(mean = means_ret) %>%
  arrange(-mean)

total_sim_mean_ret <- mean(sims_ret$mean)


data_ret <- sims_ret %>%
  select(-c(QB, ...1, mean))
sim_means_ret <- colMeans(data_ret)
# Plot of the distribution
plot(sim_means_ret, main = "Mean touchdown passes for each simulation \n (Retired after best)",
     ylab = "simulated mean",
     xlab = "simulation number")
abline(h = total_sim_mean_ret, lwd = 3)


hist(sims_ret$mean, main = "Means touchdown passes of players \n (Retired after best)",
     xlab = "Mean value",
     ylab = "Number of Players")


# Top Twelve
top_t_ret <- sims_ret[1:12,]
top_t_ret
# Note that Jim Kelly, Andrew Luck, and Tony Romo are not of the top twelve pre-specified.
top_twelve_ret <- top_t_ret %>%
  pivot_longer(X1:X1000, values_to = "tdp")
top_means_ret <- top_twelve_ret %>%
  group_by(QB) %>%
  summarize(cum_prop = cumsum(tdp) / 1:1000)
top_means_ret

one <- top_means_ret %>%
  filter(QB == "Peyton Manning")
two <- top_means_ret %>%
  filter(QB == "Ben Roethlisberger")
three <- top_means_ret %>%
  filter(QB == "Eli Manning")
four <- top_means_ret %>%
  filter(QB == "Drew Brees")
five <- top_means_ret %>%
  filter(QB == "John Elway")
six <- top_means_ret %>%
  filter(QB == "Carson Palmer")
seven <- top_means_ret %>%
  filter(QB == "Warren Moon")
eight <- top_means_ret %>%
  filter(QB == "Y.A. Tittle")
nine <- top_means_ret %>%
  filter(QB == "Steve Young")
ten <- top_means_ret %>%
  filter(QB == "Tom Brady")
eleven <- top_means_ret %>%
  filter(QB == "Randall Cunningham")
twelve <- top_means_ret %>%
  filter(QB == "Craig Morton")

plot(
  x = 1:1000, y = one$cum_prop,
  type = "l",
  ylim = c(100, 500),
  main = "Cumulative mean for Top Twelve players \n (Retired after best)",
  sub = "Other Players: ",
  ylab = "Touchdown passes",
  xlab = "",
  col = "red"
)
legend("bottomright", legend = c("Drew Brees", "Peyton Manning", "Ben Roethlisberger", "All others"),
       col = c("blue", "red", "forestgreen", "black"), lty = 1:1, cex = 0.6, lwd = 2)
lines(x = 1:1000, y = two$cum_prop, col = "forestgreen")
lines(x = 1:1000, y = three$cum_prop)
lines(x = 1:1000, y = four$cum_prop, col = "blue")
lines(x = 1:1000, y = five$cum_prop)
lines(x = 1:1000, y = six$cum_prop)
lines(x = 1:1000, y = seven$cum_prop)
lines(x = 1:1000, y = eight$cum_prop)
lines(x = 1:1000, y = nine$cum_prop)
lines(x = 1:1000, y = ten$cum_prop)
lines(x = 1:1000, y = eleven$cum_prop)
lines(x = 1:1000, y = twelve$cum_prop)









