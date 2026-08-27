
# add auth transform and relevant triples to wikidata dataset.

import pandas
import pathlib
import rdflib

input = {
    'fiaf':'https://dev.fiafcore.org/67374e03-1dd8-40a3-9ae7-4ab78e0dd1b3',
    'wd': 'https://www.wikidata.org/wiki/Q76813'
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

    g.add((
        rdflib.URIRef(input['wd']),
        rdflib.URIRef('https://dev.fiafcore.org/hasIdentifier'),
        rdflib.URIRef(f'wikidata://identifier/{pathlib.Path(input['wd']).name}'),
    ))

    g.add((
        rdflib.URIRef(f'wikidata://identifier/{pathlib.Path(input['wd']).name}'),
        rdflib.RDF.type,
        rdflib.URIRef('https://dev.fiafcore.org/Identifier')
    ))

    g.add((
        rdflib.URIRef(f'wikidata://identifier/{pathlib.Path(input['wd']).name}'),
        rdflib.URIRef('https://dev.fiafcore.org/hasIdentifierAuthority'),
        rdflib.URIRef('wikidata://resource/agent/wikidata')
    ))

    g.add((
        rdflib.URIRef(f'wikidata://identifier/{pathlib.Path(input['wd']).name}'),
        rdflib.URIRef('https://dev.fiafcore.org/hasIdentifierValue'),
        rdflib.Literal(pathlib.Path(input['wd']).name)
    ))

    g.serialize(destination=wikidata_data, format='ttl')
