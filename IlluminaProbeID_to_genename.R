## Convert a list of illumina probes to gene names/symbols

# load the illumina probe library for mouse. Change for whatever species in question. 
library(illuminaMousev2.db)

# read in probe ID list to convert
probes <- read.table("/home/cathal_king/Desktop/illumina_probes.txt", header = F, stringsAsFactors = F)

probes <- probes[[1]]

df <- data.frame(Gene=unlist(mget(x = probes,envir = illuminaMousev2SYMBOLREANNOTATED)))

# will output a 2 column dataset containing the probeID and corresponding gene name
write.table(df, file = "probe_conversion.txt", sep = "\t", row.names = T)

