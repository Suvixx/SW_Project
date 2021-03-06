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
svm_tuned <- svm(train_data$Temperature, y, probability = TRUE)
predicted_probability <- predict(svm_tuned, test_data$Temperature, decision.values
= TRUE, probability = TRUE)

#unit test to see whether the model is in "svm" class or not


# Refactoring type: Replace commands with function (wrote a function for
unit testing)
unit_test_model <- function(model){
    	type <- c("lm", "svm")
	for(i in 1:length(type))
             print(expect_that(model, is_a(type[I])))
}
unit_test_model(model = svm_tuned)

library(caret)
confusionMatrix(y_test, pred_prob)


fun <- function() {
  Temp <- readline("Enter a temperature: ")
  Temp <- as.integer(Temp)
    #Introduce assertion
   if(Temp >= -30 ){
     if(Temp <= 30){
       prediction  <- predict(svm_tuned, Temp, decision.values =
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


#random test data generation
test_data_generation = function(k){

   temperature <- data.frame(temp = floor(runif(k, min=-30, max=30)))
   #corresponding label generation
   dress_class <- data.frame(dress_class = rep(0,nrow(temperature)))

   for(i in 1:nrow(temperature))
   {
     if(temperature[i,1]>=20)
       dress_class[i,1] = 0
     if(temperature[i,1] <=19 && temperature[i,1] >= 10)
       dress_class[i,1] = 1
     if(temperature[i,1] >=0 && temperature[i,1] <= 9)
       dress_class[i,1] = 2
     if(temperature[i,1] >=-10 && temperature[i,1] <= -1)
       dress_class[i,1] = 3
     if(temperature[i,1]<=-11)
       dress_class[i,1] = 4
   }

   dress_class <- as.factor(dress_class$dress_class)
   rand_data <- cbind(temperature,dress_class)
   return(rand_data)

}

#random test data generation
test_data_generation = function(k){

   temperature <- data.frame(temp = floor(runif(k, min=-30, max=30)))
   #corresponding label generation
   dress_class <- data.frame(dress_class = rep(0,nrow(temperature)))

   for(i in 1:nrow(temperature))
   {
     if(temperature[i,1]>=20)
       dress_class[i,1] = 0
     if(temperature[i,1] <=19 && temperature[i,1] >= 10)
       dress_class[i,1] = 1
     if(temperature[i,1] >=0 && temperature[i,1] <= 9)
       dress_class[i,1] = 2
     if(temperature[i,1] >=-10 && temperature[i,1] <= -1)
       dress_class[i,1] = 3
     if(temperature[i,1]<=-11)
       dress_class[i,1] = 4
   }

   dress_class <- as.factor(dress_class$dress_class)
   rand_data <- cbind(temperature,dress_class)
   return(rand_data)

}
