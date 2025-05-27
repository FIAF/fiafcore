import pathlib
import rdflib

# build single turtle file from ontology and vocabs.

g = rdflib.Graph()
for sect in ['ontology', 'vocabularies']:
    ttl_path = pathlib.Path.cwd() / sect
    ttl_files = [x for x in ttl_path.iterdir() if x.suffix == '.ttl']
    for c in ttl_files:
        g += rdflib.Graph().parse(c)
    
g.serialize(
    destination=str(pathlib.Path.cwd() / 'fiafcore.ttl'), 
    format='longturtle'
    )

print(len(g), 'triples.')

# generate ontology documentation for repo readme.

readme_string = """
# FIAFcore

The FIAFcore ontology was developed to enable the federation of filmographic data from disparate sources. It is heavily based on the language and structures of the [FIAF Cataloguing Manual](https://www.fiafnet.org/pages/e-resources/cataloguing-manual.html).

### Ontology
"""

# calculate property domains.

query = ''' 
    select ?subject ?union_domain where {
        ?subject rdfs:domain ?domain .
        ?domain owl:unionOf ?a .
        ?a rdf:rest*/rdf:first ?union_domain .
    } '''

# calculate property domains.

property_domains = [(a,b) for a, b in g.query(query)]
property_domains += [(s,o) for s,p,o in g.triples((None, rdflib.RDFS.domain, None))]

# build primary class sections.

core_classes = [
    'Work',
    'Variant',
    'Manifestation',
    'Item',
    'Carrier',
    'Event',
    'Activity',
    'Agent'
]

for c in core_classes:
    uri = f'https://ontology.fiafcore.org/{c}'
    label_en = [o for s,p,o in g.triples((rdflib.URIRef(uri), rdflib.RDFS.label, None)) if o.language == 'en']
    if len(label_en) != 1:
        raise Exception('Expected one label.')

    readme_string += f"\n**{label_en[0]}**\n"

    desc_en = [o for s,p,o in g.triples((rdflib.URIRef(uri), rdflib.URIRef('http://purl.org/dc/elements/1.1/description'), None)) if o.language == 'en']
    if len(desc_en) != 1:
        raise Exception('Expected one description.')    
    
    readme_string += f"\n{desc_en[0]}\n"

    properties = [x for x in property_domains if str(x[1]) == uri]
    properties = sorted([x[0] for x in properties])

    readme_string += f"| Property | Range | Description |\n"
    readme_string += f"| --- | --- | --- |\n"

    for p in properties:
        property_range = [o for s,p,o in g.triples((p, rdflib.RDFS.range, None))]
        if len(property_range) != 1:
            raise Exception('This should not happen.')

        property_description = [o for s,p,o in g.triples((p, rdflib.URIRef('http://purl.org/dc/elements/1.1/description'), None)) if o.language == 'en']
        if len(property_description) != 1:
            raise Exception('This should not happen.')

        readme_string += f"| fiafcore:{pathlib.Path(p).name} "
        readme_string += f"| fiafcore:{pathlib.Path(property_range[0]).name} "
        readme_string += f"| {property_description[0]} |\n"        

readme_string += """
### Resources

Further information and resources can be found at [fiafcore.org](fiafcore.org).

### Licence
The FIAFcore ontology is licensed under [CC-BY-4.0](https://creativecommons.org/licenses/by/4.0/deed.en).
"""

with open(pathlib.Path.cwd() / 'README.md', 'w') as readme_write:
    readme_write.write(readme_string)