import pathlib
import rdflib

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