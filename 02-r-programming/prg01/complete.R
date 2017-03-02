complete <- function(directory = "specdata", id = 1:332) {
# File: complete.R
# Author: Sidafa Conde
# Email: sconde@umassd.edu
# School: UMass Dartmouth
# Date: 
# Purpose: part 2 of programming assignment 1

#TODO: write the test

counts = vector()
for(i in id){
    file <- list.files(path = directory, pattern = sprintf("%03d.csv",i), full.names = TRUE)
    data <- read.csv(file)

    #complete.cases: Return a logical vector indicating which cases are complete, i.e., have no missing values.
    counts <- c(counts, nrow(data[complete.cases(data),]))
}
data.frame(id, nobs = counts)
}
