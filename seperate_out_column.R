#################################################################################################################################################
# If a column contains more than 1 identifier/entry per cell (e.g. geneID, proteinID etc.) then the data can be partitioned into seperate columns.
# Example - Below the column contains "GeneID|ProteinID" all in 1 column and the desired output is "GeneID" by itself in a new column.
# use regex to make the pattern
#################################################################################################################################################

library(tidyr)
library(tidyverse)

df2 <- read.csv("/home/cathal_king/Desktop/Supplemental_Material_2.csv", header = TRUE, fill = TRUE)

# seperate_rows will keep them in all the same column listed underneath each other
#df2 %>% separate_rows(UniqueID, convert = F)

my.regex <- "([a-zA-Z0-9]+)|"
# add this next line to my.regex if there is a second id to the right of gene name
#([a-zA-Z0-9]+)

# extract
df3 <- df2 %>% extract(X, into = c("gene"), regex = my.regex, remove = F)

# write out the new dataframe
write.csv(df3, file = "/home/cathal_king/Desktop/Supplemental_Material_2_edited.csv", sep = ",", row.names = F)
