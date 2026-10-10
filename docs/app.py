
import dotenv
import flask
import json
import os
import pandas
import pathlib
import pydash
import pyld
import rdflib
import requests

def subclasses(superclass):

    r = requests.get('https://raw.githubusercontent.com/FIAF/fiafcore/refs/heads/develop/fiafcore.ttl')
    if r.status_code != 200:
        raise Exception(f'API {r.status_code}: {r.text}')

    ontology_graph = rdflib.Graph().parse(data=r.text)

    query = """
        prefix fiaf: <https://dev.fiafcore.org/>
        prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
        prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
        select ?country ?label
        where {
            ?country rdfs:subClassOf fiaf:"""+superclass+""" .
            ?country rdfs:label ?label .
        }
    """

    result = pandas.DataFrame(ontology_graph.query(query), columns=['id', 'label'])

    return result.map(str).to_dict('records')


def superclass():

    """Predetermine superclasses for core child elements."""

    r = requests.get('https://raw.githubusercontent.com/FIAF/fiafcore/refs/heads/develop/fiafcore.ttl')
    if r.status_code != 200:
        raise Exception(f'API {r.status_code}: {r.text}')

    ontology_graph = rdflib.Graph().parse(data=r.text)

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


    result[rdflib.URIRef('http://www.w3.org/2002/07/owl#Class')] = rdflib.URIRef('http://www.w3.org/2002/07/owl#Class')

    print('@@@', result)

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


# declare application.

app = flask.Flask(__name__)

# declare superclasses.

superclass_lookup = superclass()

# routing for pages.

@app.route('/', methods=['GET'])
def home():

    return flask.render_template('index.html')

@app.route('/datasets', methods=['GET'])
def datasets():

    return flask.render_template('datasets.html')

@app.route('/ontology', methods=['GET'])
def ontology():

    return flask.render_template('ontology.html')

@app.route('/vocabularies', methods=['GET'])
def vocabularies():

    return flask.render_template('vocabularies.html')

@app.route('/search', methods=['GET'])
def search():

    vocab = {
        'country': subclasses('Country'),
        'form': subclasses('Form'),
        'genre': subclasses('Genre')
    }

    return flask.render_template('search.html', vocab=vocab)

@app.route('/sparql', methods=['GET'])
def sparql():

    return flask.render_template('sparql.html')

@app.route('/<id>', methods=['GET'])
def entity(id):

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
    # superclass_lookup = superclass()
    if entity_type not in superclass_lookup.keys():
        raise Exception(f'{entity_type} not found in superclass lookup.')
    superclass = superclass_lookup[entity_type]

    if superclass == rdflib.URIRef('https://dev.fiafcore.org/Agent'):
        shape = 'agent'
    elif superclass == rdflib.URIRef('https://dev.fiafcore.org/Work'):
        shape = 'work'
    elif superclass == rdflib.URIRef('http://www.w3.org/2002/07/owl#Class'):
        shape = 'class'
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

    fixed_string = r.text.encode('latin-1').decode('utf-8')
    datum = rdflib.Graph().parse(data=fixed_string, format='ttl')
    print(datum)
    datum = json.loads(datum.serialize(format='json-ld'))
    print(json.dumps(datum, indent=4))
    print('\n')
    payload = pyld.jsonld.frame(datum, frame)

    print(json.dumps(payload, indent=4))

    # post-process 1: expand all data areas.

    ensure_list(payload, datum, '@type', 'type_label', 'hello')

    add_type_label(payload, datum, '@type', 'type_label', 'hello')

    # in ill-supported conveniance to display filmographies against agents.

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

    # post-transform fix 1, label has to be a list.

    if 'label' in payload.keys():
        if type(payload['label']) is not list:
            payload['label'] = [payload['label']]

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


    if shape == 'class':
        return flask.render_template('class.html', data=payload)


    return flask.render_template('resource.html', data=payload)


if __name__ == "__main__":
    app.run(debug=True, port=5000)
