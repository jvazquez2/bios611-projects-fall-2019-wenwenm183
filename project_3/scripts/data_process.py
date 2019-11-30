# load Python packages used data wrangling
import pandas as pd
import numpy as np
import datetime as datetime

# Datasets
health = pd.read_csv("https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project2_2019/HEALTH_INS_ENTRY_191102.tsv", sep = '\t')
client = pd.read_csv('https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project2_2019/CLIENT_191102.tsv',sep='\t')

# merge the two datasets
health['Entry'] =  pd.to_datetime(health['Health Insurance Start Date (Entry)'], format='%m/%d/%Y')
health1 = health.drop(['EE Provider ID','EE UID', 'Client Unique ID','Health Insurance End Date (Entry)','Provider (4307-provider)','Recordset ID (4307-recordset_id)','Date Added (4307-date_added)'], axis=1)
client1 = client.drop(['EE Provider ID','EE UID','Client Unique ID',], axis=1)

ch = client1.merge(health1, on=['Client ID'], how='left')

ch['year']=pd.DatetimeIndex(ch['Entry']).year
ch['month']=pd.DatetimeIndex(ch['Entry']).month

#new datasets formed 
temp=ch.drop_duplicates('Client ID').sort_values(by=['Client ID'])
visits= ch.drop(['Health Insurance Type (Entry)',],axis=1).drop_duplicates().groupby('Client ID').size().to_frame('Number of Visits')
client_info= temp.merge(visits, on=['Client ID'], how='left')
client_info1=client_info.dropna(subset=['Health Insurance Type (Entry)', "Client Veteran Status"])

from pandas import DataFrame

export_csv = client_info1.to_csv (r'/Users/mwen/Documents/GitHub/bios611-projects-fall-2019-wenwenm183/project_3/data/final_project.csv', index = None, header=True)

#new dataset 
from pandas import DataFrame
client_info2=client_info1[client_info1['year']>= 2013]
export_csv = client_info2.to_csv (r'/Users/mwen/Documents/GitHub/bios611-projects-fall-2019-wenwenm183/project_3/data/final_project1.csv', index = None, header=True)

