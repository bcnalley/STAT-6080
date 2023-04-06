# Visualizations Drop Highs and Lows

library(readr)
library(tidyverse)
library(ggplot2)
#
load("~/School/Data Technologies/Group Project/STAT-6080/data-raw/all_qb_tds.RData")
load("~/School/Data Technologies/Group Project/STAT-6080/data-raw/td_final_list.RData")
# load("~/School/Data Technologies/Group Project/STAT-6080/data-raw/letter_urls.RData")

drop_high_low <- read_csv("data-raw/drop_high_low.csv")
# one_season <- read_csv("data-raw/one_season.csv")
# drop_zeros <- read_csv("data-raw/drop_zeros.csv")
# retire_best <- read_csv("data-raw/retire_best.csv")
# ten_seasons <- read_csv("data-raw/ten_seasons.csv")
