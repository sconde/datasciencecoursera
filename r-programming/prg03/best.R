setwd("~/Dropbox/coursera-data-science-track/r-programming/prg03")

best <- function(state, outcome) {
    # File: best.R
    # Author: Sidafa Conde
    # Email: sconde@umassd.edu
    # School: UMass Dartmouth
    # Date: 02/25/2017
    # Purpose: 

    options(warn=-1)
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

    ## Validate the outcome string
    valid_outcomes = c("heart attack", "heart failure", "pneumonia")
    if (!( outcome %in% valid_outcomes )) stop("invalid outcome")
    if (!( state %in% data$State )) stop("invalid state")
    #if (!( outcome %in% valid_outcomes  &  state %in% data$State )) {stop("invalid outcome/state")}

    # change data type from character to numeric
    data[, 11] <- as.numeric(data[, 11]) # heart attack
    data[, 17] <- as.numeric(data[, 17]) # heart failure
    data[, 23] <- as.numeric(data[, 23]) # pneumonia

    # Filter and simplify the column names
    names(data)[11] <- "heart attack"
    names(data)[17] <- "heart failure"
    names(data)[23] <- "pneumonia"

    state_subset <- data[data$State==state, ]
    outcome_arr <- state_subset[, outcome]
    min <- min(outcome_arr, na.rm=T)
    min_index <- which(outcome_arr == min)
    hosp_name <- state_subset[min_index, 2]
    return(hosp_name)
}

testBest <- function()
{
    source("best.R")

    print(best("TX", "heart attack"))

    print(best("TX", "heart failure"))

    print(best("MD", "heart attack"))

    print(best("MD", "pneumonia"))

    print(best("BB", "heart attack"))

    print(best("NY", "hert attack"))
}
