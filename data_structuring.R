#Making a table from the raw data
exprt <- as.matrix(t(expr[,-1]))
exprt <-exprt + 1  
exprt <- log2(exprt) 
colnames(exprt) <- expr$Ensmbl.gene.ID
data <- exprt |> 
  as_tibble(exprt)
data <- data |> add_column(RNAseq_tag = rownames(exprt), .before = "ENSSSAG00000000040")


#Adding metadata
data <- data |> 
  left_join(meta, by = "RNAseq_tag")

#Making rownames
data <- as.data.frame(data)
rownames(data) <- data$RNAseq_tag

#choose metadata 
data <- data %>% 
  select(starts_with('ENS'),'November_sampling_weight(g)', 'June.sampling.weight(g)', 
  'June.sampling.smolt.status', 'light.treatment', 'November.sampling.status') 


#remove the zero expression genes
col_means <- colMeans(data[, 1:46944])     

cols_to_remove <- which(col_means <= 0)  #make a vector of cols to remove

data <- data[, -cols_to_remove]

data <- na.omit(data) #removing all NA values 


#create the response variable  

var1 <- c('November_sampling_weight(g)')
var2 <- c('June.sampling.weight(g)')

data <- data %>% 
  mutate(growth = cur_data()[[var1]] - cur_data()[[var2]]) 


#create NKA ratio
var1 <- c('ENSSSAG00000041746')
var2 <- c('ENSSSAG00000088099')

data_nka <- data_nka %>% 
  mutate(ATPase.ratio =cur_data()[[var1]] / cur_data()[[var2]])


#make three data sets
data_8_16 <- data |> 
  filter(light.treatment=="8_16")
  
data_12_12 <- data |> 
  filter(light.treatment=="8_12")
  
LL_data <- data |> 
  filter(light.treatment=="LL")  
  

  







