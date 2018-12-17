library(sigmoid)

data<- read.csv("4_1_data.csv")
plot(data$score.1, data$score.2, col = as.factor(data$label), xlab = "Score-1", ylab = "Score-2")
data_clean <- subset(data, select = c(score.1, score.2))
data_clean <- cbind(initial = 1, data_clean)

dfProb <- 0
for(i in 1:nrow(data_clean)){
  res <- Sigmoid(t(as.numeric(data_clean[i,])) %*% parameters)
  dfProb <- rbind(dfProb, res)
}
dfProb

#La primera linea de este dataframe no tiene info
dfProb <- as.data.frame(dfProb)
dfProb <- dfProb[-1,]

#Dataframe original + las probabilidades
data_complete <- cbind(data, prob = dfProb)
View(data_complete)
table(data_complete$label, ifelse(data_complete$prob > 0.68, 1, 0))
