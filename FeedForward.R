FeedForward <- function(input, theta, activation = function(x) {x}, 
                        add.bias = TRUE) {
  # Computes the output of one neural network layer.
  #
  # Agrs:
  #   input: A matrix of input values (n x m).
  #   theta: A matrix of weights (n[ + 1] x p).
  #   activation: An activation function (i.e. sigmoid).
  #   add.bias: Adds bias term if true.
  #
  # Returns:
  #   A matrix of output values for the current layer.
  
  # TODO(jdvermeire): create error handling process.  Check for matrices and
  #                   conformability.
  # set epsilon to prevent gradient issues
  epsilon <- 0.000000001
  # add bias term
  a <- if (add.bias) {
    AddBias(input)
  } else {
    input
  }
  ans <- pmax(pmin(activation(crossprod(theta, a)), 1 - epsilon), epsilon)
}