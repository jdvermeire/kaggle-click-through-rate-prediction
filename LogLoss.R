LogLoss <- function(actual, prediction) {
  # Computes the logarithmic loss between two vectors. 
  # Code was provided by Kaggle: https://www.kaggle.com/wiki/LogarithmicLoss
  # Accessed: 2014-11-18 16:40:00
  #
  # Args:
  #   actual: Vector of actual values.
  #   prediction: Vector of predicted values.
  #
  # Return:
  #   The logarithmic loss between the actual and prediction vectors.
  epsilon <- .000000000000001
  yhat <- pmin(pmax(prediction, epsilon), 1-epsilon)
  logloss <- -mean(actual*log(yhat)
                   + (1-actual)*log(1 - yhat))
  return(logloss)
}