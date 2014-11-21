GetTrain <- function() {
  # Imports competition training data downloaded from Kaggle.
  #
  # Args:
  #   null
  #
  # Returns:
  #   Training set data.
  col.classes <- c("character", "integer", "integer", rep("factor", 20))
  # read training data in batches
  batch.size <- 100000
  iter <- 0
  continue <- 1
  while (continue == 1) {
    ans <- read.csv(gzfile("data/train.gz"), colClasses = col.classes,
                    nrows = batch.size, skip = iter * batch.size)
    # save batch as RData file
    save(ans, file = paste0("data/train", iter, ".RData"))
    # check number of rows returned
    if (nrow(ans) < batch.size) {
      continue <- 0
    }
    # update iteration
    iter <- iter + 1
  }
  # load first batch set
  ans <- load("data/train0.RData")
  return(ans)
}