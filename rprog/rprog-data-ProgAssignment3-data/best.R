rankHospitals <- function(state, outcome) {
    outcomeColIdx = c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)[outcome]
    if(is.na(outcomeColIdx)) {
      stop("invalid outcome")
    }
    
    outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    states <- unique(outcomes$State)
    if(!any(states == state)) {
      stop("invalid state")
    }
    
    outcomes <- outcomes[outcomes$State == state, ]
    outcomes[, outcomeColIdx] <- as.numeric(outcomes[, outcomeColIdx])
    
    outcomes[order(outcomes[, outcomeColIdx], outcomes[, "Hospital.Name"], na.last = NA), ]
}

best <- function(state, outcome) {
  rankHospitals(state, outcome)[1, "Hospital.Name"]
}
