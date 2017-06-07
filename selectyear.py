# -*- coding: utf-8 -*-
"""
Created on Tue Jun  6 11:21:04 2017

@author: Algemeen
"""
import json
i = 0
with open('timestamps.json', 'r') as file:
    timestamps = json.load(file)


creationyear = {}
for key, value in timestamps.items():
    if "missing" in value['query']['pages'][str(key)]:
        i += 1
    else:
        creationyear[int(key)] = value['query']['pages'][str(key)]['revisions'][0]['timestamp'].split('-')[0]
        
with open('creationyear.json', 'w') as file:                        
    json.dump(creationyear, file, indent=4, ensure_ascii=True)