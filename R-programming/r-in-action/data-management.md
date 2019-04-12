# Basic Data Management

```R
manager <- c(1,2,3,4,5)
date <- c("10/24/08", "10/28/08", "10/1/08", "10/12/08", "5/1/09")
country <- c("US", "US", "UK", "UK", "UK")
gender <- c("M", "F", "F", "M", "F")
age <- c(32, 45, 25, 39, 99)
# here are five survey results for five managers
q1 <- c(5, 3,3,3,2)
q2 <- c(4, 5, 5, 3, 2)
q3 <- c(5, 2, 5, 4, 1)
q4 <- c(5, 5, 5, NA, 2)
q5 <- c(5, 5, 2, NA, 1)
leadership <- data.frame(manager, date, country, gender, age, q1, q2, q3, q4, q5, stringsAsFactors=FALSE)
```

We can do different arithmatic opeartions on variables in a dataframe. 

```R
mydata <- data.frame(x1 = c(2,2,6,4),
                    x2 = c(3,4,2,8))
mydata$sumx <- mydata$x1 + mydata$x2
mydata$meanx <- (mydata$x1 + mydata$x2) / 2
# another method
attach(mydata)
mydata$sumx <- x1 + x2
mydata$meanx <- (x1 + x2)/2
detach(mydata)
mydata <- transform(mydata, sumx = x1 + x2,
                  meanx = (x1 + x2)/2)
```

Let's categorize managers based on their age. There can't be a manager with age of 99. So, we want to code it somehow.

```R
leadership$age[leadership$age == 99] <- NA
leadership$agecat[leadership$age > 75] <- "Elder"
leadership$agecat[leadership$age >= 55 & leadership$age <= 75] <- "Middle Aged"
leadership$agecat[leadership$age < 55] <- "Young"
# this adds new agecat column
# The same can be achieved concisely as:
# first the value is set to NA and then modified according to age variable
leadership <- within(leadership, {
  agecat <- NA
  agecat[age > 75] <- "Elder",
  agecat[age >= 55 & age <= 75] <- "Middle Aged",
  agecat[age < 55] <- "Young"
})
```

The `within()` function allows us to modify the data. Several R packages offer useful recording functions (functions that modify the values or add to a data frame), especially `car` package's `recode()` function recodes numeric and character vectors and factory simply.

To change the variable name you can use `fix(leadership)` and fix manager to managerID. Programmatically, we can rename like:

```R
names(leadership)[2] <- "testDate"
names(leadership)
namese(leadership)[6:10] <- c("item1", "item2", "item3", "item4", "item5")
```

Similarly `plyr` package has a `rename()` function that's useful for altering names.

```R
install.packages("plyr")
library(plyr)
leadership <- rename(leadership, c(manager="managerID", date="testDate"))
```

Missing values are represented as NA in R. The function `is.na()` allows to test for the presence of missing values. `NA` values cannot be compared with themselves using equality comparison.

```R
y <- c(1, 2, 3, NA)
is.na(y) # return c(FALSE, FALSE, FALSE, TRUE)
is.na(leadership[,6:10])
```

R doesn't represent infinite or impossible values as missing values. Positive and negative infinite is represented as `Inf` and `-Inf`. Some values are represented as `NaN`. To identify these values, we use `is.inifinite()` or `is.nan()` functions.

```R
x <- c(1, 2, NA, 3)
y <- sum(x)
y <- sum(x, na.rm=TRUE) # 6
```

The function `na.omit()` removes any observations with missing data. It deletes any rows with missing values.

```R
leardership
newdata <- na.omit(leadership) # removes two rows
newdata
```

Dates are entered into R as character strings and then translated into date variables which are stored numerically. The function `as.Date()` is used for this.

`as.Date(x, "input_format")`

| Symbol | Meaning | Exaample |
|:-------:|:--------|:--------|
|%d | Day as a number (0-31) | 01-31 |
|%a | Abbreviated weekday | Mon |
|%A | Unabbreviated weekday | Monday |
| %m | Month (00-12) | 00-12 |
| %b | Abbreviated month | Jan |
| %B | Unabbreviated month | January |
| %y | Two-digit year | 07 |
| %Y | Four-digit year | 2007 |

```R
# The default format is yyyy-mm-dd
mydates <- as.Date(c("2007-06-22", "2004-02-13")) 
# convert to specific format
strDates <- c("01/05/1965", "08/16/1975")
dates <- as.Date(strDates, "%m/%d/%Y") # convert specific coded date into Date objects
# with leardership object
myformat <- "%m/%d/%y"
leadership$date <- as.Date(leadership$date, myformat)
Sys.Date() # returns today's date
date() # returns current date and time
```

Use `format(x, format="output_format")` functin to output dates in a specific format.

```R
today <- Sys.Date()
format(today, format="%B %d %Y")
format(today, format="%A")
```

When R stores dates internally, they're represented as the number of days since January 1, 1970, with negative values for earlier dates. You can use `difftime()` to calculate a time interval and express it as seconds, minutes, hours, days or weeks.

```R
startdate <- as.Date("2004-02-13")
enddate <- as.Date("2011-01-22")
days <- enddate - startdate
days
today <- Sys.Date()
dob <- as.Date("1956-10-12")
difftime(today, dob, units="weeks")
# convert date variables to character variables
strDates <- as.character(dates)
help(as.Date)
help(strftime)
```

The `lubricate` package contains useful function for working with dates. R provides many functions for data type conversion and there are similar functions that verify if the variable is of specific data type.

```R
is.numeric()
as.numeric()
is.character()
as.character()
is.vector()
as.vector()
is.matrix()
as.matrix()
is.data.frame()
as.data.frame()
is.factor()
as.factor()
is.logical()
as.logical()
a <- c(1, 2, 3)
is.numeric(a) # TRUE
a <- as.character(a)
is.numeric(a) # FALSE
is.vector(a) # TRUE
is.character(a) # TRUE
```

The `order()` function for sorting data frame. The default sorting order is ascending.

```R
newdata <- leadership[order(leadership$age)] # sort the data by manager's age
# sorting by multiple parameters
attach(leadership)
newdata <- leadership[order(gender, age)] # order by gender and age
newdata <- leadership[order(gender, -age)] # reverse order of age
detach(leadership)
```

To merge two data frames horizontally, we use `merge()` function. This is like join in databases. Usually, data frames are merged by one or more common key variables. If you want to combine variables from two data frames, you can use `cbind()` to horizontally add extra columns from another dataframe. We don't need common key for this. However, they both must have same number of rows and be sorted in the same order. To add new rows or join two dataframes vertically, we use `rbind()` function. This is like union in databases. For this, two variables must have same variables.

```R
# This is like join
total <- merge(dataframeA, dataframeB, by="ID") # merge by ID
total <- merge(dataframeA, dataframeB, by=c("ID", "Country")) # merge by ID and country.
total <- cbind(A, B) # you don't need common key to bind two dataframes
total <- rbind(dataframeA, dataframeB)
```

For subsetting, R provides various functions. We can use indexing features for creating subsets. You can also drop some of the records based on a condition.

```R
newdata <- leadership[, c(6:10)]
myvars <- c("q1", "q2", "q3", "q4", "q5")
newdata <- leadership[myvars]
# dropping variables
myvars <- name(leadership) %in% c("q3", "q4")
newdata <- leadership[!myvars] # exclude two columns q3 and q4
newdata <- leadership[c(-8, -9)] # the same result as above
```

For selecting observations, we need to select rows. There is also `subset()` function for selecting variables and observations.

```R
newdata <- leadership[1:3,]
newdata <- leadership[leadership$gender=="M" & leadership$age > 30,] # select men over 30
attach(leadership)
newdata <- leadership[gender == 'M' & age > 30, ]
detach(leadership)
# Use of subset function
# keep variables q1, q2, q3, q4
newdata <- subset(leadership, age >= 35 | age < 24, select=c(q1, q2, q3, q4))
# keep variables gender through q4
newdata <- subset(leadership, gender=="M" & age > 25, select=gender:q4)
```

To **select random samples**, we have `sample()` function. R has `survey` and `sampling` package which offers sampling using different methods.

```R
# second argument is number of elements, thirs is whether to sample with replacement
mysample <- leadership[sample(1:nrow(leadership), 3, replace=FALSE)]
```

We can also install `sqldf` which will allow us to run SQL commands to manipulate data. We use `sqldf()` function to apply SQL select statements to data frames.

```R
install.packages("sqldf")
library(sqldf)
newdf <- sqldf("select * from mtcars where carb=1 order by mpg", row.names=TRUE)
# mean mpg and disp within each level of gear for automobiles with four or six cylinders
sqldf("select avg(mpg) as avg_mpg, avg(disp) as avg_disp, gear from mtcars where cyl in (4,6) group by gear")
```