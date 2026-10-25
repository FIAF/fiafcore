
# merge entities based on overlapping fiafcore uris.

import json
import pandas
import pathlib
import tqdm
import uuid

def merge_auth(d):

    # merge log path.

    log_path = pathlib.Path.cwd() / 'merge.log'
    if not log_path.exists():
        raise Exception(f'{log_path} not found.')

    # load input ids, and minimum validation on uri.

    input_uris = d['fiafcore']
    for i in input_uris:
        if 'dev.fiafcore.org' not in i:
            raise Exception(f'{i} not well formed.')

    # output uri, which will replace all inputs.
    # note this does not have to be a **new** identifier, but this does seem like a good, agnostic, choice.

    output_uri = f'https://dev.fiafcore.org/{str(uuid.uuid4())}'

    # auth files for processing.

    auth_files = [
        pathlib.Path.cwd().parent / 'transform' / 'bfi' / 'auth.parquet',
        pathlib.Path.cwd().parent / 'transform' / 'bundesarchiv' / 'auth.parquet',
        pathlib.Path.cwd().parent / 'transform' / 'wikidata' / 'auth.parquet'
    ]

    # verify auth files exist.

    for a in auth_files:
        if not a.exists():
            raise Exception(f'{a} not found.')

    # find and replace, if relevant.

    for a in auth_files:
        df = pandas.read_parquet(a)
        match = df.loc[df.fiafcore.isin(input_uris)]
        if not len(match):
            continue

        df.loc[df.fiafcore.isin(input_uris), 'fiafcore'] = output_uri
        df.to_parquet(a, compression="zstd")
        for i in input_uris:
            log_string = f'{i} -> {output_uri}'
            log_extant = log_path.read_text()
            log_extant = log_extant.split('\n')
            if log_string not in log_extant:
                with open(log_path, 'a') as merge_log:
                    merge_log.write(log_string)
                    merge_log.write('\n')

def validate_auth(d):

    # load input id, and minimum validation on uri.

    input_uris = d['fiafcore']
    for i in input_uris:
        if 'dev.fiafcore.org' not in i:
            raise Exception(f'{i} not well formed.')

    # auth files for checking.

    auth_files = [
        pathlib.Path.cwd().parent / 'transform' / 'bfi' / 'auth.parquet',
        pathlib.Path.cwd().parent / 'transform' / 'bundesarchiv' / 'auth.parquet',
        pathlib.Path.cwd().parent / 'transform' / 'wikidata' / 'auth.parquet'
    ]

    # verify auth files exist.

    for a in auth_files:
        if not a.exists():
            raise Exception(f'{a} not found.')

    # check if input uris are still present.

    for a in auth_files:
        df = pandas.read_parquet(a)
        match = df.loc[df.fiafcore.isin(input_uris)]
        if len(match):
            raise Exception(f'{input_uris} detected in {a}.')

# path to overlap file.

data_path = pathlib.Path.cwd() / 'merge.json'
if not data_path.exists():
    raise Exception(f'{data_path} not found.')

# load data and process.
# TODO jsonschema checks on load would be wonderful.

data = json.loads(data_path.read_text())
for x in tqdm.tqdm(data, desc='merge'):

    # merge identifiers into a single new identifier

    merge_auth(x)

    # validate legacy uuids no longer exist.

    validate_auth(x)
