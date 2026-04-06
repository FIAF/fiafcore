# QLever

Notes on the installation and deployment of a QLever triplestore.

~

RDF data intended for the triplestore needs to be collected and exported as n-triples.

```python
import pathlib
import rdflib

g = rdflib.Graph()

ttl = [x for x in pathlib.Path.cwd().iterdir() if x.suffix == '.ttl']
for t in ttl:
    g += rdflib.Graph().parse(t)
    
g.serialize(destination=pathlib.Path.cwd() / 'fiafcore.nt', format='nt')
```

A `settings.json` file is expected.

```sh
echo '{ "ascii-prefixes-only": false, "num-triples-per-batch": 5000 }' > settings.json
```

The QLever indexing service can be run via Docker.

```sh
docker run --rm -u $(id -u):$(id -g) -v /etc/localtime:/etc/localtime:ro --mount type=bind,src="$(pwd)",target=/index -w /index --name qlever.index.fiafcore --init --entrypoint bash docker.io/adfreiburg/qlever:latest -c 'cat fiafcore.nt | qlever-index -i fiafcore -s settings.json --vocabulary-type on-disk-compressed -F ttl -f - 2>&1 | tee fiafcore.index-log.txt'
```

Once indexing is completed the QLever triplestore service can be deployed via Docker. For the current dataset (18,250,347 triples) the server (4GB of memory) consistently crashes while indexing, but my local workstation (64GB of memory) processes it fine in less than a minute. This means that the workflow is to index the triples locally, and then move the index files to the server prior to launching the triplestore. 

```sh
docker run -d --restart=unless-stopped -u $(id -u):$(id -g) -v /etc/localtime:/etc/localtime:ro --mount type=bind,src="$(pwd)",target=/index -p 7019:7019 -w /index --name qlever.server.fiafcore --init --entrypoint bash docker.io/adfreiburg/qlever:latest -c 'qlever-server -i fiafcore -j 8 -p 7019 -m 5G -c 4G -e 2G -k 200 -s 30s -a fiafcore_7643543846_Mbtp5JXuTc9m > fiafcore.server-log.txt 2>&1'         
```

The service can be tested by running a basic SPARQL query.

```sh
curl -s localhost:7019 -H "Accept: text/tab-separated-values" --data-urlencode query='SELECT * WHERE { ?s ?p ?o } LIMIT 10'
```
