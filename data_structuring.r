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

