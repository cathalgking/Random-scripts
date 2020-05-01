### Volcano Plot construction with the package EnhancedVolcano

# call the package
library(EnhancedVolcano)
# import the dataset
res <- read.csv("/home/cathal_king/Downloads/df.txt", header=TRUE, sep = '\t')

# The EnhancedVolcano package expects a dataset containing p-value, log fold change and the genes/identifiers of interest. 
# If you are importing data that already has been converted to -log10, for example perseus data, they can be converted back to p-value with the folowing line of code. 
res$pvalue <- 1/10^(res$X.Log.P.value.)

# Generate the plot. x and y arguments refer to the columns in the dataset that contain the log fold change and p-values.
# Customise as needed according to the vignette found at https://www.bioconductor.org/packages/release/bioc/vignettes/EnhancedVolcano/inst/doc/EnhancedVolcano.html
EnhancedVolcano(res,
                lab = rownames(res),
                x = 'Difference',
                y = 'pvalue',
                xlim = c(-6000000, 6000000),
                ylim = c(0,4),
                title = "Volcano Plot L,M,N VS O,P,Q,R.txt",
                pCutoff = 0.05,
                FCcutoff = 10117,
                pointSize = 4,
                legendPosition = 'right',
                hlineType = 'longdash')

# col = c('black', 'orange', 'blue', 'red'),
#  colAlpha = 4/10,



# write.table(res, file = "/home/cathal_king/Desktop/resultsAN,BR.txt", sep = "\t", row.names = F)
