import pathlib

import rdflib

# build single turtle file from ontology and vocabularies.

g = rdflib.Graph()
for sect in ["ontology", "vocabulary"]:
    ttl_path = pathlib.Path.cwd() / sect
    ttl_files = [x for x in ttl_path.iterdir() if x.suffix == ".ttl"]
    for c in ttl_files:
        g += rdflib.Graph().parse(c)

# add ontology triples.

g += rdflib.Graph().parse(
    data="""
    @prefix dc: <http://purl.org/dc/elements/1.1/> .
    @prefix dcterms: <http://purl.org/dc/terms/> .
    @prefix owl: <http://www.w3.org/2002/07/owl#> .

    <https://ontology.fiafcore.org/> a owl:Ontology ;
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
