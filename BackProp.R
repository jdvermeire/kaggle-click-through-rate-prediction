BackProp <- function(theta, output, target, input, alpha = 0.01,
                     error = target - output, act.grad = function(x) {1}) {
  # Performs backpropagation on a nn layer.
  #
  # Args:
  #   theta: A matrix of weights to update.
  #   output: The output of the current nn layer.
  #   target: The expected output of the current nn layer.
  #   input: The output of the prior nn layer.
  #   alpha: The learning rate parameter.
  #   error: The computed error for the current layer.
  #   act.grad: A function that computes the gradient of the activation 
  #             function.
  #
  # Returns:
  #   A list containing the propagated error and updated theta matrix.

  # TODO(jdvermeire): create error handling process.  Check for matrices and
  #                   conformability.
  # TODO(jdvermeire): add parameter and process to account for bias term.
  
  err <- act.grad(output) * error  # compute the error
  theta.new <- theta + alpha * tcrossprod(input, err)  # get new theta
  ans <- list(error = err, theta = theta.new)  # create answer list
  return(ans)
}