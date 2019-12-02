# load Python packages used data wrangling
import pandas as pd
import numpy as np
import datetime as datetime

# Datasets
health2 = pd.read_csv("https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project2_2019/HEALTH_INS_ENTRY_191102.tsv", sep = '\t')
client = pd.read_csv('https://raw.githubusercontent.com/biodatascience/datasci611/gh-pages/data/project2_2019/CLIENT_191102.tsv',sep='\t')

#identify clients with insurance
yeshealth=health2.loc[health2['Covered (Entry)']=='Yes' ]

#identify clients without insurancece
insurance_entry_sum = health2.groupby('Client ID')['Covered (Entry)'].apply(lambda x: (x=='Yes').sum()).reset_index(name='Insurance (Entry)')
noinsurance=insurance_entry_sum[insurance_entry_sum['Insurance (Entry)']==0]
noinsurance1 = health2.merge(noinsurance, on=['Client ID'], how='right')

#merge clients with and without insurance
health = yeshealth.append([noinsurance1])


# merge the two datasets
health['Entry'] =  pd.to_datetime(health['Health Insurance Start Date (Entry)'], format='%m/%d/%Y')
health1 = health.drop(['EE Provider ID','EE UID', 'Client Unique ID','Health Insurance End Date (Entry)','Provider (4307-provider)','Recordset ID (4307-recordset_id)','Date Added (4307-date_added)'], axis=1)
client1 = client.drop(['EE Provider ID','EE UID','Client Unique ID',], axis=1)

ch = client1.merge(health1, on=['Client ID'], how='left')

ch['year']=pd.DatetimeIndex(ch['Entry']).year
ch['month']=pd.DatetimeIndex(ch['Entry']).month

#new datasets formed 
temp=ch.drop_duplicates('Client ID')
<<<<<<< HEAD
visits= ch.drop(['Health Insurance Type (Entry)',],axis=1).drop_duplicates().groupby('Client ID').size().reset_index(name='Number of Visits')
=======
visits= ch.drop(['Health Insurance Type (Entry)',],axis=1).drop_duplicates().groupby('Client ID').size().to_frame('Number of Visits')
>>>>>>> 9bd7234ad91e481445071bc1f51369b9347c4545
new= temp.merge(visits, on=['Client ID'], how='left')
client_info=new[new['year']>= 2000]


from pandas import DataFrame

<<<<<<< HEAD
export_csv = client_info.to_csv (r'../data/final_project.csv', index = None, header=True)
=======
export_csv = client_info.to_csv (r'/Users/mwen/Documents/GitHub/bios611-projects-fall-2019-wenwenm183/project_3/data/final_project.csv', index = None, header=True)
>>>>>>> 9bd7234ad91e481445071bc1f51369b9347c4545




#new dataset 
from pandas import DataFrame
client_info1=client_info[client_info['year']>= 2014]
<<<<<<< HEAD
export_csv = client_info1.to_csv (r'../data/final_project1.csv', index = None, header=True)
=======
export_csv = client_info1.to_csv (r'/Users/mwen/Documents/GitHub/bios611-projects-fall-2019-wenwenm183/project_3/data/final_project1.csv', index = None, header=True)
>>>>>>> 9bd7234ad91e481445071bc1f51369b9347c4545


