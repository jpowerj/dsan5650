library(tibble)
library(ggplot2)
library(ggExtra)
library(dplyr)
library(tidyr)
library(R6)
WalkData <- R6Class("WalkData", list(
  long_df = NULL,
  end_df = NULL,
  num_people = NA,
  num_steps = NA,
  initialize = function(
    long_df, end_df, num_people, num_steps
  ) {
    self$long_df <- long_df
    self$end_df <- end_df
    self$num_people <- num_people
    self$num_steps <- num_steps
  }
  # add = function(x = 1) {
  #   self$sum <- self$sum + x 
  #   invisible(self)
  # })
))
filter_oob <- function(walk_data) {
  outside_pids <- walk_data$long_df |>
    group_by(pid) |>
    summarize(
      min_pos = abs(min(pos)),
      max_pos = abs(max(pos)),
    ) |> rowwise() |>
    mutate(
      furthest = max(min_pos, max_pos)
    ) |>
    filter(furthest > 30) |>
    pull(pid)
  walk_data$long_df <- walk_data$long_df |>
    filter(!(pid %in% outside_pids))
  walk_data$end_df <- walk_data$end_df |>
    filter(!(pid %in% outside_pids))
  return(walk_data)
}
gen_walk_data <- function(num_people, num_steps) {
  support <- c(-1, 1)
  # Unique id for each person
  pid_df <- tibble(pid=seq(1, num_people))
  pos_df <- tibble()
  all_steps <- t(
    replicate(
      num_people,
      sample(
        support, num_steps, replace = TRUE, prob = c(0.5, 0.5)
      )
    )
  )
  csums <- t(apply(all_steps, 1, cumsum))
  csums <- cbind(0, csums)
  # Last col is the ending positions
  ending_pos <- csums[, dim(csums)[2]]
  end_df <- tibble(
    pid = seq(1, num_people),
    endpos = ending_pos,
    t = num_steps
  )
  # Now csums as tibble
  csum_df <- as_tibble(csums, name_repair = "none")
  merged_df <- bind_cols(pid_df, csum_df)
  long_df <- merged_df |> pivot_longer(!pid)
  # Convert name -> step_num
  long_df <- long_df |>
    mutate(t = strtoi(gsub("V", "", name)) - 1) |>
    # value -> pos
    rename(`pos`=`value`) |>
    # And now drop name
    select(-name)
  walk_data <- WalkData$new(
    long_df, end_df, num_people, num_steps
  )
  return(walk_data)
}
set.seed(5651)
walk_data <- gen_walk_data(10000, 64)
print(walk_data)
walk_data |> saveRDS("./w06/assets/walk_data.rds")
