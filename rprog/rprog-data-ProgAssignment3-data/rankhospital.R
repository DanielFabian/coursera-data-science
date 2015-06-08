source("best.R")

rankhospital <- function(state, outcome, num = "best") {
  hospitalNames <- rankHospitals(state, outcome)[, "Hospital.Name"]
  
  if(num == "best") {
    return(hospitalNames[1])
  }
  if(num == "worst") {
    return(hospitalNames[length(hospitalNames)])
  }
  hospitalNames[num]
}