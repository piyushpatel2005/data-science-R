# R Basics

In R language, `<-` is used for assignment.

```R
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

```R
n <- 1000
x <- seq(1,n) # create sequence from 1 to 1000
sum(x) # sum of sequence
```
