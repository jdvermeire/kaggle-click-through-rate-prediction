FeedForward <- function(input, theta, activation = function(x) {x}, 
                        add.bias = TRUE) {
  # Computes the output of one neural network layer.
  #
  # Agrs:
  #   input: A matrix of input values (n x m).
  #   theta: A matrix of weights (n[ + 1] x p).
  #   activation: An activation function (i.e. sigmoid).
  #
  # Returns:
  #   A matrix of output values for the current layer.
  
  # TODO(jdvermeire): create error handling process.  Check for matrices and
  #                   conformability.
  # add bias term
  a <- if (add.bias) {
    rbind(rep(1, dim(input)[2]), input)
  } else {
    input
  }
  activation(crossprod(theta, a))
}