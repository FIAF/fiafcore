
# merge entities based on overlap data input.

import json
import pandas
import pathlib
import tqdm
import uuid

def merge_auth(d):

    # load input id, and minimum validation on uri.

    input_uris = d['id']
    for i in input_uris:
        if 'dev.fiafcore.org' not in i:
            raise Exception(f'{i} not well formed.')

    # output uri, which will replace all inputs.
    # note this does not have to be a **new** identifier, but this seems like a good, agnostic, choice.
    #
    # something to consider for the future is logging identifier changes.

    output_uri = f'https://dev.fiafcore.org/{str(uuid.uuid4())}'

    # auth files for processing.

    auth_files = [
        pathlib.Path.cwd().parent / 'transform' / 'bfi' / 'auth.parquet',
        pathlib.Path.cwd().parent / 'transform' / 'bundesarchiv' / 'auth.parquet'
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

def validate_auth(d):

    # load input id, and minimum validation on uri.

    input_uris = d['id']
    for i in input_uris:
        if 'dev.fiafcore.org' not in i:
            raise Exception(f'{i} not well formed.')

    # auth files for checking.

    auth_files = [
        pathlib.Path.cwd().parent / 'transform' / 'bfi' / 'auth.parquet',
        pathlib.Path.cwd().parent / 'transform' / 'bundesarchiv' / 'auth.parquet'
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

data_path = pathlib.Path.home() / 'Desktop' / 'overlap.json'
if not data_path.exists():
    raise Exception(f'{data_path} not found.')

# load data and process.

data = json.loads(data_path.read_text())

for x in tqdm.tqdm(data, desc='merge'):
    merge_auth(x)

for x in tqdm.tqdm(data, desc='validate'):
    validate_auth(x)
