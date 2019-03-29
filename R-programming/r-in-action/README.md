# R in Action Notes

## R Basics

- `ls()` - list the current environment objects
- `rm()` - remove the objects
- `rm(list=ls())` = remove all objects from the workspace
- `getwd()` - get working directory
- `setwd()` - set working directory (always use backslash / to specify directory, even on windows)
- `help(options)` - provides information on available options
- `savehistory("myfile")` - saves commands history to myfile(default=.Rhistory)
- `loadhistory("myfile")` - Reloads a command's history(default = .Rhistory)
- `save.image("myfile")` - Saves workspace to myfile (default=.RData)
- `save(objectlist, file="myfile")` - saves specific objects to a file
- `load("myfile")` - loads a workspace into the current session
- `q()` Quits R with prompt to save the workspace
- `options()` - shows available options we can set in workspace
- `source("myscript.R")` - submits a script to the current session. By convention, script names end with R extension, but not  mandatory.
- `sink("filename")` - redirects output to the file filename. Include option `append=TRUE` to append text to file. Option `split=TRUE` to send output to both screen and the output file. By default, it outputs only to screen.
- `bmp("filename.bmp")` - save file as bmp image
- `jpg`, `png,` `svg` - save image as following formats
  

```R
patientID <- c(1,2,3,4)
age <- c(25, 34, 28, 52)
diabetes <- c("Type1", "Type2", "Type1", "Type1")
status <- c("Poor", "Improved", "Excellent", "Poor")
patientdata <- data.frame(patientID, age, diabetes, status)
patientdata
patientdata[1:2]
patientdata[c("diabetes", "status")]
patientdata$age
table(patientdata$diabetes, patientdata$status)
``` 

- `attach()` - adds the data frame to R search path


```R
summary(mtcars$mpg)
plot(mtcars$mpg, mtcars$disp)
plot(mtcars$mpg, mtcars$wt)
```

The same can be written as:

```R
attach(mtcars)
# now mtcars is available variables are available direclty.
  summary(mpg)
  plot(mpg, disp)
  plot(mpg, wt)
detach(mtcars)
```

When we already have an object with the name and we try to attach a new data with same object, the earlier object takes precedence. So, it may not work as expected. The `attach` and `detach` are best used when you're analysing a single data frame and you're unlikely to have multiple objects with the same name. Alternatively, we can use `with()` function.

```R
with(mtcars, {
  print(summary(mpg))
  plot(mpg, disp)
  plot(mpg, wt)
})
```

If we want to create object that will exist outside of the `with()` construct, use `<<-` instead of single `<-`. This will save the object in the global environment.

```R
# 
with(mtcars, {
  nokeepstate <- summary
  keepstate <<- summary(mpg)
})
# nokeepstate is not available here
# keepstate can be accessed here
```

In R, case identifiers can be specified with a `rowname` option in data-frame function. These are like primary key for dataframes.

```R
patientdata <- data.frame(patientID, age, diabetes, status, rowname=patientID)
```

Nominal variables are categorical without an implied order. Ordinal varibles imply order on ordinal variables. Continuous variables acn take on any value within some range and both order and amount are implied. Categorical variables are called **factors** in R. The function `factor()` stores categorical values as a vector of integers. For vectors representing ordinal variables, you add the parameter `ordered=TRUE` to `factor()` function.

```R
status <- c("Poor", "Improved", "Excellent", "Poor")
status <- factor (status, ordered=TRUE) # this will apply ordering with 1=Excellent, 2=Improved, 3=Poor
# By default, factor levels are created in alphabetical order.
# We can specify orders using levels
status <- factor(status, order=TRUE, levels=c("Poor", "Improved", "Excellent"))
# In this case, 1=Poor, 2=Improved, 3=Excellent
```

If any of the values doesn't match the factor value, it will be set to *missing*.

```R
# This will convert varible to an unordered factor.
sex <- factor(sex, levels c(1,2), labels = c("Male", "Female"))
```

A **List** is an ordered collection of objects.

```R
g <- "My First List"
h <- c(25, 16, 18, 39)
j <- matrix(1:10, nrow=5)
k <- c("one", "two", "three")
mylist <- list(title=g, ages=h,j,k)
mylist
mylist[[2]]
mylist[["ages"]]
```

R has only single line comments that start with hash symbol. If you want to create multi line comment, you can wrap that part of the code in `if(FALSE){...}` and it will not execute.

Assigning a value to a nonexistent element of a vector, matrix, array or list expands that structre to accommodate the new value.

```R
x <- c(8,6,4)
x[7] <- 10
# now middle values from 4 to 6 are set to NA
```

R doesn't have scalar values, they are represented as single dimentional vectors. Indices start at 1 and not zero. Variables can't be declared. They become available on first assignment.

## Data Inputs

### Manual Data entry

The `edit()` function invokes a text editor in R that lets you enter data manually.

```R
mydata <- data.frame(age = numeric(0), gender=character(0),weight=numeric(0))
# create a variable of a specific mode but without actual data.
mydata <- edit(mydata)
# The last step opens a simple excel like GUI
```

The same functionality can be achieved through `fix(mydata)` function. We can also embed the data directly in program

```R
mydatatxt <- "
age gender weight
25 M 166
30 F 155
18 F 120
"
# read.table is used to process the data from string
mydata <- read.table(header=TRUE, text=mydatatxt)
```

### Import data from delimited text file

We can use `read.table()` function to read data from text file. We can also provide additional options

- `header` : logical value whether file contains variable names
- `sep` : the delimiter for data values. Defaults to white space
- `row.names` : to specify one or more variables to represent rows
- `col.names`: we can use col.names to specify column names
- `na.strings`: optional character vector indicating missing-values codes.
- `colClasses`: optional vector of classes to be assigned to the columns. The columns with "NULL" are skipped and if the number of columns is greater, it will be recycled.
- `quote`: Characters used to delimit strings that contain special characters. By default, it is double or single quotes.
- `skip`: The number of lines to skip in the data file before reading the data. (useful for skipping headers)
- `stringsAsFactors`: logical value indicating whether character variables should be converted to factors (default TRUE). When processing large text, setting this to FALSE can speed up processing.
- `text`: text string to process. If this option is specified, leave *file* as blank.

