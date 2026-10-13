
# add auth transform and relevant triples to wikidata dataset.

import pandas
import pathlib
import rdflib

input = [
{
'fiaf':'https://dev.fiafcore.org/66cde00a-6621-46cc-8174-f945b0f4e61e',
'wd': 'http://www.wikidata.org/entity/Q239823'
},
{
'fiaf':'https://dev.fiafcore.org/05a1b0a4-e018-4d74-b321-3377f6245650',
'wd': 'http://www.wikidata.org/entity/Q55375'
},
{
'fiaf':'https://dev.fiafcore.org/8b06175a-b0b0-4214-a9c8-e808b928d12e',
'wd': 'http://www.wikidata.org/entity/Q55375'
},
{
'fiaf':'https://dev.fiafcore.org/cb0c9544-b1bc-4e19-b732-ce76563aa290',
'wd': 'http://www.wikidata.org/entity/Q216266'
},
{
'fiaf':'https://dev.fiafcore.org/ec0b2f11-be49-4485-a89a-00b48213aec2',
'wd': 'http://www.wikidata.org/entity/Q152272'
},
{
'fiaf':'https://dev.fiafcore.org/5574fae1-776f-443e-901d-35c5619e0164',
'wd': 'http://www.wikidata.org/entity/Q1523434'
}
]


for i in input:

    # locate wikidata auth file.

    wikidata_auth = pathlib.Path.cwd().parent / 'transform' / 'wikidata' / 'auth.parquet'
    if not wikidata_auth.exists():
        raise Exception(f'{wikidata_auth} not found.')

    # if not extant, add auth link.

    df = pandas.read_parquet(wikidata_auth)
    if i['fiaf'] not in df.fiafcore.unique():
        df.loc[len(df)] = [(i['fiaf']), (i['wd'])]
        df.to_parquet(wikidata_auth, compression="zstd")

    # locate wikidata data file.

    wikidata_data = pathlib.Path.cwd().parent / 'transform' / 'wikidata' / 'data.ttl'
    if not wikidata_data.exists():
        raise Exception(f'{wikidata_data} not found.')

    # if rdf not extant, add.

    triple_match = (
        rdflib.URIRef(i['wd']),
        rdflib.URIRef('https://dev.fiafcore.org/hasIdentifier'),
        None
    )

    g = rdflib.Graph().parse(wikidata_data)
    if not len([s for s,p,o in g.triples(triple_match)]):

        g.add((
            rdflib.URIRef(i['wd']),
            rdflib.URIRef('https://dev.fiafcore.org/hasIdentifier'),
            rdflib.URIRef(f'wikidata://identifier/{pathlib.Path(i['wd']).name}'),
        ))

        g.add((
            rdflib.URIRef(f'wikidata://identifier/{pathlib.Path(i['wd']).name}'),
            rdflib.RDF.type,
            rdflib.URIRef('https://dev.fiafcore.org/Identifier')
        ))

        g.add((
            rdflib.URIRef(f'wikidata://identifier/{pathlib.Path(i['wd']).name}'),
            rdflib.URIRef('https://dev.fiafcore.org/hasIdentifierAuthority'),
            rdflib.URIRef('wikidata://resource/agent/wikidata')
        ))

        g.add((
            rdflib.URIRef(f'wikidata://identifier/{pathlib.Path(i['wd']).name}'),
            rdflib.URIRef('https://dev.fiafcore.org/hasIdentifierValue'),
            rdflib.Literal(pathlib.Path(i['wd']).name)
        ))

        g.serialize(destination=wikidata_data, format='ttl')
