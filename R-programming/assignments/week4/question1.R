source('~/assignment3/question1.R')
outcome <- read.csv("outcome-of-care-measures.csv", colClasses="character")

# get first five rows
head(outcome)
# get number of columns 46
ncol(outcome)
# get number of rows
nrow(outcome)
# get names of columns
names(outcome)
# convert 11th column 30-day mortality rates to numeric
outcome[,11] <- as.numeric(outcome[,11])
# draw a histogram
hist(outcome[,11])