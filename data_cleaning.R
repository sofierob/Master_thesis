library('caret')


var <- varImp(model.rf.final.fulldata.LL, scale = FALSE)

var

var2 <- var$importance

var2 |> 
  rownames_to_column("myRows") %>%
  filter(grepl("ATPase.ratio",myRows))


var2 |> 
  rownames_to_column("myRows") %>%
  filter(grepl("ENSSSAG00000051689",myRows))



# Extract variable importance data from random forest model
varimp_data <- data.frame(feature = row.names(varImp(model.rf.final.fulldata.LL$finalModel)),
                          importance = varImp(model.rf.final.fulldata.LL$finalModel)[, 1])

# Sort the data by importance
varimp_data <- varimp_data[order(-varimp_data$importance), ]

# Reorder the feature names based on importance
varimp_data$feature <- factor(varimp_data$feature, levels = varimp_data$feature[order(varimp_data$importance)])

# Select the top 10 features
varimp_data_top10 <- varimp_data[1:10, ]

varimp_data_top10
varimp_data_top50 <- varimp_data[1:50, ]

saveRDS(varimp_data_top50, file = '~/Desktop/orion_data/LD_reg/var_imp_LD_top50.RDS')

genes <- c("ZG16*", "CFTR", "ATP1A3*", "ST6GALNAC3*", "cysteine-rich venom protein TEL1*", "NLRC3*", "RTN2A", "DNA-(apurinic or apyrimidinic site) lyase 2*", "KIF6", "CABP1") 

varimp_data_top10$gene_name <- genes 

varimp_data_top10$gene_name <- reorder(varimp_data_top10$gene_name, varimp_data_top10$importance)

varimp_data_top50

# Create a feature plot with top 10 features
library(ggplot2)
ggplot(varimp_data_top10, aes(x = gene_name, y = importance)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  xlab("Feature") +
  ylab("Importance") +
  theme_light() +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))  # Rotates x-axis labels for better readability
