LogLossReg <- function(hx, y, theta = 0, lambda = 0, n.examples = length(y)) {
  # Computes the regularized logarithmic loss.
  #
  # Args:
  #   hx: A vector of the calculated hypothesis or predicted values for y.
  #   y: A vector of actual values.
  #   theta: A vector of weights.
  #   lambda: The regularization parameter.
  #   n.examples: The number of observed values.
  #
  # Returns:
  #   The computed loss as a numeric value.
  epsilon <- 0.000000000000001  # min value to prevent infinite loss
  y.hat <- pmin(pmax(hx, epsilon), 1 - epsilon)  # 0 < hx < 1
  ans <- lambda / 2 * crossprod(theta[-1]) / n.examples - mean(y * log(y.hat)
                                                    + (1 - y) * log(1 - y.hat))
  return(ans)
}