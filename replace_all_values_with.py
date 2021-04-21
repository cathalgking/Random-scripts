#!/usr/bin/env python
# coding: utf-8

# In[1]:


### replace any value below 1 in a dataset with 0

import pandas as pd

df = pd.read_table('/home/cathal_king/Desktop/toy_dataset22.txt')


# In[2]:


df


# In[3]:


# set the first column as the index as it is non-numeric

df = df.set_index('Gene')


# In[4]:


df


# In[6]:


df[df < 1] = 0


# In[7]:


df

