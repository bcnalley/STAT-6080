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

tb_12 <- qb_tds("https://www.pro-football-reference.com/players/B/BradTo00.htm")

load("data-raw/td_final_list.RData")

tb_12_list <- list(tb_12)

all_qb_tds <- append(all_qb_tds_new, tb_12_list)

save(all_qb_tds, file = "data-raw/all_qb_tds.RData")
