# Settings and parameters for Avazu click through rate competition on Kaggle.

# Directory paths
path.data <- "data/"  # data directory

# Files
file.train <- function() {
  # Uses gzfile as a wrapper function to read the training file.
  gzfile(paste0(path.data, "train.gz"))
}
file.test <- function() {
  # Uses gzfile as a wrapper function to read the test file.
  gzfile(paste0(path.data, "test.gz"))
}