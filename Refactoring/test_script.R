#random test data generation
temperature <- data.frame(temp = floor(runif(300, min=-30, max=30)))
#corresponding label generation
dress_class <- data.frame(dress_class = rep(0,nrow(temperature)))

#Refactoring type: Consolidate Conditional Expressions
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

#test
pred <- predict(svm_model_after_tune, temperature, decision.values = TRUE, probability = TRUE)
library(caret)
confusionMatrix(dress_class, pred)