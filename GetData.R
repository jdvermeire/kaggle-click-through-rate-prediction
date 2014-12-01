GetTrain <- function(size = -1, start = 1) {
  # Imports competition training data downloaded from Kaggle.
  #
  # Args:
  #   size: The number of rows to retrieve. -1 indicates all rows.
  #   start: The row number to start reading.
  #
  # Returns:
  #   Training set data.
  col.names <- c("id", "click", "hour", "C1", "banner_pos", "site_id", 
                 "site_domain", "site_category", "app_id", "app_domain",
                 "app_category", "device_id", "device_ip", "device_model",
                 "device_type", "device_conn_type", "C14", "C15", "C16", "C17",
                 "C18", "C19", "C20", "C21")
  col.classes <- c("character", "integer", "integer", rep("character", 20))
  # read training data in batches
  ans <- read.csv(gzfile("data/train.gz"), col.names = col.names,
                  colClasses = col.classes, nrows = size, skip = start)
  return(ans)
}