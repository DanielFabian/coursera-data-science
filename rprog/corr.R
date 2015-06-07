corr <- function(directory, threshold = 0) {
  nobs <- complete(directory)
  id <- nobs[nobs$nobs > threshold, "id"]
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  if (length(id) == 0) {
    vector(mode = "numeric")
  }
  else {
    sapply(id, function(id) {
      fileData <- read.csv(sprintf("%s/%03d.csv", directory, id))
      fileData <- fileData[complete.cases(fileData), ]
      cor(fileData$sulfate, fileData$nitrate)
    })
    }
}