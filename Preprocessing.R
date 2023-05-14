
#loading library
library('tidyverse')
library('yardstick')
library('randomForest')
library('caret')
#library(doParallel)

#cl <- makePSOCKcluster(12)
#registerDoParallel(cl)

#importing data
LL_data_final <- readRDS("~/R/Master/rf_regression_LL/LL_data/LL_data_final.RDS")


#removing NZV
feature_var <- nearZeroVar(rforest,                            
                           names = TRUE,
                           freqCut = 20,
                           uniqueCut = 40,
                           saveMetrics = TRUE)



rforest <-rforest[, feature_var$nzv=='FALSE'] 


#eliminating higly correlated data

corMatrix <- cor(subset(rforest, select = -c(growth, ENSSSAG00000051689, ATPase.ratio)))

highCor<- findCorrelation(corMatrix,cutoff = 0.35) 

rforest <- rforest[,-c(highCor)] 

#saving data for train
saveRDS(rforest, file = 'data_for_train_ATPase.RDS')

#correlation analysis from preprocessed data
CorMatrix_2 <- cor(rforest)






