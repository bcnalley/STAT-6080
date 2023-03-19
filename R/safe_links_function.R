library(rvest)
library(polite)
library(dplyr)
library(tidyr)
library(purrr)
library(stringr)
library(glue)
library(rlang)
library(magrittr)

load("data-raw/letter_urls.RData")
source("R/links_function.R")

safe_all_links <- safely(qb_links)

all_qb_links <- purrr::map(.x = all_letter_urls, ~ safe_all_links(link = .x))

all_qb_links %>%
  map("error") %>%
  purrr::discard(~is.null(.))

all_qb_links_new <- all_qb_links %>%
  map("result") %>%
  list_flatten()

save(all_qb_links_new, file = "data-raw/all_qb_links")
