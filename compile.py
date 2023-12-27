# import libraries

import pathlib
import rdflib

# compile class files

class_dir = pathlib.Path.cwd() / 'classes'
classes = [x for x in class_dir.iterdir() if x.suffix == '.ttl']

# load into graph, should throw syntax errors

graph = rdflib.Graph()        
for x in sorted(classes):
    graph += rdflib.Graph().parse(x)

graph.serialize(destination=str(pathlib.Path.cwd() / 'FIAFcore.ttl'), format="turtle")