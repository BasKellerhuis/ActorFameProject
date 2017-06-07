#!/usr/bin/env python3
# (c) 2016 David A. van Leeuwen

## This file converts a "raw" tye of csv file from the PoW database into a json.

## Specifically,
## - we use a short label (first line in the general CSV header)
## - "NULL" entries are simply left out
## - numbers are interpreted as numbers, not strings

import argparse, json, logging, csv, re, sys, codecs, os


floatre = re.compile("^\d+\.\d+$")
intre = re.compile("^\d+$")
actors = []
i = 0

def read_header(file="h.txt"):
    header=[]
    for line in open(file):
        header.append(line.strip())
    logging.info("%d lines in header", len(header))
    return header

def process_csv(file, header):
    out=[]
    stdin = file == "-"
    fd = sys.stdin if stdin else codecs.open(file, 'r', 'UTF-8')
    reader = csv.reader(fd)
    for nr, row in enumerate(reader):
        logging.debug("%d fields in line %d", len(row), nr)
        d = dict()
        out.append(d)
        for i, field in enumerate(row):
            if field != "NULL":
                if floatre.match(field):
                    d[header[i]] = float(field)
                elif intre.match(field):
                    d[header[i]] = int(field)
                else:
                    d[header[i]] = field
    if not stdin:
        fd.close()
    return out


header = read_header("h.txt")
for file in os.listdir("D:/Documents/UCU/Courses/Data Analysis/Assignment 6 - Wikipedia/years/"):
    out = process_csv("years/" + file, header)
    #print(json.dumps(out, indent=4, ensure_ascii=True))
    print (file)
    for entry in out:
        if "occupation_label" in entry:
        
            if entry["occupation_label"] == 'Actor' or entry["occupation_label"] == 'Actress':
                actors.append(entry)
        
            else: 
                split_occupation = entry["occupation_label"][1:-1].split('|')
                for i in range(len(split_occupation)):
                    if split_occupation[i] == 'Actor' or split_occupation[i] == 'Actress':
                        actors.append(entry)
                            
with open('actors.json', 'w') as file:                        
    json.dump(actors, file, indent=4, ensure_ascii=True)