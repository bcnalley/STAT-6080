## exploring data
setwd("D:\\Stat6080\\Project")
load("all_qb_tds.RData")
all_qb_tds[[1]]
sum(!is.na(all_qb_tds[[1]]))
View(all_qb_tds[[973]])

## Adding a new element to a list
new_list <- list()
new_list <- c(new_list, all_qb_tds[973])
new_list
View(new_list[[1]])

## Creating new list that only has data with at least 1 non na value
## Dropping all 0 after, so this is now just no_na_list
no_na_list <- list()
for (i in seq_len(length(all_qb_tds))) {
  if (sum(!is.na(all_qb_tds[[i]])) != 0) {
    no_na_list <- c(no_na_list, all_qb_tds[i])
  }
}
length(no_na_list)

# Testing how to sample one season for 1 player 1000 times
sample(no_na_list[[1]][, 1], 1000, replace = TRUE)

## editing data in qb_list to make all observations in all data frames
## numeric

## example to show why

no_na_list[[128]][, 1]

for (i in seq_len(length(no_na_list))) {
  # Setting all data as numeric
  no_na_list[[i]][, 1] <- as.numeric(no_na_list[[i]][, 1])
  # converting NA to 0
  no_na_list[[i]][, 1] <-
    ifelse(is.na(no_na_list[[i]][, 1]), 0, no_na_list[[i]][, 1])
}
## Testing to see if it worked as intended with a known example
## that included NAs.

no_na_list[[128]][, 1]

## New list to exclude guys with only 0's
qb_list <- list()
for (i in seq_len(length(no_na_list))) {
  if (sum(no_na_list[[i]]) != 0) {
    qb_list <- c(qb_list, no_na_list[i])
  }
}
length(qb_list)

# creating new data frame to store observed samples
data_format <- function() {
  x <- data.frame(matrix(ncol = 1001, nrow = 0))
  x <- x[, c(1001, 1:1000)]
  colnames(x)[1] <- "QB"
  x
}
one_season <- data_format()
colnames(one_season)

# storing one season from career in data frame.
set.seed(123)
for (i in seq_len(length(qb_list))) {
  one_season[i, 1] <- colnames(qb_list[[i]])
  one_season[i, 2:1001] <- sample(qb_list[[i]][, 1], 1000, TRUE)
}


# Total TDs in 10 seasons
ten_seasons <- data_format()


for (i in seq_len(length(qb_list))) {
  ten_seasons[i, 1] <- colnames(qb_list[[i]])
  # Creating vector to store totals from 10 seasons
  vec <- c()
  for (j in 1:1000) {
    # Taking 1000 simulations of sum of 10 with replacement from career
    vec[j] <- sum(sample(qb_list[[i]][, 1], 10, replace = TRUE))
  }
  ten_seasons[i, 2:1001] <- vec
}



## retiring after best season
retire_best <- data_format()

for (i in seq_len(length(qb_list))) {
  retire_best[i, 1] <- colnames(qb_list[[i]])
  vec <- c()
  # taking all seasons up to and including last peak season
  x <- qb_list[[i]][, 1]
  y <- x[1:max(which(x == max(x)))]
  for (j in 1:1000) {
    # taking sample of career up to and including 1st peak season
    vec[j] <- sum(sample(y, length(y), TRUE))
  }
  retire_best[i, 2:1001] <- vec
}

## Dropping seasons of 0 TD
drop_zeros <- data_format()
for (i in seq_len(length(qb_list))){
  drop_zeros[i,1] <- colnames(qb_list[[i]])
  vec <- c()
  x <- qb_list[[i]][, 1]
  y <- x[x != 0]
  for (j in 1:1000) {
    # taking sample of 10 seasons without seasons of 0 TDs
    vec[j] <- sum(sample(y, 10, TRUE))
  }
  drop_zeros[i, 2:1001] <- vec
}


## 5 seasons QBs or more
five_seasons <- list()
for (i in seq_len(length(qb_list))) {
  if (length(qb_list[[i]][,1]) >= 5) {
    five_seasons <- c(five_seasons, qb_list[i])
  }
}
length(five_seasons)



## Dropping 2 best and 2 worst seasons. Only QBs with at least 5 seasons 
## are included
drop_high_low <- data_format()
for (i in seq_len(length(five_seasons))){
  drop_high_low[i,1] <- colnames(five_seasons[[i]])
  vec <- c()
  x <- five_seasons[[i]][, 1]
  y <- sort(x)[3:(length(x)-2)]
  for (j in 1:1000) {
    # taking sample of 10 seasons without top 2 and bottom 2 seasons
    vec[j] <- sum(sample(y, 10, TRUE))
  }
  drop_high_low[i, 2:1001] <- vec
}



write.csv(one_season, "D:/Stat6080/Project/one_season.csv")
write.csv(ten_seasons, "D:/Stat6080/Project/ten_seasons.csv")
write.csv(retire_best, "D:/Stat6080/Project/retire_best.csv")
write.csv(drop_zeros, "D:/Stat6080/Project/drop_zeros.csv")
write.csv(drop_high_low, "D:/Stat6080/Project/drop_high_low.csv")
