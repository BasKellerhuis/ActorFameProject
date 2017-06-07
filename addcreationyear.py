# -*- coding: utf-8 -*-
"""
Created on Tue Jun  6 16:19:38 2017

@author: Algemeen
"""

import json
with open('creationyear.json', 'r') as file:
    creationyear = json.load(file)
with open('actors.json', 'r') as file:
    actors = json.load(file)

for key, value in creationyear.items():
    for i in range(len(actors)):
        if int(key) == actors[i]['wikiPageID']:
            actors[i]['creationYear'] = int(value)
with open('actordata.json', 'w') as file:
    json.dump(actors, file, indent=4, ensure_ascii=True)
      