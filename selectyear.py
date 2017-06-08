# -*- coding: utf-8 -*-
"""
Created on Tue Jun  6 11:21:04 2017

@author: Algemeen
"""
import json
i = 0
j = 0
with open('timestamps_big.json', 'r') as file:
    timestamps = json.load(file)



creationyear = {}
for timestamp in timestamps:
    for key, value in timestamp.items():
        if key != "query":
            i += 1 
        else:
            for k in value['pages']:
                if "missing" in value['pages'][str(k)]:
                    j += 1
                else:
                    creationyear[int(k)] = value['pages'][str(k)]['revisions'][0]['timestamp'].split('-')[0]
        
with open('creationyear_big.json', 'w') as file:                        
    json.dump(creationyear, file, indent=4, ensure_ascii=True)