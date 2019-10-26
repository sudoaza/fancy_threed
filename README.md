# Minimal Search Engine

Uses Ruby on Rails as backend. Stores data in a PostgreSQL database that is indexed by ElasticSearch.

## Run

    docker-compose up

## Submit URL 

POST to /submit

## Search

Use interface or GET to /search?q=search+for+kittens+here

## Gotchas

ElasticSearch needs more RAM

    sudo sysctl -w vm.max_map_count=262144
