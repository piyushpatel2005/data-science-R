complete <- function(directory, id=1:332) {
  # Write a function that reads a directory full of files and 
  # reports the number of completely observed cases in each data file.
  # The function should return a data frame where the first column is
  # the name of the file and the second column is the number of
  # complete cases. A prototype of this function follows
  
  # 'directory' is a character vector of length 1 indicating
  # the location of the CSV files
  # There are files like 001.csv, 002,csv upto 332.csv
  # Each file has data as below with sulfate and nitrate in different locations of USA.
  # "Date","sulfate","nitrate","ID"
  # "2002-01-02",NA,NA,313
  
  # 'id' is an integer vector indicating the monitor ID numbers to be used.
  
  # Return a data frame of the form:
  # id nobs; where id is the monitor ID number and 'nobs' is the number of complete cases
  # 1 117
  # 2 1041
  
  filenames <- list.files(directory, pattern="*.csv", full.names=TRUE)
  data <- data.frame()
  
  for (i in id) {
    temp <- read.csv(filenames[i], header=TRUE)
    temp <- na.omit(temp)
    nobs <- nrow(temp)
    
    data <- rbind(data, data.frame(i, nobs)) # add current obs count to existing data frame
  }
  data # return data frame
}