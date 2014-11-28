# A test script

# source files
source("GetData.R")
source("LogLoss.R")

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
layers[[1]] <- list(theta <- matrix(runif(n.nodes^2), ncol = n.nodes, 
                                    nrow = n.nodes),
                    error <- matrix(0, ncol = 1, nrow = n.nodes))

# output layer
layers[[2]] <- list()

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

