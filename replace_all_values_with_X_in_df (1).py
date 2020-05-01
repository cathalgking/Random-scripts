#!/usr/bin/env python
# coding: utf-8

# In[1]:


### replace any value below 1 in a dataset with 0

import pandas as pd

# read in dataset
df = pd.read_table('/home/cathal_king/Desktop/toy_dataset22.txt')


# In[2]:


#view dataset
df


# In[3]:


# set the first column as the index as it is non-numeric. In this example, "Gene" is the name of the top of the column to be indexed. Change accordingly.

df = df.set_index('Gene')


# In[4]:


# view again
df


# In[6]:


# replace all values that are less than 1 with 0 in the df. Change as needed. 
df[df < 1] = 0


# In[7]:


# ensure operation is complete by viewing again
df
