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

# columns
# feature columns
feature.cols <- c("hour", "C1", "banner_pos", "site_id", "site_domain", 
                  "site_category", "app_id", "app_domain", "app_category",
                  "device_model", "device_type", "device_conn_type", "C14", 
                  "C15", "C16", "C17", "C18", "C19", "C20", "C21")
id.col <- "id"  # id column
y.col <- "click"  # observation column