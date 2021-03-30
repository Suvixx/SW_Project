#data loading
data <- read.csv("D:/PhD/wasp-sw/sw.csv", sep = ",")

size <- floor(0.7*(nrow(data)))
set.seed(123)
train_index <- (sample(seq_len(nrow(data)), size = size))
train_data <- data[train_index,]
test_data <- data[-train_index,]