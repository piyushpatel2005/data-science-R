# The same function declared in best.R file with additional
# parameter to handle 'best' and 'worst' input
best <- function (state, outcome, num) {
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
  len <- dim(state_data[!is.na(outcome_array), ])[1]
  
  if(num == "best") {
    value <- min(outcome_array, na.rm=TRUE)
  } else if (num == "worst") {
    value <- max(outcome_array, na.rm=TRUE)
  } else {
    # this should return a vector of names at specific rank
    if(num > len) {
      return (NA)
    }
    result <- state_data[,2][order(outcome_array, state_data[,2])[num]]
    return (result)
  }
  index <- which(outcome_array == value)
  hospital <- state_data[index, 2]
  return(hospital)
}

rankhospital <- function (state, outcome, num) {
  setwd("C:\\Users\\Admin\\Documents\\assignment3")
  data <- read.csv("outcome-of-care-measures.csv", colClasses="character")
  valid_outcomes <- c("heart attack", "heart failure", "pneumonia")
  if(!state %in% data$State) {
    stop("invalid state")
  } else if (!outcome %in% valid_outcomes) {
    stop("invalid outcome")
  }
  
  hospital_names <- best(state, outcome, num)
  return (hospital_names)
}