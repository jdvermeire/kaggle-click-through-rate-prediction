# A test script

# source files
source("GetData.R")
source("LogLoss.R")
source("Sigmoid.R")
source("FeedForward.R")
source("BackProp.R")
source("AddBias.R")

# define settings
n.features <- 22  # number of features
n.dims <- 2  # number of dims per feature
n.layers <- 1  # number of hidden layers
n.nodes <- n.features * n.dims  # number of nodes per hidden layer
n.input <- n.features * n.dims  # number of input nodes
n.batch <- 1000  # number of observations per batch
alpha <- 0.1  # learning rate

# create layers list
layers <- list()

# init theta for all hidden layers
for (i in 1:n.layers) {
  i.input <- if (i == 1) {n.input} else {n.nodes}
  i.input <- i.input + 1
  i.output <- n.nodes
  layers[[i]] <- list(theta = matrix(runif(crossprod(i.input, i.output)),
                                     ncol = i.output, nrow = i.input))
}
# init theta for output layer
layers[[n.layers + 1]] <- list(theta = matrix(runif(n.nodes + 1), ncol = 1,
                                              nrow = n.nodes + 1))
# vector of back prop matrices to update
back.prop <- c("error", "theta", "prop")

# init input matrix
input <- matrix(rep(0, n.input), ncol = 1, nrow = n.input)


# load data from training
train <- GetTrain(n.batch, 0)
n.obs <- dim(train)[1]  # number of current observations

# update hour to drop date and convert to factor
train$hour <- as.factor(substr(as.character(train$hour), 7, 8))

# separate out variables from train
train.id <- train$id
train.y <- train$click
train.x <- train[, -1:-2]

# create list to hold feature info
features <- list()

# populate feature list with initial values for each feature
for (feature.name in colnames(train.x)) {
  features[[feature.name]] <- data.frame(key = train.x[1, feature.name], 
                                                  t(runif(n.dims)))
}

# run through each observation in current batch
for (i in 1:n.obs) {
  x <- train.x[i, ]  # current x
  y <- train.y[i]  # current y

  # iterate through each feature to get values or add new features
  for (j in 1:n.features) {
    fact <- x[, j]
    input[(j * n.dims - 1):(j * n.dims), 1] <- as.matrix(
      if (fact %in% features[[j]]$key) {
        features[[j]][features[[j]]$key == fact, -1]
      } else {
        rndm <- runif(n.dims)
        features[[j]] <- rbind(features[[j]], data.frame(key = fact, t(rndm)))
        rndm
      })
  }
  
  # feed forward through layers
  for (j in 1:(n.layers + 1)) {
    layer.input <- if (j == 1) {input} else {layers[[j - 1]]$output}
    layers[[j]]$output <- FeedForward(layer.input, layers[[j]]$theta,
                                      activation = Sigmoid)
  }
  
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
                                       layer.error, layer.input, alpha = alpha,
                                       error = layer.error,
                                       act.grad = function(x) {
                                         x * (1 - x)
                                       })[back.prop]
  }
  
  input <- input + 0.01 * layers[[1]]$prop  # update input layer
  # update feature values
  for (j in 1:n.features) {
    fact <- x[, j]  # get current factor
    features[[j]][features[[j]]$key == fact, -1] <- input[(j * n.dims - 1):(j * n.dims), 1]
  }
  
}
