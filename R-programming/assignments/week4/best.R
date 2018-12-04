# set the work directory to the location of source files

best <- function (state, outcome) {
  setwd("C:\\Users\\Admin\\Documents\\assignment3")
  data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
  col <- 0
  if(!state %in% data$State) {
    stop("invalid state")
  } else if (!outcome %in% valid_outcomes) {
    stop("invalid outcome")
  } else if (outcome == "heart attack") {
    col <- 11
  } else if (outcome == "heart failure") {
    col <- 17
  } else {
    col <- 23
  }
  state_data <- data[data["State"] == state,]
  outcome_array <- as.numeric(state_data[, col])
  min <- min(outcome_array, na.rm=TRUE)
  min_index <- which(outcome_array == min)
  hospital <- state_data[min_index, 2]
  return(state_data[min_index, 2])
}