library(tidyverse)

#importing data
cormat <- CorMatrix_after_feature_selection


#selecting growth
growthtcor <- cormat[, 'growth']

#structuring dataframe
growthcor <- as.data.frame(growthtcor)

growthcor$genes <- rownames(growthcor)
rownames(growthcor) <- 1:nrow(growthcor)

cor <- growthcor %>% 
  filter(genes != 'growth')



#function to find single gene with highest correlation
colMax <- function(data) sapply(data, max, na.rm = TRUE)

#gene with highest correlation
colMax(cor)  


# Finding correlation coefficients
CTRFgene <- cor %>% 
  filter(genes == 'ENSSSAG00000051689')

ATPase <- cor %>% 
  filter(genes == 'ATPase.ratio')

rsquared <- 0.04

R <- sqrt(rsquared)


#plotting 

ggplot(cor) +
  aes(x = growthtcor ) +
  geom_histogram(binwidth = 0.01, fill="steelblue", colour="black") +
  xlim(-0.3, 0.4) +
  
  labs(x = 'Correlation coefficients', y = 'Number of genes') +
  geom_vline(xintercept = 0.079, linetype =2, colour= "darkgrey") +
  #geom_vline(xintercept = 0., linetype =2, colour = "darkgrey" ) +
  geom_vline(xintercept = R, linetype = 2, colour = "darkgrey") +
  geom_vline(xintercept = 0.068, linetype = 2, colour = "red") +
  annotate('text', x = 0.079, y = 600, label = 'CFTR', size = 3) +
  #annotate('text', x = 0.163, y = 600, label= 'NKCC', size = 3) +
  annotate('text', x = R, y = 550, label = 'Rf.model', size = 3 ) +
  annotate('text', x = 0.0686, y = 400, label = 'NKA', size = 3, col = "red" ) +
  theme_light()



