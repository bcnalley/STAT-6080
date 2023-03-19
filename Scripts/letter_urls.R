player_url <- "https://www.pro-football-reference.com/players/"

url_text <- as.character(player_url)

all_letter_urls <- sapply(url_text, FUN = function(x) paste0(url_text, LETTERS))

save(all_letter_urls, file = "data-raw/letter_urls.RData")
