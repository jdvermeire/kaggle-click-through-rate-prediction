random.baseline <- cbind(id = as.character(test$id), click = runif(dim(test)[1]))
write.csv(random.baseline, file = "data/random.baseline.csv", row.names = FALSE)
rm(random.baseline)
