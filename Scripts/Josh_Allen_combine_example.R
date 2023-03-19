# Web Page
ja_url <- "https://www.pro-football-reference.com/players/A/AlleJo02.htm"
ja_session <- bow(ja_url)
ja_session

# Get TDs
ja_allstats_node <- scrape(ja_session) %>% 
  html_node("#passing > tbody:nth-child(4)")

ja_df <- ja_allstats_node %>% 
  html_table()
#  .[[1]]

ja_td <- ja_df$X13

# Get Player Name
ja_name_node <- scrape(ja_session) %>% 
  html_node("#meta > div:nth-child(2) > h1:nth-child(1) > span:nth-child(1)")

ja_name <- ja_name_node %>% 
  html_text()

# Create data frame of player name and TDs
allen_df <- magrittr::set_names(data.frame(ja_td), ja_name)

#Combine TB & JA dfs
qb_df <- merge(test_df, allen_df, by = 0, all = TRUE)[-1]
