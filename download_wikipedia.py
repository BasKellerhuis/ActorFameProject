'''
    download.py: Code for fetching data from a REST API.
    This script uses real UCDP data: http://ucdp.uu.se/apidocs/
    Only to be used for educational purposes. Distribution or publication without
    written permission from the author is not allowed.
    Written by Teun van Gils. All rights reserved, 2016.
'''

from urllib import parse, request
import json

def request_page(page=1, params=None):
    '''Request a page of data from the UCDP database.'''

    # Below are the parameters for the REST request
    # Information about possible parameters can be found at:
    #   http://ucdp.uu.se/apidocs/
    req_params = params if params is not None else {
        'pagesize': 1000,
        'page': page
    }
    req_string = parse.urlencode(req_params) # will encode the parameters in the right format

    # Below, we prepare the request to the REST webpage that will return our data
    req = request.Request('https://en.wikipedia.org/w/api.php/' + req_string)

    # Submit the request and retrieve the response:
    with request.urlopen(req) as rawdata:
        data = rawdata.read().decode('utf8') # decode the raw response
        response = json.loads(data) # parse the json from the response

    return response

# Request some data from the online database
parameters = {
    'pagesize': 1000,
    'page': 0,
    'Country': 645
}
result = request_page(params=parameters)

with open('sample.json', 'w') as file: # open a file for writing
    json.dump(result, file, indent=4) # save the result as json in this file
