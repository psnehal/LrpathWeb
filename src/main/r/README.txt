#cTo set up R to run test, and run test...

# To build module: in shell environment... 
# R CMD BUILD LRpath
# R CMD INSTALL LRpath_1_0.tar.gz

# To run, in R: 
library(LRpath)
source("http://bioconductor.org/biocLite.R")
biocLite("annotate")
biocLite("GO.db")
biocLite("org.Ce.eg.db")
biocLite("KEGG.db")

# run test, in R ...
testDataPath = "/Users/terry/Desktop/celegan_test-Directional.txt"
testData <- read.delim(testDataPath, stringsAsFactors=FALSE)
result <- LRpath(testData[,2],testData[,1],species="Ce",direction=testData[,3])
result[1,]

