# SW_Project
This repository will have all the files related to the WASP AS software engineering project.

The aim of this project is to build a recommendation system which will recommend a set of clothes to wear accoridng to the outside temperature.

This is a simple multi-class classification task where the features is temperature and the class label is dress_class. We divided the temperatures into five different classes. They are following:
* Class 0 <- Shorts, Half Sleeves T-shirt, Hat, Shoes (Temperature group = >= 20 degree celcius)
* Class 1 <- Trouser, Sweater, Socks, Cap, Shoes (Temperature Group = 10-19 degree celcius)
* Class 2 <- Trouser, Sweater, Socks, Woolen Cap, Shoes, Wind-Cheater, Gloves (Temperature group = 0-9 degree celcius)
* Class 3 <- Trouser, Sweater, Socks, Woolen Cap, Snow-Boots, Jacket, Gloves, Neck-cover, Winter-Pants (Temperature group = -10-1 degree celcius)
* Class 4 <- Trouser, Sweater, Socks, Woolen Cap, Snow-Boots, Jacket, Gloves, Neck-cover, Winter-Pants, Muffler, Balaclava-helmet (Temperature group = <=-11 degree celcius)
We wrote entire code using R programming language. The Packages we used are following:
* e1071
* caret
* utils
