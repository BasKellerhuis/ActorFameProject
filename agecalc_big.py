# -*- coding: utf-8 -*-
"""
Created on Tue Jun  6 16:45:40 2017

@author: Algemeen
"""
#deleted Bill Goldberg, wrongly encoded end/start year etc.
import json
with open('actorfame_big.json', 'r') as file:
    actordata = json.load(file)
i=0
for actor in actordata:
    if actor['birthDate']== None or actor['birthDate']== '' or '- ' in actor['birthDate'] or ' -' in actor['birthDate']:
        i+=1
    elif '{' in actor['birthDate']: 
        actor['birthDate'] = (actor['birthDate'].split('|')[1][0:-1])
        actor['birthDate'] = (actor['birthDate'].split('-')[0])
        if actor['birthDate'] != '':
            actor['birthDate']=int(actor['birthDate'])
            age = 2017 - actor['birthDate']
            actor['age']= age
   
    else:
        actor['birthDate'] = (actor['birthDate'].split('-')[0])
        if actor['birthDate'] != '':
            actor['birthDate']=int(actor['birthDate'])
            age = 2017 - actor['birthDate']
            actor['age']= age

with open('age_big.json', 'w') as file:                        
    json.dump(actordata, file, indent=4, ensure_ascii=True)
    