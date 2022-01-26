#####################################################################################################################################################################################
# merge datasets by row name
# input 2 datasets (columns/lists of genes) and match them up by row name. Length of the second list can be shorter and in the case where there is no match to a gene/entry, input NA.
# top of the column of genes must be labelled with 'Gene_id' in this case
#####################################################################################################################################################################################

# libraries
library(dplyr)
library(tidyr)

# /home/cathal_king/Desktop/merge_test.txt
# datasets

df1 <- read.table("/home/cathal_king/Desktop/main_genes_TBI.txt", header = T)
df2 <- read.table("/home/cathal_king/Desktop/genes_down_WEKA_TBI.txt", header = T)

df3 <- df1 %>% mutate(Gene_id_2 = ifelse(Gene_id %in% df2$Gene_id, as.character(Gene_id), NA)) #as.character in case you deal with factors

write.table(df3, file = "matched_genes_DOWN_TBI.txt", sep = "\t", row.names = F)

#i1 <- df1$Gene_id %in% df2$Gene_id
#df1$newGene_id[i1] <- df1$Gene_id[i1]
