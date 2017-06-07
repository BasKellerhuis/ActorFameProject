# -*- coding: utf-8 -*-
"""
Created on Tue Jun  6 14:30:41 2017

@author: Algemeen
"""

from urllib import parse, request
import json
WikiIDs = []
dictIDs={}
with open('actors.json', 'r') as file:
    elements = json.load(file)

def request_page(page=1, params=None):
    '''Request a page of data from the UCDP database.'''
    # Below are the parameters for the REST request
    # Information about possible parameters can be found at:
    #   http://ucdp.uu.se/apidocs/
    req_params = params if params is not None else {
        'action': 'query',
        'prop': 'revisions',
        'pageids': 1,
        'rvlimit': 1,
        'rvdir': 'newer',
        'format': 'json'
    }
    req_string = parse.urlencode(req_params) # will encode the parameters in the right format

    # Below, we prepare the request to the REST webpage that will return our data
    req = request.Request('https://en.wikipedia.org/w/api.php/?' + req_string)

    # Submit the request and retrieve the response:
    with request.urlopen(req) as rawdata:
        data = rawdata.read().decode('utf8') # decode the raw response
        response = json.loads(data) # parse the json from the response

    return response
IDdict={}
for element in elements:
    print(element["wikiPageID"])
        #for element in WikiIDs:
        # Request some data from the online database
    parameters = {
        'action': 'query',
        'prop': 'revisions',
        'pageids': element["wikiPageID"],
        'rvlimit': 1,
        'rvdir': 'newer',
        'format': 'json'
    }
    result = request_page(params=parameters)
    IDdict[element["wikiPageID"]] = result
with open('timestamps.json', 'w') as file: # open a file for writing
    json.dump(IDdict, file, indent=4) # save the result as json in this file
