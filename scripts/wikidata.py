
# add auth transform and relevant triples to wikidata dataset.

import pandas
import pathlib
import rdflib

input = {
    'fiaf':'https://dev.fiafcore.org/62010913-cfd4-43fd-9a00-6c52c17c7433',
    'wd': 'https://www.wikidata.org/wiki/Q151599'
}

# locate wikidata auth file.

wikidata_auth = pathlib.Path.cwd().parent / 'transform' / 'wikidata' / 'auth.parquet'
if not wikidata_auth.exists():
    raise Exception(f'{wikidata_auth} not found.')

# if not extant, add auth link.

df = pandas.read_parquet(wikidata_auth)
if input['fiaf'] not in df.fiafcore.unique():
    df.loc[len(df)] = [(input['fiaf']), (input['wd'])]
    df.to_parquet(wikidata_auth, compression="zstd")

# locate wikidata data file.

wikidata_data = pathlib.Path.cwd().parent / 'transform' / 'wikidata' / 'data.ttl'
if not wikidata_data.exists():
    raise Exception(f'{wikidata_data} not found.')

# if rdf not extant, add.

triple_match = (
    rdflib.URIRef(input['wd']),
    rdflib.URIRef('https://dev.fiafcore.org/hasIdentifier'),
    None
)

g = rdflib.Graph().parse(wikidata_data)
if not len([s for s,p,o in g.triples(triple_match)]):

    bnode = rdflib.BNode()

    g.add((
        rdflib.URIRef(input['wd']),
        rdflib.URIRef('https://dev.fiafcore.org/hasIdentifier'),
        bnode
    ))

    g.add((
        bnode,
        rdflib.URIRef('https://dev.fiafcore.org/hasIdentifierAuthority'),
        rdflib.URIRef('wikidata://resource/agent/wikidata')
    ))

    g.add((
        bnode,
        rdflib.URIRef('https://dev.fiafcore.org/hasIdentifierValue'),
        rdflib.Literal(pathlib.Path(input['wd']).name)
    ))

    g.serialize(destination=wikidata_data, format='ttl')
