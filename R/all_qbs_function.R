
all_qbs <- function(link) {
  
  session <- bow(link)
  
  qb_links(session = session)
  
  purrr::map(.x = full_links, .f = qb_tds(link = .x))
  
#  all_tds <- purrr::map(.x = full_links, .f = qb_tds(link = .x))
  
#  return(all_tds)
}