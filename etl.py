
# script to add FIAFcode ontology to graph.

import dotenv
import os
import pathlib
import rdflib
import requests

# load local turtle files.

g = rdflib.Graph().parse(pathlib.Path.cwd() / 'FIAFcore.ttl')

# skolemize graph.

g = g.skolemize()

# connection details for graphdb.

dotenv.load_dotenv()
graph_user, graph_pass = os.getenv('graph_username'), os.getenv('graph_password')
endpoint = 'https://graph.fiafcore.org/repositories/fiafkg/statements'
headers = {'Content-Type': 'application/sparql-update'}

# remove existing triples.

query = ''' 
    delete {
        graph <https://graph.fiafcore.org/graph/fiafcore> { 
            ?s ?p ?o } } 
    where {
        graph <https://graph.fiafcore.org/graph/fiafcore> {
            ?s ?p ?o } }
    '''

r = requests.post(endpoint, headers=headers, data=query, auth=(graph_user, graph_pass))
if r.status_code != 204:
    raise Exception('Problem sending payload.')

# write new triples.

query = ''' insert data { graph <https://graph.fiafcore.org/graph/fiafcore> { '''+g.serialize(format='nt')+''' } } '''
r = requests.post(endpoint, headers=headers, data=query.encode('utf-8'), auth=(graph_user, graph_pass))
if r.status_code != 204:
    raise Exception('Problem sending payload.')
