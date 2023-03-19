a_url <- "https://www.pro-football-reference.com/players/A/"

a_session <- bow(a_url)

#Grab all players on page
a_players <- scrape(a_session) %>% 
  html_nodes("#div_players") %>% 
  html_text()

#Add comma to separate players
a_play_comma <- gsub("([[:digit:]])([[:space:]])([[:alpha:]])", "\\1\\3",
                     a_players)
a_play_comma <- gsub("([[:digit:]])([[:alpha:]])", "\\1,\\2",
                     a_play_comma)

#Split into individual player strings
a_play_split <- unlist(strsplit(a_play_comma, ","))

#Grab only QBs
a_qbs <- str_subset(a_play_split, "QB")

# Scrape bold players
bold_players <- scrape(a_session) %>% 
  html_elements("#div_players b") %>% 
  html_text()

qb_names <- str_extract_all(a_qbs,
            "^[[:alpha:]]+[[:space:]]{1}[[:alpha:]]+[[:space:]]{1}[()A-Z\\-]+")

active_qbs <- match(qb_names, bold_players)
active_qbs <- which(!is.na(active_qbs))

ret_qbs <- a_qbs[-active_qbs]

#All player links on page
a_links <- scrape(a_session) %>% 
  html_nodes("#div_players a") %>% 
  html_attr("href")

# find positions of Qbs on page
matches <- match(ret_qbs, a_play_split)

# Get those QB links
qb_links <- a_links[matches]

base_link <- "https://www.pro-football-reference.com"

full_links <- sapply(base_link, FUN = function (x) paste0(base_link, qb_links))

