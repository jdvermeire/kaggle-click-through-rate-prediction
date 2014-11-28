AddBias <- function(x) {
  # Adds bias term to matrix for nn layer
  #
  # Args:
  #   x: Numeric matrix to which bias will be added
  #
  # Returns:
  #   Updated x matrix with bias term (n + 1) x m
  rbind(rep(1, dim(x)[2]), x)
}