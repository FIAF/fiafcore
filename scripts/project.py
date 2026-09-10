
# in the interest of developing the transform for web,
# render complete JSON from a triplestore query.

import json
import jsonschema
import pathlib
import pydash
import pyld
import rdflib
import requests

def superclass():

    """Predetermine superclasses for core child elements."""

    ontology_path = pathlib.Path.cwd().parent / 'fiafcore.ttl'
    if not ontology_path.exists():
        raise Exception(f'{ontology_path} not found.')

    ontology_graph = rdflib.Graph().parse(ontology_path)

    query = """
        prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        prefix fiaf: <https://dev.fiafcore.org/>
        select ?parent ?child
        where {
            values ?parent { fiaf:Work fiaf:Variant fiaf:Manifestation fiaf:Item fiaf:Carrier fiaf:Agent }
            ?child rdfs:subClassOf+ ?parent
        }
    """

    result = dict([(row.child, row.parent) for row in ontology_graph.query(query)])
    for entity_type in ['Work', 'Variant', 'Manifestation', 'Item', 'Carrier', 'Agent']:
        entity_uri = rdflib.URIRef(f'https://dev.fiafcore.org/{entity_type}')
        result[entity_uri] = entity_uri

    return result


def ensure_list(data, ref, target_key, new_key, new_value):

    if isinstance(data, dict):
        if target_key in data:
            if type(data[target_key]) is not list:
                data[target_key] = [data[target_key]]

        for value in data.values():
            ensure_list(value, ref, target_key, new_key, new_value)

    elif isinstance(data, list):
        for item in data:
            ensure_list(item,ref, target_key, new_key, new_value)


def add_type_label(data, ref, target_key, new_key, new_value):

    if isinstance(data, dict):
        if target_key in data:
            data['type'] = [y for y in ref if y['@id'] in data[target_key]]

        for value in data.values():
            add_type_label(value, ref, target_key, new_key, new_value)

    elif isinstance(data, list):
        for item in data:
            add_type_label(item,ref, target_key, new_key, new_value)



# subject to render.

id = 'a54ec8e3-5372-491f-8b12-d29219f87a75'
# id = '2fe108df-ba7f-4e2b-a610-d0d46ff9b184'

# convert to uri.

uri = f'https://dev.fiafcore.org/{id}'

# determine if uri resolves within triplestore.

query = """
    prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
    prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
    select ?entity_type
    where {
        values ?entity { <"""+str(uri)+"""> }
        ?entity rdf:type ?entity_type
        } """

r = requests.post('https://data.fiafcore.org', data={'query': query})
if r.status_code != 200:
    raise Exception(f'API {r.status_code}: {r.text}')

datum = r.json()['results']['bindings']
if not len(datum):
    raise Exception(f'{uri} does not resolve in knowledge graph.')

# determine superclass of entity type.

entity_type = rdflib.URIRef(datum[0]['entity_type']['value'])
superclass_lookup = superclass()
if entity_type not in superclass_lookup.keys():
    raise Exception(f'{entity_type} not found in superclass lookup.')
superclass = superclass_lookup[entity_type]

if superclass == rdflib.URIRef('https://dev.fiafcore.org/Agent'):
    shape = 'agent'
elif superclass == rdflib.URIRef('https://dev.fiafcore.org/Work'):
    shape = 'work'
else:
    raise Exception(f'{superclass} shape not detected.')

# route to appropriate shape and insert subject uri.

shape_path = pathlib.Path.cwd().parent / 'docs' / 'shapes' / f'{shape}.rq'
if not shape_path.exists():
    raise Exception(f'{shape_path} not found.')

with open(shape_path) as construct:
    construct = construct.read()
    construct = construct.replace('SUBJECT_URI', f'<{uri}>')

# issue type specific sparql query to triplestore.

r = requests.post('https://data.fiafcore.org', data={'query': construct})
if r.status_code != 200:
    raise Exception(f'API {r.status_code}: {r.text}')

# load json-ld frame.

frame_path = pathlib.Path.cwd().parent / 'docs' / 'frames' / f'{shape}.json'
if not frame_path.exists():
    raise Exception(f'{frame_path} not found.')

with open(frame_path) as frame:
    frame = json.load(frame)
    frame['@id'] = uri

# raise Exception('@@', frame)

# apply transforms.

datum = rdflib.Graph().parse(data=r.text, format='ttl')
print(datum)
datum = json.loads(datum.serialize(format='json-ld'))
print(json.dumps(datum, indent=4))
print('\n')
payload = pyld.jsonld.frame(datum, frame)

print(json.dumps(payload, indent=4))

# post-process 1: expand all data areas.

ensure_list(payload, datum, '@type', 'type_label', 'hello')

add_type_label(payload, datum, '@type', 'type_label', 'hello')

# in ill-supported conveniance is to display filmographies against agents.

if shape == 'agent':
    query = """
        PREFIX rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        prefix fiaf: <https://dev.fiafcore.org/>
        SELECT distinct ?work ?title WHERE {
            ?work fiaf:hasEvent ?event .
            ?event fiaf:hasActivity ?activity .
            ?activity fiaf:hasAgent fiaf:"""+id+""" .
            ?work fiaf:hasTitle ?t .
            ?t fiaf:hasTitleValue ?title .
        }
    """

    r = requests.post('https://data.fiafcore.org', data={'query': query})
    if r.status_code != 200:
        raise Exception(f'API {r.status_code}: {r.text}')

    filmography = list()
    datum = r.json()['results']['bindings']
    if len(datum):
        for x in datum:
            a = {'@id': pydash.get(x, 'work.value'), 'label': pydash.get(x, 'title.value')}
            if a['@id'] in [x['@id'] for x in filmography]:
                continue
            filmography.append(a)

    payload['filmography'] = filmography

# print result.

print(json.dumps(payload, indent=4))

# validate result.

# validate_path = pathlib.Path.cwd().parent / 'docs' / 'validate' / f'{shape}.json'
# if not validate_path.exists():
#     raise Exception(f'{validate_path} not found.')

# with open(validate_path) as valid:
#     schema = json.load(valid)
# try:
#     jsonschema.validate(instance=payload, schema=schema)
# except jsonschema.exceptions.ValidationError as e:
#     raise Exception(f'Validation failed: {e}')
