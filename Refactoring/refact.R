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

#unit testing split function
library(testthat)
#k <- 0.6
#j <- expect_that(index, equals(split(k,data)))
#k <- 0.7
#j <- expect_that(index, equals(split(k,data)))
#k <- 0.8
#j <- expect_that(index, equals(split(k,data)))
#k <- 0.2765
#j <- expect_that(index, equals(split(k,data)))
value <- c(0.6,0.7,0.8,0.2765)
utsp = function(value){
  for(i in 1:length(value)){
    j <- expect_that(index, equals(split(value[i],data)))
    print(j)
  }
}


#factoring
y <- as.factor(train_data$Dress_Class)
y_test <- as.factor(test_data$Dress_Class)

#multiclass SVM Classification
library(e1071)
svm_untuned <- svm(train_data$Temperature, y, probability = TRUE)
pred_prob <- predict(svm_untuned, test_data$Temperature, decision.values
= TRUE, probability = TRUE)


library(caret)
confusionMatrix(y_test, pred_prob)


fun <- function() {
  Temp <- readline("Enter a temperature: ")
  Temp <- as.integer(Temp)
    #Introduce assertion
   if(Temp >= -30 ){
     if(Temp <= 30){
       predt <- predict(svm_model_after_tune, Temp, decision.values =
FALSE, probability = FALSE)
       cat(as.integer(predt[[1]]) - 1)
     }
     else
       print("Not in the range")
   }
   else
     print("Not in the range")
  
}
if(interactive()) fun()