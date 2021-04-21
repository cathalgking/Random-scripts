#########################################################################################
## Read in image / object file(s) from CellProfiler output
## Pre-process the file using dplyr and tidyr packages
## Calculate mean, max and min values in columns
## Note: A pre-defined Vector of column names can be defined using a character vector c()
## Plot calculations in a stacked barplot using ggplot2
##########################################################################################

# load the relevant libraries required below
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggpubr)

# test df
df <- read.csv("/home/cathal_king/Desktop/testdf2.csv" , header = T)

# import a df (data-frame)
df <- read.csv("/home/cathal_king/Documents/R01_A01_test_df.csv" , header = T)

# View the df in a spreadsheet-like display
utils::View(df)

#vars <- c("ExecutionTime_11Rescale_YELLOW" , "ExecutionTime_12Rescale_GREEN")

## pivot_longer all your data columns
df2 <- df %>% pivot_longer(cols = everything())
# pivot longer columns with a certain pattern in their headers
# df12 <- df %>% pivot_longer(cols = starts_with("Int"))

## then group_by those values to get your summary values,  group_by your value columns,  calling the summarize function after your group_by
df3 <- df2 %>% group_by(name) %>% summarise_at(vars(everything()), list(mean=mean, max = max, min = min))

# view these values
utils::View(df3)

#df4 <- df2 %>% group_by(name) %>% summarise_at(vars(contains("Rescale")), list(mean=mean, max = max, min = min))

## reshape df for ggplot
df4 <- reshape2::melt(df3)


## plot
ggplot(df4, aes(fill = variable, y = name, x = value)) + geom_bar(position = "stack", stat = "identity") + 
  coord_flip()+theme_bw() + 
  theme(axis.text.x = element_text(angle = 90)) +
  scale_fill_brewer(palette = "Dark2")



# facet plot
ggplot(df4, aes(fill = variable, y = name, x = value)) + geom_bar(position = "stack", stat = "identity") + coord_flip()+theme_bw() + facet_wrap(~variable) +
  theme(axis.text.x = element_text(angle = 90)) +
  scale_fill_brewer(palette = "Dark2")


