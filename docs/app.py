# import json
# import os
# import pathlib
# import random
# import requests
# import rdflib
# from flask import Flask
# from flask import render_template

import dotenv
import flask
import json
import os
import pathlib
import pydash
import pyld
import rdflib
import requests

# def pull_attribute(e, p, gr):

#     x = [c for a,b,c in gr.triples((e, p, None))]
#     if len(x) != 1:
#         # print(c)
#         raise Exception(f'Single value expected {x}.')

#     return x[0]


# load environ vars.

dotenv.load_dotenv()

# declare application.

app = flask.Flask(__name__)



# # pull example rdf, from web resource. Do this on flask deploy.

# example_graph = rdflib.Graph()
# example_graph.add((rdflib.DC.description, rdflib.RDFS.label, rdflib.Literal("Description")))
# example_graph.add((rdflib.DC.source, rdflib.RDFS.label, rdflib.Literal("Source")))
# example_graph.add((rdflib.RDFS.subClassOf, rdflib.RDFS.label, rdflib.Literal("Subclass Of")))
# example_graph.add((rdflib.RDFS.domain, rdflib.RDFS.label, rdflib.Literal("Domain")))
# example_graph.add((rdflib.RDFS.range, rdflib.RDFS.label, rdflib.Literal("Range")))
# example_graph.add((rdflib.RDFS.label, rdflib.RDFS.label, rdflib.Literal("Label")))

# # mint deterministic bnode uris.

# bnodes = dict()
# for i in range(1,30):
#     bnodes[f'blankNode{i}'] = rdflib.BNode()

# # build example graph from turtle fragments.

# for example_type in [
#     'Work',
#     'Variant',
#     'Manifestation',
#     'Item',
#     'Carrier',
#     'Event',
#     'Activity',
#     'Agent']:

#     example_path = f'https://raw.githubusercontent.com/FIAF/fiafcore/refs/heads/develop/example/{example_type}.ttl'
#     r = requests.get(example_path)
#     if r.status_code != 200:
#         raise Exception(f'API {r.status_code}: {r.text}')

#     # convert bnodes to literals.

#     rdf = r.text
#     for b in bnodes.keys():
#         rdf = rdf.replace(f'_:{b}', f'"{b}"')

#     example_graph += rdflib.Graph().parse(data=rdf)

# # extra entity labelling.
# # NOTE: these additional example statements should be present at source.

# example_graph.add((rdflib.URIRef('https://example.fiafcore.org/f0032f62-d28c-4730-a358-afb8106173e0'), rdflib.RDFS.label, rdflib.Literal('Test Archive')))
# example_graph.add((rdflib.URIRef('https://example.fiafcore.org/f0032f62-d28c-4730-a358-afb8106173e0'), rdflib.RDF.type, rdflib.URIRef('https://dev.fiafcore.org/Organisation')))

# # replace bnode literals with deterministic bnodes.

# for k,v in bnodes.items():
#     for s,p,o in example_graph.triples((None, None, None)):
#         if s == rdflib.Literal(k):
#             example_graph.add((v, p, o))
#             example_graph.remove((s,p,o))
#         if o == rdflib.Literal(k):
#             example_graph.add((s, p, v))
#             example_graph.remove((s,p,o))

# r = requests.get('https://raw.githubusercontent.com/FIAF/fiafcore/refs/heads/develop/fiafcore.ttl')
# if r.status_code != 200:
#     raise Exception('API call failed.')

# g = rdflib.Graph().parse(data=r.text) # turn this off in lieu of ontology_graph, once you have re routed.

# ontology_graph = rdflib.Graph().parse(data=r.text)
# ontology_graph.add((rdflib.OWL.Class, rdflib.RDFS.label, rdflib.Literal("Class")))
# ontology_graph.add((rdflib.OWL.DatatypeProperty, rdflib.RDFS.label, rdflib.Literal("Datatype Property")))
# ontology_graph.add((rdflib.OWL.ObjectProperty, rdflib.RDFS.label, rdflib.Literal("Object Property")))
# ontology_graph.add((rdflib.RDFS.subClassOf, rdflib.RDFS.label, rdflib.Literal("Subclass Of")))
# ontology_graph.add((rdflib.RDFS.subClassOf, rdflib.RDFS.domain, rdflib.Literal("Domain")))
# ontology_graph.add((rdflib.RDFS.subClassOf, rdflib.RDFS.range, rdflib.Literal("Range")))
# ontology_graph.add((rdflib.URIRef('http://purl.org/dc/elements/1.1/description'), rdflib.RDFS.label, rdflib.Literal("Description")))
# ontology_graph.add((rdflib.URIRef('http://purl.org/dc/elements/1.1/source'), rdflib.RDFS.label, rdflib.Literal("Source")))

# # parsing entity to remove all unionOf nodes.

# query = '''
#     select ?subject ?union_domain where {
#         ?subject rdfs:domain ?domain .
#         ?domain owl:unionOf ?a .
#         ?a rdf:rest*/rdf:first ?union_domain .
#     } '''

# # add direct domain statements

# for a, b in g.query(query):
#     g.add((a, rdflib.RDFS.domain, b))

# # remove blank node statements

# for a,b,c in g.triples((None, None, None)):
#     if type(a) is type(rdflib.BNode('')) or type(b) is type(rdflib.BNode('')):
#         g.remove(( a, b, c))


# def superclass(graph):

#     """Predetermine superclasses for core child elements."""

#     query = """
#         prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
#         prefix fiaf: <https://dev.fiafcore.org/>
#         select ?parent ?child
#         where {
#             values ?parent { fiaf:Work fiaf:Variant fiaf:Manifestation fiaf:Item fiaf:Carrier fiaf:Agent }
#             ?child rdfs:subClassOf+ ?parent
#         }
#     """

#     result = dict([(row.child, row.parent) for row in graph.query(query)])
#     for entity_type in ['Work', 'Variant', 'Manifestation', 'Item', 'Carrier', 'Agent']:
#         entity_uri = rdflib.URIRef(f'https://dev.fiafcore.org/{entity_type}')
#         result[entity_uri] = entity_uri

#     return result

# superclass_lookup = superclass(ontology_graph)
# # print('**', superclass_lookup)

# def subclasses(parent):

#     # fiafcore_path = pathlib.Path.cwd() / 'fiafcore.ttl'
#     # if not fiafcore_path.exists():
#     #     raise Exception('Local ontology file not found.')

#     # fiafcore = rdflib.Graph().parse(fiafcore_path)
#     query = """
#         PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
#         SELECT ?subClass
#         WHERE {
#             ?subClass rdfs:subClassOf+ <"""+parent+"""> .
#         }
#     """
#     result = [row.subClass for row in g.query(query)]
#     result.append(rdflib.URIRef(parent))

#     return result

# agent_classes = subclasses('https://dev.fiafcore.org/Agent')
# work_classes = subclasses('https://dev.fiafcore.org/Work')
# manifestation_classes = subclasses('https://dev.fiafcore.org/Manifestation')
# item_classes = subclasses('https://dev.fiafcore.org/Item')
# carrier_classes = subclasses('https://dev.fiafcore.org/Carrier')

@app.route('/', methods=['GET'])
def home():
    if os.getenv('INSTANCE') != 'dev':
        return flask.render_template('error.html')

    return flask.render_template('index.html')


@app.route('/sources', methods=['GET'])
def sources():
    if os.getenv('INSTANCE') != 'dev':
        return flask.render_template('error.html')

    return flask.render_template('sources.html')

@app.route('/ontology', methods=['GET'])
def ontology():
    if os.getenv('INSTANCE') != 'dev':
        return flask.render_template('error.html')

    return flask.render_template('ontology.html')

@app.route('/search', methods=['GET'])
def search():
    if os.getenv('INSTANCE') != 'dev':
        return flask.render_template('error.html')

    return flask.render_template('search.html')

@app.route('/sparql', methods=['GET'])
def sparql():
    if os.getenv('INSTANCE') != 'dev':
        return flask.render_template('error.html')

    return flask.render_template('sparql.html')


# @app.route('/ontology', methods=['GET'])
# def ontology():
#     if os.getenv('INSTANCE') != 'dev':
#         return render_template('error.html')

#     string = ''
#     for entity in [
#         rdflib.URIRef('https://dev.fiafcore.org/Work'),
#         rdflib.URIRef('https://dev.fiafcore.org/Variant'),
#         rdflib.URIRef('https://dev.fiafcore.org/Manifestation'),
#         rdflib.URIRef('https://dev.fiafcore.org/Item'),
#         rdflib.URIRef('https://dev.fiafcore.org/Carrier'),
#         rdflib.URIRef('https://dev.fiafcore.org/Event'),
#         rdflib.URIRef('https://dev.fiafcore.org/Activity'),
#         rdflib.URIRef('https://dev.fiafcore.org/Agent'),
#     ]:

#         label = pull_attribute(entity, rdflib.RDFS.label, g)
#         string += f'<h4>{label}</h4>'

#         desc = pull_attribute(entity, rdflib.URIRef('http://purl.org/dc/elements/1.1/description'), g)
#         string += f'{desc}<br><br>'

#         # string += '<i>Subclasses</i><br><br>'
#         # query = """
#         #        PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
#         #        SELECT ?sub ?subLabel
#         #        WHERE {
#         #            ?sub rdfs:subClassOf <"""+str(entity)+"""> .
#         #            ?sub rdfs:label ?subLabel
#         #        }
#         #    """

#         # subclasses = [{'uri':str(x.sub), 'label':str(x.subLabel)} for x in g.query(query)]
#         # for s in subclasses:

#         #     query = """
#         #             PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>
#         #             SELECT ?sub ?subLabel
#         #             WHERE {
#         #                 ?sub rdfs:subClassOf <"""+str(s['uri'])+"""> .
#         #                 ?sub rdfs:label ?subLabel
#         #             }
#         #         """
#         #     s['subclasses'] = [{'uri':str(x.sub), 'label':str(x.subLabel)} for x in g.query(query)]

#         # string += f'<ul class="tree"><li><details><summary>{pull_attribute(entity, rdflib.RDFS.label, g)}</summary>'
#         # for a in subclasses:

#         #     string += f'<ul><li>'
#         #     if len(a["subclasses"]):
#         #         string += f'<details><summary><a href="{a["uri"]}">{a["label"]}</a></summary>'
#         #     else:
#         #         string += f'<a href="{a["uri"]}">{a["label"]}</a>'

#         #     for b in a['subclasses']:
#         #         string += f'<ul><li>'
#         #         if 'subclasses' not in b.keys():
#         #             string += f'<a href="{b["uri"]}">{b["label"]}</a>'
#         #         elif not len(b['subclasses']):
#         #             string += f'<a href="{b["uri"]}">{b["label"]}</a>'
#         #         else:
#         #             string += f'<details><summary><a href="{b["uri"]}">{b["label"]}</a></summary></details>'

#         #         string += '</li></ul>'
#         #     if len(a["subclasses"]):
#         #         string += '</details></li></ul>'
#         #     else:
#         #         string += '</li></ul>'
#         # string += '</details></li></ul>'

#         string += '<i>Properties</i><br><br>'
#         string += "<table style='table-layout: fixed;width: 100%;'><tr style='background-color: grey;color: white'><td><b>Property</b></td><td><b>Description</b></td><td><b>Example</b></td></tr>"
#         props = [s for s,p,o in g.triples((None, rdflib.RDFS.domain, entity))]
#         for p in sorted(props):
#             prop = f'fiaf:{pathlib.Path(p).name}'
#             desc = str(pull_attribute(p, rdflib.URIRef('http://purl.org/dc/elements/1.1/description'), g))
#             examples = [o for s,p,o in example_graph.triples((None, p, None))]
#             if len(examples):
#                 example = random.choice(examples)
#                 if type(example) is type(rdflib.BNode()):
#                     example = '_:blankNode'
#                 if 'fiafcore.org' in example:
#                     example = f'&lt;<a href={example} style="color: crimson;">{example}</a>&gt;'
#             else:
#                 example = ''

#             string += f'<tr><td>{prop}</td><td>{desc}</td><td>{example}</td></tr>'

#         string += '</table>'

#         # add example link, where relevant.

#         if entity == rdflib.URIRef('https://dev.fiafcore.org/Work'):
#             example_link = 'https://example.fiafcore.org/77566b79-9889-4772-adff-8640a0f6287e'
#         elif entity == rdflib.URIRef('https://dev.fiafcore.org/Manifestation'):
#             example_link = 'https://example.fiafcore.org/ede01e7e-3513-4d9c-bfac-a37e01785b22'
#         elif entity == rdflib.URIRef('https://dev.fiafcore.org/Item'):
#             example_link = 'https://example.fiafcore.org/732fce4e-9738-4501-bc5f-f9243db387af'
#         elif entity == rdflib.URIRef('https://dev.fiafcore.org/Carrier'):
#             example_link = 'https://example.fiafcore.org/005ecbf8-1693-4986-8fef-43f55436dfe8'
#         elif entity == rdflib.URIRef('https://dev.fiafcore.org/Agent'):
#             example_link = 'https://example.fiafcore.org/37101230-528d-4f14-b50b-e0127756b7fa'
#         else:
#             example_link = ''

#         if len(example_link):
#             string += f'<br><i>Example</i> [<a href="{example_link}" style="color: crimson">link</a>]<br><br>'
#         else:
#             string += '<br><i>Example</i><br><br>'

#         example_type = pathlib.Path(entity).name
#         example_path = f'https://raw.githubusercontent.com/FIAF/fiafcore/refs/heads/develop/example/{example_type}.ttl'
#         r = requests.get(example_path)
#         if r.status_code != 200:
#             raise Exception(f'API {r.status_code}: {r.text}')

#         example = r.text
#         example = example.replace('<', '&lt;')
#         example = example.replace('>', '&gt;')
#         string += f'<pre><code class="language-turtle">{example}</code></pre>'

#     return render_template('ontology.html', data=string)

# @app.route('/sources', methods=['GET'])
# def sources():
#     if os.getenv('INSTANCE') != 'dev':
#         return render_template('error.html')

#     return render_template('sources.html')

# @app.route('/access', methods=['GET'])
# def access():
#     if os.getenv('INSTANCE') != 'dev':
#         return render_template('error.html')

#     return render_template('access.html')

# @app.route('/licence', methods=['GET'])
# def licence():
#     if os.getenv('INSTANCE') != 'dev':
#         return render_template('error.html')

#     return render_template('licence.html')

# @app.route('/<resource>', methods=['GET'])
# def page(resource):

#     if os.getenv('INSTANCE') == 'example':

#         # determine uuid validaty by attempting to determine the rdf.type.

#         uri = rdflib.URIRef(f'https://example.fiafcore.org/{resource}')
#         uri_match = [o for s,p,o in example_graph.triples((uri, rdflib.RDF.type, None))]
#         if not len(uri_match):
#             return render_template('error.html')

#         # pull type and generalise.

#         uri_type = uri_match[0]
#         if uri_type not in superclass_lookup.keys():
#             return render_template('error.html')

#         uri_superclass = superclass_lookup[uri_type]

#         # route to appropriate shape and insert subject uri.

#         shape = pathlib.Path(uri_superclass).stem.lower()
#         shape_path = pathlib.Path.cwd() / 'shapes' / f'{shape}.rq'
#         if not shape_path.exists():
#             raise Exception('Shape file not found.')

#         with open(shape_path) as construct:
#             construct = construct.read()
#             construct = construct.replace('SUBJECT_URI', f'<{uri}>')

#         # apply shape query to example graph and return json-ld.

#         result = (example_graph+ontology_graph).query(construct)
#         data = result.serialize(format="json-ld").decode()
#         data = json.loads(data)

#         return render_template('entity.html', resource=str(uri), data=data)

#     elif os.getenv('INSTANCE') == 'dev':

#         # determine uuid validaty by attempting to determine the rdf.type.

#         uri = rdflib.URIRef(f'https://dev.fiafcore.org/{resource}')
#         uri_match = [o for s,p,o in ontology_graph.triples((uri, rdflib.RDF.type, None))]
#         if len(uri_match):

#             uri_type = uri_match[0]
#             if rdflib.URIRef(uri_type) == rdflib.OWL.Class:
#                 shape = 'class'
#             elif rdflib.URIRef(uri_type) == rdflib.OWL.DatatypeProperty:
#                 shape = 'property'
#             elif rdflib.URIRef(uri_type) == rdflib.OWL.ObjectProperty:
#                 shape = 'property'
#             else:
#                 raise Exception('Shape not determined.')

#             shape_path = pathlib.Path.cwd() / 'shapes' / f'{shape}.rq'
#             if not shape_path.exists():
#                 raise Exception('Shape file not found.')

#             with open(shape_path) as construct:
#                 construct = construct.read()
#                 construct = construct.replace('SUBJECT_URI', f'<{uri}>')

#             # apply shape query to example graph and return json-ld.

#             result = (example_graph+ontology_graph).query(construct)
#             print(result.serialize(format="ttl"))
#             data = result.serialize(format="json-ld").decode('utf-8')
#             data = json.loads(data)

#             return render_template('entity.html', resource=str(uri), data=data)

#         # process to request data from triplestore.

#         query = """
#             prefix rdf: <http://www.w3.org/1999/02/22-rdf-syntax-ns#>
#             prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
#             select ?entity_type
#             where {
#                 values ?entity { <"""+str(uri)+"""> }
#                 ?entity rdf:type ?entity_type
#                 } """

#         r = requests.post('https://data.fiafcore.org', data={'query': query})
#         if r.status_code != 200:
#             raise Exception(f'API {r.status_code}: {r.text}')

#         entity_types = r.json()['results']['bindings']
#         if not len(entity_types):
#             raise Exception(f'At least one type should exist for {uri}.')

#         # pull type and generalise.

#         uri_type = rdflib.URIRef(entity_types[0]['entity_type']['value'])
#         if uri_type not in superclass_lookup.keys():
#             return render_template('error.html')

#         uri_superclass = superclass_lookup[uri_type]

#         # route to appropriate shape and insert subject uri.

#         shape = pathlib.Path(uri_superclass).stem.lower()
#         shape_path = pathlib.Path.cwd() / 'shapes' / f'{shape}.rq'
#         if not shape_path.exists():
#             raise Exception('Shape file not found.')

#         with open(shape_path) as construct:
#             construct = construct.read()
#             construct = construct.replace('SUBJECT_URI', f'<{uri}>')

#         # issue type specific sparql query to triplestore.

#         r = requests.post('https://data.fiafcore.org', data={'query': construct})
#         if r.status_code != 200:
#            raise Exception(f'API {r.status_code}: {r.text}')

#         # format switch to prepare for flask.

#         data = rdflib.Graph().parse(data=r.content)
#         data = data.serialize(format="json-ld", encoding="utf-8")
#         data = json.loads(data)

#         return render_template('entity.html', resource=str(uri), data=data)

#     else:
#         return render_template('error.html')









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


def format_type(u, d):
    # print('@@', u, d)
    new_types = list()
    types = [x for x in d if x['@id'] == u]
    # print('types', types)
    if not len(types):
        raise Exception(f'{u} not found.')
    types = types[0]['@type']
    for t in types:
        # print('@@', t)
        type_label = [x for x in d if x['@id'] == t]
        # print(type_label)
        if not len(type_label):
            raise Exception(f'{type_label} not found.')
        type_label = type_label[0]['http://www.w3.org/2000/01/rdf-schema#label'][0]['@value']
        new_types.append({'id':t, 'label':type_label})

    return new_types


superclass_lookup = superclass()

@app.route('/<resource>', methods=['GET'])
def entity(resource):

    # convert to uri.

    uri = f'https://dev.fiafcore.org/{resource}'

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

    shape_path = pathlib.Path.cwd() / 'shapes' / f'{shape}.rq'
    if not shape_path.exists():
        raise Exception(f'{shape_path} not found.')

    with open(shape_path) as construct:
        construct = construct.read()
        construct = construct.replace('SUBJECT_URI', f'<{uri}>')

    # print(construct)

    # issue type specific sparql query to triplestore.

    r = requests.post('https://data.fiafcore.org', data={'query': construct})
    if r.status_code != 200:
        raise Exception(f'API {r.status_code}: {r.text}')

    # print(r.text)

    # transform to json-ld.

    test_frame = {
        "@context": {
            "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
            "rdfs" :"http://www.w3.org/2000/01/rdf-schema#",
            "fiaf": "https://dev.fiafcore.org",
            "label": "http://www.w3.org/2000/01/rdf-schema#label",
            'hasIdentifier': 'https://dev.fiafcore.org/hasIdentifier',
            'hasIdentifierAuthority': 'https://dev.fiafcore.org/hasIdentifierAuthority',
            'hasIdentifierValue': 'https://dev.fiafcore.org/hasIdentifierValue',
            'hasTitle': 'https://dev.fiafcore.org/hasTitle',
            'hasTitleValue': 'https://dev.fiafcore.org/hasTitleValue',
            'hasCountry': 'https://dev.fiafcore.org/hasCountry',
            'hasForm': 'https://dev.fiafcore.org/hasForm',
            'hasEvent': 'https://dev.fiafcore.org/hasEvent',
            'hasGenre': 'https://dev.fiafcore.org/hasGenre',
            'hasActivity': 'https://dev.fiafcore.org/hasActivity',
            'hasAgent': 'https://dev.fiafcore.org/hasAgent',
            'hasManifestation': 'https://dev.fiafcore.org/hasManifestation',
            'hasColourCharacteristic': 'https://dev.fiafcore.org/hasColourCharacteristic',
            'hasFormat': 'https://dev.fiafcore.org/hasFormat',
            'hasSoundCharacteristic': 'https://dev.fiafcore.org/hasSoundCharacteristic',

        },
        "@id": uri,
        "hasIdentifier": {
            "hasIdentifierAuthority": {
                "@embed": "@always"
            }
        },
        "hasManifestation": {
            "hasFormat": {
                "@embed": "@always"
            }
        },

    }

    # apply transforms.

    datum = rdflib.Graph().parse(data=r.text, format='ttl')
    datum = json.loads(datum.serialize(format='json-ld'))
    payload = pyld.jsonld.frame(datum, test_frame)

    # ensure all expected values are expanded to arrays.


    for x in [
        '@type',
        'hasCountry',
        'hasEvent',
        'hasGenre',
        'hasIdentifier',
        'hasManifestation'
    ]:
        if type(pydash.get(payload, x)) is not list:
            pydash.set_(payload, x, [pydash.get(payload, x)])

    for a in pydash.get(payload, 'hasEvent'):
        if type(pydash.get(a, '@type')) is not list:
            pydash.set_(a, '@type', [pydash.get(a, '@type')])

        for b in pydash.get(a, 'hasActivity'):
            if type(pydash.get(b, '@type')) is not list:
                pydash.set_(b, '@type', [pydash.get(b, '@type')])

            if type(pydash.get(b, 'hasAgent.@type')) is not list:
                pydash.set_(b, 'hasAgent.@type', [pydash.get(b, 'hasAgent.@type')])
            if type(pydash.get(b, 'hasAgent.label')) is not list:
                pydash.set_(b, 'hasAgent.label', [pydash.get(b, 'hasAgent.label')])

    for a in pydash.get(payload, 'hasTitle'):
        if type(pydash.get(a, '@type')) is not list:
            pydash.set_(a, '@type', [pydash.get(a, '@type')])

    for a in pydash.get(payload, 'hasManifestation'):
        if type(pydash.get(a, '@type')) is not list:
            pydash.set_(a, '@type', [pydash.get(a, '@type')])

        if type(pydash.get(a, 'hasColourCharacteristic')) is not list:
            pydash.set_(a, 'hasColourCharacteristic', [pydash.get(a, 'hasColourCharacteristic')])
        for b in pydash.get(a, 'hasColourCharacteristic'):
            if type(pydash.get(b, '@type')) is not list:
                pydash.set_(b, '@type', [pydash.get(b, '@type')])

        if type(pydash.get(a, 'hasSoundCharacteristic')) is not list:
            pydash.set_(a, 'hasSoundCharacteristic', [pydash.get(a, 'hasSoundCharacteristic')])
        for b in pydash.get(a, 'hasSoundCharacteristic'):
            if type(pydash.get(b, '@type')) is not list:
                pydash.set_(b, '@type', [pydash.get(b, '@type')])






    # replace all types with existing defintions.

    for i,x in enumerate(payload['@type']):
        match = [y for y in datum if y['@id'] == x]
        if not len(match):
            raise Exception('Match not found.')

        payload['@type'][i] = match[0]
        # x = match[0]
        # print(x)

    for i,x in enumerate(payload['hasEvent']):
        for j,y in enumerate(x['@type']):
            match = [z for z in datum if z['@id'] == y]
            if not len(match):
                raise Exception('Match not found.')
            payload['hasEvent'][i]['@type'][j] = match[0]


    for i,x in enumerate(payload['hasEvent']):
        for j,y in enumerate(x['hasActivity']):
            for k,z in enumerate(y['@type']):
                match = [a for a in datum if a['@id'] == z]
                if not len(match):
                    raise Exception(f'Match not found for {z}.')
                payload['hasEvent'][i]['hasActivity'][j]['@type'][k] = match[0]

            # print('@@', y.keys())
            tt = y['hasAgent']
            print('@@', y.keys(), tt)
    #         print('tt', tt)
    #         for k, z in enumerate(tt['@type']):
    #             match = [b for b in datum if b['@id'] == z]
    #             if not len(match):
    #                 raise Exception(f'Match not found for {z}.')


    # #                 payload['hasEvent'][i]['hasActivity'][j]['hasAgent']['@type'][k] = match[0]





       # x = match[0]
       # print(x)


    with open(pathlib.Path.cwd() / 'temp.json', 'w') as temp_save:
        json.dump(payload, temp_save, ensure_ascii=False, indent=4)








    # payload['type'] = format_type(uri, datum)
    # payload['id'] = pathlib.Path(payload['@id']).name

    # def ensure_arrary(data, key):
    #     if key in data.keys():
    #         if type(data[key]) is dict:
    #             # identifier_list = list()
    #             # identifier_list.append(payload['hasCountry'])
    #             data[key] = [data[key]]

    #     return data


    # payload = ensure_arrary(payload, 'hasIdentifier')
    # payload = ensure_arrary(payload, 'hasCountry')
    # payload = ensure_arrary(payload, 'hasForm')
    # payload = ensure_arrary(payload, 'hasGenre')
    # payload = ensure_arrary(payload, 'hasTitle')
    # payload = ensure_arrary(payload, 'hasEvent')
    # payload = ensure_arrary(payload, 'hasManifestation')





    # # add title type.

    # if 'hasTitle' in payload.keys():
    #     for x in payload['hasTitle']:
    #         # print('@@', x)
    #         # title_type = x['@type']
    #         match = [y for y in datum if y['@id'] == x['@type']]
    #         if len(match):

    #             match = match[0]
    #             x['type'] = {'@id': match['@id'], 'label': match['http://www.w3.org/2000/01/rdf-schema#label'][0]['@value']}
    #             # z = {}
    #             # print('@@', match)



    # # you need to update this so that it returns, instead of "@type", "type" with {"id":..., "label":...}

    # if 'hasEvent' in payload.keys():
    #     for x in payload['hasEvent']:
    #         match = [y for y in datum if y['@id'] == x['@type']]
    #         # print('&&&', match)
    #         if match:
    #             x['type_label'] = match[0]['http://www.w3.org/2000/01/rdf-schema#label'][0]['@value']

    #         if 'hasActivity' in x.keys():
    #             for y in x['hasActivity']:
    #                 match2 = [z for z in datum if z['@id'] == y['@type']]
    #                 if len(match2):
    #                     match2 = match2[0]
    #                     match2['label'] = match2['http://www.w3.org/2000/01/rdf-schema#label'][0]['@value']
    #                     y['type'] = match2


    #                 # print('%%%', y)



    # if 'hasManifestation' in payload.keys():
    #     for x in payload['hasManifestation']:
    #         match = [y for y in datum if y['@id'] == x['@type']]
    #         # print('&&&', match)
    #         if match:
    #             x['type_label'] = match[0]['http://www.w3.org/2000/01/rdf-schema#label'][0]['@value']




    # # Okay I want to do a switch for manifestation sound type.

    # if 'hasManifestation' in payload.keys():
    #     for x in payload['hasManifestation']:
    #         # print(x)
    #         if 'hasSoundCharacteristic' in x.keys():
    #             print(x['hasSoundCharacteristic']['@type'])
    #             match = [y for y in datum if y['@id'] == x['hasSoundCharacteristic']['@type']]
    #             x['hasSoundCharacteristic'] = match[0]

    # if 'hasManifestation' in payload.keys():
    #     for x in payload['hasManifestation']:
    #         # print(x)
    #         if 'hasColourCharacteristic' in x.keys():
    #             print(x['hasColourCharacteristic']['@type'])
    #             match = [y for y in datum if y['@id'] == x['hasColourCharacteristic']['@type']]
    #             x['hasColourCharacteristic'] = match[0]




# , 'hasSoundCharacteristic': {'@type': 'https://dev.fiafcore.org/Silent'}, 'type_label': 'Manifestation'

    # okay so what are we doing here?
    #
    # 1. determine if uri resolves in triple store
    # 2. superclass of item
    # 3. construct based on superclass
    # 4. json-ld frame
    # 5. feed resulting json to template for plotting

    return flask.render_template('entity.html', data=payload, d=datum)


if __name__ == "__main__":
    app.run(debug=True, port=5000)
