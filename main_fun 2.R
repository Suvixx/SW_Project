#data loading
data <- read.csv("D:/PhD/wasp-sw/sw.csv", sep = ",")

#training and testing split
size <- floor(0.7*(nrow(data)))
set.seed(123)
train_index <- (sample(seq_len(nrow(data)), size = size))
train_data <- data[train_index,]
test_data <- data[-train_index,]

#factoring
y <- as.factor(train_data$Dress_Class)
y_test <- as.factor(test_data$Dress_Class)

#multi-class svm classification
library(e1071)
model_dc1 <- svm(train_data$Temperature, y, probability = TRUE)
pred_prob <- predict(model_dc1, test_data$Temperature, decision.values = TRUE, probability = TRUE)
result <- attr(pred_prob, "probabilities")
result_df <- as.data.frame(result)
write.csv(result_df, "~/Desktop/wasp/result1.csv", sep = ",")
pred_prob_n <- predict(model_dc1, test_data$Temperature, decision.values = FALSE, probability = FALSE)
pred_prob_n <- as.data.frame(pred_prob_n)
pred_prob_n <- as.factor(pred_prob_n)
View(pred_prob_n)

library(caret)
confusionMatrix(y_test, pred_prob)

