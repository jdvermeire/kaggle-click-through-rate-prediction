FeedForward <- function(input, theta, activation = function(x) {x}, 
                        add.bias = TRUE, use.dropout = FALSE, 
                        dropout.fact = 0.1) {
  # Computes the output of one neural network layer.
  #
  # Agrs:
  #   input: A matrix of input values (n x m).
  #   theta: A matrix of weights (n[ + 1] x p).
  #   activation: An activation function (i.e. sigmoid).
  #   add.bias: Adds bias term if true.
  #   use.dropout: Uses random dropout against theta.
  #   dropout.fact: Random dropout factor (probability of dropout)
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
  # random dropout
  b <- if (use.dropout) {
    theta * matrix(as.numeric(runif(prod(dim(theta)), 0, 1) > dropout.fact), 
                   nrow = dim(theta)[1], ncol = dim(theta)[2])
  } else {
    theta
  }
  ans <- pmax(pmin(activation(crossprod(b, a)), 1 - epsilon), epsilon)
}