# =======================================================================
# Sample R script for thesis template
#
# Cleans temp_raw_wnba.csv dataset, which contains data pulled from
# https://www.espn.com/wnba/stats/player on 2024/06/19
#
# Last updated: 2024/06/19
# =======================================================================
library(tidyverse)

wnba <- read_csv("data/temp_raw_wnba.csv") |> 
  janitor::clean_names() |> 
  # Pull jersey numbers off of names and 
  # turn height text into msmt (6'4" = 6.3333)
  mutate(jersey = str_extract(name, "[0-9]+$"),
         name = str_remove(name, "[0-9]+$"),
         ht_ft = parse_number(str_extract(ht, "^[0-9]")),
         ht_in = parse_number(str_extract(ht, '[0-9]+\\"$')),
         height = ht_ft * 12 + ht_in,
         weight = parse_number(wt),
         position = factor(pos,
                           levels = c("G", "F", "C"),
                           labels = c("Guard", "Forward", "Center"))) |> 
  select(-c(ht, wt, ht_ft, ht_in, pos))
  
save(wnba, file = "data/temp_wnba.RData")


