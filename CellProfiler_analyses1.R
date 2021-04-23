#############################################################################################
## Read in image / object file(s) from CellProfiler output                                 ##
## Pre-process the file using dplyr and tidyr packages                                     ##
## Calculate mean, max and min values in columns                                           ##
## Note: A pre-defined Vector of column names can be defined using a character vector c()  ##
## Plot calculations in a stacked barplot using ggplot2                                    ##
#############################################################################################

# load the relevant libraries required below
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggpubr)

# import a df (data-frame)
df <- read.csv("~/Documents/R01_A01_test_df.csv" , header = T)

# View the df in a spreadsheet-like display
utils::View(df)

# my_cols <- c("Intensity_MeanIntensity_Original_BLUE" , "Intensity_MeanIntensity_Original_GREEN")
# df <- df %>% pivot_longer(cols = all_of(my_cols2))

# all cols between col x and col y
# df <- df %>% pivot_longer(cols = Intensity_MeanIntensity_Original_BLUE:Intensity_MinIntensity_Original_BLUE)

# or cols that fit a pattern, for example all columns that start with "Intensity_Mean"
# df <- df %>% pivot_longer(cols = starts_with("Intensity_Mean"))
# see all options in the dplyr cheat sheet https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf


## re-format df using pivot_longer() for all your data columns
df2 <- df %>% pivot_longer(cols = everything())

# Alternatively, pivot_longer only columns of interest by defining with a certain pattern similar to above
# df12 <- df %>% pivot_longer(cols = starts_with("Int"))

## then group_by() those values and pipe to summarise_at() to get summary values mean, max and min
df3 <- df2 %>% group_by(name) %>% summarise_at(vars(everything()), list(mean=mean, max = max, min = min))

# view these values
utils::View(df3)

## reshape df for ggplot2
df4 <- reshape2::melt(df3)

## generate plot
ggplot(df4, aes(fill = variable, y = name, x = value)) + geom_bar(position = "stack", stat = "identity") + 
  coord_flip()+theme_bw() + 
  theme(axis.text.x = element_text(angle = 90)) +
  scale_fill_brewer(palette = "Dark2")


# same plot, faceted
ggplot(df4, aes(fill = variable, y = name, x = value)) + geom_bar(position = "stack", stat = "identity") + coord_flip()+theme_bw() + facet_wrap(~variable) +
  theme(axis.text.x = element_text(angle = 90)) +
  scale_fill_brewer(palette = "Dark2")

