pollutantmean <- function(directory, pollutant, id=1:332) {
  # Write a function named 'pollutantmean' that calculates
  # the mean of a pollutant (sulfate or nitrate) across a
  # specified list of monitors. 
  # The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. 
  # Given a vector monitor ID numbers, 'pollutantmean'
  # reads that monitors' particulate matter data from the
  # directory specified in the 'directory' argument and
  # returns the mean of the pollutant across all of the
  # monitors, ignoring any missing values coded as NA.

  # 'directory' is a character vector of length 1 indicating
  # the location of the CSV files
  # There are files like 001.csv, 002,csv upto 332.csv
  # Each file has data as below with sulfate and nitrate in different locations of USA.
  # "Date","sulfate","nitrate","ID"
  # "2002-01-02",NA,NA,313
  
  # 'pollutant' is a character vector of length 1 indicating the name of the pollutant for which we will calculate the mean; either sulfate or nitrate.
  
  # 'id' is an integer vector indicating the monitor ID numbers to be used.
  
  # Return the mean of the pollutant across all monitors list
  # in the 'id' vector (ignoring NA values)
  
  # Create list of files first
  filenames <- list.files("specdata", pattern="*.csv", full.names=TRUE)
  data <- data.frame()
  # loop through files to create 
  for (i in id) {
    temp <- read.csv(filenames[i], header=TRUE)
    data <- rbind(data, temp)
  }
  # find the mean of the data
  mean(data[,pollutant], na.rm=TRUE)
  
}