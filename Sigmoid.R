Sigmoid <- function(x) {
  # Computes the logistic (sigmoid) function of a vector or matrix (x).
  #
  # Args:
  #   x: A vector or matrix of values.
  #
  # Returns:
  #   The computed sigmoid for all values of x.
  1 / (1 + exp(-x))
}