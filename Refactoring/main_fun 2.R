#data loading
data <- read.csv("D:/PhD/wasp-sw/sw.csv", sep = ",")

#training and testing split
#Introduce abstraction by writing a function for the split
split = function(k,data){
  size <- floor(k*(nrow(data)))
  set.seed(123)
  train_index <- (sample(seq_len(nrow(data)), size = size))
  return(train_index)}

index <- split(0.8,data)
train_data <- data[index,]
test_data <- data[-index,]


size <- floor(0.7*(nrow(data)))
set.seed(123)
train_index <- (sample(seq_len(nrow(data)), size = size))
train_data <- data[train_index,]
test_data <- data[-train_index,]

#factoring
y <- as.factor(train_data$Dress_Class)
y_test <- as.factor(test_data$Dress_Class)

#multi-class svm classification
# Refactoring type: Replace code with library use (by using library e1071)
library(e1071)
# Refactoring type: Rename variable (by changing model_dc1 to svm_untuned)
svm_untuned <- svm(train_data$Temperature, y, probability = TRUE)
pred_prob <- predict(svm_untuned, test_data$Temperature, decision.values = TRUE, probability = TRUE)
result <- attr(pred_prob, "probabilities")
result_df <- as.data.frame(result)
write.csv(result_df, "~/Desktop/wasp/result1.csv", sep = ",")
pred_prob_n <- predict(svm_untuned, test_data$Temperature, decision.values = FALSE, probability = FALSE)
pred_prob_n <- as.data.frame(pred_prob_n)
pred_prob_n <- as.factor(pred_prob_n)
#View(pred_prob_n)

#Refactoring by introducing abstraction through writing function for confusionmatrix
#confusion matrix function
confusion = function(pred_prob,y_test){
conf <- matrix(data = rep(0,25), nrow = 5, ncol = 5)
rownames(conf) <- c(0,1,2,3,4)
colnames(conf) <- c(0,1,2,3,4)
for(i in 1:nrow(pred_prob))
{
  if(identical(pred_prob[i,1], y_test[i,1]) == TRUE)
  {conf[pred_prob[i,1],pred_prob[i,1]] <- conf[pred_prob[i,1],pred_prob[i,1]] + 1}
  else
    conf[pred_prob[i,1],y_test[i,1]] <- conf[pred_prob[i,1],y_test[i,1]] + 1
}
return(conf)
}
confusion_matrix <- confusion(pred_prob = pred_prob, y_test = y_test)




library(caret)
confusionMatrix(y_test, pred_prob)

#tune for better accuracy <0.9833
#refactoring the svm model for extracting (magic) constant, literal
svm_tune <- tune(svm, train.x=train_data$Temperature, train.y=y, 
                 kernel="radial", ranges=list(cost=10^(-1:3), gamma=c(.5,1,2,3)))

#substitute algorithm
svm_model_after_tune <- svm(train_data$Temperature,y, cost=100, gamma=0.5, probability = TRUE)
summary(svm_model_after_tune)

pred <- predict(svm_model_after_tune, test_data$Temperature, decision.values = TRUE, probability = TRUE)

confusionMatrix(y_test, pred)

#Combine functions into transform
fun <- function() {
  Temp <- readline("Enter a temperature: ")
  Temp <- as.integer(Temp)
  #Introduce assertion
  if(Temp >= -30 ){
    if(Temp <= 30){
      predt <- predict(svm_model_after_tune, Temp, decision.values = FALSE, probability = FALSE)
      cat(as.integer(predt[[1]]) - 1)
    }
    else
      print("Not in the range")
  }
  else
    print("Not in the range")
}

if(interactive()) fun()