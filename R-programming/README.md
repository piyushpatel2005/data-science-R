# R Basics

In R language, `<-` is used for assignment and the variable is called the symbol. R uses one-based indexing and not zero-based.

```r
getwd() # get the working directory
ls() # list the created objects
a <- 1	# assign a to the value of 1
b <- 1
c <- 1
ls() # print saved variables in the workspace
print(a)
# To find a solution for quadratic equation x^2+x+1=0
# one solution would be like this
(-b + sqrt(b^2 - 4*a*c)) / (2*a)
(-b - sqrt(b^2 - 4*a*c)) / (2*a)
# To evaluate a function, we need parentheses
log(8)
log(a)
# Functions can be nested
exp(1)
log(exp(1))
help("ls") # get the help file
?log # get help shortcut
args(log) # quick reminder of the arguments to log function
# To change the default value, we use equal sign in the function call
log(8, base=2)
log(x=8,base=2)
log(8,2)
# Some functions don't need parentheses
2^3
help("+") # get all arithmetic functions
?"+"
data() # datasets available
CO2 # print one of the dataset
pi
Inf
dir.create("testdir") # create directory
setwd("testdir") # change working directory to testdir
file.create("mytest.R")
file.exists("mytest.R")
file.info("mytest.R")
file.info("mytest.R")$size # get size
file.rename("mytest.R", "mytest2.R")
file.copy("mytest2.R", "mytest3.R")
file.remove("mytest3.R")
file.path("mytest3.R") # get relative path of file
file.path("folder1", "folder2") # creates platform independent filepath
dir.create(file.path("testdir2", "testdir3"), recursive = TRUE)
rm(list=ls())
```

Variable names have to start with letter and can't contain spaces
Use underscores for variable names.

```r
n <- 1000
x <- seq(1,n) # create sequence from 1 to 1000
sum(x) # sum of sequence
1:100 # same as seq(1,100)
1:length(my_seq) # create sequence as long as length of my_seq
# we can also achieve this using
seq(along.with = my_seq)
seq_along(my_seq)
rep(0, times=40) # create 40 length sequence with 0 replicated (all elements 0)
rep(c(0,1,2), times=10) # create 10 replicas of the list
rep(c(0,1,2), each=10) # creates 10 zeros, 10 ones and 10 twos
```

All values are stored as vector. We can have numeric or character vector. Assignment is called an expression. When we press Enter, the expression is evaluated and the output is shown if any.

```r
x <- 1:20 # create vector of 1 to 20
```

## Data Types:

R has five basic or atomic classes of objects:
- character
- numeric (real numbers): double precision real number. If we want integer we have to provide suffix 'l'. There is special number `Inf` for infinity. `NaN` is an undefined value similar to Javascript.
- integer
- complex
- logical (True/False)
The most basic object is vector and vector can contain objects of only the same class. Empty vectors can be created with `vector()` function.
We can have that has`` multiple types of objects.
R objects can have attributes like names, dimnames, dimensions, class, length, etc. These can be accessed using the `attributes()` function.

The `c()` function can be used to create vectors of objects. We can think of `c` as concatenate.

When objects are mixed in a vector, coercion occurs so that every element in the vector is of the same class. Atomic vectors contain only one type of data whereas a list may contain multiple data types.

```r
x <- c(0.5, 0.6) ## create numeric vector
x <- c(TRUE, FALSE) # logical
x <- c(T, F) # logical
x <- c("a", "b", "c") # character
x <- c(1+0i, 2 + 4i) # complex
x <- vector("numeric", length=10) # create vector of length 10 with values 0

y <- c(1.7, "a") # will create character vector
y <- c(TRUE, 2) # create numeric
y <- c("a", TRUE) # character

num_vect <- c(0.5, 55, -10, 6)
tf <- num_vect < 1 # creates logical vector based on condition
# AND operation as &, OR operation as | and NOT opearation as !
(3 > 5) & (4 == 4) # FALSE

my_char <- c("My", "name", "is")
paste(my_char, collapse= " ") # create a single string with all elements collapsed with space
my_name <- c(my_char, "Piyush")
paste(my_name, collapse=" ")
paste("Hello", "World!", sep=" ") # join two character vectors with space
paste(1:3, c("X", "Y", "Z"), sep="")
paste(LETTERS, 1:4, sep="-")
```

We can explicitly coerce objects using `as.*` functions. However, nonsensical coercion will result in NAs.

```r
x <- 0:6
class(x)
as.numeric(x)
as.logical(x)
as.character(x)
x <- c("a", "b", "c")
as.numeric(x) # NA NA NA
as.logical(x) # NA NA NA
```

Subsetting a vector

```r
x[1:10] # get first 10 elements from x vector
x[is.na(x)] # returns elements with NA values.
y <- x[!is.na(x)]
y[y>0] # get all postive values
x[!is.na(x) & x > 0] # combine above logic in one
x[c(3,5,7)] # get 3rd, 5th and 7th elements
x[c(-2,-10)] # give all the elements except 2nd and 10th (negative indexing)
x[-c(2,10)] # same as above, only one negative sign
vect <- c(foo=11, bar=2, norf=NA) # create named vector
names(vect) # get only the names of a vector
vect2 <- c(11, 2, NA) # unnamed vector
names(vect2) <- c("foo", "bar", "norf") # add names to vector
identical(vect, vect2) # check if both vectors are identical
vect["bar"] # get bar element of `vect`
vect[c("foo", "bar")] # get foo and bar from a vector
```

### Lists and Matrices

Lists are a special type of vector that can contain elements of different classes.

Matrices are vectors with dimension attribute. Dimension is  Matrices are constructed column-wise, entries in the columns are filled first, then second column and so on. We can also create matrix by column-binding or row-binding using `cbind()` and `rbind()` functions.

```r
x <- list(1, "a", TRUE, 1+4i)
m <- matrix(nrow=2, ncol=3)
dim(m)
attributes(m)
m <- matrix(1:6, nrow=2, ncol=3)

m <- 1:10
dim(m) <- c(2,5) # change the matrix to 2x5 matrix.

x <- 1:3
y <- 10:12
cbind(x,y) # column 1 will be x values, 3x2
rbind(x,y) # row 1 will be x values, 2x3
```

```r
my_vector <- 1:20
dim(my_vector) # vectors don't have dim attributes
length(my_vector) # this works
dim(my_vector) <- c(4,5) # set the dimension of a vector
dim(my_vector) # check the dimension of a vector
attributes(my_vector)
# Now my_vector is a matrix
class(my_vector)
my_matrix <- my_vector
my_matrix2 <- matrix(data=1:20, nrow=4, ncol=5) # create same matrix using matrix method
identical(my_matrix, my_matrix2) # check if two matrix are identical

# We can also assign names to columns and rows as follows
patients <- c("Bill", "Gina", "Kelly", "Sean")
cbind(patients, my_matrix) # add one extra column column-bind
# R matrix can contain only one type of data, so this will result in coersion.
# If we create data frame, it will preserve the integrity of the data.
my_data <- data.frame(patients, my_matrix)
class(my_data)
cnames <- c("patient", "age", "weight", "bp", "rating", "test")
colnames(my_data)
colnames(my_data) <- cnames # now my_data has column names from cnames
```

### Factors

Factor is a special type of vector to represent categorical data. (Similar to enum). This can be unordered or ordered. Factors are treated specially by modelling functions like `lm()` and `glm()`. Using factors with labels is better than using integers because factors are self-describing, i.e. having a name to represent what they mean instead of values.
It has a special attribute called *Labels* which shows what values it can take.
We can set the order of the levels using `levels` argument to `factor()`. This can be useful in linear modelling. By default levels are set alphanumerically based on first character.

```r
x <- factor(c("yes", "yes", "no", "yes", "no")) # create factor
table(x) # represents frequency count of each label
unclass(x) # strips out class and represents it to integer
attr(x,"levels")

x <- factor(c("yes", "no", "yes", "yes", "no"), levels=c("yes", "no")) # Here, yes will be baseline level.
```

### Missing values

Missing values are denoted by NA or NaN. NA can also have classes. NaN value is also NA but reverse is not true. Any operation involving NA generally yields NA as the result.

```r
is.na() # test if object is NA
is.nan() # tset for NaN
x <- c(1,2,NA,10,3)
is.na(x) # F F T F F
is.nan(x) # F F F F F
x <- c(1, 2, NaN, NA, 4)
is.na(x) # F F T T F
is.nan(x) # F F T F F
unique(c(3,4,5,5,5,6,6)) # get unique elements only
```

```R
x <- c(44, NA, 5, NA)
x * 3
y <- rnorm(1000) # create standard normal distribution of draw
z <- rep(NA, 1000) # create 1000 NA values vector
my_data <- sample(c(y,z), 100) # create sample data of 100 values from those two vectors
my_na <- is.na(my_data)
# Under the hood, R assigns 1 to all TRUE values and 0 to FALSE
sum(my_na) # returns number of NA values
Inf - Inf # results in NaN
0 / 0 # results in NaN
### DataFrame

This is used to store tabular data. These are represented as special type of list where each element of the list is number of rows. Data frames can store different classes of objects in each column unlike matrices. Data frames also have special attributes `row.names` for annotating data row-wise. Dataframes are usually created by `read.table()` or `read.csv()`. They can be converted from matrix using `data.matrix()`. This results in coercision.

```R
x <- data.frame(foo=1:4, bar: c(T, T, F, F))
nrow(x) # 4
ncol(x) # 2
```

R objects can also have names, which are used to make readable code.

```R
x <- 1:3
names(x)
names(x) <- c("foo", "bar", "baz")
names(x)

x <- list(a=1, b=3, c=4)
m <- matrix(1:4, nrow=2, ncol=2)
dimnames(m) <- list(c("a", "b"), c("c", "d")) # first row names and second is column names.
```


## Reading/Writing Tabular Data

### Reading from files:

- `read.table`, `read.csv` for reading tabular data from text files. To write `write.table`. This takes following arguments.
	1. `file` - the name of the file or a connection
	2. `header` - logical indicating if the file has a header line
	3. `sep` - a string indicating how the colums are separated.
	4. `colClasses` - a character vector indicating the class of each column in the dataset
	5. `nrows` - number of rows in dataset
	6. `comment.char` - a chracter string indicating the comment character
	7. `skip` - the number of lines to skip from beginning
	8. `stringsAsFactors` - should character variables be coded as factors? Default is `true`.
- `readLines` for reading lines of a text file. To write `writeLines`.
- `source` for reading R code. To write `dump`
- `dget` for reading  R code files. To write `dput`.
- `load` for reading saved workspaces. To write `save`.
- `unserialize` for reading single R objects in binary form. To write `serialize`.
When we specify all these, R can run faster. `read.csv` is similar to `read.table` except that csv are by default separated by comman and table is separated by space.

```r
data <- read.table("foo.txt")
```

For reading larger datasets, we have to check if our computer has enough memory to store that data into our RAM. For optimization, set `comment.char = ""` if there are no comments in the file. if we know column classes, it is always better to specify `colClasses` to avoid R having to check each row data type. We can find the datatype as follows.

```r
initial <- read.table("datatable.txt", nrows=100)
classes <- sapply(initial, class)
taball <- read.table("datatable.txt", colClasses=classes)
```

Set `nrows`. It helps with memory usage. This will find out how much memory is required. For calculation of memory. Suppose, I have a data frame with 1.5m rows and 120 columns, all numeric.

= 1500000 x 120 x 8 bytes/numeric
= 1.34 GB

We will require twice as much memory.

`dumping` and `dputing` are usuful because the resulting textual format is editable. `dump` and `dput` preserve the metadata. This format is not space-efficient. If something is corrupted, we can recover it.
Another way to pass data around is deparsing the R object with `dput` and reading it back in using `dget`.

```r
y <- data.frame(a=1, b="a")
dput(y)
structure(list(a=1,
				b = structure(1L, .Label="a", class="factor")),
		.Names = c("a", "b"), row.names=c(NA, -1L),
		class="data.frame")
dput(y, file="Y.R")
new.y <- dget("y.R")
new.y
```

Multiple obejcts can be deparsed using the `dump` function and read back in using `source`.

```r
x <- "foo"
y <- data.frame(a=1, b="a")
dump(c("x", "y"), file="data.R")
rm(x,y)
source("data.R")
y
x
```

### Interfaces to outside world

Data are read in using `connection` interfaces. Connections can be made to files or to other more exotic things.
- `file` - opens a connection to a file.
- `gzfile` - opens connection to gzip file.(gz extension)
- `bzfile` - opens connection to bzip2 compressed file. (bz2 extension)
- `url` - opens connection to a webpage.

`file` function takes `description`, `open` to indicate open mode (r,w,a,rb,ab,wb), etc.

```r
con <- file("foo.txt", "r")
data <- read.csv(con)
close(con)

# This is same as using read.csv function
data <- read.csv("foo.txt")

con <- gzfile("words.gz")
x <- readLines(con, 10) # read only 10 lines
x

con <- url("http://hostname", "r")
x <- readLines(con)
head(x)
```

## Subsetting R objects

There are operators that can be used to extract subsets of R objects.
`[` always returns an object of the same class as the original. This can be used to select more than one element.
`[[` is used to extract elements of a list or a data frame; it can only be used to extract a single element and the class of the returned object will not necessarily be a list or data frame.
`$` is used to extract elements of a list or data frame by name; semantics are similar to that of `[[`.

```r
x <- c("a", "b", "c", "c", "d", "a")
x[1] # a
x[2] # b
x[1:4] # a b c c
x[x > "a"] # b c c d
u <- x > "a" # F T T T T F
x[u] # b c c d

x <- list (foo = 1:4, bar = 0.6)
x[1] # $foo returns list
x[[1]] # 1 2 3 4 returns sequence
x$bar # 0.6
x[["bar"]] # 0.6 same as above
x["bar"] # $bar as list

x <- list(foo=1:4, bar=0.6, baz="hello")
x[c(1,3)] # $foo
$baz # hello

x <- list(foo=1:4, bar=0.6, baz="hello")
name <- "foo"
x[[name]] # 1 2 3 4
x$name # element 'name' doesn't exist so return NULL
x$foo # 1 2 3 4

x <- list(a=list(10, 12, 14), b=c(3.14, 2.81))
x[[c(1,3)]] # 14
x[[1]][[3]] # 14 same as above
x[[c(2,1)]] # 3.14
```

By default, when a single element of a matrix is retrieved, it is returned as a vector of length 1 rather than a 1x1 matrix. This behavior can be turned off by setting `drop=FALSE`.

```r
x <- matrix(1:6, 2, 3)
x[1,2] # 3
x[2,1] # 2
x[1, ] # 1 3 5
x[, 2] # 3 4

x <- matrix(1:6, 2, 3)
x[1,2]
x(1,2,drop=FALSE)

x[1,] # returns list
x[1,,drop=FALSE] # return matrix
```

Partial matching of names is allowed with [[ and $.

```r
x <- list(aardvark=1:5)
x$a # 1 2 3 4 5 this looks for a names that matches 'a'. This is partial matching.
x[["a"]] # name should be exact match, so it will return NULL
x[["a", exact=FALSE]] # 1 2 3 4 5
```

Removing NA values.

```r
x <- c(1, 2, NA, 4, NA, 5)
bad <- is.na(x)
x[!bad] # 1 2 4 5

# multiple things you want to take subset with no missing values
x <- c(1, 2, NA, 4, NA, 5)
y <- c("a", "b", NA, "d", NA, "f")
good <- complete.cases(x,y)
good # TRUE TRUE FALSE TRUE FALSE TRUE
x[good] # 1 2 4 5
y[good] # "a" "b" "d" "f"
```

Vectorized operations make it easy to write code on command line. Things can happen in parallel.

```r
x <- 1:4, y <- 6:9
x + y
x > 2 # F F T T
x / y # divide each element of x by corresponding element from y
x <- matrix(1:4, 2, 2); y <- matrix(rep(10, 4), 2, 2)
x * y # elementwise multiplication
x %*% y # true matrix multiplication
# We can access current date and time using
t1 <- Sys.time()
t2 <- as.POSIXlt(Sys.time())
class(t2)
unclass(t2)
str(unclass(t2))
t2$min
difftime(Sys.time(), t1, units = 'days') # to specify the unit of difference
```

Learn R programming interactively

```R
install.packages("swirl") # install swirl package
packageVersion("swirl") # check version of the package
library("swirl") # load the library package for swirl
install_from_swirl("R Programming")
swirl()
```

[Data Types](html/DataTypes.Rmd)


## Control Structures:

& and | are used as AND and OR operator in R. `&&` is used with vector for AND operation of only first element of vector.

```R
TRUE & c(TRUE, FALSE, FALSE) # TRUE
TRUE & c(TRUE, FALSE, FALSE) # T T T
isTRUE(6>4) # TRUE
xor(FALSE, TRUE) # TRUE
which(c(TRUE, FALSE, TRUE)) # c(1,3), returns indices of vector which are TRUE
any(c(TRUE, FALSE, FALSE)) # TRUE, to check if any element is TRUE
all(c(FALSE, FALSE, TRUE)) # FALSE, to check if all elements are TRUE
```

These are mostly used in R scripts or R programs.

```r
if(<condition>) {
	# statements
} else if(<condition>){
} else {
	# statements
}

if (x > 3) {
	y <- 10
} else {
	y <- 0
}

# This can also be written as
y <- if (x > 3) 10 else 0
```

**For loop** take an iterator and assign it successive values from a sequence or vector.

```R
for (i in 1:10) {
	print(x[i])
}

for (letter in x) { print (letter)}

x <- c("a", "b", "c", "d")
for (i in seq_along(x)) {
	print(x[i])
}

x <- matrix(1:6, 2, 3)
for(i in seq_len(nrow(x))) {
	for(j in seq_len(ncol(x))) {
		print(x[i,j])
	}
}
```

**While loop**

```R
count <- 0
while(count < 10) {
	print(count)
	count <- count + 1
}
```

**repeat** initiates infinite loop. To exit the loop, use `break`.

```R
x0 <- 1
tol <- 1e-8

repeat {
	x1 <- computeEstimate()
	if(abs (x1 - x0) < tol) {
		break
	} else {
		x0 <- x1
	}
}
```

**next** to skip an iteration. (similar to continue). **return** signals that a function should exit and return a given value.

```R
for (i in 1:100) {
	if (i <= 20) {
		next
	}
	# do something
}
```

## Functions

Functions are created using `function` directive and stored as R objects.
Functions can be passed as arguments to other functions. Functions can be nested. Return value is the last expression in the function to be evaluated.

Functions have named arguments which potentially have default values.


```R
add2 <- function(x,y) {
  x + y
}

above <- function(x, n = 10) {
  use <- x > n
  x[use]
}
x <- 1:20
above(x, 12)

columnmean <- function (y, removeNA=TRUE) {
	# y will be dataframe
	nc <- ncol(y)
	means <- numeric(nc)
	for (i in 1:nc) {
		means[i] <- means(y[,i], na.rm = removeNA)
	}
	means
}

columnmean(airquality)

mydata <- rnorm(100)
sd(mydata)
sd(x = mydata)
sd (x=mydata, na.rm=FALSE)
sd(na.rm=FALSE, x=mydata)
sd(na.rm=FALSE, mydata)


mad_libs <- function(...){
  # Do your argument unpacking here!
  args <- list(...)
  place <- args[["place"]]
  adjective <- args[["adjective"]]
  noun <- args[["noun"]]
  paste("News from", place, "today where", adjective, "students took to the streets in protest of the new", noun, "being installed on campus.")
}
```

We can also define binary operators that work on two arguments like this.

```R
"%p%" <- function(left, right){ # Remember to add arguments!
  paste(left, right, sep=' ')
}
'Hello' %p% 'stduent'
'I' %p% 'love' %p% 'R!'
```

Arguments to functions are lazily evaluated.

```R
f <- function(a,b) {
	a * 2
}
f(2) # this works without errors
```

The `...` argument is used to indicate variable number of arguments.

```R
myplot <- function(x,y, type="l", ...) {
	plot(x,y,type=type,...)
}

#
make.power <- function (n) {
	pow <- function(x) {
		x^n
	}
	pow
}
cube <- make.power(3)
square <- make.power(2)

ls(environment(cube))
get("n", environment(cube))
```

### Dates

R uses different data classes to represent dates. Date class are used for DATE and Times are represented using `POSIXct` and `POSIXlt` class. Times are number of seconds since January 1, 1970.
In POSIXct times are represented as big integer. POSIXlt stores time as list and also stores various other information.

```R
x <- as.Date("1970-01-01")
unclass(x) # 0
unclass(as.Date("1970-01-02")) # 1
x <- Sys.time()
p <- as.POSIXlt(x)
names(unclass(p))
p$sec
# strptime used to convert string to dates in different format.
datestring <- c("January 10, 2012 10:40", "December 9, 2011 9:11")
x <- strptime(datestring, "%B %d, %Y %H:%M")
x
class(x)
x <- as.Date("2012-01-01")
y <- strptime("9 Jan 2011 11:34:21", "%d %b %Y %H:%M:%S")
x <- as.POSIXlt(x)
x-y # this is possible only when both are POSIXlt

x <- as.Date("2012-03-01")
y <- as.Date("2012-02-28")
x -y # time difference for leap year

x <- as.POSIXct("2012-10-25 01:00:00")
y <- as.POSIXct("2012-10-25 06:00:00", tz="GMT")
y - x # Time difference based on timezone
```

## Loop functions

Loop functions usually have word `apply` in them.
- `lapply`: loop over a list of objects and apply a function to all elements of list (similar to map)
- `sapply`: same as `lapply` but try to simplify the results. Sometimes if we don't want results as list. For example, for single element list.
- `apply`: Apply a function over the margins of an array
- `tapply`: Apply a function over subsets of a vector (table apply)
- `mapply`: Multivariate version of `lapply`
- `split` is useful in conjunction with `lapply`.

```R
x <- list(a=1:5, b=rnorm(10))
lapply(x, mean) # apply mean on each element

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20,1), d=rnorm(100, 5))
lapply(x, mean)

x <- 1:4
lapply(x, runif) # create a sequence of 1,2,3,4 elements
lapply(x, runif, min=0, max=10)

x<- list(a = matrix(1:4, 2, 2), b=matrix(1:6, 3,2))
lapply(x, function(elt) elt[,1])

x <- list(a = 1:4, b = rnorm(10), c = rnorm(20,1), rnorm(100,5))
# lapply on x return list when we apply mean
sapply(x, mean) # returns vector with 4 elements.

# apply function is used to evaluate a function over the margins ofan array.
# mostly used to apply a function to the rows and columns of a matrix
# It is not faster than writing a loop, but works in one line.
str(apply) # margin specifies which margins to be retained.
x <- matrix(rnorm(200), 20, 20)
apply(x, 2, mean) # it applies mean on second dimension means on columns, 10 element vector is returned.
apply(x, 1, sum) # applies sum function on rows, so 20 length vector is returned

# There are functions rowSums, rowMeans, colSums and colMeans which are optimized version to calculate such simple functions.

x <- matrix(rnorm(200), 20, 10)
# calcuate quantile for 25 and 75 percentile on rows.
apply(x, 1, quantile, probs = c(0.25, 0.75))

a <- array(rnorm(2*2*10), c(2,2,10))
apply(a, c(1,2), mean)
rowMeans(a, dims = 2) # same as above

# It applies a function in parallel over a set of arguments.
list(rep(1,4), rep(2,3), rep(3,2), rep(4,1))
mapply(rep, 1:4, 4:1) # same as above
noise <- function(n, mean, sd) {
	rnorm(n, mean, sd)
}
noise(5,1,2)
noise(1:5, 1:5, 2)
mapply(noise, 1:5, 1:5, 2) # 1 element with mean 1, 2 element with mean 2, etc.

# tapply is used to apply a function over a subsets of a vector.
x <- c(rnorm(10), runif(10), rnorm(10,1))
f <- gl(3, 10) # 3 levels with each level repeated 10 Times
tapply(x, f, mean)
tapply(x, f, mean, simplify=FALSE)
tapply(x, f, range)

# split takes a vector or objects and splits it into groups determined by a factor or list of factors.
# `drop` indicates whether empty factor levels should be dropped.
x <- c(rnorm(10), runif(10), rnorm(10, 1))
f <- gl(3,10)
split(x, f)
lapply(split(x,f), mean)

library(datasets)
head(airquality)
# calculate mean for each column based on month
s <- split(airquality, airquality$Month)
lapply(s, function(x) colMeans(x[,c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[,c("Ozone", "Solar.R", "Wind")]))
sapply(s, function(x) colMeans(x[,c("Ozone", "Solar.R", "Wind")], na.rm=TRUE))

# splitting data on more than over variable.
x <- rnorm(10)
f1 <- gl(2,5)
f2 <- gl(5,2)
interaction(f1,f2)
str(split(x, list(f1,f2)))
str(split(x, list(f1,f2), drop=TRUE)) # drop empty levels
```

### Exploring (Looking at) Data

```R
class(plants) # look at class of dataset
dim(plants) # look at dimension of dataset, when it is data.frame
nrow(plants)
object.size(plants) # size in memory for dataset
names(plants) # character vector of columns
head(plants)
head(plants, 10) # see 10 rows
tail(plants, 10) # read last 10 rows
summary(plants) # see summary distribution
table(plants$Active_Growth_Period)
str(plants)
```

## Debugging

Three main types of indication for debugging. message, warning and error. R comes with several debugging tools.

- `traceback`: prints out the function call stack after an error occurs; does nothing if no error.
- `debug`: flags a function for "debug" mode which allows you to step through execution of a fcuntion one line at a time.
- `browser`: suspends the execution of a function whenever it is called and puts the function in debug mode.
- `trace`: allows to insert debugging code into a function at specific places.
- `recover`: allows you to modify the error behvior so that you can browse the function call stack.

```R
mean(x) # throws error
traceback()
lm (y ~ x)
traceback()
debug(lm) # now all `lm` function calls go into debug mode. We enter browse mode.
# We can press `n` to run the next line. We can check the line where error occurs.
# we can nest inside debug mode by using debug another function.
options(error=recover)
read.csv("nosuchfile")
```

### Caching the results

`<<-` oeprator is used to assign a value to an object in an environment that is different from the current environment.

```R
makeVector <- function(x = numeric()) {
	m <- NULL
	# sets numeric vector and mean m to default values
	set <- function(y) {
		x <<- y
		m <<- NULL
	}
	# get the vector
	get <- function() x
	# set mean of x
	setmean <- function(mean) m <<- mean
	# get mean
	getmean <- function() m
	list(set = set, get = get, setmean = setmean, getmean = getmean)
}

# The following function calculates the mean of special vector created with above function.
# However, it first checks to see if the mean has already been calculated.
# If so, it  gets the mean from the cache and skip computation
# otherwise it calculates the mean and sets the value of mean in cache.
cachemean <- function(x, ...) {
	m <- x$getmean()
	if(!is.null(m)) {
		message("getting cached data")
		return (m)
	}
	data <- x$get()
	m <- mean(data, ...)
	x$setmean(m)
	m
}
```

`str` function is very useful to look at object. It represents the internal *structure* of the object. We can use `summary` but `str` is another option.

```R
str(str)
str(lm)
str(ls)
x <- rnorm(100, 2, 4)
summary(x)
str(x) # gives first 5 numbers
f <- gl(40, 10)
str(f)
library(datasets)
head(airquality)
str(airquality)
m <- matrix(rnorm(100), 10, 10)
str(m)
s <- split(airquality, airquality(airquality$Month))
```

### Simulation

Functions for probability distributions in R
- `rnorm`: generate random Normal variates with a given mean and standard deviation.
- `dnorm`: evaluate the normal probability density (with a given mean/SD) at a point(or vector of points)
- `prnorm`: evaluate the cumulative distribution function for a normal distribution.
- `rpois`: generate random Poisson variates with a given rate.

Probability distribution functions usually have four functions associated with them. These functions are prefixed with a:
- `d` for density
- `r` for random number generation
- `p` for cumulative distribution
- `q` for quantile function.

Every distribution has these four types of functions.

```R
x <- rnorm(10)
x <- rnorm(10, mean=20, sd=2)
summary(x)

set.seed(1)
rnorm(5)
rnorm(5)
set.seed(1) # set seed again to 1
rnorm(5) # will reproduce the random numbers

rpois(10, 1)
rpois(10, 2)
rpois(10, 20)

ppois(2,2)
ppois(4,2)
ppois(6,2)
```

Generating Random numbers from a linear model

```R
set.seed(20)
x <- rnorm(100)
e <- rnorm(100, 0, 2)
y <- 0.5 + x * x + e
summary(y)
```

Simulate from a Poisson model

```R
set.seed(1)
x <- rnorm(100)
log.mu <- 0.5 + 0.3 * x
y <- rpois(100, exp(log.mu))
summary(y)
plot(x, y)
```

Random sampling

`sample` function draws randomly from a specified set of (scalar) objects allowing you to sample from arbitrary distributions.

```R
set.seed(1)
sample(1:10, 4)
sample(1:10, 4)
sample(letters, 5)
sample(1:10) # permutation
sample(1:10, replace=TRUE) # sample with replacement
```

## R Profiler Tool

When doing big data analysis, it is important. Profiler helps us fine tune our code. We can optimize our software with the help of profiler. Profiler helps us to get time duration for different parts of our code.

- `system.time()` takes an abitrary R expression as input and returns the amount of time taken to evaluate the expression in seconds.

```R
system.time(readLines("http://www.jhsph.edu"))
# user time will be less than elapsed time

hilbert <- function(n) {
	i <- 1:n
	1 / outer(i - 1, i, "+")
}
x <- hilbert(1000)
system.time(svd(x))
# user time is more than elapsed. Here it uses multi-core cpu.

# time longer expressions
system.time({
	n <- 1000
	r <- numeric(n)
	for (i in 1:n) {
		x <- rnorm(n)
		r[i] <- mean(x)
	}
})
```

Rprofiler is function in R. `Rprof()` and `summaryRprof()` are used to get profiles. We should not use `system.time()` with profiler functions. It keeps track of the function call stack at regularly sampled intervals and tabulates how much time is spent in each function. The `summaryRprof` function tabulates the R profiler output and calculates how much time is spent in which function. There are two methods for normalizing the data. `by.total` divides the time spent in each function by the total runtime. `by.self` does the same but first subtracts out time spent in functions above in the call stack. This is more accurate picture of the time spent by each function.

```R
summaryRprof()
$by.total
$by.self
$sample.interval
$sampling.time
```

```R
sample(1:6, 4, replace=TRUE) # sample with repetition
sample(LETTERS) # without repetition
flips <- sample(c(0,1), 100, replace=TRUE, prob=c(0.3, 0.7)) # flip with given probability
sum(flips)
rbinom(1, size=100, prob=0.7)
