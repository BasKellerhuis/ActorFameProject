# -*- coding: utf-8 -*-
"""
Created on Tue Jun  6 16:45:40 2017

@author: Algemeen
"""
#deleted Bill Goldberg, wrongly encoded end/start year etc.
import json
with open('actordata.json', 'r') as file:
    actordata = json.load(file)
i=0
for actor in actordata:
    if 'activeYearsStartYear' in actor:
        if actor['activeYearsStartYear'][0]== '{':
            i+=1
        else:
            actor['activeYearsStartYear'] = int(actor['activeYearsStartYear'].split('-')[0])
            if 'creationYear'in actor:
                fame = actor['creationYear'] - actor['activeYearsStartYear']
                actor['fame']=fame
with open('actorfame.json', 'w') as file:                        
    json.dump(actordata, file, indent=4, ensure_ascii=True)
    