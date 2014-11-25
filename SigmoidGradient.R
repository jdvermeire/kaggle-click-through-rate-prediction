SigmoidGradient <- function(x) {
  # Computes the gradient of the sigmoid function.
  #
  # Args:
  #   x: The value for which to computed the gradient.
  #
  # Returns:
  #   The sigmoid gradient.
  s <- Sigmoid(x)
  ans <- s * (1 - s)
  return(ans)
}