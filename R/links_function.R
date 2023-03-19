qb_links <- function(link) {
  # Takes links from alphabetical player pages and extracts links for all QBs
  # on that letter page.
  #
  # Args:
  #   link:  url to alphabetical player page
  #
  # Returns:
  #   links to all QB player pages contained on that letter page.
  session <- bow(link)

  players <- scrape(session) %>%
    html_nodes("#div_players") %>%
    html_text()

  #Add comma to separate players
  play_comma <- gsub("([[:digit:]])([[:space:]])([[:alpha:]])", "\\1\\3",
                       players)
  play_comma <- gsub("([[:alpha:]])([[:punct:]])([[:alpha:]])", "\\1-\\3",
                     play_comma)
  play_comma <- gsub("([[:digit:]])(['])([[:alpha:]])", "\\1\\3",
                     play_comma)
  play_comma <- gsub("([[:digit:]])([[:alpha:]])", "\\1,\\2",
                       play_comma)

  #Split into individual player strings
  play_split <- unlist(strsplit(play_comma, ","))

  #Grab only QBs
  qbs <- str_subset(play_split, "QB")

  # Scrape bold players
  bold_players <- scrape(session) %>%
    html_elements("#div_players b") %>%
    html_text()

  qb_names <- str_extract_all(qbs,
            "^[[:alpha:]]+[[:space:]]{1}[[:alpha:]]+[[:space:]]{1}[()A-Z\\-]+")

  active_qbs <- match(qb_names, bold_players)
  active_qbs <- which(!is.na(active_qbs))

  if (length(active_qbs) == 0) {
    ret_qbs <- qbs
  } else {
    ret_qbs <- qbs[-active_qbs]
  }

  #All player links on page
  links <- scrape(session) %>%
    html_nodes("#div_players a") %>%
    html_attr("href")

  # find positions of Qbs on page
  matches <- match(ret_qbs, play_split)

  # Get those QB links
  qb_links <- links[matches]

  base_link <- "https://www.pro-football-reference.com"

  full_links <- sapply(base_link,
                         FUN = function(x) paste0(base_link, qb_links))
  return(full_links)

}
