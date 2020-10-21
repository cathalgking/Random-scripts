###########################################################################
## convert many gene ensembl id's (e.g. ENSMUSG00000000127) to gene symbols
###########################################################################

library(biomaRt)
library(org.Mm.eg.db)
library(AnnotationDbi)

df <- read.table("/home/cathal_king/Downloads/D12.txt", header = T)

# change species and download relevant library

# gives an extra column with gene info
df$name <- mapIds(org.Mm.eg.db,
                  keys = row.names(df),
                  column = "GENENAME",
                  keytype="ENSEMBL",
                  multiVals = "first")

# gives an extra column with gene symbol
df$symbol <- mapIds(org.Mm.eg.db,
                  keys = row.names(df),
                  column = "SYMBOL",
                  keytype="ENSEMBL",
                  multiVals = "first")

write.table(df, file = "DF12_converted.txt", sep = ",", row.names = F)
