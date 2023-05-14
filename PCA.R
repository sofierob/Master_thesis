library('ggfortify')
library('tidyverse')


LL_data_final <- readRDS("~/R/Master/rf_regression_LL/LL_data/LL_data_final.RDS")


PCAdata <- LL_data_final

PCAdata <- PCAdata %>% 
  select(starts_with("ENS"))  

dim(PCAdata) # check that number of individuals and genes makes sense

gene_to_keep <- apply(PCAdata, 2, var, na.rm = TRUE) # Check variance
table(gene_to_keep == 0, useNA = 'always') 
genes_to_keep_idx <- which(gene_to_keep != 0) #creating a vector of genes to keep
PCA <-PCAdata[,genes_to_keep_idx, ] 
PCA <-as.matrix(PCA)
pca_res <-prcomp(PCA, scale. = TRUE) #PCA analysis

#making PCAplot
LL_pca <- autoplot(pcares, data = LL_data_final , colour = 'June.sampling.smolt.status', 
                     alpha=0.5)


saveRDS(pca_res, file = 'pcares.RDS')
cat(' ferdig')
