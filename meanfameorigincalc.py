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
    if actor['stateOfOrigin_label'] == None or actor['fame']==None:
        i+=1
    elif 'American' in actor['stateOfOrigin_label'] or 'United States' in actor['stateOfOrigin_label'] or 'America' in actor['rdf-schema#label']:
        USactors+=1
        USfame+=actor['fame']
        US= (USfame/USactors)
        actor['stateOfOrigin_label']='United States'
        
    elif 'United Kingdom' in actor['stateOfOrigin_label'] or 'Britain' in actor['stateOfOrigin_label'] or 'British' in actor['stateOfOrigin_label'] or 'British' in actor['rdf-schema#label'] or 'Scotland' in actor['stateOfOrigin_label'] or 'Scottish' in actor['rdf-schema#label'] or 'Scottish' in actor['stateOfOrigin_label'] or 'Ireland' in actor['stateOfOrigin_label'] or 'Irish' in actor['stateOfOrigin_label'] or 'Irish' in actor['rdf-schema#label']:
        UKactors+=1
        UKfame+=actor['fame']
        UK= (UKfame/UKactors)
        actor['stateOfOrigin_label']='United Kingdom'
        
    else:
        abroadactors+=1
        abroadfame+=actor['fame']
        abroad= (abroadfame/abroadactors)
        
with open('countryfame_big.json', 'w') as file:                        
    json.dump(actorfame, file, ensure_ascii=True)