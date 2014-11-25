GetTrain <- function(size = -1, start = 0) {
  # Imports competition training data downloaded from Kaggle.
  #
  # Args:
  #   size: The number of rows to retrieve. -1 indicates all rows.
  #   start: The row number to start reading.
  #
  # Returns:
  #   Training set data.
  col.classes <- c("character", "integer", "integer", rep("factor", 20))
  # read training data in batches
  ans <- read.csv(gzfile("data/train.gz"), colClasses = col.classes,
                  nrows = size, skip = start)
  return(ans)
}