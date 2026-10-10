
# build fiafcore-docs-dev image.

docker build -t fiafcore-docs-dev .

# deploy containers.

docker compose up -d
