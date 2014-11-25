SigmoidInv <- function(x) {
  # Computes the inverse sigmoid
  #
  # Args:
  #   x: Input values.
  #
  # Returns:
  #   Value(s) with the inverse sigmoid applied
  return(-log(1 / x - 1))
}