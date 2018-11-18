corr <- function(directory, threshold=0) {
  # Write a function that takes a directory of data files and a threshold
  # for complete cases and calculates the correlation between sulfate and
  # nitrate for monitor locations where the number of completely observed
  # cases (on all variables) is greater than the threshold. 
  # The function should return a vector of correlations for the monitors
  # that meet the threshold requirement. If no monitors meet the
  # threshold requirement, then the function should return a numeric
  # vector of length 0.
  
  # 'directory' is a character vector of length 1 indicating
  # the location of the CSV files
  
  # 'threshold' is a numeric vector of length 1 indicating the
  # number of completely observed observations (on all variables)
  # required to compute the correlation between
  # nitrate and sulffte, the default is 0
  
  # There are files like 001.csv, 002,csv upto 332.csv
  # Each file has data as below with sulfate and nitrate in different locations of USA.
  # "Date","sulfate","nitrate","ID"
  # "2002-01-02",NA,NA,313
  
  # Return a numeric vector of correlations
  # Do not round the result!
  filenames <- list.files(directory, pattern="*.csv", full.names=TRUE)
  data <- vector(mode="numeric", length=0)
  
  for (i in 1:length(filenames)) {
    temp <- read.csv(filenames[i], header=TRUE)
    # find the complete cases
    temp <- temp[complete.cases(temp),]
    csum <- nrow(temp)
    # if csum > threshold
    if(csum > threshold) {
      # for this file find the correlation between nitrate and sulfate
      # combine each correlation for each file in vector format using concatenate function
      data <- c(data, cor(temp$nitrate, temp$sulfate))
    }
  }
  data
}