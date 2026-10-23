
# add auth transform and relevant triples to wikidata dataset.

import json
import pandas
import pathlib
import rdflib

# load input data, matching fiafcore to wikidata entities.
# TODO jsonschema checks on load would be wonderful.

wd_path = pathlib.Path.cwd() / 'wikidata.json'
if not wd_path.exists():
    raise Exception(f'{wd_path} not found.')

input = json.loads(wd_path.read_text())

for i in input:

    # locate wikidata auth file.

    wikidata_auth = pathlib.Path.cwd().parent / 'transform' / 'wikidata' / 'auth.parquet'
    if not wikidata_auth.exists():
        raise Exception(f'{wikidata_auth} not found.')

    # if not extant, add auth link.

    df = pandas.read_parquet(wikidata_auth)
    if i['fiafcore'] not in df.fiafcore.unique():
        df.loc[len(df)] = [(i['fiafcore']), (i['wikidata'])]
        df.to_parquet(wikidata_auth, compression="zstd")

    # locate wikidata data file.

    wikidata_data = pathlib.Path.cwd().parent / 'transform' / 'wikidata' / 'data.ttl'
    if not wikidata_data.exists():
        raise Exception(f'{wikidata_data} not found.')

    # if rdf not extant, add.

    triple_match = (
        rdflib.URIRef(i['wikidata']),
        rdflib.URIRef('https://dev.fiafcore.org/hasIdentifier'),
        None
    )

    g = rdflib.Graph().parse(wikidata_data)
    if not len([s for s,p,o in g.triples(triple_match)]):

        wikidata_id = pathlib.Path(i['wikidata']).name

        g.add((
            rdflib.URIRef(i['wikidata']),
            rdflib.URIRef('https://dev.fiafcore.org/hasIdentifier'),
            rdflib.URIRef(f'wikidata://identifier/{wikidata_id}'),
        ))

        g.add((
            rdflib.URIRef(f'wikidata://identifier/{wikidata_id}'),
            rdflib.RDF.type,
            rdflib.URIRef('https://dev.fiafcore.org/Identifier')
        ))

        g.add((
            rdflib.URIRef(f'wikidata://identifier/{wikidata_id}'),
            rdflib.URIRef('https://dev.fiafcore.org/hasIdentifierAuthority'),
            rdflib.URIRef('wikidata://resource/agent/wikidata')
        ))

        g.add((
            rdflib.URIRef(f'wikidata://identifier/{wikidata_id}'),
            rdflib.URIRef('https://dev.fiafcore.org/hasIdentifierValue'),
            rdflib.Literal(wikidata_id)
        ))

        g.serialize(destination=wikidata_data, format='ttl')
