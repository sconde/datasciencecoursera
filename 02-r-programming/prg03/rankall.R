rankall <- function(outcome, num = "best") {
    # File: rankall.R
    # Author: Sidafa Conde
    # Email: sconde@umassd.edu
    # School: UMass Dartmouth
    # Date: 02/25/2017
    # Purpose: return a data frame containing the names of the hospitals that are the best in their respective states for 30-day heart attack death rates

    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")

    ## Validate the outcome string
    valid_outcomes = c("heart attack", "heart failure", "pneumonia")
    if (!( outcome %in% valid_outcomes )) stop("invalid outcome")

    state_arr <- sort(unique(data$State))
    arr_len <- length(state_arr)
    hospital <- rep("", arr_len)

    for(i in 1:arr_len) {
        # loop for each state
        hospital[i] <- rankhospital(state_arr[i], outcome, num)
    }

    # create the data frame to return
    df <- data.frame(hospital=hospital, state=state_arr)
    return(df)
}
