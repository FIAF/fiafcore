
# merge entities.

import pandas
import pathlib
import uuid

# input uris to be merged.

input_uris = [
    'https://dev.fiafcore.org/684e617a-ae04-4070-a6d9-885aa2565706',
    'https://dev.fiafcore.org/804b6fcd-a05a-4223-b91b-af23e88a8a28'
]

# output uri, which will replace all inputs.
# note this does not have to be a **new** identifier, but this seems like a good, agnostic, choice.
#
# something to consider for the future is logging identifier changes.

output_uri = f'https://dev.fiafcore.org/{str(uuid.uuid4())}'

print(f'minted identifier: {output_uri}')

# auth files for processing.

auth_files = [
    pathlib.Path.cwd().parent / 'transform' / 'bfi' / 'auth.parquet',
    pathlib.Path.cwd().parent / 'transform' / 'bundesarchiv' / 'auth.parquet'
]

# verify auth files exist.

for a in auth_files:
    if not a.exists():
        raise Exception(f'{a} not found.')

# find and replace.

for a in auth_files:
    df = pandas.read_parquet(a)
    df.loc[df.fiafcore.isin(input_uris), 'fiafcore'] = output_uri
    df.to_parquet(a, compression="zstd")

# report on result.

for a in auth_files:
    df = pandas.read_parquet(a)
    print(a.parent.stem)
    print('input:', len(df.loc[df.fiafcore.isin(input_uris)]))
    print('output:', len(df.loc[df.fiafcore.isin([output_uri])]))
