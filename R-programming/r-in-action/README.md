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

Suppose we have a file with header as sample below.

StudentID, First,Last,Math,Science,Social Studies
011,Bob,Smith,90,80,67
022,Jane,Weary,75,,80

```R
grades <- read.table("studentgrades.csv", header = TRUE, row.name="StudentID", sep=",")
str(grades)
```

The variable *Social Studies* will be renamed as *Social.Studies*. The missing values are converted to NA. We can also specify the schema of the table.

```R
grades <- read.table("studentgrades.csv", header=TRUE, row.name="StudentID", sep=",", colClasses=c("character", "character", "character", "numeric", "numeric", "numeric"))
str(grades)
```

R provides several mechanisms for accessing data via functions `file()`, `gzfile()`, `bzfile()`, `unz()` and `url()`.

### Importing data from Excel

Excel files can be imported using `xlsx` package. Download and install it before using. `read.xlsx(file, n)` function imports a worksheet into a data frame where n is the number of worksheet to be imported. This function also has ability to specify specific `rowIndex` and `colIndex` along with class of each column `colClasses`. 

```R
library(xlsx)
workbook <- "C:/myworkbook.xlsx"
mydataframe <- read.xlsx(workbook, 1)
```

For large worksheets, we can also use `read.xlsx2()` which performs more of processing in Java. There are other packages like `openxlsx` and `XLConnect` (depends on Java).

### Importing from XML

`XML` package can be used to read, write and manipulate XML files.

### Importing from the web

The text on the web page can be downloaded into an R vector using `readLines()` function and manipulated with `grep()` and `gsub()`. For complex web scrapping, `RCurl` and `XML` packages can be used to extract information. We can access different social media using `twitterR`, `Rfacebook`, `Rflickr`

### Importing data from SPSS

IBM SPSS datasets can be imported via `read.spss()` function in `foreign` package. `Hmisc` package also contains `spss.get()` function.

```R
install.packages("Hmisc")
library(Hmisc)
mydataframe <- spss.get("mydata.sav", use.value.labels=TRUE)
```

### Importing from SAS

In `foreign` package, there are `read.ssd()` function. In `Hmisc` package, `sas.get()` and `read.sas7bdat()` function from `sas7bdat` package.

```R
library(Hmisc)
datadir <- "C:/mydata"
sasexe <- "C:/Program Files/SASHome/SASFoundation/9.4/sas.exe"
mydata <- sas.get(libraryName=datadir, member="clients", sasprog=sasexe)
# OR
library(sas7bdat)
mydata <- read.sas7bdat("C:/mydata/clients.sas7bdat")
```

### Accessing DBMS

The most popular method of accessing a DBMS in R is through the RODBC package which allows R to connect to any DBMS that has ODBC driver. Once the drivers are installed and configured for the databses of your choice, install the `RODBC` package. Use `install.packages("RODBC")` to isntall it.

- `odbcConnect(dsn, uid="", pwd="")`: opens a connection to ODBC database
- `sqlFetch(channel, sqlTable)`: reads a table from ODBC database into a dataframe.
- `sqlQuery(channel, query)`: submits query to an ODBC database and returns the results
- `sqlSave(channel, mydf, tablename=sqltable, append=FALSE)`: writes or updates (append=TRUE) a dataframe to a table in the ODBC database.
- `sqlDrop(channel, sqltable)`: removes a table from the ODBC database
- `close(channel)`: close the connection

```R
library(RODBC)
myconn <- odbcConnect("mydsn", uid="rob", pwd="password")
crimedat <- sqlFetch(myconn, Crime)
pundat <- sqlQuery(myconn, "select * from Punishment")
close(myconn)
```

## Annotating datasets

Annotating includes adding descriptive labels to variable names and value labels to the codes used for categorical variables.

```R
names(patientdata)[2] <- "Age at hospitalization (in years)"
# Then refer to this variables as patientdata[2]. Not a convenient approach
```

The `factor()` function can be used to create value labels for categorical variables.

```R
patientdata$gender <- factor(patientdata$gender, levels = c(1,2), labels = c("male", "female"))
```

Here are some of the useful functions which can be used when working with objects.

- `length(object)`: give number of elements
- `dim(object)`: gives dimensions
- `str(Object)`: structure of the object
- `class(Object)`: gives class of the object
- `mode(Object)`: determines how object is stored
- `names(object)`: gives names of componets of an object
- `c(Object, object,...)`: combines objects into a vector
- `cbind(object, object,...)`: combines objects as columns
- `rbind(object, object, ...)`: combines objects as rows
- `object`: prints an object
- `head(Object)`: lists first part of object
- `tail(object)`: lists last part of object
- `ls()`: lists current objects
- `rm(Object, object,...)`: deletes one or more objects.
- `rm(list=ls())`: removes most objects from working environment
- `fix(Object)`: edits an object in place

[Creating Graphs](graphs.md)

[Basic Data Management](data-management.md)

[Advanced Data Management](advanced-data-management.md)