#!/usr/bin/env python
# coding: utf-8

# The Pandas library can find all 'NaN's in a dataset and replace them with a numerical number, here it is 0.
import pandas as pd

data2 = pd.read_table('/home/cathal_king/Desktop/MergedTBIdataStudy.txt')

data2.head(11)

data2.fillna(0, inplace=True)

data2.head(11)

# export as an excel initially and then save as text csv
data2.to_excel('/home/cathal_king/Desktop/MergedTBIdataStudy_noNaN.xlsx')
