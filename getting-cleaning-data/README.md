# Getting and Cleaning Data in R

This page contains information about how we can get and clean data for data exploration.

The raw data is often hard to use for data analysis and need to be processed once.
When going through processing step, you should have:
- the raw data
- a tidy data set
- a code book describing each variable and its values in the tidy data set
- an explicit and exact recipe you used to go from raw to processed data

The tidy data set should have each variable in one column, each different observation of that variable should be in a different row. There should be one table for each kind of variable. If there are multiple tables, you should include a column in the table that allows them to be linked.
- Include a row at the top in each file with variable names.
- Name the variables clearly
- Data should be saved in one file per table.

The **code book** contains:
- Information about the variables (including units) in the data set not contained in the tidy data.
- Information about the summary choices you made
- Information about the experimental study design yoiu used.
- A common format is Word/Text file
- There should be a sectipon called "Study Design" that has a thorough description of how you collected the data.
- There must be section called "Code book" that describes each variable and its units.

## Getting Data

### Downloading files

First you need to set the working directory where your data will be downloaded.
- `getwd()`: get current working directory
- `setwd("directory-path")`: set the working directory. `setwd("/Users/username/data/")` or `setwd("C:\\Users\\Admin\\Downloads")`
- `file.exists("directoryName")`: check to see if directory exists
- `dir.create("directoryName")`: create directory if not exists

```R
if(!file.exists("data")) {
  dir.create("data")
}
```

- `download.file(url="", destfile="", method="")`: download file from source

```R
# If url is http, you can use download.file
# If url is https, on windows it is fine
# If url is https, on Mac, you need to set method="curl"
# Be sure to record when you downloaded the file
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.csv?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/cameras.csv", method="curl")
list.files("./data")
dateDownloaded <- date()
```

### Reading local flat files

`read.table()` is flexible and robust but requires more parameters. It reads the data into RAM so big data can cause problems. It has parameters like file, header, sep, row.names, nrows
- `quote`: tell R whether there are any quotes values. `quote=""` means no quotes
- `na.strings`: set the character used to represent missing values
- `nrows`: how many rows to read of the file
- `skip`: how many rows to skip before starting to read (headers)

```R
cameraData <- read.table("./data/cameras.csv") # by default separator is tab
head(cameraData)
cameraData <- read.table("./data/cameras.csv", sep=",", header=TRUE) # specify separator and whether the file contains header
head(cameraData)
# we can directly read this using read.csv
cameraData <- read.csv("./data/cameras.csv")
head(cameraData)
```

### Reading  Excel files

```R
if(!file.exists("data")) {
  dir.create("data")
}
fileUrl <- "https://data.baltimorecity.gov/api/views/dz54-2aru/rows.xlsx?accessType=DOWNLOAD"
download.file(fileUrl, destfile="./data/cameras.xlsx", method="curl")
dateDownloaded <- date()
# use xlsx library to read data
library(xlsx)
cameraData <- read.xlsx("./data/cameras.xlsx", sheetIndex=1, header=TRUE)
head(cameraData)
# Read specific rows and columns
colIndex <- 2:3
rowIndex <- 1:4
cameraDataSubset <- read.xlsx("./data/cameras.xlsx", sheetIndex=1, colIndex=colIndex, rowIndex=rowIndex)
cameraDataSubset
```

The `write.xlsx` will write out an Excel file. Usually `read.xlsx2` is much faster than `read.xlsx`. The **XLConnect** package has more options for writing and manipulating Excel files.

### Reading XML files

XML is made up of tags, elements and attributes.

```R
library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal=TRUE) # use internal elements as well?
rootNode <- xmlRoot(doc)
xmlName(rootNode)
names(rootNode)
# access first root node
rootNode[[1]]
# access first node of first root node
rootNode[[1]][[1]]
# extract parts of the file
xmlSApply(rootNode, xmlValue)
```

**XPath** provides easier way to parse XML files
- /node - Top level node
- //node - Node at any level
- node[@attr-name] - Node with an attribute name
- node[@attr-name='bob'] - Node with specific attribute and value
  
```R
xpathSApply(rootNode, "//name", xmlValue)
xpathSApply(rootNode, "//price", xmlValue)
# Extract content by attributes
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal/baltimore-ravens"
doc <- htmlTreeParse(fileUrl, useInternal=TRUE)
scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)
scores
teams
```

### Reading from JSON files

```R
# Use jsonlite library
library(jsonlite)

jsonData <- fromJson("https://api.github.com/users/piyushpatel2005/repos")
names(jsonData)
names(jsonData$owner)
jsonData$owner$login
# convert dataset into JSON
myjson <- toJSON(iris, pretty=TRUE)
cat(myjson)
iris2 <- fromJSON(myjson)
head(iris2)
```

`data.table` inherits from `data.frame`. All functions that accept dataframe work on datatable.  Data table is written in C and is much faster at subsetting, group and updating.

```R
library(data.table)
DF = data.frame(x=rnorm(9), y=rep(c("a", "b", "c"), each=3), z=rnorm(9))
head(DF, 3)
DT = data.table(x=rnorm(9), y=rep(c("a", "b", "c"), each=3), z=rnorm(9))
head(DT,3)
tables() # see all tables in memory
# subsetting rows
DT[2,] # 
DT[DT$y == "a",] # filter rows where y == a
DT[c(2,3)] # 2 rows and 3 columns
DT[,w:=z^2] # add new column
DT[,m:= {tmp <- (x+z); log2(tmp+5)}] # add new column with complex operation
DT[,a:=x>0] # new row a with logical type
DT[, b:=mean(x+2), by=a]
DT <- data.table(x=rep(c("a", "b", "c"), each=100), y=rnorm(300))
setkey(DT, x)
DT['a']
DT1 <- data.table(x=c('a','a','b','dt1'), y=1:4)
DT2 <- data.table(x=c('a','b','dt2'), z=5:7)
setkey(DT1, x);setkey(DT2, x)
merge(DT1, DT2)
```