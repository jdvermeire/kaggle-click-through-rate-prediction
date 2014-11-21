test <- read.csv("data/test.csv", colClasses = "character")[, "id"]
all4.baseline <- cbind(id = test, click = rep(0.4, length(test)))
write.csv(all4.baseline, file = "data/all4.baseline.csv", row.names = FALSE)
rm(list = c("all4.baseline", "test"))
