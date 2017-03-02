pollutantmean <- function(directory = "specdata", pollutant = "sulfate", id = 1:332) {
# File: pollutantmean.R
# Author: Sidafa Conde
# Email: sconde@umassd.edu
# School: UMass Dartmouth
# Date: 02/19/2017
# Purpose: part 1 of the first programming assignment

#'directory' is a character vector of length 1 indicating the location of the CSV files

#'pollutant' is a character of vector of length 1 indicating the name of the pollutant for which we will
#calculate the mean; either 'sulfate' or 'nitrate'

#'id' is an integer vector indicating the monitor ID numers to be used

#Returns the mean of the pollutant across all monitors list
#in the 'id' vector (ignoring NA values)
#Note: Do not round the result!

    vals <- vector()
        for(i in id){
            file <- list.files(path = directory, pattern = sprintf("%03d.csv",i), full.names=TRUE)
                data <- read.csv(file)
                flag <- !is.na(data[, pollutant])
                vals <- c(vals, data[flag, pollutant])
        }
    round(mean(vals), 3)
}

test_pollutantmean <- function(){
# Author: Sidafa Conde
# Email: sconde@umassd.edu
# School: UMass Dartmouth
# Purpose: test the pollutantmean function
# make sure to match the output

test01 <- pollutantmean("specdata", "sulfate", 1:10)
expect_res01 <- 4.064
stopifnot(test01 == expect_res01)

test02 <- pollutantmean("specdata", "nitrate", 70:72)
expect_res02 <- 1.706
stopifnot(test02 == expect_res02)

test03 <- pollutantmean("specdata", "nitrate", 23)
expect_res03 <- 1.281
stopifnot(test03 == expect_res03)

sprintf("All the values are matched");
}
