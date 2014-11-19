GetTrain <- function() {
  # Downloads competition training data from Kaggle.
  #
  # Args:
  #   null
  #
  # Returns:
  #   Training set data.
  col.classes <- c("character", "integer", "integer", rep("character", 20))
  # read training data
  ans <- read.csv(gzfile("data/train.gz"), colClasses = col.classes)
  # save to data directory
  save(ans, file = "data/train.RData")
  return(ans)
}