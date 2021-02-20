#!/usr/bin/env python
# coding: utf-8

# In[1]:


import pandas as pd


# In[2]:


price = pd.read_csv('import.csv')
jeju = pd.read_csv('jeju1719.csv')
gwangju = pd.read_csv('gwangju1719.csv')
choonchun = pd.read_csv('choonchun1719.csv')


# In[3]:


price['target_value'] = price['target_value'].apply(lambda x: x.replace(',', ''))
price['30avg'] = price['30avg'].apply(lambda x: x.replace(',', ''))


# In[4]:


price['item_id'] = price['item_id'].astype('str')
price['timestamp'] = price['timestamp'].astype(str)
price['target_value'] = price['target_value'].astype(float)
price['30avg'] = price['30avg'].astype(float)


# In[16]:


price.info()


# In[5]:


price.dtypes


# In[6]:


is_carrot = price['item_id'] == 'carrot'
carrot = price[is_carrot]
is_cucumber = price['item_id'] == 'cucumber'
cucumber = price[is_cucumber]
is_onion = price['item_id'] == 'onion'
onion = price[is_onion]
is_radish = price['item_id'] == 'radish'
radish = price[is_radish]
is_springonion = price['item_id'] == 'springonion'
springonion = price[is_springonion]


# In[7]:


jeju = jeju.fillna(0)
choonchun = choonchun.fillna(0)
gwangju = gwangju.fillna(0)


# In[8]:


carrot1 = carrot.merge(jeju)
cucumber1 = cucumber.merge(choonchun)
onion1 = onion.merge(gwangju)
radish1 = radish.merge(choonchun)
springonion1 = springonion.merge(gwangju)


# In[9]:


train1 = pd.concat([carrot1, cucumber1])
train1


# In[10]:


train2 = pd.concat([train1, onion1])
train3 = pd.concat([train2, radish1])
train = pd.concat([train3, springonion1])


# In[11]:


fin = pd.DataFrame(train)


# In[15]:


fin.dtypes


# In[13]:


train.to_csv('C:/Users/HyeJee Yang/Desktop/school/train.csv')


# In[14]:


train.dtypes

