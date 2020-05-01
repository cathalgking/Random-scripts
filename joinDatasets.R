# join datasets

# dplyr & tidyr
library(dplyr)
library(tidyr)

# read in all datasets
table1 <- read.table("/home/cathal_king/Desktop/Aoifes_datasets/Dataset1_Aoife.txt", header = TRUE, fill = TRUE)
table2 <- read.table("/home/cathal_king/Desktop/Aoifes_datasets/Dataset2_Aoife.txt", header = TRUE, fill = TRUE)
table3 <- read.table("/home/cathal_king/Desktop/Aoifes_datasets/Dataset3_Aoife.txt", header = TRUE, fill = TRUE)
table4 <- read.table("/home/cathal_king/Desktop/Aoifes_datasets/Dataset4_Aoife.txt", header = TRUE, fill = TRUE)
table5 <- read.table("/home/cathal_king/Desktop/Aoifes_datasets/Padhraic_dataset_above1.tsv", header = TRUE, fill = TRUE)

# full join6 and full join 7 below are normally not needed. They are only here now as there was a problem merging some datasets all together and they were done seperately in full join 8.
full_join6 <- full_join(table1, table2, table3, by = "Gene_id") %>% 
  gather(sample_id, expression, -Gene_id) %>% group_by(Gene_id, sample_id) %>% 
  summarize(median_expression = median(expression, na.rm = T)) %>% spread(sample_id, median_expression)

full_join7 <- full_join(table4, table5, by = "Gene_id") %>% gather(sample_id, expression, -Gene_id) %>% 
  group_by(Gene_id, sample_id) %>% summarize(median_expression = median(expression, na.rm = T)) %>% spread(sample_id, median_expression)


# now the complete join
full_join8 <- full_join(full_join6, full_join7, by = "Gene_id") %>% 
  gather(sample_id, expression, -Gene_id) %>% 
  group_by(Gene_id, sample_id) %>% 
  summarize(median_expression = median(expression, na.rm = T)) %>% 
  spread(sample_id, median_expression)

# write out to new file 
write.table(full_join8, file = "ALL2_table.txt", sep = "\t", row.names = F)

