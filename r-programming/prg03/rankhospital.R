rankhospital <- function(state, outcome, num) {
    # File: rankhospital.R
    # Author: Sidafa Conde
    # Email: sconde@umassd.edu
    # School: UMass Dartmouth
    # Date: 02/25/2017
    # Purpose: returns a character vector with the name of the hospital that has the ranking specified by the num argument

    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

    valid_outcomes = c("heart attack", "heart failure", "pneumonia")
    if (!( outcome %in% valid_outcomes )) stop("invalid outcome")
    if (!( state %in% data$State )) stop("invalid state")

    # change data type from character to numeric
    data[, 11] <- as.numeric(data[, 11]) # heart attack
    data[, 17] <- as.numeric(data[, 17]) # heart failure
    data[, 23] <- as.numeric(data[, 23]) # pneumonia

    # Filter and simplify the column names
    names(data)[1] <- "name"
    names(data)[11] <- "heart attack"
    names(data)[17] <- "heart failure"
    names(data)[23] <- "pneumonia"

    ## Validate the num value
    if( num != "best" && num != "worst" && num%%1 != 0 ) stop("invalid num")

    ## Grab only rows with our state value    
    state_subset <- data[data$State==state, ]
    outcome_arr <- state_subset[, outcome]
    len <- dim(state_subset[!is.na(outcome_arr), ])[1]

    browser()

    ## Order the data
    state_subset <- state_subset[order(state_subset$name, decreasing = FALSE), ]
    browser()
    state_subset <- outcome_arr[order(state_subset[outcome], decreasing = FALSE), ]
    browser()

    ## Process the num argument
    vals <- data[, outcome]
    if( num == "best" ) {
        rowNum <- which.min(vals)
    } else if( num == "worst" ) {
        rowNum <- which.max(vals)
    } else {
        rowNum <- num
    }

    ## Return hospital name in that state with lowest 30-day death rate
    data[rowNum, ]$name
}

findRank <- function(state_subset, outcome_arr, num) {
    result <- state_subset[, 2][order(outcome_arr, state_subset[, 2])[num]]
    return(result)
}
