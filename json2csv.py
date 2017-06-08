# -*- coding: utf-8 -*-
"""
Created on Wed Jun  7 16:25:52 2017

@author: Bas
"""

import csv, json

with open('letters_big.json', 'r') as file:
    actordata = json.load(file)

with open('actorfame.csv', 'w', newline='') as csvfile:
    spamwriter = csv.writer(csvfile,quoting=csv.QUOTE_NONNUMERIC)
    spamwriter.writerow(['Name', 'Age', 'CountryOfOrigin', 'FirstActiveYear', 'PageCreationYear', 'FameScore', 'FirstLetter'])
    for actor in actordata:
        spamwriter.writerow([actor['rdf-schema#label'].encode('utf-8'), actor['age'], actor['stateOfOrigin_label'], actor['activeYearsStartYear'], actor['creationYear'], actor['fame'], actor['1stletter']])