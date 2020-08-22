# Recommender model

library(proxy)
library(recommenderlab)
library(reshape2)
library(dplyr)
movies2 <- read.csv("movies.csv", header = TRUE, stringsAsFactors=FALSE)
ratings <- read.csv("ratings.csv", header = TRUE)

#movie_recommendation <- function(select,select1,select2, rating1,rating2,rating3) {
movie_recommendation <- function(input1,input2,input3, input4,input5,input6) {
  row_num <- which(movies2[,2] == input1) # Locating the position/row of the first selected movie
  row_num2 <- which(movies2[,2] == input2) # Locating the position/row of the second selected movie
  row_num3 <- which(movies2[,2] == input3) # # Locating the position/row of the third selected movie
  
  userSelect <- matrix(NA,9724,611) # Creating a matrix of the same number of columns(movies) as we have in movies2
  userSelect[row_num] <- input4 # hard code first selection to rating 5 (assigning rating to the first movie selection)
  userSelect[row_num2] <- input5# hard code second selection to rating 4 (assigning rating to the second selected movie )
  userSelect[row_num3] <- input6 # hard code third selection to rating 3 (assigning rating to the third selected movie )
  userSelect <- t(userSelect) # t() transpose function, to make the rows of the assigned movies the same as the columns in order to conform to the ratingsmat
  
  ratingmat <- dcast(ratings, userId~movieId, value.var = "rating", na.rm=FALSE)
  ratingmat <- ratingmat[,-1] # remove userIds
  colnames(userSelect) <- colnames(ratingmat) # Making their colnames the same for convenient rbind
  ratingmat2 <- rbind(userSelect,ratingmat) # Combining the ratingmat dataset to the userSelect 
  ratingmat2 <- as.matrix(ratingmat2) # Converting "ratingmat2" to matrix to make it fit for the model
  
  #Convert rating matrix into a sparse matrix
  ratingmat2 <- as(ratingmat2, "realRatingMatrix") # Converting "ratingmat2" to "realRatingMatrix" object to make it fit for the model
  
  #Create Recommender Model. "UBCF" stands for user-based collaborative filtering
  recommender_model <- Recommender(ratingmat2, method = "UBCF",param=list(method="Cosine",nn=30))
  recom <- predict(recommender_model, ratingmat2[1], n=10) # ratingmat2[1], that means it should predict for the values in row 1 as the test data
  recom_list <- as(recom, "list") # Converting the predicted object "recom" to list for easy understanding
  
  # Creating matrix that will store the recommendation and converting to dataframe (You can omit the NA)
  recom_result <- data.frame(matrix(NA,10,3)) # Creating dataframe to store the predicted values
  for (i in c(1:10)){ # Looping through the predicted ratings in order to convert it to movies values
    recom_result[i,c(1:3)] <- movies2[as.integer(recom_list[[1]][i]),c(1:3)]
    
  }
  
  recom_result$movie
  colnames(recom_result) <- c("S/N","Recommended Movies for Your Purchase", "Genres")
  recom_result$movie_ID <- recom_result["S/N"]
  
  recom_result["S/N"] <- c(1:10) #'S/N'is representing the 'moviesId', which I changed to vector btw c(1:10)
  return(recom_result)
}


