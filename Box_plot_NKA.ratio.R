#load libraries
library('tidyverse')
library('ggfortify')
library(gridExtra)
library(cowplot)



#plotting
p <- ggplot(data, aes(x = factor(light.treatment, level= c('8_16', '12_12', '24:0')) , y = ATPase.ratio, fill = light.treatment)) +
  geom_boxplot() +
  xlab("Light treatment") +
  ylab("NKA ratio") +
  scale_fill_brewer() +
  theme_light()

p + guides(colour = "None") 
p + scale_fill_brewer(name = "Light treatment", labels = c("8:16", "12:12", "24:0"))

