#loading the packages
library(tidyverse)
library('caret')


# Extract variable importance data from random forest model
varimp_data <- data.frame(feature = row.names(varImp(model.rf.fulldata.12.12$finalModel)),
                          importance = varImp(model.rf.fulldata.12.12$finalModel)[, 1])

# Sort the data by importance
varimp_data <- varimp_data[order(-varimp_data$importance), ]

# Reorder the feature names based on importance
varimp_data$feature <- factor(varimp_data$feature, levels = varimp_data$feature[order(varimp_data$importance)])

# Select the top 10 features
varimp_data_top10 <- varimp_data[1:10, ]

# Select the top 50 features
varimp_data_top50 <- varimp_data[1:50, ]


genes <- c("transposase*", "zink finger protein*", "chordc1", "zink finger (SCAN) protein*", "GAS2L3*", "ZFAND4", "nrxn3b", "eosinophil peroxidase-like*", "TLR", "CFAP206")

varimp_data_top10$gene_name <- genes 

varimp_data_top10$gene_name <- reorder(varimp_data_top10$gene_name, varimp_data_top10$importance)



# Create a feature plot with top 10 features
library(ggplot2)
ggplot(varimp_data_top10, aes(x = gene_name, y = importance)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  xlab("Feature") +
  ylab("Importance") +
  theme_light() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))  # Rotates x-axis labels for better readability



# extracting variable importance data from ATPase.ratio and CFTR from random forest model

var <- varImp(model.rf.fulldata.12.12, scale = FALSE)

var2 <- var$importance

var2 |> 
  rownames_to_column("myRows") %>%
  filter(grepl("ATPase.ratio",myRows))


var2 |> 
  rownames_to_column("myRows") %>%
  filter(grepl("ENSSSAG00000051689",myRows))

