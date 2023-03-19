library(rvest)
library(polite)
library(dplyr)
library(tidyr)
library(purrr)
library(stringr)
library(glue)
library(rlang)
library(magrittr)
library(tibble)


source("R/td_function.R")
load("data-raw/all_qb_links")

qb_links_separate <- unlist(all_qb_links_new)

safe_all_qbs <- safely(qb_tds)

all_qb_tds <- purrr::map(.x = qb_links_separate, ~ safe_all_qbs(link = .x),
                         .ptype = double())

all_qb_tds %>%
  map("error") %>%
  purrr::discard(~is.null(.))

all_qb_tds_new <- all_qb_tds %>%
  map("result") %>%
  list_flatten()

save(all_qb_tds_new, file = "data-raw/td_final_list.RData")
