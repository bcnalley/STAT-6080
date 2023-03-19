library(rvest)
library(polite)
library(dplyr)
library(tidyr)
library(purrr)
library(stringr)
library(glue)
library(rlang)
library(magrittr)

# Web Page
tb_url <- "https://www.pro-football-reference.com/players/B/BradTo00.htm"
tb_session <- bow(tb_url)
tb_session

#passing > tbody:nth-child(4)

# Get TDs
tb_allstats_node <- scrape(tb_session) %>% 
  html_node("#passing > tbody:nth-child(4)")

tb_df <- tb_allstats_node %>% 
  html_table() 
#  .[[1]]

tb_td <- tb_df$X13

# Get Player Name
tb_name_node <- scrape(tb_session) %>% 
  html_node("#meta > div:nth-child(2) > h1:nth-child(1) > span:nth-child(1)")

tb_name <- tb_name_node %>% 
  html_text()

# Create data frame of player name and TDs
test_df <- magrittr::set_names(data.frame(tb_td), tb_name)
