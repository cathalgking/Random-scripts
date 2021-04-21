## dplyr practice
library(dplyr)
library(tidyr)
library(ggplot2)
library(ggpubr)


df9 <- read.csv("/home/cathal_king/Desktop/testdf2.csv" , header = T)

# view the df in a spreadsheet-like display
utils::View(df)

# re-arrange the df's rows by a certain columns values
df2 <- dplyr::arrange(df, desc(ExecutionTime_11Rescale_YELLOW))

# re-name the column called "ExecutionTime_11Rescale_YELLOW" to be called "YELLOW"
df3 <- dplyr::rename(df, YELLOW = ExecutionTime_11Rescale_YELLOW)

# select columns that only contain the character "Rescale"
df4 <- select(df, contains("Rescale"))
# select columns that starts with "."
df5 <- select(df, starts_with("."))

# select all columns except "ExecutionTime_11Rescale_YELLOW"
df6 <- select(df, -ExecutionTime_11Rescale_YELLOW)

# select all columns between ExecutionTime_13Rescale_YELLOW and ExecutionTime_13Rescale_BLUE
df7 <- select(df, ExecutionTime_11Rescale_YELLOW:ExecutionTime_13Rescale_BLUE)

# group_by
df10 <- df9 %>% group_by(Species) %>% summarise(avg = mean(ExecutionTime_11Rescale_YELLOW))
df11 <- df9 %>% group_by(Species) %>% summarise(avg = mean(ExecutionTime_13Rescale_BLUE))


# summarise
# get the average of the column ExecutionTime_11Rescale_YELLOW
df12 <- df %>% summarise(avg = mean(ExecutionTime_11Rescale_YELLOW))

# df13 <- df %>% summarise_all(df, funs(mean))

# get the mean, max, min etc. of each column in the df
df14 <- dplyr::summarise_all(df, list(mean = mean, max = max, min = min))

# df15 <- df14 %>% pivot_longer(ExecutionTime_11Rescale_YELLOW_mean)


df16 <- dplyr::summarise_all(df, across({{vars}}), list(mean = mean, max = max, min = min))

df17 <- df %>% summarise(df, across({{vars}}), list(mean = mean, max = max, min = min))

# creating a vector of column names
#my_cols <- vars(contains("Rescale"))
my_cols <- c("ExecutionTime_11Rescale_YELLOW" , "ExecutionTime_12Rescale_GREEN")

# vars
vars <- c("ExecutionTime_11Rescale_YELLOW" , "ExecutionTime_12Rescale_GREEN")

# get the mean, max, min etc. of each column in the df that begins with "Execution"
df19 <- df %>% summarise_at(vars(starts_with("Execution")), list(mean=mean, max = max, min = min))

df19 <- df %>% summarise_at(vars(contains("YELLOW")), list(mean=mean, max = max, min = min))

# all columns
df19 <- df %>% summarise_at(vars(everything()), list(mean=mean, max = max, min = min))

# only those within ""
df19 <- df %>% summarise_at(vars(one_of(c("ExecutionTime_11Rescale_YELLOW", "ExecutionTime_13Rescale_BLUE"))), list(mean=mean, max = max, min = min))

# only the columns in the character vector "my_cols"
df19 <- df %>% summarise_at(vars(one_of(my_cols)), list(mean=mean, max = max, min = min))

# pivot the output to long format
df20 <- df19 %>% pivot_longer(cols = starts_with("Exe"))
# do the same for all cols
df21 <- df19 %>% pivot_longer(cols = everything())


ggbarplot(df21, x = "name", y = "value")

ggplot(df21, x = "name", y = "value")



# experiment
expr <- read.delim("https://raw.githubusercontent.com/kassambara/data/master/expr_tcga.txt",
                   stringsAsFactors = FALSE)




stat_summary(fun=mean, colour="yellow", geom="point", 
             shape=18, size=3)
