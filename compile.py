import pathlib
import rdflib

class_path = pathlib.Path.cwd() / 'classes'
class_files = [x for x in class_path.iterdir() if x.suffix == '.ttl']

g = rdflib.Graph()
for c in class_files:
    g += rdflib.Graph().parse(c)
    
g.serialize(
    destination=str(pathlib.Path.cwd() / 'fiafcore.ttl'), 
    format='longturtle'
    )

print(len(g), 'triples.')