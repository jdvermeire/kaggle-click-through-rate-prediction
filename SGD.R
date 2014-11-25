SGD <- function(theta, gradient, alpha = 0.01) {
  # Updates a vector of weights (theta) via stochastic gradient descent for
  # a given gradient.
  #
  # Args:
  #   theta: A vector of weights to be updated.
  #   gradient: The calculated gradient
  #   alpha: The step parameter
  #
  # Returns:
  #   The updated theta vector of weights
  theta - alpha * gradient
}