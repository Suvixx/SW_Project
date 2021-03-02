#test library load
library(testthat)

#data loading
data <- read.csv("D:/PhD/wasp-sw/sw.csv", sep = ",")

#training and testing split
size <- floor(0.7*(nrow(data)))
set.seed(123)
train_index <- (sample(seq_len(nrow(data)), size = size))
train_data <- data[train_index,]
test_data <- data[-train_index,]



#unit test of training testing split. 
#You can see that only when the value of k=0.7 there will be no error message
k <- 0.7
j <- expect_that(size, equals(floor(k*(nrow(data)))))
k <- 0.8
j <- expect_that(size, equals(floor(k*(nrow(data)))))
k <- 0.9
j <- expect_that(size, equals(floor(k*(nrow(data)))))



#factoring
y <- as.factor(train_data$Dress_Class)
y_test <- as.factor(test_data$Dress_Class)

#multi-class svm classification
library(e1071)
model_dc1 <- svm(train_data$Temperature, y, probability = TRUE)
pred_prob <- predict(model_dc1, test_data$Temperature, decision.values = TRUE, probability = TRUE)

#unit test to see whether the model is in "svm" class or not
expect_that(model_dc1, is_a("svm"))

result <- attr(pred_prob, "probabilities")
result_df <- as.data.frame(result)
write.csv(result_df, "~/Desktop/wasp/result1.csv", sep = ",")
pred_prob_n <- predict(model_dc1, test_data$Temperature, decision.values = FALSE, probability = FALSE)
pred_prob_n <- as.data.frame(pred_prob_n)
pred_prob_n <- as.factor(pred_prob_n)
View(pred_prob_n)

library(caret)
confusionMatrix(y_test, pred_prob)

#tune for better accuracy <0.9833
svm_tune <- tune(svm, train.x=train_data$Temperature, train.y=y, 
                 kernel="radial", ranges=list(cost=10^(-1:3), gamma=c(.5,1,2,3)))

svm_model_after_tune <- svm(train_data$Temperature,y, cost=100, gamma=0.5, probability = TRUE)
summary(svm_model_after_tune)

pred <- predict(svm_model_after_tune, test_data$Temperature, decision.values = TRUE, probability = TRUE)

confusionMatrix(y_test, pred)


fun <- function() {
  Temp <- readline("Enter a temperature: ")
  Temp <- as.integer(Temp)
  predt <- predict(svm_model_after_tune, Temp, decision.values = FALSE, probability = FALSE)
  cat(as.integer(predt[[1]]) - 1)
}
#if(interactive()) fun()