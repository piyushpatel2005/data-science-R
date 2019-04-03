# Creating Graphs in R

Graphs are created in interactive environment. Include destination at the top and a statement that closes that destination at the end.

```R 
# To save the graph
pdf("mygraph.pdf")
attach(mtcars)
plot(wt,mpg)
abline(lm(mpg~wt))
title("Regression of MPG on Weight")
detach(mtcars)
dev.off()
```

Plotting commands like `plot()`, `hist()` and `boxplot()` typically overwrites a previous graph. To create new graph we can open a new window when we want to create new graph 

```R
dev.new()
# statements to create graph
dev.new()
# statements to create another graph
dev.next() # go to next window
dev.prev() # go to previous window
dev.set() # choose window
dev.off() # close the window
dev.cur() # to get details of current window
```

```R
dose <- c(20, 30, 40, 45, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)

# This creates a line graph with points indicated on the graph
plot(dose, drugA, type="b") # b means both points and line
```

We can customize the graph (fonts, colors, axes, labels) through options called *graphical parameters*. One way is to use `par()` function. Values set in this way will be in effect for the rest of the session or until they're changed.

```R
# copy the current settings
opar <- par(no.readonly=TRUE) # this creates a list of parameters that can be modified
# set line type to dashed, set default point character to solid triangle
par(lty=2, pch=17)
plot(dose, drugA, type="b")
# restore original settings again
par(opar)
par() # list the currently set parameters
```

The `par()` function could also be written as two separate function calls with different parameters.

Second way to specify graphical parameters is by using the key-value pairs in the `plot()` function itself. 

`plot(dose, drugA, type="b", lty=2, pch=17)`

Similarly `lwd` is used to specify line width and `cex` option specifies symbol size. We can specify color using `col` option.
- `col`: Some functions accept a vector of color values that will be recycled. For example, `col=c("red","blue")` and three lines are plotted, the first and third will be red and second will be blue.
- `col.axis`: color of axis text
- `col.lab`: color of axis label
- `col.main`: color of titles
- `col.sub`: color of subtitles
- `fg`: color of plot's foreground
- `bg`: color of plot's background

Color can be specified as numbers, string, string of hex code, rgb code, hsv color code. The function `colors()` returns all the available color names. R also has functions to create vectors of contiguous colors. These are `rainbow()`, `heat.colors()`, `terrain.colors()`, `topo.colors()` and `cm.colors()`. 
`rainbow(10)` creates 10 contiguous rainbow colors. *RColorBrewer*is popular package for creating attractive color palettes.

```R
install.packages("RColorBrewer")
library(RColorBrewer)
n <- 7
mycolors <- brewer.pal(n, "Set1") # generates vector of colors
barplot(rep(1,n), col=mycolors)
```

To get a list of all available palettes, type `brewer.pal.info` or `display.brewer.all()`.

gray level generated with the `gray()` function.

```R
n <- 10
mycolors <- rainbow(n)
pie(rep(1,n), labels=mycolors, col=mycolors)
mygrays <- gray(0:n/n)
pie(rep(1,n), labels=mygrays, col=mygrays)
```

