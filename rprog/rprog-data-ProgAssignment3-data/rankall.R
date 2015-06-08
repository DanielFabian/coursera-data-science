rankall <- function(outcome, num = "best") {
  outcomeColIdx = c("heart attack" = 11, "heart failure" = 17, "pneumonia" = 23)[outcome]
  if(is.na(outcomeColIdx)) {
    stop("invalid outcome")
  }
  
  outcomes <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  states <- sort(unique(outcomes$State))
  
  outcomes[, outcomeColIdx] <- as.numeric(outcomes[, outcomeColIdx])
  
  outcomes <- outcomes[order(outcomes$State, outcomes[, outcomeColIdx], outcomes[, "Hospital.Name"], na.last = NA), ]
  
  outcomes <- t(sapply(states, function(state) {
    hospitalNames <- outcomes[outcomes$State == state, "Hospital.Name"]
    
    if(num == "best") {
      return(c(hospital = hospitalNames[1], state = state))
    }
    if(num == "worst") {
      return(c(hospital = hospitalNames[length(hospitalNames)], state = state))
    }
    
    c(hospital = hospitalNames[num], state = state)
  }))
  
  data.frame(outcomes,
             row.names = outcomes[, "state"])
}