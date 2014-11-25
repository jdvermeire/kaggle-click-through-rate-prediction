FeedForward <- function(input, theta, activation = function(x) {x}) {
  # Computes the output of one neural network layer.
  #
  # Agrs:
  #   input: A matrix of input values.
  #   theta: A matrix of weights.
  #   activation: An activation function (i.e. sigmoid).
  #
  # Returns:
  #   A matrix of output values for the current layer.
  
  # TODO(jdvermeire): create error handling process.  Check for matrices and
  #                   conformability.
  # TODO(jdvermeire): add parameter and process to add bias term.
  
  activation(crossprod(theta, input))
}