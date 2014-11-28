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


# load data from training
train <- GetTrain(1000, 0)

# update hour to drop date and convert to factor
train$hour <- as.factor(substr(as.character(train$hour), 7, 8))

# separate our variables from train
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

# create layers list
layers <- list()

# init layers
layers[[1]] <- list(theta = matrix(runif(n.nodes^2 + n.nodes), ncol = n.nodes, 
                                    nrow = n.nodes + 1),
                    error = matrix(0, ncol = 1, nrow = n.nodes))

# output layer
layers[[2]] <- list(theta = matrix(runif(n.nodes + 1), ncol = 1,
                                   nrow = n.nodes + 1),
                    error = matrix(0, ncol = 1, nrow = n.nodes))

# get first observation
x <- train.x[1, ]

input <- matrix(rep(0, n.input), ncol = 1, nrow = n.input)

# iterate through each feature
for (i in 1:n.features) {
  fact <- x[, i]
  input[(i * n.dims - 1):(i * n.dims), 1] <- as.matrix(
    if (fact %in% features[[i]]$key) {
      features[[i]][features[[i]]$key == fact, -1]
    } else {
      rndm <- runif(n.dims)
      features[[i]] <- rbind(features[[i]], data.frame(key = fact, t(rndm)))
      rndm
    })
}

layers[[1]]$output <- FeedForward(input, layers[[1]]$theta, 
                                  activation = Sigmoid)
layers[[2]]$output <- FeedForward(layers[[1]]$output, layers[[2]]$theta,
                                  activation = Sigmoid)

layers[[2]][c("error", "theta", "prop")] <- BackProp(layers[[2]]$theta, 
                                            layers[[2]]$output, train.y[1],
                                            layers[[1]]$output,
                                            act.grad = function(x) {
                                              x * (1 - x)
                                            })[c("error", "theta", "prop")]
layers[[1]][c("error", "theta", "prop")] <- BackProp(layers[[1]]$theta,
                                            layers[[1]]$output, 
                                            layers[[2]]$prop,
                                            input,
                                            error = layers[[2]]$prop,
                                            act.grad = function(x) {
                                              x * (1 - x)
                                            })[c("error", "theta", "prop")]
input <- input + 0.01 * layers[[1]]$prop  #update input layer
