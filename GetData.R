GetTrain <- function() {
  # Imports competition training data downloaded from Kaggle.
  #
  # Args:
  #   null
  #
  # Returns:
  #   Training set data.
  col.classes <- c("character", "integer", "integer", rep("factor", 20))
  # read training data
  ans <- read.csv(gzfile("data/train.gz"), colClasses = col.classes, 
                  nrows = 100000)
  # save to data directory
  save(ans, file = "data/train.RData")
  return(ans)
}