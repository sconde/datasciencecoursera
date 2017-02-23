corr <- function(directory = "specdata", threshold = 0) {
# File: corr.R
# Author: Sidafa Conde
# Email: sconde@umassd.edu
# School: UMass Dartmouth
# Date: 02/20/2017
# Purpose: part 3 of programming assignment 1

#TODO: write the test to verify the output

source("complete.R")
    completes <- complete(directory, 1:332)
    completes <- subset(completes, nobs > threshold )
    correlations <- vector()

    ## Loop over the passed id's
    for(i in completes$id ) {

        file <- list.files(path = directory, pattern = sprintf("%03d.csv",i), full.names = TRUE)
        data <- read.csv(file)

        completeCases <- data[complete.cases(data),]
        count <- nrow(completeCases)

        if( count >= threshold ) {
            correlations <- c(correlations, cor(completeCases$nitrate, completeCases$sulfate) )
        }
    }

    correlations
}
