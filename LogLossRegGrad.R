LogLossRegGrad <- function(theta, x, y, hx = t(theta) %*% x, lambda = 0) {
  # Computes the regularized gradient of the logarithmic loss function.
  #
  # Args:
  #   theta: A vector (or row matrix) of weights.
  #   x: A feature vector or matrix.
  #   y: A vector of actual values.
  #   hx: The hypothesis (or predicted) vector of values.
  #   lambda: A regularization parameter.
  #
  # Returns:
  #   A delta vector for theta (weights).
}