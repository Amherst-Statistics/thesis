## -----------------------------------------------------------------------------
#| label: setup
#| include: false

# Load packages
library(tidyverse)
library(gt)

# Set default ggplot theme for document
theme_set(theme_classic())
# If using kableExtra tables, print blank cells instead of `NA`
options(knitr.kable.NA = "")

# Load data
load("data/temp_wnba.RData")


## -----------------------------------------------------------------------------
#| label: fig-wnba-ht
#| fig-cap: "Distribution of heights of WNBA players in the 2024 season."

# Use Freedman-Diaconus rule to set binwidth
ht_bw <- 2 * IQR(wnba$height) / nrow(wnba)^(1/3)

# Create histogram of height faceted by player position
ggplot(wnba, aes(height)) +
  geom_histogram(binwidth = ht_bw) +
  labs(x = "Height (in)",
       y = "Count",
       caption = "Source: https://www.espn.com/wnba/stats/player") +
  theme_bw()


## -----------------------------------------------------------------------------
#| label: tbl-ht-by-pos
#| tbl-cap: "Average WNBA player height by position."

wnba |> 
  group_by(position) |> 
  summarize(mean_ht = mean(height)) |> 
  gt() |> 
  cols_label(
    position = "Position",
    mean_ht = "Average height (in)"
  ) |> 
  fmt_number(decimals = 1)

