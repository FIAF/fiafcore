
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


# post-process 1: expand all data areas.

# payload['type']

def ensure_array(data, key):
    if type(pydash.get(data, key)) is not list:
        pydash.set_(data, key, [pydash.get(data, key)])


ensure_array(payload, '@type')
ensure_array(payload, 'hasIdentifier')
ensure_array(payload, 'hasTitle')
ensure_array(payload, 'hasCountry')
ensure_array(payload, 'hasGenre')
ensure_array(payload, 'hasEvent')

for x in payload['hasEvent']:
    for y in x['hasActivity']:
        ensure_array(y, 'hasAgent.label')

for x in payload['hasManifestation']:
    if '@type' in x.keys():
        ensure_array(x, '@type')


    if 'hasColourCharacteristic' in x.keys():
        ensure_array(x, 'hasColourCharacteristic')
    if 'hasSoundCharacteristic' in x.keys():
        ensure_array(x, 'hasSoundCharacteristic')
    if 'hasFormat' in x.keys():
        ensure_array(x, 'hasFormat')
    if 'hasItem' in x.keys():
        ensure_array(x, 'hasItem')

for x in payload['hasManifestation']:
    if 'hasItem' not in x.keys():
        continue
    for y in x['hasItem']:
        if 'hasBase' in y.keys():
            ensure_array(y, 'hasBase')
        if 'hasHoldingInstitution' in y.keys():
            ensure_array(y, 'hasHoldingInstitution')
        if 'hasSoundCharacteristic' in y.keys():
            ensure_array(y, 'hasSoundCharacteristic')
        if 'hasStatus' in y.keys():
            ensure_array(y, 'hasStatus')
        if 'hasStock' in y.keys():
            ensure_array(y, 'hasStock')
        if 'isElement' in y.keys():
            ensure_array(y, 'isElement')


for x in payload['hasManifestation']:
    if 'hasItem' not in x.keys():
        continue
    for y in x['hasItem']:
        if 'hasStock' in y.keys():
            for z in y['hasStock']:
                if '@type' in z.keys():
                    ensure_array(z, '@type')


            # ensure_array(y, 'hasStock')


# for x in payload['hasEvent']:
#     for y in x['hasActivity']:
#         print(y)
#         # ensure_array(y, 'hasAgent.label')
#         print('\n')


# raise Exception('@@')

# post-process 2: insert "type" data.


# TODO do this using an additive method,
# traverse
# detect of @type exists, should always be array?
# find actual type in source,
# and write to a new "type" key


# for x in payload.keys():

if '@type' in payload.keys():
    payload['type'] = [y for y in datum if y['@id'] in payload['@type']]

for x in payload.keys():
    for y in payload[x]:
        if type(y) is not dict:
            continue
        if '@type' not in y.keys():
            continue
        # print(y['@type'])
        y['type'] = [z for z in datum if z['@id'] in y['@type']]

        for z in y.keys():
            for a in y[z]:
                if type(a) is not dict:
                    continue
                if '@type' not in a.keys():
                    continue
                a['type'] = [b for b in datum if b['@id'] in a['@type']]

                for d in a.keys():
                    print(d)
                    for e in a[d]:
                        if type(e) is not dict:
                            continue
                        if '@type' not in e.keys():
                            continue
                        print(e['@type'])

                        e['type'] = [f for f in datum if f['@id'] in e['@type']]



        # print(y)


# TODO
# now contract, if label.value exists, reduce to "label"
# if "type" exists, drop "@type"
# ideally all elements should just have "id" and "label" pairs


# print result.

print(json.dumps(payload, indent=4))


# validate result.

validate_path = pathlib.Path.cwd().parent / 'docs' / 'validate' / f'{shape}.json'
if not validate_path.exists():
    raise Exception(f'{validate_path} not found.')

with open(validate_path) as valid:
    schema = json.load(valid)

try:
    jsonschema.validate(instance=payload, schema=schema)
except jsonschema.exceptions.ValidationError as e:
    raise Exception(f'Validation failed: {e}')


# todo, expand first layer.
# add json schema
# build out
# add type replace.
