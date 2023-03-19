b_url <- "https://www.pro-football-reference.com/players/B/"

b_session <- bow(b_url)

#Grab all players on page
b_players <- scrape(b_session) %>% 
  html_nodes("#div_players") %>% 
  html_text()

#Add comma to separate players
b_play_comma <- gsub("([[:digit:]])([[:space:]])([[:alpha:]])", "\\1\\3",
                     b_players)
b_play_comma <- gsub("([[:digit:]])([[:alpha:]])", "\\1,\\2",
                     b_play_comma)

#Split into individual player strings
b_play_split <- unlist(strsplit(b_play_comma, ","))

#Grab only QBs
b_qbs <- str_subset(b_play_split, "QB")

# Scrape bold players
bold_players <- scrape(b_session) %>% 
  html_elements("#div_players b") %>% 
  html_text()

qb_names <- str_extract_all(b_qbs,
            "^[[:alpha:]]+[[:space:]]{1}[[:alpha:]]+[[:space:]]{1}[()A-Z\\-]+")

active_qbs <- match(qb_names, bold_players)
active_qbs <- which(!is.na(active_qbs))

ret_qbs <- b_qbs[-active_qbs]

#All player links on page
b_links <- scrape(b_session) %>% 
  html_nodes("#div_players a") %>% 
  html_attr("href")

# find positions of Qbs on page
matches <- match(ret_qbs, b_play_split)

# Get those QB links
qb_links <- b_links[matches]
