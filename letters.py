# -*- coding: utf-8 -*-
"""
Created on Thu Jun  8 14:49:31 2017

@author: Algemeen
"""

import json
with open('age_big.json', 'r') as file:
    actordata = json.load(file)
i=0
for actor in actordata:
   actor['1stletter']=actor['rdf-schema#label'][0]
   if str.isalpha(actor['rdf-schema#label'][0]) == False:
       i+=1
       actor['rdf-schema#label']=None
with open('letters_big.json', 'w') as file:                        
    json.dump(actordata, file, indent=4, ensure_ascii=True)