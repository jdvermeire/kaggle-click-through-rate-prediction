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
train <- GetTrain(10, 0)

# update hour to drop date and convert to factor
train$hour <- as.factor(substr(as.character(train$hour), 7, 8))

