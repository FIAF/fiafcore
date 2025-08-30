import pathlib
import rdflib


def main():
    g = rdflib.Graph()
    for sect in ["ontology", "vocabularies"]:
        ttl_path = pathlib.Path.cwd() / sect
        ttl_files = [x for x in ttl_path.iterdir() if x.suffix == ".ttl"]
        for c in ttl_files:
            g += rdflib.Graph().parse(c)

    g.serialize(destination=str(pathlib.Path.cwd() / "fiafcore.ttl"), format="turtle")

    print(len(g), "triples.")

    # TODO: compile readme here.

if __name__ == "__main__":
    main()
