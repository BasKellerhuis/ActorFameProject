# -*- coding: utf-8 -*-
"""
Created on Wed Jun  7 16:15:50 2017

@author: Algemeen
"""

import json
with open('actorfame_big.json', 'r') as file:
    actorfame = json.load(file)
i=0
USfame=0
USactors=0
UKfame=0
UKactors=0
abroadfame=0
abroadactors=0

for actor in actorfame:
    if actor['fame']==None:
        i+=1
    elif 'American' in actor['rdf-schema#label'] or 'American people' in actor['rdf-schema#label']:
        USactors+=1
        USfame+=actor['fame']
        actor['stateOfOrigin_label']='United States'
    elif 'British'in actor['rdf-schema#label'] or 'Irish' in actor['rdf-schema#label'] or 'Scottish' in actor['rdf-schema#label'] or 'English' in actor['rdf-schema#label'] or 'British people'in actor['rdf-schema#label'] or 'English people'in actor['rdf-schema#label']:
        UKactors+=1
        UKfame+=actor['fame']
        actor['stateOfOrigin_label']='United Kingdom'
    else:
        if actor['stateOfOrigin_label']==None:
            i+=1
        elif 'American' in actor['stateOfOrigin_label'] or 'United States' in actor['stateOfOrigin_label'] or 'America' in actor['stateOfOrigin_label'] or 'American people' in actor['stateOfOrigin_label']:
            USactors+=1
            USfame+=actor['fame']
            actor['stateOfOrigin_label']='United States'
        elif 'United Kingdom' in actor['stateOfOrigin_label'] or 'England' in actor['stateOfOrigin_label'] or 'Britain' in actor['stateOfOrigin_label'] or 'British' in actor['stateOfOrigin_label'] or 'Scotland' in actor['stateOfOrigin_label'] or 'Scottish' in actor['stateOfOrigin_label'] or 'Ireland' in actor['stateOfOrigin_label'] or 'Irish' in actor['stateOfOrigin_label'] or 'British people' in actor['stateOfOrigin_label'] or 'English people' in actor['stateOfOrigin_label']:
            UKactors+=1
            UKfame+=actor['fame']
            actor['stateOfOrigin_label']='United Kingdom'
        else:
            abroadactors+=1
            abroadfame+=actor['fame']

with open('countryfame_big.json', 'w') as file:                        
    json.dump(actorfame, file, ensure_ascii=True)