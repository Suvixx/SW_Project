#data loading
data <- read.csv("D:/PhD/wasp-sw/sw.csv", sep = ",")

split = function(k,data){
  size <- floor(k*(nrow(data)))
  set.seed(123)
  train_index <- (sample(seq_len(nrow(data)), size = size))
  return(train_index)}

index <- split(0.8,data)
train_data <- data[index,]
test_data <- data[-index,]

#factoring
y <- as.factor(train_data$Dress_Class)
y_test <- as.factor(test_data$Dress_Class)

#multiclass SVM Classification
library(e1071)
svm_untuned <- svm(train_data$Temperature, y, probability = TRUE)
pred_prob <- predict(svm_untuned, test_data$Temperature, decision.values
= TRUE, probability = TRUE)

pred_prob <- as.data.frame(pred_prob)
y_test <- as.data.frame(y_test)
#confusion matrix function
confusion = function(pred_prob,y_test){
   conf <- matrix(data = rep(0,25), nrow = 5, ncol = 5)
   rownames(conf) <- c(0,1,2,3,4)
   colnames(conf) <- c(0,1,2,3,4)
   for(i in 1:nrow(pred_prob))
   {
     if(identical(pred_prob[i,1], y_test[i,1]) == TRUE)
     {conf[pred_prob[i,1],pred_prob[i,1]] <-
conf[pred_prob[i,1],pred_prob[i,1]] + 1}
     else
       conf[pred_prob[i,1],y_test[i,1]] <-
conf[pred_prob[i,1],y_test[i,1]] + 1
   }
   return(conf)
}
confusion_matrix <- confusion(pred_prob = pred_prob, y_test = y_test)
