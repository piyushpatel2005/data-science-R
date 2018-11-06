# datasciencecoursera

Data Science courses from John Hopkins University and Coursera

With R, assignment is `<-` rather than equal sign.
Open R Console and type:

```R
a <- available.packages()
a
head(rownames(a),3)

# install single package
install.packages("slidify")
# install multiple packages
install.packages(c("slidify", "ggplot2","devtools"))

source("http://bioconductor.org/biocLite.R")
biocLite()

biocLite(c("GenomicFeatures", "AnnotationDbi"))

library(ggplot2) # load library
search() # list the functions of ggplot2 package.

# Install Rtools
# Verify Rtools installation
find.package("devtools")
install.packages("devtools")
library("devtools")
find_rtools() # should return true if Rtools installed properly.
```

[R Programming](R-programming/README.md)
