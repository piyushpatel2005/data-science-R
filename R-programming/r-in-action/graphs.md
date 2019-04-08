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

### Text characteristics

Font family and styles can be controlled with font options.
 
- `cex` : number indicating the amount by which the plotted text should be scaled relative to default. 1 is default, 1.5 is 50% larger
- `cex.axis`: magnification of axis text relative to cex
- `cex.lab`: magnification of axis labels
- `cex.main`: magnification of titles relative to cex
- `cex.sub`: magnification of subtitles relative to cex
- `font`: Integer specifying the font to use for plotted text. 1=plain, 2=bold, 3=italic, 4=bold italic and 5=symbol
- `font.axis`: font for axis text
- `font.lab`: font for axis label
- `font.main`: font for titles
- `font.sub`: font for subtitles
- `ps`: font point size
- `family`: font family for drawing text. This selection is device dependent.

```R
par(font.lab=3, cex.lab=1.5, font.main=4, cex.main=2)
```

On Windows, we can easily set these mappings to create fonts of our choice. On Mac, similarly we have `quartzFonts` method.

```R
windowsFonts (
    A = windowsFont("Arial Black")
    B=windowsFont("Bookman Old Style")
    C=windowsFont("Comic Sans MS")
)
par(family="A") # speicifies Arial Black font.
```

- `pin`: plots dimensions in inches.
- `mai`: numerical vector indicating margin size where c(bottom, left, top, right) is expressed in inches.
- `mar`: numerical vector indicating margin size where c(bottom, left, top, right) is in inches.

```R
par(pin=c(4,3), mai=c(1,0.5,1,0.2))
```

```R
dose <- c(20, 30, 40, 45, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)

opar <- par(no.readonly=TRUE)
par(pin=c(2,3))
par(lwd=2, cex=1.5)
par(cex.axis=0.75, font.axis=3)
plot(dose, drugA, type="b", pch=19, lty=2, col="red")
plot(dose, drugB, type="b", pch=23, lty=6, col="blue", bg="green")
par(opar)
```

High level plotting functions such as `plot`, `hist` and `boxplot` allow to include axis and text options

```R
plot(dose, drugA, type="b", col="red", lty=2, pch=2, lwd=2,
    main="clinical trials for Druga A",
    sub="This is hypotheitcal data",
    xlab="Dosage", ylab="Drug Response",
    xlim=c(0,60), ylim=c(0,70))
```

We can use `title` function to add title and labels.

```R
title(main="main title", sub="subtitle", xlab="x-axis label", ylab="y-axis label")
```

We can create axis as we want using following

```R
axis(side, at=, labels=, pos=, lty=, col=, las=,tck=,...)
```

- `side`: Integer indicating the side of the graph on which to draw the axis(1=bottom, 2=left, 3=top, 4=right)
- `at`: Numeric vector indicating where tick marks should be drawn
- `labels`: Character vector of labels to be placed at the tick names
- `pos`: coordinate at which the axis 
- `lty`: line type
- `col`: line and tick mark color
- `las`: specifies labels are parallel(1) or perpendicular(2) to axis.
- `tck`: length of each tick mark as a fraction of plotting region (negative number is outside the graph, positive number is inside, 0 suppresses ticks and 1 creates gridliness)

```R
x <- c(1:10)
y <- x
z <- 10/x
opar <- par(no.readonly=TRUE)
par(mar=c(5,4,4,8) + 0.1) # increases margin
plot(x, y, type="b", pch=21, col="red", yaxt="n", lty=3, ann=FALSE)
lines(x, z, type="b", pch=22, col="blue", lty=2)
# draw axis
axis(2, at=x, labels=x, col.axis="red", las=2)
axis(4, at=z, labels=round(z, diigts=2), col.axis="blue", las=2, cex.axis=0.7, tck=-.01)
mtext("y=1/x", side=4, line=3, cex.lab=1, las=2, col="blue")
title("An Example of Creative Axes", xlab="X value", ylab="Y=X")
par(opar)
```

`mtext` is used to add text to the margings of the plot. To create minor tick marks, you need the `minor.tick()` function in the `Hmisc` package.

```R
library(Hmisc)
# nx and ny specify the number of intervals into which to divide the area between major tick marks on the X and Y axis. tick.ratio is the size of the minor tick marks relative to the major tick mark.
minor.tick(nx=n, ny=n, tick.ratio=n)
```

You can retrieve the current length of the major tick mark using `par("tck")`.

`minor.tick(nx=2, ny=3, tick.ratio=0.5)` will be 50% as long as major tick marks and will add one tick mark between each major tick mark on X axis and two tick marks in Y-axis.

The `abline()` function is used to add reference line to a graph. We can also specify line type, color and width.

```R
abline(h=yvalues, v=xvalues) # specify vector of xvalues for vertical line and yvalues for horizontal line.
abline(h=c(1,5,7)) # horizontal line passing through 1,5,7
abline(v=seq(1,10,2), lty=2, col="blue") # dashed line with color blue
```

A legend can help you to identify what's being represented.

`legend(location, title, legend, ...)`

- `location`: we can use bottom, bottomleft, left, topleft, top, topright, right, bottomright or center to place the legend in the graph. We can also specify `inset` to specify how much to move the legend into the graph
- `title`: character string for legend title
- `legend`: character vector with labels.

```R
dose <- c (20, 30, 40, 45, 60)
drugA <- c(16, 20, 27, 40, 60)
drugB <- c(15, 18, 25, 31, 40)
opar <- par(no.readonly=TRUE)
par(lwd=2, cex=1.5, font.lab=2)
plot(dose, drugA, type="b", pch=15, lty=1, col="red", ylim=c(0,60),
    main="Drug A vs Drug B", xlab="Drug Dosage", ylab="Drug Response")
lines(dose, drugB, type="b", pch=17, lty=2, col="blue")
abline=(h=c(30), lwd=1.5, lty=2, col="gray")
library(Hmisc)
minor.tick(nx=3, ny=3, tick.ratio=0.5)
legend("topleft", inset=0.05, title="Drug Type", c("A", "B"),
    lty=c(1,2), pch=c(15, 17), col=c("red", "blue"))
par(opar)
```

Text annocation is possible with `text()` and `mtext()` functions.

```R
text(location, "text to place", pos, ...)
mtext("text to place", side, line=n, ...)
```

- `location`: location can be x,y coordinates.
- `pos`: position relative to location. 1=below, 2=left, 3=above and 4=right. We can also specify offset as percetange of character width.
- `side`: Which margin to place text in. 1= bottom, 2=left, 3=top and 4=right.

```R
attach(mtcars)
plot(wt,mpg, main="Mileage vs Car weight",
    xlab="Weight", ylab="Mileage",
    pch=18, col="blue")
text(wt, mpg, row.names(mtcars), cex=0.6, pos=4, col="red")
detach(mtcars)
```

We can also add mathematical symbols and formulas to graph using TeX-like rules. Use `help(plotmath)` to see details. R also makes it easy to combine several graphs into one graph using `par()` or `layout()` function. With `par()` function, you can include the graphical parameter `mfrow=c(nrows,ncols)` to create a matrix of `nrows x ncols`. 

```R
# create four plots and arrange them into 2x2 matrix
attach(mtcars)
opar <- par(no.readonly=TRUE)
par(mfrow=c(2,2))
plot(wt, mpg, main="Scatterplot of wt vs mpg")
plot(wt, disp, main="Scatterplot of wt vs disp")
hist(wt, main="Histogram of wt")
boxplot(wt, main="Boxplot of wt")
par(opar)
detach(mtcars)

# create three plots in three rows and single column
attach(mtcars)
opar <- par(no.readonly=TRUE)
par(mfrow=c(3,1))
hist(wt)
hist(mpg)
hist(disp)
par(opar)
detach(mtcars)

# with plot, we can specify location of plots using matrix.
# here one figure is plcaed in row 1 and two figures in row 2
attach(mtcars)
layout(matrix(c(1,1,2,3), 2, 2, byrow=TRUE))
hist(wt)
hist(mpg)
hist(disp)
detach(mtcars)
```

We can also specify width and height to control the size of each figure more precisely using `width` and `height` option.

If we want to superimpose several figures to create a single meaningful plot, we need fine control over the placement of figures. This is possible through `fig` graphical parameter.

```R
opar <- par(no.readonly=TRUE)
par(fig=c(0, 0.8, 0, 0.8))
plot(mtcars$wt, mtcars$mpg, xlab="Miles per Gallon", ylab="Car Weight")
par(fig=c(0, 0.8, 0.55, 1), new=TRUE)
boxplot(mtcars$wt, horizontal=TRUE, axes=FALSE) # ads a box plot
par(fig=c(0.65, 1, 0, 0.8), new=TRUE)
boxplot(mtcars$mpg, axes=FALSE)
mtext("Enhanced Scatterplot", side=3, outer=TRUE, line=-3)
par(opar)
```

We can tihnk of graph area as going from (0,0) in lowerleft corner to (1,1) in upper-right corner. Above code first setsup box plot from 0 to 0.8.
