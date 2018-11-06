# R Basics

In R language, `<-` is used for assignment and the variable is called the symbol. 

```{r}
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
```

Variable names have to start with letter and can't contain spaces
Use underscores for variable names.

```{r}
n <- 1000
x <- seq(1,n) # create sequence from 1 to 1000
sum(x) # sum of sequence
```

All values are stored as vector. We can have numeric or character vector. Assignment is called an expression. When we press Enter, the expression is evaluated and the output is shown if any.

```{r}
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
We can have that has multiple types of objects.
R objects can have attributes like names, dimnames, dimensions, class, length, etc. These can be accessed using the `attributes()` function.

The `c()` function can be used to create vectors of objects. We can think of `c` as concatenate.

When objects are mixed in a vector, coercion occurs so that every element in the vector is of the same class.

```{r}
x <- c(0.5, 0.6) ## numeric
x <- c(TRUE, FALSE) # logical
x <- c(T, F) # logical
x <- c("a", "b", "c") # character
x <- c(1+0i, 2 + 4i) # complex
x <- vector("numeric", length=10) # create vector of length 10 with values 0

y <- c(1.7, "a") # will create character vector
y <- c(TRUE, 2) # create numeric
y <- c("a", TRUE) # character
```

We can explicitly coerce objects using `as.*` functions. However, nonsensical coercion will result in NAs.

```{r}
x <- 0:6
class(x)
as.numeric(x)
as.logical(x)
as.character(x)
x <- c("a", "b", "c")
as.numeric(x) # NA NA NA
as.logical(x) # NA NA NA
```

### Lists and Matrices

Lists are a special type of vector that can contain elements of different classes.

Matrices are vectors with dimension attribute. Dimension is  Matrices are constructed column-wise, entries in the columns are filled first, then second column and so on. We can also create matrix by column-binding or row-binding using `cbind()` and `rbind()` functions.

```{r}
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

### Factors

Factor is a special type of vector to represent categorical data. (Similar to enum). This can be unordered or ordered. Factors are treated specially by modelling functions like `lm()` and `glm()`. Using factors with labels is better than using integers because factors are self-describing, i.e. having a name to represent what they mean instead of values.
It has a special attribute called *Labels* which shows what values it can take.
We can set the order of the levels using `levels` argument to `factor()`. This can be useful in linear modelling. By default levels are set alphanumerically based on first character.

```{r}
x <- factor(c("yes", "yes", "no", "yes", "no")) # create factor
table(x) # represents frequency count of each label
unclass(x) # strips out class and represents it to integer
attr(,"levels")

x <- factor(c("yes", "no", "yes", "yes", "no"), levels=c("yes", "no")) # Here, yes will be baseline level.
```

### Missing values

Missing values are denoted by NA or NaN. NA can also have classes. NaN value is also NA but reverse is not true.

```{r}
is.na() # test if object is NA
is.nan() # tset for NaN
x <- c(1,2,NA,10,3)
is.na(x) # F F T F F
is.nan(x) # F F F F F
x <- c(1, 2, NaN, NA, 4)
is.na(x) # F F T T F
is.nan(x) # F F T F F
```

### DataFrame

This is used to store tabular data. These are represented as special type of list where each element of the list is number of rows. Data frames can store different classes of objects in each column unlike matrices. Data frames also have special attributes `row.names` for annotating data row-wise. Dataframes are usually created by `read.table()` or `read.csv()`. They can be converted from matrix using `data.matrix()`. This results in coercision.

```{r}
x <- data.frame(foo=1:4, bar: c(T, T, F, F))
nrow(x) # 4
ncol(x) # 2
```

R objects can also have names, which are used to make readable code.

```{r}
x <- 1:3
names(x)
names(x) <- c("foo", "bar", "baz")
names(x)

x <- list(a=1, b=3, c=4)
x <- matrix(1:4, nrow=2, ncol=2)
dimnames(m) <- list(c("a", "b"), c("c", "d")) # first row names and second is column names.
```
