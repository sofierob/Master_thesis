
# Rename variables from 'LL' to '24:0'
data$light.treatment[data$light.treatment == 'LL'] <- '24:0'



#boxplot for june sampling weight

juneweight <- ggplot(data, aes(x = factor(light.treatment, level= c('8_16', '12_12', '24:0')) , y = `June.sampling.weight(g)`, fill = light.treatment)) +
  geom_boxplot() +
  xlab("Light treatment") +
  ylab("Weight (g)") +
  scale_fill_brewer() +
  theme_light() +
  guides(colour = "None") +
  scale_fill_brewer(name = "Light treatment", labels = c("8:16", "12:12", "24:0"))



#boxplot for growth in SW

box_growth <- ggplot(data, aes(x = factor(light.treatment, level= c('8_16', '12_12', '24:0')) ,y=growth, fill = light.treatment)) +
                       geom_boxplot() +
                       scale_fill_brewer() +
                       xlab("Light treatment") +
                       ylab("Growth(g)") +
                       scale_fill_brewer() +
                       theme_light() +
                       guides(colour = "None") +
                       scale_fill_brewer(name = "Light treatment", labels = c("8:16", "12:12", "24:0"))
              
              
  #combine the two plots            
 ggarrange(juneweight, box_growth, common.legend = TRUE, legend = "bottom", labels = (c("A", "B")))
