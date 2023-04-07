# Visualizations Drop Highs and Lows

library(readr)
library(tidyverse)
library(ggplot2)
#
# load("~/School/Data Technologies/Group Project/STAT-6080/data-raw/all_qb_tds.RData")
# load("~/School/Data Technologies/Group Project/STAT-6080/data-raw/td_final_list.RData")
# load("~/School/Data Technologies/Group Project/STAT-6080/data-raw/letter_urls.RData")

drop_high_low <- read_csv("data-raw/drop_high_low.csv")
# one_season <- read_csv("data-raw/one_season.csv")
# drop_zeros <- read_csv("data-raw/drop_zeros.csv")
# retire_best <- read_csv("data-raw/retire_best.csv")
# ten_seasons <- read_csv("data-raw/ten_seasons.csv")

# Calculate Mean
means_hl <- numeric()
dataset1 <- drop_high_low %>%
  select(-c(QB, ...1))
for(i in 1:nrow(dataset1)) {
  means_hl[i] <- mean(unlist(dataset1[i, ]))
}

ten_seasons_hl <- drop_high_low %>%
  mutate(mean = means_hl) %>%
  arrange(-mean)

total_sim_mean_hl <- mean(ten_seasons_hl$mean)


data_hl <- ten_seasons_hl %>%
  select(-c(QB, ...1, mean))
sim_means_hl <- colMeans(data_hl)
# Plot of the distribution
plot(sim_means_hl, main = "Mean touchdown passes for each simulation \n (Removed Highs and Lows)",
     ylab = "simulated mean",
     xlab = "simulation number")
abline(h = total_sim_mean_hl, lwd = 3)


hist(ten_seasons_hl$mean, main = "Means touchdown passes of players \n (Removed Highs and Lows)",
     xlab = "Mean value",
     ylab = "Number of Players")



# Top Twelve
top_t_hl <- ten_seasons_hl[1:12,]
top_t_hl
# Note that Jim Kelly, Andrew Luck, and Jay Cutler are not of the top twelve pre-specified.
top_twelve_hl <- top_t_hl %>%
  pivot_longer(X1:X1000, values_to = "tdp")
top_means_hl <- top_twelve_hl %>%
  group_by(QB) %>%
  summarize(cum_prop = cumsum(tdp) / 1:1000)
top_means_hl

one <- top_means_hl %>%
  filter(QB == "Peyton Manning")
two <- top_means_hl %>%
  filter(QB == "Drew Brees")
three <- top_means_hl %>%
  filter(QB == "Tom Brady")
four <- top_means_hl %>%
  filter(QB == "Philip Rivers")
five <- top_means_hl %>%
  filter(QB == "Andrew Luck")
six <- top_means_hl %>%
  filter(QB == "Brett Favre")
seven <- top_means_hl %>%
  filter(QB == "Eli Manning")
eight <- top_means_hl %>%
  filter(QB == "Ben Roethlisberger")
nine <- top_means_hl %>%
  filter(QB == "Dan Marino")
ten <- top_means_hl %>%
  filter(QB == "Carson Palmer")
eleven <- top_means_hl %>%
  filter(QB == "Jim Kelly")
twelve <- top_means_hl %>%
  filter(QB == "Jay Cutler")

plot(
  x = 1:1000, y = one$cum_prop,
  type = "l",
  ylim = c(150, 320),
  main = "Cumulative mean for Top Twelve players \n (Removed Highs and Lows)",
  sub = "Other Players: Peyton Manning, Drew Brees, Tom Brady,\n Brett Favre, Philip Rivers, Dan Marino, Ben Roethlisberger,\n Eli Manning, and Carson Palmer",
  ylab = "Touchdown passes",
  xlab = "",
)
legend("bottomright", legend = c("Drew Brees", "Andrew Luck, Jim Kelly, and Jay Cutler", "All others"),
       col = c("blue", "red", "black"), lty = 1:1, cex = 0.8)
lines(x = 1:1000, y = two$cum_prop)
lines(x = 1:1000, y = three$cum_prop, col = "blue")
lines(x = 1:1000, y = four$cum_prop)
lines(x = 1:1000, y = five$cum_prop, col = "red")
lines(x = 1:1000, y = six$cum_prop)
lines(x = 1:1000, y = seven$cum_prop)
lines(x = 1:1000, y = eight$cum_prop)
lines(x = 1:1000, y = nine$cum_prop)
lines(x = 1:1000, y = ten$cum_prop)
lines(x = 1:1000, y = eleven$cum_prop, col = "red")
lines(x = 1:1000, y = twelve$cum_prop, col = "red")


# Plot by group
plot(
  x = 1:1000, y = one$cum_prop,
  type = "l",
  ylim = c(135, 320),
  main = "Cumulative mean for Top Twelve players \n (Removed Highs and Lows)",
  ylab = "Touchdown passes",
  xlab = "Simulation",
  col = "darkblue"
)
legend("bottomright", legend = c("Peyton Manning, Andrew Luck, and Drew Brees",
                                 "Tom Brady, Brett Favre, and Philip Rivers",
                                 "Dan Marino, Ben Roethlisberger, Eli Manning",
                                 "Jim Kelly, Carson Palmer, Jay Cutler"),
       col = c("darkblue", "darkred", "black", "darkgreen"), lty = 1:1, cex = 0.8, lwd = 2)
lines(x = 1:1000, y = two$cum_prop, col = "darkblue")
lines(x = 1:1000, y = three$cum_prop, col = "darkblue")
lines(x = 1:1000, y = four$cum_prop, col = "darkred")
lines(x = 1:1000, y = five$cum_prop, col = "darkred")
lines(x = 1:1000, y = six$cum_prop, col = "darkred")
lines(x = 1:1000, y = seven$cum_prop, col = "black")
lines(x = 1:1000, y = eight$cum_prop, col = "black")
lines(x = 1:1000, y = nine$cum_prop, col = "black")
lines(x = 1:1000, y = ten$cum_prop, col = "darkgreen")
lines(x = 1:1000, y = eleven$cum_prop, col = "darkgreen")
lines(x = 1:1000, y = twelve$cum_prop, col = "darkgreen")



