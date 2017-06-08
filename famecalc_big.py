# -*- coding: utf-8 -*-
"""
Created on Tue Jun  6 16:45:40 2017

@author: Algemeen
"""
#deleted Bill Goldberg, wrongly encoded end/start year etc.
import json
with open('actordata_big.json', 'r') as file:
    actordata = json.load(file)
i=0
for actor in actordata:
    if actor['activeYearsStartYear']== None or actor['creationYear']== None:
        actor['fame']= None 
    elif actor['activeYearsStartYear'][0]== '{': 
        actor['fame']= None 
    else:
        actor['activeYearsStartYear'] = int(actor['activeYearsStartYear'].split('-')[0])
        if 'creationYear'in actor:
            if actor['activeYearsStartYear']>= 2001:
                fame = actor['creationYear'] - actor['activeYearsStartYear']
                actor['fame']=fame
            if actor['activeYearsStartYear']<= 2001:
                fame = actor['creationYear'] - 2001
                actor['fame']=fame
with open('actorfame_big.json', 'w') as file:                        
    json.dump(actordata, file, indent=4, ensure_ascii=True)
    