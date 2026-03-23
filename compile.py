
import pathlib
import rdflib

def convert_vocabulary(input_file):
    ''' Convert OWL file to SKOS. '''

    g = rdflib.Graph().parse(pathlib.Path.cwd() / 'ontology' / input_file)
    skos_graph = rdflib.Graph()

    # identify concept scheme.

    concept_scheme = None
    for s,p,o in g.triples((None, rdflib.RDF.type, rdflib.OWL.Class)):
        if not len([x for x in g.triples((s, rdflib.RDFS.subClassOf, None))]):
            concept_scheme = s

    if not concept_scheme:
        raise Exception('Concept scheme should have been detected.')

    # parse triples.

    for s,p,o in g.triples((None, rdflib.RDF.type, rdflib.OWL.Class)):

        if not len([x for x in g.triples((s, rdflib.RDFS.subClassOf, None))]):
            skos_graph.add((s, rdflib.RDF.type, rdflib.SKOS.ConceptScheme))
        else:
            skos_graph.add((s, rdflib.RDF.type, rdflib.SKOS.Concept))

        for a,b,c in g.triples((s, rdflib.RDFS.label, None)):
            skos_graph.add((s, rdflib.SKOS.prefLabel, c))

        for a,b,c in g.triples((s, rdflib.DC.description, None)):
            skos_graph.add((s, rdflib.SKOS.definition, c))

        for a,b,c in g.triples((s, rdflib.RDFS.subClassOf, None)):
            skos_graph.add((s, rdflib.SKOS.broader, c))

        for a,b,c in g.triples((s, rdflib.RDFS.subClassOf, None)):
            skos_graph.add((s, rdflib.SKOS.inScheme, concept_scheme))

    skos_graph.serialize(
        destination=pathlib.Path.cwd()  / 'vocabulary' / input_file,
        format="longturtle",
        )

# convert ontology vocabularies to SKOS.

for vocab in [
    'fiafcore-base.ttl',
    'fiafcore-broadcaststandard.ttl',
    'fiafcore-colourstandard.ttl',
    'fiafcore-country.ttl',
    'fiafcore-element.ttl',
    'fiafcore-form.ttl',
    'fiafcore-format.ttl',
    'fiafcore-genre.ttl',
    'fiafcore-language.ttl',
    'fiafcore-soundstandard.ttl',
    'fiafcore-status.ttl']:
    convert_vocabulary(vocab)

# build single turtle file from ontology.

g = rdflib.Graph()
ontology_path = pathlib.Path.cwd() / 'ontology'
ttl_files = [x for x in ontology_path.iterdir() if x.suffix == ".ttl"]
for c in ttl_files:
    g += rdflib.Graph().parse(c)

# add ontology triples.

g += rdflib.Graph().parse(
    data="""
    @prefix dc: <http://purl.org/dc/elements/1.1/> .
    @prefix dcterms: <http://purl.org/dc/terms/> .
    @prefix owl: <http://www.w3.org/2002/07/owl#> .

    <https://dev.fiafcore.org/> a owl:Ontology ;
        dc:title "FIAFcore" ;
        owl:versionInfo "dev-2.0.0" ;
        dcterms:license "https://creativecommons.org/licenses/by/4.0/" ;
        dc:creator "FIAF Cataloguing and Documentation Commission" ;
    . """,
    format="ttl",
)

# write ontology graph to disk.

g.serialize(destination=str(pathlib.Path.cwd() / "fiafcore.ttl"), format="longturtle")
print(len(g), "triples.")
