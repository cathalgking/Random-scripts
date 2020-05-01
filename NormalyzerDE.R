### NormalyzerDE ###

## Normalise a dataset which may be a combination of multiple datasets merged together, for example.

#load relevant libraries
library(NormalyzerDE)

# outDir should contain the PATH to where your output report and normalised matrices will be 
outDir <- ('/home/cathal/Desktop')

# The following line reads in the design matrix. In this example, my design matrix file (design_matrix1.csv) is in the folder "FYP_datasets" which is in my current working directory.
# Set your working directory with setwd() and check what it is with getwd()
designFp <- "/home/cathal_king/Downloads/ECM_design_tab.txt"

# Then read in your master dataset
dataFp <- "/home/cathal_king/Desktop/ECM_Data/ECM_master_matrix_noNaN.csv"

# Finally, call the NormalyzerDE command with the following line. You should then see it processing in the Console. 
# Add any other relevant Arguments to the commands by checking the package notes.
# jobName refers the folder name that will be created in the outDir.
NormalyzerDE::normalyzer(jobName="Cathals_ECMrun", designPath = designFp, dataPath = dataFp, outputDir=outDir)
# , noLogTransform = T, omitLowAbundSamples = T, sampleAbundThres = 110

## Notes ###
# Both your design and data matrices ideally should be tab seperated text files or Text CSV files. Comma seperated will not work.
# Calling the arguments designFp or dataFp in the console will not show a matrix. These arguments are designed to take file paths directly, rather than load data frames.
# Run "??NormalyzerDE" in the Console to explore some other useful arguments that the package provides and can be added to this script. 




    
