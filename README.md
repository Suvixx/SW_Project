# SW_Project
This repository will have all the files related to the WASP AS software engineering project.

The aim of this project is to build a recommendation system which will recommend a set of clothes to wear accoridng to the outside temperature.

This is a simple multi-class classification task where the features is temperature and the class label is dress_class. We divided the temperatures into five different classes. They are following:
* Class 0 <- Shorts, Half Sleeves T-shirt, Hat, Shoes (Temperature group = >= 20 degree celsius)
* Class 1 <- Trouser, Sweater, Socks, Cap, Shoes (Temperature Group = 10-19 degree celsius)
* Class 2 <- Trouser, Sweater, Socks, Woolen Cap, Shoes, Wind-Cheater, Gloves (Temperature group = 0-9 degree celsius)
* Class 3 <- Trouser, Sweater, Socks, Woolen Cap, Snow-Boots, Jacket, Gloves, Neck-cover, Winter-Pants (Temperature group = -10-1 degree celsius)
* Class 4 <- Trouser, Sweater, Socks, Woolen Cap, Snow-Boots, Jacket, Gloves, Neck-cover, Winter-Pants, Muffler, Balaclava-helmet (Temperature group = <=-11 degree celsius)

We wrote the entire code using R programming language. The Packages we used are following:
* e1071 (for implementing SVM classifier)
* caret (for calculating accuracy and model statistics)
* utils (for reading and writing different files. Generally one do not need to call this library explicitly. It comes automatically into action when one initiated a .R file)


**Work-Flow**
* First download and install [Rstudio](https://rstudio-education.github.io/hopr/starting.html).
* clone the [SW_Project repository](https://github.com/Suvixx/SW_Project).
* Run the file [main_fun 2.R](https://github.com/Suvixx/SW_Project/blob/main/main_fun%202.R).
* At the console type: <if(interactive()) fun()>
* Put your temperature
* **#HAVE FUN DRESSING**
