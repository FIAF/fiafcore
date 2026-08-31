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
    else:
        raise Exception('Shape not detected.')


    # route to appropriate shape and insert subject uri.

    shape_path = pathlib.Path.cwd() / 'shapes' / f'{shape}.rq'
    if not shape_path.exists():
        raise Exception('{shape_path} not found.')

    with open(shape_path) as construct:
        construct = construct.read()
        construct = construct.replace('SUBJECT_URI', f'<{uri}>')

    # issue type specific sparql query to triplestore.

    r = requests.post('https://data.fiafcore.org', data={'query': construct})
    if r.status_code != 200:
        raise Exception(f'API {r.status_code}: {r.text}')

    # transform to json-ld.


    test_frame = {
        "@context": {
    "rdf": "http://www.w3.org/1999/02/22-rdf-syntax-ns#",
    "rdfs" :"http://www.w3.org/2000/01/rdf-schema#",
    "fiaf": "https://dev.fiafcore.org",
    "label": "http://www.w3.org/2000/01/rdf-schema#label",




    },
    "@id": uri,

    }


    datum = rdflib.Graph().parse(data=r.text, format='ttl')
    datum = json.loads(datum.serialize(format='json-ld'))
    datum = pyld.jsonld.frame(datum, test_frame)



    # raise Exception('@@', uri, len(datum), entity_type, superclass, datum, len(datum))


    # okay so what are we doing here?
    #
    # 1. determine if uri resolves in triple store
    #
    # 2. superclass of item
    #
    # 3. construct based on superclass
    #
    # 4. json-ld frame
    #
    # 5. feed resulting json to template for plotting


    return flask.render_template('entity.html', data=datum)




if __name__ == "__main__":
    app.run(debug=True, port=5000)
