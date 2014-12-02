# A test script

# source files
source("GetData.R")
source("LogLoss.R")
source("Sigmoid.R")
source("FeedForward.R")
source("BackProp.R")
source("AddBias.R")
source("LogLoss.R")
source("Settings.R")

# define settings
n.features <- length(feature.cols)  # number of features
n.dims <- 2  # number of dims per feature
n.layers <- 1  # number of hidden layers
n.nodes <- n.features * n.dims  # number of nodes per hidden layer
n.input <- n.features * n.dims  # number of input nodes
n.batch <- 10000  # number of observations per batch
n.batches <- 500  # number of batches to iterate through
alpha <- 0.000001  # initial learning rate

# create layers list
layers <- list()

# init theta for all hidden layers
for (i in 1:n.layers) {
  i.input <- if (i == 1) {n.input} else {n.nodes}
  i.input <- i.input + 1
  i.output <- n.nodes
  layers[[i]] <- list(theta = matrix(runif(prod(i.input, i.output), -1, 1),
                                     ncol = i.output, nrow = i.input))
}
# init theta for output layer
layers[[n.layers + 1]] <- list(theta = matrix(runif(n.nodes + 1, -1, 1), 
                                              ncol = 1, nrow = n.nodes + 1))
# vector of back prop matrices to update
back.prop <- c("error", "theta", "prop")

# init input matrix
input <- matrix(rep(0, n.input), ncol = 1, nrow = n.input)

# create list to hold feature info
features <- list()

# # populate feature list with initial values for each feature
# for (feature.name in feature.cols) {
#   features[[feature.name]] <- data.frame(key = character(), 
#                                          matrix(numeric(), ncol = n.dims,
#                                                 nrow = 0))
# }

# init y vectors
all.y <- all.y.hat <- all.y.error <- NULL

# iterate through batches
for(h in 1:n.batches) {
  
  # load data from training
  train <- GetTrain(n.batch, (h - 1) * n.batch + 1)
  n.obs <- dim(train)[1]  # number of current observations
  
  # update hour to drop date and convert to factor
  train$hour <- substr(as.character(train$hour), 7, 8)
  
  # separate out variables from train
  train.id <- train$id
  train.y <- train$click
  train.x <- train[, c(-1, -2, -12, -13)]
 
  # init y.hat and y.hat.error
  train.y.hat <- train.y.error <- NULL
  
  # run through each observation in current batch
  for (i in 1:n.obs) {
    x <- train.x[i, ]  # current x
    y <- train.y[i]  # current y
    
    # iterate through each feature to get values or add new features
    #    for (j in 1:n.features) {
    #      fact <- x[, j]
    #      input[((j - 1) * n.dims + 1):(j * n.dims), 1] <- as.matrix(
    #        if (fact %in% features[[j]]$key) {
    #          features[[j]][features[[j]]$key == fact, -1]
    #        } else {
    #          rndm <- runif(n.dims, -1, 1)
    #          features[[j]] <- rbind(features[[j]], data.frame(key = fact, t(rndm)))
    #          rndm
    #        })
    #    }

    for (j in 1:n.features) {
      feat <- feature.cols[j]
      fact <- x[, feat]
      fact.vals <- features[[feat]][[fact]]
      if (is.null(fact.vals)) {
        fact.vals <- features[[feat]][[fact]] <- runif(n.dims, -1, 1)
      }
      input[((j - 1) * n.dims + 1):(j * n.dims), 1] <- as.matrix(fact.vals)
    }

    # feed forward through layers
    for (j in 1:(n.layers + 1)) {
      layer.input <- if (j == 1) {input} else {layers[[j - 1]]$output}
      layers[[j]]$output <- FeedForward(layer.input, layers[[j]]$theta,
                                        activation = Sigmoid, 
                                        use.dropout = TRUE, dropout.fact = 0.4)
    }
    
    # add current output to y.hat
    train.y.hat <- c(train.y.hat, layers[[n.layers + 1]]$output)
    
    # backpropagate error
    for (j in (n.layers + 1):1) {
      layer.error <- if (j == n.layers + 1) {
        y - layers[[j]]$output
      } else {
        layers[[j + 1]]$prop
      }
      
      layer.input <- if (j == 1) {
        input
      } else {
        layers[[j - 1]]$output
      }
      
      layers[[j]][back.prop] <- BackProp(layers[[j]]$theta, layers[[j]]$output,
                                         layer.error, layer.input, 
                                         alpha = alpha * runif(1),
                                         error = layer.error,
                                         act.grad = function(x) {
                                           x * (1 - x)
                                         })[back.prop]
    }
    
    # add error to error vector
    train.y.error <- c(train.y.error, LogLoss(train.y[1:j], train.y.hat))
    
    input <- input + alpha * layers[[1]]$prop  # update input layer
    # update feature values
    for (j in 1:n.features) {
      feat <- feature.cols[j]
      fact <- x[, feat]  # get current factor
      features[[feat]][[fact]] <- 
        input[((j - 1) * n.dims + 1):(j * n.dims), 1]
    }
    
  }
  print(LogLoss(train.y, train.y.hat))
  
  # add ys
  all.y <- c(all.y, train.y)
  all.y.hat <- c(all.y.hat, train.y.hat)
  all.y.error <- c(all.y.error, train.y.error)
}
LogLoss(all.y, all.y.hat)
plot(all.y.error)

