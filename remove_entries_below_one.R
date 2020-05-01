# Remove values below 1 in a dataset. Removes a row that contain value(s) below 1 anywhere in that row. Reduces the matrix to one with less rows. 

library(readr)

df <- read_tsv("/home/cathal_king/Desktop/test_data.csv", na = "null")

rows_above_one <- apply(df[,-1], 1, min) >1 

df_above_one <- df[rows_above_one, ]

write_tsv(df_above_one, path = "test_data_out.tsv")

