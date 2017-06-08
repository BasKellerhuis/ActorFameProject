# -*- coding: utf-8 -*-
"""
Created on Tue Jun  6 16:19:38 2017

@author: Algemeen
"""

import json
with open('creationyear_big.json', 'r') as file:
    creationyear = json.load(file)
with open('actors_big.json', 'r') as file:
    actors = json.load(file)
actordata = []
for key, value in creationyear.items():
    for i in range(len(actors)):
        if int(key) == actors[i]['wikiPageID']:
            actors[i]['creationYear'] = int(value)
            actordata.append({key:actors[i].get(key, None) for key in ["rdf-schema#label", "birthDate", "stateOfOrigin_label", "activeYearsStartYear", "creationYear"]})
with open('actordata_big.json', 'w') as file:
    json.dump(actordata, file, ensure_ascii=True)
      