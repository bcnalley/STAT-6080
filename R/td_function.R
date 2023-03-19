qb_tds <- function(link) {
  # Takes links from player pages and scrapes each season's TD totals
  #
  # Args:
  #   link:  direct link to player stats page
  #
  # Returns:
  #   A data frame consisting of the number of touchdowns the quarterback
  #   threw in each season they played.
  session <- bow(link)

  # Get Player Name
  name_node <- scrape(session) %>%
    html_node("#meta > div:nth-child(2) > h1:nth-child(1) > span:nth-child(1)")

  name <- name_node %>%
    html_text()

  if (is.na(name)) {
    name_node <- scrape(session) %>%
      html_node(".nothumb > h1:nth-child(1) > span:nth-child(1)")

    name <- name_node %>%
      html_text()
  }

  # Stats
  allstats_node <- scrape(session) %>%
    html_node("#passing > tbody:nth-child(4)")

  if (is.na(allstats_node)) {
    tds <- NA

  } else {

    df <- allstats_node %>%
      html_table()

    tds <- df$X13
  }

  # Create data frame of player name and TDs
  td_df <- magrittr::set_names(data.frame(tds), name)

  return(td_df)
}
