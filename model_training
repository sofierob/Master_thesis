library('tidyverse')
library('yardstick')
library('randomForest')
library('caret')
library(doParallel)

cl <- makePSOCKcluster(12)
registerDoParallel(cl)



#import data
data_for_train_ATPase <- readRDS("~/R/Master/rf_regression_LL/LL_data/data_for_train_ATPase.RDS")

rftrain <- data_for_train

#Cross validation, 10 folds
control <- trainControl(method="cv", number=10)


mtry_def <- floor(sqrt(ncol(rftrain))*0.80) #How many columns to select in each bootstrap sample?

#Gridsearch
t_grid <- expand.grid(.mtry = c(67, 500, 1000, 2000, 2500, 3000, 3500, 4000, 4500, 5000, 5500, 6000, 6500, 7037))

cat("kjører train")
set.seed(1234)
start <- proc.time() [3]
model.rf.final.fulldata <- train(growth ~.,
                   data = rftrain,
                   method = 'rf',
                   ntree = 1000,
                   tuneGrid = t_grid,
                   importance = TRUE,
                   trControl = control,
                   
)

end <- proc.time() [3]
print(paste("This took ", round(end-start,digits = 1), " seconds", sep = ""))
saveRDS(model.rf.final.fulldata, file = 'model.rf.final.fulldata.RDS')
cat("ferdig")

stopCluster(cl)
