max_name <- character()
max_mean <- 0
for (i in seq_along(all_qb_tds_new)) {
  temp_mean <- mean(all_qb_tds_new[[i]][, 1])
  # browser()
  if (!is.na(temp_mean)) {
    if (temp_mean > max_mean) {
      max_mean <- temp_mean
      max_name <- colnames(all_qb_tds_new[[i]][1])
    }
  }
}
max_name
max_mean
