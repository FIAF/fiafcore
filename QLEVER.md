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

The QLever indexing service can be run via Docker. For the current dataset (18,250,347 triples) the server (4GB of memory) consistently crashes while indexing, but my local workstation (64GB of memory) processes it fine in less than a minute. This means that the workflow is to index the triples locally, and then move the index files to the server prior to launching the triplestore. 

```sh
docker run --rm -u $(id -u):$(id -g) -v /etc/localtime:/etc/localtime:ro --mount type=bind,src="$(pwd)",target=/index -w /index --name qlever.index.fiafcore --init --entrypoint bash docker.io/adfreiburg/qlever:latest -c 'cat fiafcore.nt | qlever-index -i fiafcore -s settings.json --vocabulary-type on-disk-compressed -F ttl -f - 2>&1 | tee fiafcore.index-log.txt'
```

Once indexing is completed the QLever triplestore service can be deployed via Docker. 

```sh
docker run -d --restart=unless-stopped -u $(id -u):$(id -g) -v /etc/localtime:/etc/localtime:ro --mount type=bind,src="$(pwd)",target=/index -p 7019:7019 -w /index --name qlever.server.fiafcore --init --entrypoint bash docker.io/adfreiburg/qlever:latest -c 'qlever-server -i fiafcore -j 8 -p 7019 -m 5G -c 4G -e 2G -k 200 -s 30s -a fiafcore_7643543846_Mbtp5JXuTc9m > fiafcore.server-log.txt 2>&1'         
```

The service can be tested by running a basic SPARQL query.

```sh
curl -s localhost:7019 -H "Accept: text/tab-separated-values" --data-urlencode query='SELECT * WHERE { ?s ?p ?o } LIMIT 10'
```

Certbot can be used to grant the service a HTTPS certificate.

```sh
sudo certbot certonly --nginx --noninteractive --agree-tos -d data.fiafcore.org
```

Nginx can be configured with `sudo nano /etc/nginx/nginx.conf`. 

```sh
user  paulduchesne;
worker_processes  1;
error_log  /var/log/nginx/error.log warn;
pid        /var/run/nginx.pid;
events {}

http {
    client_max_body_size 100M;
    server {
        listen 80;
        server_name data.fiafcore.org;
        return 301 https://$server_name$request_uri;
    }
    server {
        listen 443 ssl;
        server_name data.fiafcore.org;
        ssl_certificate /etc/letsencrypt/live/data.fiafcore.org/fullchain.pem;
        ssl_certificate_key /etc/letsencrypt/live/data.fiafcore.org/privkey.pem;
        ssl_protocols       TLSv1 TLSv1.1 TLSv1.2;
        ssl_ciphers         HIGH:!aNULL:!MD5;
        access_log /var/log/nginx/data.fiafcore.org.log;
        location / {
            proxy_pass http://127.0.0.1:7019;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-forwarded-host $host;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }  
} 
```

The Nginx config can be tested with

```sh
sudo nginx -t  
```

The Nginx service can be reloaded with

```sh
sudo service nginx reload 
```

The service should now be accessible at https://data.fiafcore.org.
