best <- function(state, outcome) {
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
  
  best <- which(outcomes[, outcomeColIdx] == min(outcomes[, outcomeColIdx], na.rm = T))
  outcomes <- outcomes[best, ]
  sort(outcomes[, "Hospital.Name"])[1]
}